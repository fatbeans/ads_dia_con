package controller;

import adapter.hbase.UserDetailHbaseAdapter;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.DbKit;
import dao.Pager;
import dao.UserDetailsDao;
import dic.DbType;
import export.ExcelExport;
import model.UserDetHbaseEntity;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang.time.DateUtils;

import java.sql.*;
import java.text.ParseException;
import java.util.*;
import java.util.Date;

/**
 * Created by xinxin on 2015/7/17.
 */
public class UserDetailsController extends Controller {

    /**
     * 详单-2/3G
     */
    public void search23g() {
    }

    /**
     * 详单-LTE
     */
    public void searchLTE() throws Throwable {
        int page = getParaToInt("page", 1);
        int size = getParaToInt("rows", 30);

        long sd = getParaToLong("sd", 2000010100l);
        long ed = getParaToLong("ed", 2100010100l);
        long msisdn = getParaToLong("msisdn", -1l);

        String dbPre = PropKit.get("dbPre");

        Pager pager = getPager(msisdn, sd, ed, page, size);

        String jsonStr = pager.toJsonString();
        renderJson(jsonStr);
    }

    private void doForHbase(int page, int size, long sd, long ed, long msisdn) throws Throwable {
        List<UserDetHbaseEntity> list = UserDetailHbaseAdapter.getPage(msisdn + "", sd + "", ed + "");
        Pager pager = new Pager();
        pager.setPage(page);
        pager.setSize(size);
        pager.setRows(list);
        pager.setRecords(list.size());
        pager.setTotal(pager.getRecords() / pager.getSize() + (pager.getRecords() % pager.getSize() > 0 ? 1 : 0));
        JSONObject json = pager.toJson();
        json.put("rows", list);
        renderJson(json.toJSONString());
    }


    private String getTime(String str) {
        if (StringUtils.isNumeric(str) && str.length() == 17) {
            String res = str.substring(0, 4) + "/" + str.substring(4, 6) + "/" + str.substring(6, 8) + " " + str
                    .substring(8, 10) + ":" + str.substring(10, 12) + ":" + str.substring(12, 14) + "." + str.substring
                    (14, 17);
            return res;

        } else {
            return null;
        }
    }


    public void export() {

        long sd = getParaToLong(("sd"), 20000101l);
        long ed = getParaToLong(("ed"), 21000101l);
        long msisdn = getParaToLong(("msisdn"), -1l);

        String prefix = msisdn + "_" + sd + "_" + ed;

        String fileName = ExcelExport.checkFileExists(prefix);
        if (fileName == null) {

            String where = "where procedure_starttime >= ? and procedure_starttime < ? " + (msisdn == -1 ? "" : " and" +
                    " msisdn = " + msisdn);

            List<UserDetailsDao> list = UserDetailsDao.dao.find(PropKit.get("LTE_SQL").replace("$where", where), sd,
                    ed);
            String[] headStr = {
                    "手机号码", "开始时间", "结束时间", "终端型号", "终端厂家", "业务大类", "业务小类", "访问站点", "详细站点",
                    "状态", "错误码", "上行流量", "下行流量", "平均响应时间", "APN", "网络类型", "服务小区"};
            String[] key = {"msisdn",
                    "procedure_starttime_ms",
                    "procedure_endtime_ms",
                    "tactype",
                    "tacbrnd",
                    "app_type_name",
                    "app_sub_type_name",
                    "host",
                    "uri",
                    "status_code",
                    "",
                    "ul_data",
                    "dl_data",
                    "bus_lantency",
                    "apn",
                    "rat_code",
                    "cell_name"};
            fileName = ExcelExport.exportExcelFile(list, prefix, headStr, key);
        }
        renderText(fileName);
    }

    /**
     * 分页查询
     *
     * @param msisdn
     * @param startDate
     * @param endDate
     * @param page
     * @param size
     * @return
     * @throws ParseException
     * @throws SQLException
     */
    private Pager getPager(long msisdn, long startDate, long endDate, int page, int size) throws ParseException,
            SQLException {
        Connection connection = DbKit.getConfig(DbType.GBASE.getValue()).getConnection();
        Pager pager = new Pager();

        LinkedHashMap<String, Long> tabMap = getPlanTab(startDate, endDate);
        List<String> tabNameList = getFactTab(connection, tabMap);


        LinkedHashMap<String, Long> tabCntMap = count(msisdn, tabNameList, startDate, endDate);

        long cntSum = 0l;
        for (long cnt : tabCntMap.values()) {
            cntSum += cnt;
        }

        pager.setRecords(cntSum);
        pager.setSize(size);
        pager.setPage(page);
        pager.setTotal(pager.getRecords() / pager.getSize() + (pager.getRecords() % pager.getSize() > 0 ? 1 : 0));
        List<Map<String, String>> rows = getData(msisdn, page, size, connection, tabNameList, startDate, endDate,
                tabCntMap);
        connection.close();
        pager.setRows(rows);
        return pager;
    }

    /**
     * 查询数据
     *
     * @param msisdn
     * @param page
     * @param size
     * @param connection
     * @param tabNameList
     * @param startDate
     * @param endDate
     * @return
     * @throws SQLException
     */
    private List<Map<String, String>> getData(long msisdn, int page, int size, Connection connection, List<String>
            tabNameList, long startDate, long endDate, LinkedHashMap<String, Long> tabCntMap) throws SQLException {
        long offset = size * (page - 1);

        ArrayList<Map<String, String>> rows = new ArrayList<Map<String, String>>();


        Statement statement = connection.createStatement();
        long ctsCurrent = 0;
        boolean beginSearch = false;

        for (String tabName : tabNameList) {
            System.out.println(tabName);
        }

        for (String tab : tabNameList) {
            long tabCnt = tabCntMap.get(tab);
            String where = getWhere(msisdn, startDate, endDate, tab);
            if (offset < ctsCurrent + tabCnt) {
                if (!beginSearch) {
                    offset = offset - ctsCurrent;
                    StringBuffer sql = new StringBuffer(PropKit.get("LTE_SQL").replaceAll("F_MS_S1U_HTTP", tab).replace
                            ("$where", where)).append(" limit ").append(offset).append(" , ").append(size);
                    rows.addAll(queryRows4Gbase(sql.toString(), statement));
                    beginSearch = true;
                } else {
                    if (rows.size() >= size) {
                        break;
                    } else {
                        StringBuffer sql = new StringBuffer(PropKit.get("LTE_SQL").replaceAll("F_MS_S1U_HTTP", tab)
                                .replace("$where", where)).append(" limit ").append(size - rows.size());
                        rows.addAll(queryRows4Gbase(sql.toString(), statement));
                    }
                }
            } else if (beginSearch) {
                if (rows.size() >= size) {
                    break;
                } else {
                    StringBuffer sql = new StringBuffer(PropKit.get("LTE_SQL").replaceAll("F_MS_S1U_HTTP", tab)
                            .replace("$where", where)).append(" limit ").append(size - rows.size());
                    rows.addAll(queryRows4Gbase(sql.toString(), statement));
                }
            }
            ctsCurrent += tabCntMap.get(tab);

        }
        statement.close();
        return rows;
    }

    /**
     * count
     *
     * @param msisdn
     * @param tabNameList
     * @param startDate
     * @param endDate
     * @return
     */
    private LinkedHashMap<String, Long> count(long msisdn, List<String> tabNameList, long startDate, long endDate) {
        LinkedHashMap<String, Long> cntMap = new LinkedHashMap<String, Long>();

        for (String tab : tabNameList) {
            String where = getWhere(msisdn, startDate, endDate, tab);

            String cntSql = PropKit.get("LTE_SQL_COUNT").replaceAll("F_MS_S1U_HTTP", tab).replace("$where", where);
            long records = Db.use(DbType.GBASE.getValue()).queryLong(cntSql);
            cntMap.put(tab, records);

        }
        System.out.println(cntMap);
        return cntMap;
    }

    /**
     * 获取实际上能查询的表
     *
     * @param connection
     * @param tabMap
     * @return
     * @throws SQLException
     */
    private List<String> getFactTab(Connection connection, LinkedHashMap<String, Long> tabMap) throws SQLException {
        String tabNameSql = "select table_name from information_schema.tables where TABLE_SCHEMA='dw' and " +
                "table_name like '%F_MS_S1U_HTTP%' ORDER BY TABLE_NAME ";

        for (String tabName : tabMap.keySet()) {
            System.out.println(tabName);
        }

        PreparedStatement preparedStatement = connection.prepareStatement(tabNameSql);

        ResultSet resultSet = preparedStatement.executeQuery();

        List<String> tabNameList = new ArrayList<String>();
        while (resultSet.next()) {
            if (tabMap.containsKey(resultSet.getString(1).toUpperCase())) {
                tabNameList.add(resultSet.getString(1).toUpperCase());
            }
        }
        resultSet.close();

        for (String tabName : tabNameList) {
            System.out.println(tabName);
        }

        return tabNameList;
    }


    /**
     * 获取条件范围内可能有的表
     *
     * @param startDate
     * @param endDate
     * @return
     * @throws ParseException
     */
    private static LinkedHashMap<String, Long> getPlanTab(long startDate, long endDate) throws ParseException {
        LinkedHashMap<String, Long> tabMap = new LinkedHashMap<String, Long>();

        System.out.println(startDate);
        System.out.println(endDate);

        Date sDate = DateUtils.parseDate((startDate / 100) + "", new String[]{"yyyyMMdd"});
        Date eDate = DateUtils.parseDate((endDate / 100) + "", new String[]{"yyyyMMdd"});

        System.out.println(sDate);
        System.out.println(eDate);
        System.out.println(sDate.compareTo(eDate));

        while (sDate.compareTo(eDate) <= 0) {
            System.out.println(sDate.compareTo(eDate));
            String tableName = "F_MS_S1U_HTTP_" + DateFormatUtils.format(sDate, "yyyyMMdd");
            System.out.println(tableName);
            tabMap.put(tableName, 1l);
            sDate = DateUtils.addDays(sDate, 1);
        }

        for (String tableName : tabMap.keySet()) {
            System.out.println(tableName);
        }

        return tabMap;
    }

    /**
     * 查询数据库并转化List
     *
     * @param sql
     * @param statement
     * @return
     * @throws SQLException
     */
    private List<Map<String, String>> queryRows4Gbase(String sql, Statement statement) throws SQLException {
        System.out.println(sql);
        List<Map<String, String>> rows = new ArrayList<Map<String, String>>();
        ResultSet resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
            Map<String, String> row = new HashMap<String, String>();
            for (int i = 0; i < resultSet.getMetaData().getColumnCount(); i++) {
                if (resultSet.getString(i + 1) != null)
                    row.put(resultSet.getMetaData().getColumnLabel(i + 1).toUpperCase(), resultSet.getString(i + 1));
            }
            rows.add(row);
        }
        return rows;
    }

    /**
     * where条件
     *
     * @param msisdn
     * @param startDate
     * @param endDate
     * @param tab
     * @return
     */
    private String getWhere(long msisdn, long startDate, long endDate, String tab) {
        String where = "";

        String sdStr = (startDate / 100) + "";
        String edStr = (endDate / 100) + "";
        String time_key = PropKit.get("WHERE_TIME_KEY");

        if (tab.contains(sdStr)) {
            where += " and " + time_key + " >= " + startDate;
        }
        if (tab.contains(edStr)) {
            where += " and " + time_key + " < " + endDate;
        }
        where = "where 1=1 and msisdn = " + msisdn + where;
        return where;
    }


}

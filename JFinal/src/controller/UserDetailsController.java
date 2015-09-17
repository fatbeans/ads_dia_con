package controller;

import adapter.hbase.UserDetailHbaseAdapter;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import dao.Pager;
import dao.UserDetailsDao;
import dialect.XDialect;
import dialect.XGbaseDialect;
import dialect.XGpDialect;
import dic.DbType;
import export.ExcelExport;
import model.UserDetHbaseEntity;
import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xinxin on 2015/7/17.
 */
public class UserDetailsController extends Controller {
    Logger logger = Logger.getLogger(UserDetailsController.class);

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
        int size = getParaToInt("rows", 10);

        long sd = getParaToLong("sd", 20000101l);
        long ed = getParaToLong("ed", 21000101l);
        long msisdn = getParaToLong("msisdn", -1l);

        String dbPre = PropKit.get("dbPre");


        DbType dbType = DbType.HBASE;
        if (dbPre == null) {
            dbType = DbType.HBASE;

        } else {
            dbType = dbPre.contains("GBASE") ? DbType.GBASE : dbPre.contains("GP") ? DbType.GP : DbType.HBASE;

        }

        if (dbType == DbType.HBASE) {
            doForHbase(page, size, sd, ed, msisdn);
            return;
        }

        XDialect xDialect = dbType == DbType.GBASE ? new XGbaseDialect() : new XGpDialect();

        String time_key = PropKit.get("WHERE_TIME_KEY");

        String where = "where " + time_key + " >= ? and " + time_key + " < ? " + (msisdn == -1 ? "" : " and " +
                "msisdn = " + msisdn);

        Pager pager = new Pager();
        pager.setPage(page);
        pager.setSize(size);


        if (getPara("showSql") != null) {
            renderText(xDialect.forPaginate((int) pager.getPage(),
                    (int) pager.getSize
                            (), PropKit.get("LTE_SQL")
                            .replace("$where", where)).replaceFirst("\\?", sd + "").replaceFirst("\\?", ed + ""));
            return;
        }


        long records = Db.use(dbType == DbType.GBASE ? "gbase" : "gp").queryLong(PropKit.get("LTE_SQL_COUNT").replace
                ("$where", where), sd, ed);
        pager.setRecords(records);


        if (pager.getRecords() == 0) {
            pager.setRows(new ArrayList<UserDetailsDao>(0));
        } else {
            List<UserDetailsDao> list = UserDetailsDao.dao.find(xDialect.forPaginate((int) pager.getPage(),
                    (int) pager.getSize(), PropKit.get("LTE_SQL").replace("$where", where)), sd, ed);
            for (UserDetailsDao item : list) {
                String cell_name = item.get("cell_name");
                String start_time = item.get("procedure_starttime_ms").toString();
                String end_time = item.get("procedure_endtime_ms").toString();
                start_time = getTime(start_time);
                end_time = getTime(end_time);
                if (start_time != null) {
                    item.put("procedure_starttime_ms", start_time);
                }
                if (end_time != null) {
                    item.put("procedure_endtime_ms", end_time);
                }
            }
            pager.setRows(list);
        }

        pager.setTotal(pager.getRecords() / pager.getSize() + (pager.getRecords() % pager.getSize() > 0 ? 1 : 0));

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
                    " " +

                    "msisdn = " + msisdn);

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


}

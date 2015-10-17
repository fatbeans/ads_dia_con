package controller;

import adapter.hbase.UserDetailHbaseAdapter;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.DbKit;
import dao.Pager;
import dao.UserDetailsDao;
import dialect.XDialect;
import dialect.XGbaseDialect;
import dialect.XGpDialect;
import dic.DbType;
import export.ExcelExport;
import model.AppInfoEntity;
import model.UserDetHbaseEntity;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


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

    private String mdn2Imsi(String mdn) throws SQLException {
//
        Connection connection = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("select IMSI from map_imsi_mdn where " +
                "mdn=" + mdn);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            String imsi = resultSet.getString(1);
            resultSet.close();
            preparedStatement.close();
            connection.close();
            return imsi;
        }else{
            resultSet.close();
            preparedStatement.close();
            connection.close();
            return null;
        }
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


        if((msisdn+"").length()==11) {
            String imsi = mdn2Imsi(msisdn+"");
            if(imsi == null){
                renderError(488);
            }else {
                msisdn = NumberUtils.toLong(imsi, 0l);
            }
        }

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
        Map<String, AppInfoEntity> appInfoEntityMap = getAppInfo();
        List<UserDetHbaseEntity> list = UserDetailHbaseAdapter.getPage(msisdn + "", sd + "", ed + "");
        joinAppName(appInfoEntityMap, list);
        joinHttpStatus(list);
        joinErrorCode(list);
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


    private void joinHttpStatus(List<UserDetHbaseEntity> list) throws SQLException {
        String sql = "select * from ads_dia_http_status";
        Connection connection = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        HashMap<Integer, String> statusMap = new HashMap<Integer, String>();

        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            statusMap.put(resultSet.getInt(1), resultSet.getString(2));
        }
        resultSet.close();
        preparedStatement.close();
        connection.close();

        for (UserDetHbaseEntity item : list) {
            String var = statusMap.get(NumberUtils.toInt(item.STATUS_CODE, -1));
            if (var != null) {
                item.STATUS_CODE = var;
            }
        }
    }

    private void joinErrorCode(List<UserDetHbaseEntity> list) throws SQLException {
        String sql = "select error_code,fail_cause,fial_scene_ch from ADS_DIA_ERROR_CODE where proto_type_code=15";
        Connection connection = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        HashMap<Integer, String> erroeCodeMap = new HashMap<Integer, String>();

        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            erroeCodeMap.put(resultSet.getInt(1), resultSet.getString(2) + "," + resultSet.getString(3));
        }
        resultSet.close();
        preparedStatement.close();
        connection.close();

        for (UserDetHbaseEntity item : list) {
            String var = erroeCodeMap.get(NumberUtils.toInt(item.ERROR_CODE, -1));
            if (var != null) {
                String[] v = var.split(",");
                item.FIAL_SCENE_EN = v[0];
                item.FIAL_SCENE_CH = v[1];
            }
        }
    }

    private void joinAppName(Map<String, AppInfoEntity> appInfoEntityMap, List<UserDetHbaseEntity> list) {
        for (UserDetHbaseEntity item : list) {
            AppInfoEntity appInfoEntity = appInfoEntityMap.get(AppInfoEntity.getKey(NumberUtils.toInt(item
                    .APP_TYPE_NAME, 0), NumberUtils.toInt(item.APP_SUB_TYPE_NAME, 0)));
            if (appInfoEntity != null) {
                item.APP_TYPE_NAME = appInfoEntity.appTypeName;
                item.APP_SUB_TYPE_NAME = appInfoEntity.appSubTypeName;
            }
        }
    }


    private Map<String, AppInfoEntity> getAppInfo() throws SQLException {
        Connection connection = DbKit.getConfig("orcl").getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(PropKit.get
                ("LTE_APP_SQL"));
        ResultSet resultSet = preparedStatement.executeQuery();
        HashMap<String, AppInfoEntity> map = new HashMap<String, AppInfoEntity>();
        while (resultSet.next()) {
            Integer appID = resultSet.getBigDecimal("APP_TYPE_ID").intValue();
            String appName = resultSet.getString("APP_TYPE_NAME");
            Integer appSubID = resultSet.getBigDecimal("APP_SUB_TYPE_ID").intValue();
            String appSubName = resultSet.getString("APP_SUB_TYPE_NAME");
            AppInfoEntity entity = new AppInfoEntity(appID, appName, appSubID, appSubName);

            map.put(entity.getKey(), entity);


        }
        resultSet.close();
        preparedStatement.close();
        connection.close();
        return map;
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


    public void export() throws Exception {

        long sd = getParaToLong(("sd"), 20000101l);
        long ed = getParaToLong(("ed"), 21000101l);
        long msisdn = getParaToLong(("msisdn"), -1l);

        String prefix = msisdn + "_" + sd + "_" + ed;

        String fileName = ExcelExport.checkFileExists(prefix);
        if (fileName == null) {


            Map<String, AppInfoEntity> appInfoEntityMap = getAppInfo();
            List<UserDetHbaseEntity> list = UserDetailHbaseAdapter.getPage(msisdn + "", sd + "", ed + "");
            joinAppName(appInfoEntityMap, list);
            joinHttpStatus(list);
            joinErrorCode(list);

            JSONArray array = new JSONArray();
            array.addAll(list);

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
            fileName = ExcelExport.exportExcelFile(array, prefix, headStr, key);
        }
        renderText(fileName);
    }


}

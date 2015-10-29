package controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.DbKit;
import dic.DbType;
import export.ExcelExport;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.time.DateFormatUtils;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by xinxin on 2015/9/6.
 */
public class ConclusionStatController extends Controller {

    /**
     * 地市下拉数据
     *
     * @throws SQLException
     */
    public void getCity() throws SQLException {
        String s = PropKit.get("CITY_SQL");
        Connection connection = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(s);
        ResultSet resultSet = preparedStatement.executeQuery();

        JSONArray array = new JSONArray();
        while (resultSet.next()) {
            if (resultSet.getString(1) != null && resultSet.getString(2) != null) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("id", resultSet.getString(1));
                jsonObject.put("name", resultSet.getString(2));
                array.add(jsonObject);
            }
        }
        resultSet.close();
        preparedStatement.close();
        connection.close();
        renderJson(array.toJSONString());
    }

    /**
     * 结论下拉数据
     */
    public void getConCfg() throws SQLException {
        String s = PropKit.get("CON_CFG_SQL");
        Connection connection = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(s);
        ResultSet resultSet = preparedStatement.executeQuery();

        JSONArray array = new JSONArray();
        while (resultSet.next()) {
            if (resultSet.getString(1) != null && resultSet.getString(2) != null && resultSet.getString(3) != null &&
                    resultSet.getString(4) != null) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("lv1id", resultSet.getString(1));
                jsonObject.put("lv1name", resultSet.getString(2));
                jsonObject.put("lv2id", resultSet.getString(3));
                jsonObject.put("lv2name", resultSet.getString(4));
                array.add(jsonObject);
            }
        }
        resultSet.close();
        preparedStatement.close();
        connection.close();
        renderJson(array.toJSONString());
    }


    /**
     * 查询结论
     *
     * @throws SQLException
     */
    public void concUnder() throws SQLException {
        String sd = getPara("sd", DateFormatUtils.format(new Date(), "yyyyMMdd"));
        String ed = getPara("ed", DateFormatUtils.format(new Date(), "yyyyMMdd"));
        long msisdn = getParaToLong("msisdn", 0l);

        long lv2_con_id = getParaToLong("lv2_con_id", -1l);
        int cityId = getParaToInt("cityId", 0);

        List<Map<String, String>> data = new ArrayList<Map<String, String>>();

        getCtlCellData(sd, ed, lv2_con_id, data, cityId, msisdn);


        JSONObject json = new JSONObject();
        json.put("rows", data);
        System.out.println(json.toJSONString());
        renderJson(json.toJSONString());
    }

    private void getHttpSpResData(String sd, long lv2_con_id, List<Map<String, String>> data) throws SQLException {
        String sql = PropKit.get("HTTP_SP_RES_STAT");
        Connection connection = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setLong(1, lv2_con_id);
        preparedStatement.setString(2, sd);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            HashMap<String, String> row = new HashMap<String, String>();
            for (int i = 0; i < resultSet.getMetaData().getColumnCount(); i++) {
                try {
                    row.put(resultSet.getMetaData().getColumnName(i + 1), resultSet.getObject(i + 1).toString());
                } catch (NullPointerException e) {

                }
            }
            data.add(row);
        }
        try {
            resultSet.close();
            preparedStatement.close();

        } catch (Exception e) {
        } finally { connection.close(); }
    }

    private void getCtlCellData(String sd, String ed, long lv2_con_id, List<Map<String, String>> data, int cityId,
                                long msisdn)
            throws
            SQLException {
        String sql = PropKit.get("VIEW_LIST_STAT");
        if (msisdn != 0) {
            sql = sql.replace("1=1", "a.usr=" + msisdn);
        }
        Connection connection = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        int startTime = NumberUtils.toInt(sd);
        int endTime = NumberUtils.toInt(ed);

        System.out.println("sd = [" + startTime + "], ed = [" + endTime + "], lv2_con_id = [" + lv2_con_id + "], data" +
                " = ["
                + data
                + "], cityId = [" + cityId + "], msisdn = [" + msisdn + "]");
        preparedStatement.setLong(1, lv2_con_id);
        preparedStatement.setInt(2, cityId);
        preparedStatement.setInt(3, startTime);
        preparedStatement.setInt(4, endTime);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            HashMap<String, String> row = new HashMap<String, String>();
            for (int i = 0; i < resultSet.getMetaData().getColumnCount(); i++) {
                try {
                    row.put(resultSet.getMetaData().getColumnName(i + 1), resultSet.getObject(i + 1).toString());
                } catch (NullPointerException e) {

                }
            }
            data.add(row);
        }

        try{
            resultSet.close();
            preparedStatement.close();
        }catch (Exception e){

        }finally {
            connection.close();
        }
    }

    private void getCtlMmeData(String sd, long lv2_con_id, List<Map<String, String>> data) throws SQLException {
        String sql = PropKit.get("CTL_MME_STAT");
        Connection connection = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setLong(1, lv2_con_id);
        preparedStatement.setString(2, sd);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            HashMap<String, String> row = new HashMap<String, String>();
            for (int i = 0; i < resultSet.getMetaData().getColumnCount(); i++) {
                try {
                    row.put(resultSet.getMetaData().getColumnName(i + 1), resultSet.getObject(i + 1).toString());
                } catch (NullPointerException e) {

                }
            }
            data.add(row);
        }
        try {
            resultSet.close();
            preparedStatement.close();
        }catch (Exception e){ }
        finally { connection.close(); }
    }

    private void getDnsDelayData(List<Map<String, String>> data) throws SQLException {
        String sql = PropKit.get("DNS_DELAY_STAT");
        Connection connection = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            HashMap<String, String> row = new HashMap<String, String>();
            for (int i = 0; i < resultSet.getMetaData().getColumnCount(); i++) {
                try {
                    row.put(resultSet.getMetaData().getColumnName(i + 1), resultSet.getObject(i + 1).toString());
                } catch (NullPointerException e) {
                }
            }
            data.add(row);
        }
        try{
            resultSet.close();
            preparedStatement.close();
        }catch (Exception e){}
        finally { connection.close(); }
    }

    private void getDnsEcStatData(long lv2_con_id, List<Map<String, String>> data) throws SQLException {
        String sql = PropKit.get("DNS_EC_STAT");
        Connection connection = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setLong(1, lv2_con_id);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            HashMap<String, String> row = new HashMap<String, String>();
            for (int i = 0; i < resultSet.getMetaData().getColumnCount(); i++) {
                try {
                    row.put(resultSet.getMetaData().getColumnName(i + 1), resultSet.getObject(i + 1).toString());
                } catch (NullPointerException e) {

                }
            }
            data.add(row);
        }
        try{
            resultSet.close();
            preparedStatement.close();

        }catch (Exception e){}
        finally { connection.close();
        }
    }


    public void initEomsExcel() throws Exception {
        String jsStr = getPara("data");
        if (jsStr != null) {
            JSONArray array = JSONArray.parseArray(jsStr);

            String[] header = new String[]{"网元类型", "网元名称", "网元归属地市", "诊断问题", "影响人数"};
            String[] key = new String[]{"NETYPE", "NENAME", "NECITY", "LV2_CON_NAME", "SCNT"};

            String fileName = PropKit.get("FILE_PRE") + DateFormatUtils.format(new Date(),
                    "yyyyMmddHHmmssSSS") + ".xlsx";
            System.out.println(fileName);
            File file = new File(PropKit.get("FILE_PATH") + fileName);

            ExcelExport.createExcelFile(file, array, header, key,"工单网元");
            renderText(fileName);

        } else {
            renderError(501);
        }
    }

}

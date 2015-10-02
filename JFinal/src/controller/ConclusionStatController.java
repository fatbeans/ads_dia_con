package controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.DbKit;
import dic.DbType;
import model.ConEntity;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by xinxin on 2015/9/6.
 */
public class ConclusionStatController extends Controller {

    public void concUnder() throws SQLException {
        String sd = getPara("sd", DateFormatUtils.format(new Date(), "yyyyMMdd"));
        sd = StringUtils.rightPad(sd, 6, "0").substring(0, 6);
        long lv2_con_id = getParaToLong("lv2_con_id", -1l);

        List<Map<String, String>> data = new ArrayList<Map<String, String>>();
//        DNS服务器出错 DNS域名服务器不支持请求的类型 DNS拒绝服务
        if (lv2_con_id == 10020005 || lv2_con_id == 10020006 || lv2_con_id == 10020007) {
            getDnsEcStatData(lv2_con_id, data);
        }
//        用户侧DNS解析时延问题 核心侧DNS解析时延问题
        else if (lv2_con_id == 10030008 || lv2_con_id == 10020008) {
            getDnsDelayData(data);
        }
//        核心侧·质量问题 核心侧·高负荷 核心侧·核查参数
        else if (lv2_con_id == 10020002 || lv2_con_id == 10020001 || lv2_con_id == 10020009) {
            getCtlMmeData(sd, lv2_con_id, data);
        }
//        弱覆盖 质差小区 高负荷
        else if (lv2_con_id == 10010001 || lv2_con_id == 10010002 || lv2_con_id == 10010003) {
            getCtlCellData(sd, lv2_con_id, data);
        }
//        业务属网外资源
        else if(lv2_con_id == 10050001){
            getHttpSpResData(sd, lv2_con_id, data);
        }

        JSONObject json = new JSONObject();
        json.put("rows", data);
        System.out.println(json.toJSONString());
        renderJson(json.toJSONString());


    }

    private void getHttpSpResData(String sd, long lv2_con_id, List<Map<String, String>> data) throws SQLException {
        String sql = PropKit.get("HTTP_SP_RES_STAT");
        PreparedStatement preparedStatement = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection()
                .prepareStatement(sql);
        preparedStatement.setLong(1, lv2_con_id);
        preparedStatement.setString(2, sd);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            HashMap<String, String> row = new HashMap<String, String>();
            for (int i = 0; i < resultSet.getMetaData().getColumnCount(); i++) {
                row.put(resultSet.getMetaData().getColumnName(i + 1), resultSet.getObject(i + 1).toString());
            }
            data.add(row);
        }

        resultSet.close();
        preparedStatement.close();
    }

    private void getCtlCellData(String sd, long lv2_con_id, List<Map<String, String>> data) throws SQLException {
        String sql = PropKit.get("CTL_CELL_STAT");
        PreparedStatement preparedStatement = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection()
                .prepareStatement(sql);
        preparedStatement.setLong(1, lv2_con_id);
        preparedStatement.setString(2, sd);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            HashMap<String, String> row = new HashMap<String, String>();
            for (int i = 0; i < resultSet.getMetaData().getColumnCount(); i++) {
                if(resultSet.getObject(i+1)!=null){
                    row.put(resultSet.getMetaData().getColumnName(i + 1), resultSet.getObject(i + 1).toString());
                }
            }
            data.add(row);
        }

        resultSet.close();
        preparedStatement.close();
    }

    private void getCtlMmeData(String sd, long lv2_con_id, List<Map<String, String>> data) throws SQLException {
        String sql = PropKit.get("CTL_MME_STAT");
        PreparedStatement preparedStatement = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection()
                .prepareStatement(sql);
        preparedStatement.setLong(1, lv2_con_id);
        preparedStatement.setString(2, sd);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            HashMap<String, String> row = new HashMap<String, String>();
            for (int i = 0; i < resultSet.getMetaData().getColumnCount(); i++) {
                row.put(resultSet.getMetaData().getColumnName(i + 1), resultSet.getObject(i + 1).toString());
            }
            data.add(row);
        }
        resultSet.close();
        preparedStatement.close();
    }

    private void getDnsDelayData(List<Map<String, String>> data) throws SQLException {
        String sql = PropKit.get("DNS_DELAY_STAT");
        PreparedStatement preparedStatement = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection()
                .prepareStatement(sql);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            HashMap<String, String> row = new HashMap<String, String>();
            for (int i = 0; i < resultSet.getMetaData().getColumnCount(); i++) {
                row.put(resultSet.getMetaData().getColumnName(i + 1), resultSet.getObject(i + 1).toString());
            }
            data.add(row);
        }
        resultSet.close();
        preparedStatement.close();
    }

    private void getDnsEcStatData(long lv2_con_id, List<Map<String, String>> data) throws SQLException {
        String sql = PropKit.get("DNS_EC_STAT");
        PreparedStatement preparedStatement = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection()
                .prepareStatement(sql);
        preparedStatement.setLong(1, lv2_con_id);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            HashMap<String, String> row = new HashMap<String, String>();
            for (int i = 0; i < resultSet.getMetaData().getColumnCount(); i++) {
                try {
                    row.put(resultSet.getMetaData().getColumnName(i + 1), resultSet.getObject(i + 1).toString());
                }catch (NullPointerException e){

                }
            }
            data.add(row);
        }
        resultSet.close();
        preparedStatement.close();
    }

}

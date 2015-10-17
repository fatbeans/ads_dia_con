package controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.DbKit;
import model.EomsOrder;
import org.apache.commons.lang.StringUtils;
import util.DbOpUtil;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by xinxin on 2015/7/13.
 */
public class WorkCotronller extends Controller {
//    dw_dm_co_city

    public void downFileTest() {
        String fileName = "g:/10_3_10010.log";
        File f = new File(fileName);
        if (f.exists()) {
            renderFile(f);
        } else {
            renderError(690);
        }

    }

    public void getRange() throws SQLException {
        String sql = PropKit.get("RANGE_SQL");
        Connection connection = DbKit.getConfig().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        ResultSet resultSet = preparedStatement.executeQuery();
        JSONArray array = new JSONArray();
        while (resultSet.next()) {
            if (resultSet.getString(1) != null && resultSet.getString(2) != null) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("rangeid", resultSet.getString(1));
                jsonObject.put("rangename", resultSet.getString(2));
                array.add(jsonObject);
            }
        }
        resultSet.close();
        preparedStatement.close();
        connection.close();
        renderJson(array.toJSONString());
    }

    public void addNeEomsOrder(String neType, String neNames, String woId) throws SQLException {
        System.out.println("开始插入");

        String sql = "insert into rel_wo_conc(ne_type, ne_name,  wo_id) values (?,?,?)";

        Connection connection = DbKit.getConfig().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        connection.setAutoCommit(false);
        for (String neName : StringUtils.split(neNames, ",")) {
            System.out.println(neName);
            if (StringUtils.isNotBlank(neName)) {
                preparedStatement.setString(1, neType);
                preparedStatement.setString(2, neName.trim());
                preparedStatement.setString(3, woId);
                preparedStatement.addBatch();
            }
        }

        preparedStatement.executeBatch();
        connection.commit();
        connection.setAutoCommit(true);
        preparedStatement.close();
        connection.close();
        System.out.println("插入完毕");

    }

    public void getCity() throws SQLException {
        String sql = PropKit.get("CITY_SQL");
        Connection connection = DbKit.getConfig().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        ResultSet resultSet = preparedStatement.executeQuery();
        JSONArray array = new JSONArray();
        while (resultSet.next()) {
            if (resultSet.getString(1) != null && resultSet.getString(2) != null) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("citykey", resultSet.getString(1));
                jsonObject.put("cityname", resultSet.getString(2));
                array.add(jsonObject);
            }
        }
        resultSet.close();
        preparedStatement.close();
        connection.close();
        renderJson(array.toJSONString());
    }


    /**
     * 新建工单
     *
     * @throws SQLException
     */
    public void addWork() throws SQLException {
        String workId = getPara("wo_id");
        String neNames = getPara("neNames");
        EomsOrder workObj = EomsOrder.initEomsOrder(getParaMap());

        boolean update = false;

        if (StringUtils.isNotBlank(workId)) {
            update = checkExists(workId);
        } else {
            update = false;
        }

        if (!update) {
            workId = addWrokData(workId, workObj);
            addNeEomsOrder(workObj.getNeType(),neNames,workId);
        } else {
            workId = updateWrokData(workId, workObj);
        }

        JSONObject res = new JSONObject();
        res.put("workId", workId);

        renderJson(res.toJSONString());
    }

    private String updateWrokData(String workId, EomsOrder workObj) throws SQLException {
        String orderSql = "update  W_WORKORDER_INFO set CITY_KEY = ?, CITY = ?, WO_RANGE_ID = ? , WO_RANGE = ?, " +
                "WO_CONTENT = ?, WO_NETYPE =  ?,SEND_STATUS=? where wo_id = " + workId;
        Connection connection = DbKit.getConfig("orcl").getConnection();
        PreparedStatement statement = connection.prepareStatement(orderSql);
        try {
            statement.setString(1, workObj.getCityKey());
            statement.setString(2, workObj.getCityName());
            statement.setString(3, workObj.getRangeId());
            statement.setString(4, workObj.getRangeName());
            statement.setString(5, workObj.getContent());
            statement.setString(6, workObj.getNeType());
            statement.setString(7, workObj.getSendStatus());
            statement.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
        statement.close();
        connection.close();
        return workId;
    }


    private String addWrokData(String workId, EomsOrder workObj) throws SQLException {
        Connection connection = DbKit.getConfig("orcl").getConnection();
        Statement statement = connection.createStatement();
        try {
            String workIdSql = "select SEQ_W_WORKORDER_INFO.nextval as WORKID from dual";
            List<Map<String, String>> workIdData = DbOpUtil.query(workIdSql, statement);
            workId = workIdData.get(0).get("WORKID");
            workObj.setDetailUrl(PropKit.get("DETAIL_URL") + "?workId=" + workId);

            String workTitleIndexSql = "select SEQ_WORKORDER_TITLE_INDEX.nextval as TITLEINDEX from dual";
            List<Map<String, String>> workIndexData = DbOpUtil.query(workTitleIndexSql, statement);
            String workTitleIndex = workIndexData.get(0).get("TITLEINDEX");
            workTitleIndex = ("000" + workTitleIndex).substring(workTitleIndex.length() + 3 - 4, workTitleIndex
                    .length() + 3);

            String orderSql = "insert into W_WORKORDER_INFO(WO_ID,WO_TITLE,CITY_KEY,CITY,WO_TYPE," +
                    "WO_TYPE_SUB,WO_RANGE_ID,WO_RANGE,WO_CONTENT,WO_NETYPE,WO_SEND_WAY,WO_CREATE_TIME," +
                    "SEND_STATUS,FILE_NAME,DETAIL_URL) values(" + workId + "," +
                    "'" + workObj.getEomsOrderTitle() + "-" + workTitleIndex + "'," +
                    workObj.getCityKey() + ",'" + workObj.getCityName() + "'," + workObj.getTypeId() + "," +
                    workObj.getTypeSubId() + "," + workObj.getRangeId() + ",'" + workObj.getRangeName() + "'," +
                    "'" + workObj.getContent() + "','" + workObj.getNeType() + "','" + workObj.getSendWay() + "'," +
                    "sysdate," + workObj.getSendStatus() + ",'" + workObj.getFileName() + "','" + workObj
                    .getDetailUrl() + "')";
            DbOpUtil.exec(orderSql, statement);
        } catch (Exception e) {
            e.printStackTrace();
        }
        statement.close();
        connection.close();
        return workId;
    }


    private boolean checkExists(String workId) throws SQLException {

        String sql = PropKit.get("EXIST_WORK_SQL");
        Connection connection = DbKit.getConfig("orcl").getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, workId);
        ResultSet resultSet = preparedStatement.executeQuery();
        boolean isExists = false;
        if (resultSet.next()) {
            isExists = resultSet.getInt(1) > 0 ? true : false;
        } else {
            isExists = false;
        }
        return isExists;


    }


    /**
     * 查询记录
     */
    public void getWorkFields() throws SQLException {

        String type = getPara("type");
        String parent = getPara("parent");
        List<Map<String, String>> resultDatas = new ArrayList<Map<String, String>>();
        Connection connection = DbKit.getConfig("orcl").getConnection();
        Statement statement = connection.createStatement();
        try {
            String sql = "select dic_id as key,dic_name as value,dic_search as search,dic_remark as remark " +
                    "from WORK_DICTIONARY where 1=1 ";
            if (type != null && !"".equals(type)) {
                sql += " and dic_type='" + type + "' ";
            }
            if (parent != null && !"".equals(parent)) {
                sql += " and dic_id in (select dic_id from WORK_DICTIONARY_REL where dic_parent='" + parent + "') ";
            }
            sql += " order by dic_id";
            List<Map<String, String>> searchDatas = DbOpUtil.query(sql, statement);
            for (int s = 0; s < searchDatas.size(); s++) {
                Map<String, String> searchObj = searchDatas.get(s);
                Map<String, String> dataObj = new HashMap<String, String>();
                dataObj.put("key", searchObj.get("KEY"));
                dataObj.put("value", searchObj.get("VALUE"));
                dataObj.put("search", searchObj.get("SEARCH"));
                dataObj.put("remark", searchObj.get("REMARK"));
                resultDatas.add(dataObj);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        statement.close();
        connection.close();
        renderJson(JSONObject.toJSONString(JSON.toJSON(resultDatas)));
    }

    /**
     * 查询工单列表
     *
     * @return
     */
    public void getTasks() throws SQLException {

        int page = getParaToInt("page");
        int rows = getParaToInt("rows");
        Map<String, String[]> taskObj = getParaMap();
        Connection connection = DbKit.getConfig("orcl").getConnection();
        Statement statement = connection.createStatement();

        Map<String, Object> resultData = new HashMap<String, Object>();
        try {
            String sql = "select t1.WO_ID,t1.WO_TITLE,t1.CITY,t2.DIC_NAME as WO_TYPE," +
                    "t3.DIC_NAME as WO_TYPE_SUB," +
                    "t1.WO_RANGE as WO_RANGE,t1.WO_CONTENT,t1.WO_NETYPE," +
                    "t1.WO_SEND_WAY,to_char(t1.WO_CREATE_TIME,'yyyy-mm-yy hh24:mi:ss') as WO_CREATE_TIME," +
                    "to_char(t1.WO_SEND_TIME,'yyyy-mm-yy hh24:mi:ss') as WO_SEND_TIME," +
                    "t1.WO_SEND_DEPARTMENT,t1.RECEIVE_USER," +
                    "t1.EOMS_ID,t1.EOMS_STATUS, " +
                    "to_char(t1.WO_CLOSE_TIME,'yyyy-mm-yy hh24:mi:ss') as WO_CLOSE_TIME," +
                    "t1.SEND_STATUS,t1.FILE_NAME " +
                    " from W_WORKORDER_INFO t1 left join WORK_DICTIONARY t2 on t1.WO_TYPE=t2.DIC_ID " +
                    " left join WORK_DICTIONARY t3 on t1.WO_TYPE_SUB=t3.DIC_ID where 1=1 ";
            if (taskObj.get("fromTime") != null) {
                sql += " and t1.WO_CREATE_TIME >= to_date('" + taskObj.get("fromTime")[0] + " 000000', 'yyyymmdd " +
                        "hh24miss')";
            }
            if (taskObj.get("endTime") != null) {
                sql += " and t1.WO_CREATE_TIME <= to_date('" + taskObj.get("endTime")[0] + " 235959', 'yyyymmdd " +
                        "hh24miss')";
            }
            if (taskObj.get("types") != null) {
                sql += " and t2.DIC_ID in (" + taskObj.get("types")[0] + ")";
            }
            if (taskObj.get("typesubs") != null) {
                sql += " and t3.DIC_ID in (" + taskObj.get("typesubs")[0] + ")";
            }
            if (taskObj.get("ranges") != null) {
                sql += " and t1.WO_RANGE like '%" + taskObj.get("ranges")[0] + "%' ";
            }
            int start = (page - 1) * rows + 1;
            int end = page * rows;
            String pageSql = " select * from ( select temp.*, rownum rn from (  " + sql +
                    " ) temp where rownum <= " + end + " ) where rn >= " + start;
            List<Map<String, String>> searchDatas = DbOpUtil.query(pageSql, statement);
            String countSql = " select count(*) as countNum from (" + sql + ") tttt1 ";
            List<Map<String, String>> countDatas = DbOpUtil.query(countSql, statement);
            resultData.put("total", countDatas.get(0).get("COUNTNUM"));
            resultData.put("rows", searchDatas);
        } catch (Exception e) {
            e.printStackTrace();
        }
        statement.close();
        connection.close();
        renderJson(JSON.toJSONString(JSON.toJSON(resultData)));
    }

    /**
     * 查询工单详情
     *
     * @return
     * @throws Exception
     */
    public void getTaskOne() throws Exception {
        String workId = getPara("workId");
        String sql = "select t1.WO_ID,t1.WO_TITLE,t1.CITY," +
                "t2.DIC_NAME as WO_TYPE,t3.DIC_NAME as WO_TYPE_SUB," +
                "t1.WO_RANGE as WO_RANGE,t1.WO_CONTENT,t1.WO_NETYPE," +
                "t1.WO_SEND_WAY,to_char(t1.WO_CREATE_TIME,'yyyy-mm-yy hh24:mi:ss') as WO_CREATE_TIME," +
                "to_char(t1.WO_SEND_TIME,'yyyy-mm-yy hh24:mi:ss') as WO_SEND_TIME," +
                "t1.WO_SEND_DEPARTMENT,t1.RECEIVE_USER," +
                "t1.EOMS_ID,t1.EOMS_STATUS, " +
                "to_char(t1.WO_CLOSE_TIME,'yyyy-mm-yy hh24:mi:ss') as WO_CLOSE_TIME," +
                "t1.SEND_STATUS,t1.FILE_NAME,t1.DETAIL_URL from W_WORKORDER_INFO t1 " +
                " left join WORK_DICTIONARY t2 on t1.WO_TYPE=t2.DIC_ID " +
                " left join WORK_DICTIONARY t3 on t1.WO_TYPE_SUB=t3.DIC_ID where 1=1 ";
        if (workId != null && !"".equals(workId)) {
            sql += " and t1.WO_ID=" + workId;
        }
        Connection connection = DbKit.getConfig("orcl").getConnection();
        Statement statement = connection.createStatement();
        List<Map<String, String>> countDatas = DbOpUtil.query(sql, statement);
        statement.close();
        connection.close();
        if (countDatas.size() != 1) {
            renderJson("");
        } else {
            renderJson(JSONObject.toJSONString(JSON.toJSON(countDatas.get(0))));
        }
    }


    public void downFile() throws Exception {
        HttpServletResponse response = getResponse();
        String filePath = PropKit.get("FILE_PATH");

        String fileName = getPara("fileName");
        if (StringUtils.isBlank(fileName) || fileName.equals("null")) {
            System.out.println("文件名" + fileName + "异常");
            renderError(403);
        }
        if (filePath != null && !"".equals(filePath)) {
            String fileAllPath = filePath + fileName;
            File f = new File(fileAllPath);
            if (f.exists()) {
                renderFile(f);
            } else {
                System.out.println("文件" + f.getAbsolutePath() + "不存在");
                renderError(403);
            }
        }
    }
}
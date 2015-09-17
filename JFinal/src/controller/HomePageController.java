package controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.kit.HashKit;
import com.jfinal.kit.JsonKit;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.DbKit;
import com.jfinal.plugin.activerecord.Model;
import dao.adsDiaCon.*;
import dic.DbType;
import dic.Lv2Con;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.time.DateFormatUtils;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by xinxin on 2015/8/7.
 */
public class HomePageController extends Controller {
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss.SSS");

    /**
     * 首面-客服-查询
     *
     * @throws IOException
     * @throws InterruptedException
     */
    public void cust() throws IOException, InterruptedException, SQLException {
        String sd = getPara("sd").replaceAll("/", "").replaceAll(" ", "");
        String ed = getPara("ed").replaceAll("/", "").replaceAll(" ", "");
        String msisdn = getPara("msisdn");
        String sessionId = (Long.valueOf(HashKit.md5(sd + ed + msisdn).substring(9, 24), 16) + "");
        System.out.println("session_id:" + sessionId);
        boolean isInDB = isInDB(sessionId);
        System.out.println(sessionId + "|first in db?" + isInDB);
        if (!isInDB) {

            //发送查询请求
            boolean isCompelete = sendAnalyse(sd, ed, msisdn, sessionId);

            if (isCompelete) {
//            检查结论是否入库
                int waitTime = 0;
                long space = 5000;
                while (!isInDB) {
                    isInDB = isInDB(sessionId);
                    Thread.sleep(space);
                    waitTime += space;
                    if (waitTime >= PropKit.getInt("waitTimeS")) {
                        break;
                    }
                }
            } else {
                renderError(412);
            }
        }

        if (isInDB) {
            insertLog(sessionId, sd.substring(0, 8), msisdn, null, sd, ed);
            renderJson(datadispose(sessionId, msisdn));
        } else {
            renderError(411);
        }

    }

    /**
     * 检查结论是否插入数据库
     *
     * @param sessionId
     * @return
     */
    private boolean isInDB(String sessionId) {
        List<AdsDiaCon> list = AdsDiaCon.dao.find(PropKit.get("CON_IS_IN_DB_SQL"), sessionId);

        return list.size() > 0;
    }

    public void test() {
        for (String s : getColName(Lv2Con.DNS拒绝服务)) {
            System.out.println(s);
        }

    }

    private void insertLog(String session_id, String day_key, String mdn, String imsi, String sd, String ed) throws
            SQLException {
        PreparedStatement statement = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection().prepareStatement
                (PropKit.get
                        ("USR_INSERT"));

        statement.setBigDecimal(1, BigDecimal.valueOf(NumberUtils.toLong(session_id, 0)));
        statement.setBigDecimal(2, BigDecimal.valueOf(NumberUtils.toLong(day_key), 0));
        statement.setBigDecimal(3, BigDecimal.valueOf(NumberUtils.toLong(mdn), 0));
        statement.setBigDecimal(4, BigDecimal.valueOf(NumberUtils.toLong(imsi), 0));
        statement.setBigDecimal(5, BigDecimal.valueOf(NumberUtils.toLong(StringUtils.rightPad(sd, 14, "0"), 0)));
        statement.setBigDecimal(6, BigDecimal.valueOf(NumberUtils.toLong(StringUtils.rightPad(ed, 14, "0"), 0)));
        statement.setBigDecimal(7, BigDecimal.valueOf(NumberUtils.toLong(DateFormatUtils.format(new Date(),
                "yyyyMMddHHmmss"), 0)));
        statement.execute();
        statement.close();

    }


    /**
     * 结论数据处理
     *
     * @param sessionId
     * @return
     */
    private JSON datadispose(String sessionId, String msisdn) {
        List<AdsDiaCon> conList = AdsDiaCon.dao.find(PropKit.get("ADS_DIA_CON_SQL") + " where session_id=" + sessionId);
        JSONObject data = new JSONObject();
        if (conList.size() > 0) {
            for (AdsDiaCon item : conList) {
                JSONObject lv2Data = getLv2Data(item, sessionId);
                if (lv2Data == null) {
                    continue;
                }
                String lv1id = "id" + lv2Data.getString("lv1id");
                String lv1name = lv2Data.getString("lv1name");
                lv2Data.remove("lv1id");
                lv2Data.remove("lv1name");
                if (data.containsKey(lv1id)) {
                    data.getJSONObject(lv1id).getJSONArray("lv2").add(lv2Data);
                } else {
                    JSONObject lv1 = new JSONObject();
                    lv1.put("lv1name", lv1name);
                    JSONArray lv2 = new JSONArray();
                    lv2.add(lv2Data);
                    lv1.put("lv2", lv2);
                    data.put(lv1id, lv1);
                }

            }

            JSONObject ass = getAssData(sessionId);
            data.put("rfg", ass.getJSONArray("rfg"));
            data.put("gfh", ass.getJSONArray("gfh"));
            data.put("gzc", ass.getJSONArray("gzc"));
            data.put("ywsl", ass.getJSONArray("ywsl"));
            data.put("xysy", ass.getJSONArray("xysy"));

            data.put("bdjl", getVirListData(sessionId));
            data.put("ipjl", getIpListData(sessionId));
            data.put("fxyw", getFloList(sessionId));
            data.put("teInfo", getInfo(sessionId, msisdn));

            return data;
        }
        return null;

    }

    /**
     * 病毒列表
     *
     * @param sessionId
     * @return
     */
    private JSONArray getVirListData(String sessionId) {
        String sql = PropKit.get("LIST_VIR_SQL");
        JSONArray virList = new JSONArray();
        List<UsrVir> list = UsrVir.dao.find(sql + " where session_id = ?", sessionId);
        for (UsrVir item : list) {
            virList.add(item.get("VIRUS_NAME"));
        }
        return virList;
    }

    /**
     * 非法IP列表
     *
     * @param sessionId
     * @return
     */
    private JSONArray getIpListData(String sessionId) {
        String sql = PropKit.get("LIST_IP_SQL");
        JSONArray ipList = new JSONArray();
        List<UsrIlIp> list = UsrIlIp.dao.find(sql + " where session_id = ?", sessionId);
        for (UsrIlIp item : list) {
            ipList.add(item.get("SERVER_IP"));
        }
        return ipList;
    }

    /**
     * 高流量业务
     *
     * @param sessionId
     * @return
     */
    private JSONArray getFloList(String sessionId) {
        DecimalFormat df = new DecimalFormat();
        df.setMaximumFractionDigits(2);
        String sql = PropKit.get("LIST_FLO_SQL");
        JSONArray floList = new JSONArray();
        List<UsrHiFloSrv> list = UsrHiFloSrv.dao.find(sql + " where session_id = ? order by flo desc", sessionId);
        for (UsrHiFloSrv item : list) {

            JSONObject it = new JSONObject();
            it.put("name", item.get("APP_SUB_TYPE_NAME") != null ? item.get("APP_SUB_TYPE_NAME") : "未知业务");
            it.put("flo", df.format(item.getBigDecimal("FLO")));
            floList.add(it);
        }
        return floList;
    }

    /**
     * 辅助分析
     *
     * @param sessionId
     * @return
     */
    private JSONObject getAssData(String sessionId) {
        String sql = PropKit.get("ASS_CELL_SQL");
        System.out.println("查询弱小区（辅助）");
        JSONArray rfg = getAssCellJson(CtlCell.dao.find(sql, sessionId, Lv2Con.弱覆盖.getValue()));
        System.out.println("小区高负荷（辅助）");
        JSONArray gfh = getAssCellJson(CtlCell.dao.find(sql, sessionId, Lv2Con.小区高负荷.getValue()));
        System.out.println("质差小区（辅助）");
        JSONArray gzc = getAssCellJson(CtlCell.dao.find(sql, sessionId, Lv2Con.质差小区.getValue()));

        System.out.println(rfg);
        System.out.println(gfh);
        System.out.println(gzc);

        String srvSql = PropKit.get("ASS_SPD_SQL");
        JSONArray ywsl = getAssSrvJson(UsrSrv.dao.find(srvSql, sessionId));

        String delaySql = PropKit.get("ASS_DELAY_SQL");
        JSONArray xysy = getAssSrvJson(UsrSrv.dao.find(delaySql, sessionId));


        JSONObject res = new JSONObject();
        res.put("rfg", rfg);
        res.put("gfh", gfh);
        res.put("gzc", gzc);
        res.put("ywsl", ywsl);
        res.put("xysy", xysy);

        return res;
    }

    /**
     * 辅助分析-业务
     *
     * @param list
     * @return
     */
    private JSONArray getAssSrvJson(List<UsrSrv> list) {
        JSONArray assJson = new JSONArray();
        if (list == null) {
            return assJson;
        }
        Map<String, List<String>> data = new HashMap<String, List<String>>();
        for (UsrSrv item : list) {
            String name = item.get("APP_SUB_TYPE_NAME");
            String hour = item.getBigDecimal("DAY_KEY").toString() + item.getBigDecimal
                    ("HOUR_KEY")
                    .toString();
            if (!data.containsKey(name)) {
                data.put(name, new ArrayList<String>());
            }
            data.get(name).add(hour);
        }
        assJson = getObjects(data);
        return assJson;
    }

    /**
     * 用户基础信息
     *
     * @param session_id
     * @return
     */
    private JSONObject getInfo(String session_id, String msisdn) {
        String sql = PropKit.get("TAC_INFO_SQL");
        List<AdsDiaHttp> list = AdsDiaHttp.dao.find(sql, session_id);
        String mdn = null;
        String tename = null;
        long cnt = 0;

        if (list.size() > 0) {
            mdn = list.get(0).getBigDecimal("MDN").toString();
            tename = list.get(0).getStr("TE_NAME");
            for (AdsDiaHttp item : list) {
                cnt += item.getBigDecimal("CNT").longValue();
            }
        }

        if (mdn == null) {
            mdn = msisdn;
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("MDN", mdn);
        jsonObject.put("TE_NAME", tename);
        jsonObject.put("CNT", cnt + "");
        jsonObject.putAll(ComplaintController.getCnt(mdn));
        return jsonObject;
    }


    /**
     * 辅助分析小区类
     *
     * @param list
     * @return
     */
    private JSONArray getAssCellJson(List<CtlCell> list) {

        if (list == null || list.size() == 0) {
            return null;
        }
        Map<String, List<String>> data = new HashMap<String, List<String>>();
        for (CtlCell item : list) {
            String name = item.getStr("CELL_NAME") != null ? item.getStr("CELL_NAME") : "未知";
            String hour = item.getNumber("BAD").intValue() == 1 ? (item.getNumber("DAY_KEY").toString() + item.getNumber
                    ("HOUR_KEY").toString()) : "000000";
            if (!data.containsKey(name)) {
                data.put(name, new ArrayList<String>());
            }
            data.get(name).add(hour);
        }
        JSONArray assJson = getObjects(data);
        System.out.println(assJson.toJSONString());
        return assJson;

    }

    private JSONArray getObjects(Map<String, List<String>> data) {
        JSONArray assJson = new JSONArray();
        for (String key : data.keySet()) {
            JSONObject row = new JSONObject();
            row.put("name", key);
            List l = data.get(key);
            JSONArray time = new JSONArray(l);
            row.put("time", time);
            assJson.add(row);
        }
        return assJson;
    }


    /**
     * 二级结论数据
     *
     * @param adsDiaCon
     * @param sessionId
     * @return
     */
    private JSONObject getLv2Data(AdsDiaCon adsDiaCon, String sessionId) {
        if (adsDiaCon.get("LV2_CON_ID") == null) {
            return null;
        }
        int lv2ConId = adsDiaCon.getBigDecimal("LV2_CON_ID").intValue();
        if (lv2ConId <= 0) {
            return null;
        }
        Lv2Con lv2Con = Lv2Con.getLv2Con(lv2ConId);
        String whereLv2Sessionid = " where LV2_CON_ID = ? and  session_id = ? ";
        String whereSessionid = " where session_id = ? ";
        String sql = null;
        List dataList = null;
        switch (lv2Con) {
            case 弱覆盖:
                sql = PropKit.get("CTL_CELL_SQL");
                dataList = CtlCell.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case 质差小区:
                sql = PropKit.get("CTL_CELL_SQL");
                dataList = CtlCell.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case 小区高负荷:
                sql = PropKit.get("CTL_CELL_SQL");
                dataList = CtlCell.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case 小区时延问题:
                sql = PropKit.get("HTTP_CELL_SQL");
                dataList = HttpCell.dao.find(sql.replace("$where", whereSessionid), sessionId);
                break;
            case 无线侧_工程预约:
                break;
            case 小区核查参数:
                sql = PropKit.get("CTL_CELL_SQL");
                dataList = CtlCell.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case MME高负荷:
                sql = PropKit.get("CTL_MME_SQL");
                dataList = CtlMme.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case MME质量问题:
                sql = PropKit.get("CTL_MME_SQL");
                dataList = CtlMme.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case SGW时延问题:
                sql = PropKit.get("HTTP_SGW_SQL");
                dataList = HttpSgw.dao.find(sql.replace("$where", whereSessionid), sessionId);
                break;
            case 核心侧_工程预约:
                break;
            case DNS服务器出错:
                sql = PropKit.get("DNS_EC_SQL");
                dataList = DnsEc.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case DNS域名服务器不支持请求的类型:
                sql = PropKit.get("DNS_EC_SQL");
                dataList = DnsEc.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case DNS拒绝服务:
                sql = PropKit.get("DNS_EC_SQL");
                dataList = DnsEc.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case 核心侧_DNS解析时延问题:
                sql = PropKit.get("DNS_DELAY_SQL");
                dataList = DnsDelay.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case MME核查参数:
                sql = PropKit.get("CTL_MME_SQL");
                dataList = CtlMme.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case 业务受限:
                sql = PropKit.get("CTL_USR_EC_SQL");
                dataList = CtlUsrEc.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case 用户感染手机病毒:
                sql = PropKit.get("USR_VIR_SQL");
                dataList = UsrVir.dao.find(sql + whereSessionid, sessionId);
                break;
            case 用户访问非法地址:
                sql = PropKit.get("USR_IL_IP_SQL");
                dataList = UsrIlIp.dao.find(sql.replace("$where", whereSessionid), sessionId);
                break;
            case 用户没有产生上网记录:
                break;
            case 用户访问较多容易产生高流量的业务:
                sql = PropKit.get("USR_HI_FLO_SRV_SQL");
                dataList = UsrHiFloSrv.dao.find(sql.replace("$where", whereSessionid), sessionId);
                break;
            case DNS格式错误:
                sql = PropKit.get("DNS_EC_SQL");
                dataList = DnsEc.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case DNS请求的域名错误:
                sql = PropKit.get("DNS_EC_SQL");
                dataList = DnsEc.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case 用户侧_DNS解析时延问题:
                sql = PropKit.get("DNS_DELAY_SQL");
                dataList = DnsDelay.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case 终端质量问题:
                sql = PropKit.get("CTL_TE_SQL");
                dataList = CtlTe.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case 上网记录返回终端侧错误:
                sql = PropKit.get("HTTP_SERV_IP_SQL");
                dataList = HttpServIp.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case 终端时延问题:
                sql = PropKit.get("HTTP_TE_SQL");
                dataList = HttpTe.dao.find(sql.replace("$where", whereSessionid), sessionId);
                break;
            case 用户终端有异常:
                break;
            case 终端APN设置问题:
                sql = PropKit.get("CTL_S_EC_SQL");
                dataList = CtlSEc.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                break;
            case 业务属网外资源:
                sql = PropKit.get("HTTP_LIST_SQL");
                dataList = HttpList.dao.find(sql.replace("$where", whereLv2Sessionid), lv2Con.getValue(), sessionId);
                httpListTimeChange(dataList);
                break;
            case 上网日志返回业务侧错误:
                sql = PropKit.get("HTTP_SERV_IP_SQL").replace("$where", whereLv2Sessionid);
                System.out.println("lv2sql" + sql);
                System.out.println("lv2Con" + lv2Con.getPref());
                System.out.println("seesionid" + sessionId);
                System.out.println("daonull" + HttpServIp.dao == null);
                dataList = HttpServIp.dao.find(sql, lv2Con.getValue(), sessionId);
                break;
            case 业务时延问题:
                sql = PropKit.get("HTTP_SP_SQL");
                dataList = HttpSp.dao.find(sql.replace("$where", whereSessionid), sessionId);
            default:
                break;
        }
        if (dataList != null && dataList.size() > 0) {
            JSONArray colModel = new JSONArray();
            for (String name : getColName(lv2Con)) {
                JSONObject n = new JSONObject();
                n.put("name", name);
                colModel.add(n);
            }
            JSONObject json = new JSONObject();
            json.put("cnt", adsDiaCon.get("CON_NUM"));
            json.put("id", lv2ConId);
            json.put("name", adsDiaCon.get("LV2_CON_NAME"));
            json.put("desc", adsDiaCon.get("LV2_CON_DESC"));
            json.put("ex", adsDiaCon.get("LV2_CON_EXPLAIN"));
            json.put("colModel", colModel);
            json.put("data", JSON.parse(JsonKit.toJson(dataList)));
            json.put("lv1id", adsDiaCon.get("LV1_CON_ID"));
            json.put("lv1name", adsDiaCon.get("LV1_CON_NAME"));
            return json;
        } else {
            return null;
        }
    }


    private void httpListTimeChange(List<Model> dataList) {
        for (Model item : dataList) {
            item.put("start_time", sdf.format(new Date(item.getTimestamp("连接开始时间").getTime())));
            item.put("end_time", sdf.format(new Date(item.getTimestamp("连接结束时间").getTime())));
        }
    }

    /**
     * 调用结论分析
     *
     * @param sd
     * @param ed
     * @param msisdn
     * @param sessionId
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    public static boolean sendAnalyse(String sd, String ed, String msisdn, String sessionId) throws IOException,
            InterruptedException {

        String cmd = PropKit.get("cmd").replaceFirst("\\?", PropKit.get("CONTORL_JAR_PATH")).replaceFirst("\\?",
                PropKit.get
                        ("CONTORL_CONFIG_FILE")).replaceFirst("\\?", sessionId).replaceFirst("\\?", sessionId)
                .replaceFirst("\\?",
                        sd).replaceFirst("\\?", ed).replaceFirst("\\?", msisdn);
        System.out.println(cmd);
        Process p = Runtime.getRuntime().exec(cmd);
        p.waitFor();
        int exitvalue = p.exitValue();
        System.out.println("exitvalue:" + exitvalue);

        return exitvalue == 0;
    }

    private String getSql(Lv2Con con) {
        return PropKit.get(con.getPref() + "_SQL");
    }

    private String[] getColName(Lv2Con con) {
        return StringUtils.split(PropKit.use("colName.properties").get(con.getPref() + "_COL"), ",");
    }


    /**
     * 结论下钻
     *
     * @throws SQLException
     */
    public void concUnder() throws SQLException {
        String server_ip = getPara("server_ip");
        String lv2_con_id = getPara("lv2_con_id");
        String session_id = getPara("session_id");

        String where = "where SERVER_IP = '" + server_ip + "' and LV2_CON_ID = '" + lv2_con_id +
                "' and SESSION_ID= '" + session_id + "'";


        String sql = PropKit.get
                ("HTTP_LIST_SQL").replaceAll("\\$where", where);
        System.out.println("查询SQL" + sql);
        PreparedStatement preparedStatement = DbKit.getConfig(DbType.ORACLE.getValue()).getConnection()
                .prepareStatement(sql);

        ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();

        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            HashMap<String, String> data = new HashMap<String, String>();
            for (int i = 1; i <= resultSet.getMetaData().getColumnCount(); i++) {
                data.put(resultSet.getMetaData().getColumnLabel(i), resultSet.getString(i));
            }
            list.add(data);
        }

        JSONObject json = new JSONObject();
        json.put("rows", list);
        renderJson(json.toJSONString());
    }

}
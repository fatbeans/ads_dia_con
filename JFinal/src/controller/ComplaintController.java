package controller;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import dao.ComplaintDao;
import dao.Pager;
import dao.UserDetailsDao;
import dao.adsDiaCon.Usr;
import dialect.XDialect;
import dialect.XGbaseDialect;
import dialect.XGpDialect;
import dialect.XOracleDialect;
import dic.DbType;
import export.ExcelExport;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by xinxin on 2015/7/17.
 */
public class ComplaintController extends Controller {
    Logger logger = LoggerFactory.getLogger(ComplaintController.class);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");

    /**
     * 诊断明细
     */
    public void searchUsrLog() {
        int page = getParaToInt("page", 1);
        int size = getParaToInt("rows", 10);
        long msisdn = getParaToLong(("msisdn"), -1l);
        if (msisdn == -1) {
            render("");
            return;
        }

        Pager pager = new Pager();
        pager.setPage(page);
        pager.setSize(size);
        pager.setRecords(NumberUtils.toLong(Usr.dao.findFirst(PropKit.get("USR_CNT")).get("CNT").toString(), 0));

        if (pager.getRecords() == 0) {
            pager.setRows(new ArrayList<ComplaintDao>(0));
        } else {
            pager.setRows(Usr.dao.find(new XOracleDialect().forPaginate((int) pager.getPage(), (int) pager.getSize(),
                    PropKit.get("USR_SQL")), msisdn));
        }

        pager.setTotal(pager.getRecords() / pager.getSize() + (pager.getRecords() % pager.getSize() > 0 ? 1 : 0));

        String jsonStr = pager.toJsonString();
        renderJson(jsonStr);
    }

    public void searchHistory() {
        int page = getParaToInt("page", 1);
        int size = getParaToInt("rows", 10);
        long sd = getParaToLong(("sd"), 2000010100l);
        long ed = getParaToLong(("ed"), 2100010100l);
        String msisdn = getPara("msisdn");
        String business_class = getPara("business_class");
        DbType dbType = null;
        if (PropKit.get("dbPre").contains("GBASE")) {
            dbType = DbType.GBASE;
        } else if (PropKit.get("dbPre").contains("GP")) {
            dbType = DbType.GP;
        } else {
            dbType = DbType.GISORCL;
        }

        XDialect xDialect = (dbType == DbType.GBASE ? new XGbaseDialect() : (dbType == DbType.GP ? new XGpDialect() :
                new
                        XOracleDialect()));
        Pager pager = new Pager();
        pager.setPage(page);
        pager.setSize(size);
        System.out.println("page Para:" + msisdn + "|" + sd + "|" + ed);

        String pageSql = PropKit.get("COMP_SQL_PAGE");

        if (StringUtils.isBlank(business_class)) {
            pageSql = pageSql.replace(PropKit.get("COMP_WHERE_BUSINESS"), " ");
        }


        pageSql = StringUtils.isNotBlank(msisdn) ? pageSql.replaceFirst("\\?", msisdn)
                .replaceFirst("\\?", (sd + "")).replaceFirst("\\?", (ed + "")).replaceFirst("\\%\\?\\%", "%" +
                        business_class + "%") : StringUtils.replaceOnce(pageSql, PropKit.get
                ("COMP_WHERE_MDN"), " ").replaceFirst("\\?", (sd + "")).replaceFirst("\\?", (ed + ""))
                .replaceFirst("\\%\\?\\%", "%" + business_class + "%");
        System.out.println(pageSql);
        ComplaintDao complaintDao = ComplaintDao.dao.findFirst(pageSql);
        String cnt = complaintDao.get("cnt") == null ? complaintDao.get("CNT").toString() : complaintDao.get("cnt")
                .toString();
        pager.setRecords(NumberUtils.toLong(cnt, 0));
        if (pager.getRecords() == 0) {
            pager.setRows(new ArrayList<ComplaintDao>(0));
        } else {
            String sql = StringUtils.isBlank(business_class) ? PropKit.get("COMP_SQL").replace(PropKit.get
                    ("COMP_WHERE_BUSINESS"), " ") : PropKit.get("COMP_SQL");

            if (StringUtils.isNotBlank(msisdn)) {
                pager.setRows(ComplaintDao.dao.find(xDialect.forPaginate(page, size,sql )
                                .replaceFirst("\\%\\?\\%", "%" + business_class + "%"),
                        msisdn, sd, ed));
            } else {
                pager.setRows(ComplaintDao.dao.find(xDialect.forPaginate(page, size, StringUtils.replaceOnce(sql, PropKit.get("COMP_WHERE_MDN"), " ")).replaceFirst("\\%\\?\\%", "%" +
                        business_class + "%"), sd, ed));
            }
        }

        pager.setTotal(pager.getRecords() / pager.getSize() + (pager.getRecords() % pager.getSize() > 0 ? 1 : 0));

        String jsonStr = pager.toJsonString();
        System.out.println(jsonStr);
        renderJson(jsonStr);
    }

    public void seachInfo() {

        String sd = getPara("sd", "20000101").replaceAll("/", "").replaceAll(" ", "");
        String ed = getPara("ed", "20000101").replaceAll("/", "").replaceAll(" ", "");
        String msisdn = getPara("msisdn", "-1");
        JSONObject json = new JSONObject();
        json.putAll(getCnt(msisdn));

        renderJson(json.toJSONString());
    }


    /**
     * 上月。本月投诉次数
     *
     * @param msisdn
     * @return
     */
    public static JSONObject getCnt(String msisdn) {
        if (StringUtils.isBlank(msisdn)) {
            JSONObject json = new JSONObject();
            json.put("thisMonCnt", 0);
            json.put("lastMonCnt", 0);
            return json;
        }
        Date thisMonFirDay = DateUtils.truncate(new Date(), Calendar.MONTH);
        String dbPre = PropKit.get("dbPre");
        DbType dbType = dbPre.contains("GBASE") ? DbType.GBASE : dbPre.contains("GP") ? DbType.GP : DbType.HBASE;
        String formatStr = dbType == DbType.GP ? "yyyyMMddHHmmss" : "yyyyMMddHH";

        long cMonFir = Long.parseLong(DateFormatUtils.format(thisMonFirDay, formatStr));
        long pMonFir = Long.parseLong(DateFormatUtils.format(DateUtils.addMonths(thisMonFirDay, -1), formatStr));
        long nMonFir = Long.parseLong(DateFormatUtils.format(DateUtils.addMonths(thisMonFirDay, 1), formatStr));

        System.out.println(cMonFir);
        System.out.println(pMonFir);
        System.out.println(nMonFir);

        ComplaintDao cnt = ComplaintDao.dao.findFirst(PropKit.get("COMP_CNT_SQL"), cMonFir, nMonFir, pMonFir,
                cMonFir, msisdn, pMonFir, nMonFir);

        JSONObject json = new JSONObject();
        System.out.println(cnt.toJson());
        if (dbType == dbType.GP) {
            json.put("thisMonCnt", cnt.get("cmoncnt", 0));
            json.put("lastMonCnt", cnt.get("pmoncnt", 0));
        } else {
            json.put("thisMonCnt", cnt.get("CMONCNT", 0));
            json.put("lastMonCnt", cnt.get("PMONCNT", 0));
        }
        System.out.println(json.toJSONString());
        return json;
    }


//    public void export() {
//
//        long sd = getParaToLong(("sd"), 20000101l);
//        long ed = getParaToLong(("ed"), 21000101l);
//        long msisdn = getParaToLong(("msisdn"), -1l);
//
//        String prefix = msisdn + "_" + sd + "_" + ed;
//
//        String fileName = ExcelExport.checkFileExists(prefix);
//        if (fileName == null) {
//
//            String where = "where procedure_starttime >= ? and procedure_starttime < ? " + (msisdn == -1 ? "" : " and" +
//                    " " +
//
//                    "msisdn = " + msisdn);
//
//            List<UserDetailsDao> list = UserDetailsDao.dao.find(PropKit.get("LTE_SQL").replace("$where", where), sd,
//                    ed);
//            String[] headStr = {
//                    "手机号码", "开始时间", "结束时间", "终端型号", "终端厂家", "业务大类", "业务小类", "访问站点", "详细站点",
//                    "状态", "错误码", "上行流量", "下行流量", "平均响应时间", "APN", "网络类型", "服务小区"};
//            String[] key = {"msisdn",
//                    "procedure_starttime_ms",
//                    "procedure_endtime_ms",
//                    "tactype",
//                    "tacbrnd",
//                    "app_type_name",
//                    "app_sub_type_name",
//                    "host",
//                    "uri",
//                    "status_code",
//                    "",
//                    "ul_data",
//                    "dl_data",
//                    "bus_lantency",
//                    "apn",
//                    "rat_code",
//                    "cell_name"};
//            fileName = ExcelExport.exportExcelFile(list, prefix, headStr, key);
//        }
//        renderText(fileName);
//    }
}

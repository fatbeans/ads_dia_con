package controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.kit.JsonKit;
import com.jfinal.kit.PathKit;
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

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
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
        if(getPara("export")!=null) {
            exportExcel();
            return;
        }
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
        System.out.println("mdn Blank:"+StringUtils.isNotBlank(msisdn));

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


    public void exportExcel()  {

        long sd = getParaToLong(("sd"), 20000101l);
        long ed = getParaToLong(("ed"), 21000101l);
        long msisdn = getParaToLong(("msisdn"), -1l);

        String prefix = "toushu" + (msisdn == -1 ? "" : msisdn) + "_" + sd + "_" + ed + "_" + ((int) Math.random() *
                100);
        ExcelExport.checkFileExists(prefix);

        String realFileName = ExcelExport.getRealFilename(prefix);
        String fileName = ExcelExport.getFileName(prefix);


        System.out.println("fileName = " + fileName);
        if (realFileName != null) {

            File file = new File(realFileName);
            JSONArray data = getCompData();
            System.out.println("data = " + data);

            String[] headStr = {"全量投诉流水号", "客服受理时间", "受理号码", "用户归属地市", "客户级别", "客户品牌", "投诉业务类型", "诉求内容", "重复投诉", "投诉类型",
                    "客服判断是否解决（认可）", "省EOMS流水号", "派单EOMS时间", "工单时限", "最终处理部门"};
            String[] key = {"TOTALFLOWID", "ACCEPT_TIME", "CALLING_NO", "PRO_MAN_BELONG", "PRO_MAN_LEVEL",
                    "PRO_MAN_SIZEUP", "BUSINESS_CLASS", "PRO_CONTENT", "PROSECUTE_TIMES", "PROSECUTE_TYPE",
                    "IS_OVER", "FLOW_ID", "START_TIME", "SHEET_LIMIT", "DEAL_DEPT_NAME"};
            try {
                ExcelExport.createExcelFile(file, data, headStr, key,"历史投诉");
            } catch (Exception e) {
                e.printStackTrace();
            }
            renderText(fileName);
        }
    }

    public void download() throws UnsupportedEncodingException {
        String fileName = URLDecoder.decode(getPara("fileName"), "utf-8");
        File file = new File(PathKit.getWebRootPath()+"/export/" + fileName);
        System.out.println("file = " + file);
        renderFile(file);
    }


    public JSONArray getCompData() {
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
                new XOracleDialect()));
        System.out.println("page Para:" + msisdn + "|" + sd + "|" + ed);

        String sql = StringUtils.isBlank(business_class) ? PropKit.get("COMP_SQL").replace(PropKit.get
                ("COMP_WHERE_BUSINESS"), " ") : PropKit.get("COMP_SQL");

        List<ComplaintDao> list;

        if (StringUtils.isNotBlank(msisdn)) {
            list = ComplaintDao.dao.find(xDialect.forPaginate(page, size, sql).replaceFirst("\\%\\?\\%", "%" +
                    business_class + "%"), msisdn, sd, ed);
        } else {
            list = ComplaintDao.dao.find(xDialect.forPaginate(page, size, StringUtils.replaceOnce(sql, PropKit.get
                    ("COMP_WHERE_MDN"), " ")).replaceFirst("\\%\\?\\%", "%" + business_class + "%"), sd, ed);
        }
        return JSONArray.parseArray(JsonKit.toJson(list));
    }


}

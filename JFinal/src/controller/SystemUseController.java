package controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.kit.JsonKit;
import dao.LogDao;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by xinxin on 2015/7/20.
 */
public class SystemUseController extends Controller {
    private final String SQL_COUNT_FUNC_BY_DEP = "select dep, case when func_id = 2 then 1 else 0 end as xdcx, case " +
            "when func_id = 3 then 1 else 0 end as tsll, case when func_id = 4 then 1 else 0 end as znzd, case when " +
            "func_id = 5 then 1 else 0 end as xlcx, case when func_id = 6 then 1 else 0 end as xlgis from " +
            "ads_dia_con_syslog where $where and time >= ? and time <= ?  group by dep," +
            "func_id  ";
    private final String SQL_COUNT_FUNC_BY_USER ="select usr, case when func_id = 2 then 1 else 0 end as xdcx, case " +
            "when func_id = 3 then 1 else 0 end as tsll, case when func_id = 4 then 1 else 0 end as znzd, case when " +
            "func_id = 5 then 1 else 0 end as xlcx, case when func_id = 6 then 1 else 0 end as xlgis from " +
            "ads_dia_con_syslog where $where and time >= ? and time <= ?  group by usr," +
            "func_id  ";

    private final String SQL_COUNT_FUNC = "select a.func_id,b.func_desc, count(*) cnt from ads_dia_con_syslog a inner" +
            " JOIN " +
            "ads_dia_con_func b on a.func_id = b.id where $where and time >= ? and time <= ?   group by a.func_id,b" +
            ".func_desc ";
    private final String SQL_SYSLOG_LIST = "select usr,time,b.func_desc,tel from ads_dia_con_syslog a inner join " +
            "ads_dia_con_func b on a" +
            ".func_id =b.id where $where and time >= ? and time <= ?";

    private final SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
    private final String DE_DATE_SD_STR = "2000010100";
    private final String DE_DATE_ED_STR = "2100010100";
    private final String PARA_SD = "sd";
    private final String PARA_ED = "ed";
    private Object rows;


    /**
     * 模块使用频次统计（按部门）
     */
    public void countFuncBydep() throws ParseException {

        String dep = getPara("dep");
        String sql = StringUtils.isBlank(dep) ? SQL_COUNT_FUNC_BY_DEP.replace("$where", "1=1") :
                SQL_COUNT_FUNC_BY_DEP.replace("$where", "dep like ?");

        long sd = NumberUtils.toLong(StringUtils.rightPad(getPara(PARA_SD, DE_DATE_SD_STR), 14, "0"));
        long ed = NumberUtils.toLong(StringUtils.rightPad(getPara(PARA_ED, DE_DATE_ED_STR), 14, "0"));

        if (StringUtils.isBlank(dep))
            renderJson(LogDao.dao.find(sql, sd, ed));
        else
            renderJson(LogDao.dao.find(sql, "%"+dep+"%", sd, ed));
    }


    /**
     * 模块使用频次统计（按账号）
     */
    public void countFuncByUser() throws ParseException {
        String usr = getPara("usr");
        String sql = StringUtils.isBlank(usr) ? SQL_COUNT_FUNC_BY_USER.replace("$where", "1=1") :
                SQL_COUNT_FUNC_BY_USER.replace("$where", "usr like ?");

        long sd = NumberUtils.toLong(StringUtils.rightPad(getPara(PARA_SD, DE_DATE_SD_STR), 14, "0"));
        long ed = NumberUtils.toLong(StringUtils.rightPad(getPara(PARA_ED, DE_DATE_ED_STR), 14, "0"));

        if (StringUtils.isBlank(usr))
            renderJson(LogDao.dao.find(sql, sd, ed));
        else
            renderJson(LogDao.dao.find(sql, "%" + usr + "%", sd, ed));
    }

    /**
     * 模块使用频次明细（按账号）
     */
    public void listByUser() throws ParseException {
        String usr = getPara("usr");
        String sql = StringUtils.isBlank(usr) ? SQL_SYSLOG_LIST.replace("$where", "1=1") : SQL_SYSLOG_LIST.replace
                ("$where", "usr like ?");

        long sd = NumberUtils.toLong(StringUtils.rightPad(getPara(PARA_SD, DE_DATE_SD_STR), 14, "0"));
        long ed = NumberUtils.toLong(StringUtils.rightPad(getPara(PARA_ED, DE_DATE_ED_STR), 14, "0"));

        List<LogDao> list = null;
        if (StringUtils.isBlank(usr))
            list = (LogDao.dao.find(sql, sd, ed));
        else
            list = (LogDao.dao.find(sql, "%" + usr + "%", sd, ed));


        JSONObject json = new JSONObject();

        json.put("rows", JSON.parse(JsonKit.toJson(list)));
        json.put("page", 1);
        json.put("total", 2);
        json.put("records", 30);
        renderJson(json.toJSONString());
    }

    /**
     * 模块使用频次统计（按模块）
     */
    public void countFunc() throws ParseException {

        String func = getPara("func");
        String sql = StringUtils.isBlank(func) ? SQL_COUNT_FUNC.replace("$where", "1=1") : SQL_COUNT_FUNC.replace
                ("$where", "b.id = ?");

        long sd = NumberUtils.toLong(StringUtils.rightPad(getPara(PARA_SD, DE_DATE_SD_STR), 14, "0"));
        long ed = NumberUtils.toLong(StringUtils.rightPad(getPara(PARA_ED, DE_DATE_ED_STR), 14, "0"));

        if (StringUtils.isBlank(func))
            renderJson(LogDao.dao.find(sql, sd, ed));
        else
            renderJson(LogDao.dao.find(sql, func, sd, ed));

    }
}

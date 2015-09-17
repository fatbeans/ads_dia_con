package controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.annotation.JSONCreator;
import com.jfinal.core.Controller;
import com.jfinal.kit.JsonKit;
import dao.FuncDao;
import dao.LogDao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by xinxin on 2015/7/20.
 */
public class SystemUseController extends Controller {
    private final String SQL_COUNT_FUNC_BY_DEP = "select dep, sum(if (func_id = 1 ,1 , 0) ) as fire," +
            "sum(if (func_id = 2 ,1 , 0) ) as xdxc, sum(if (func_id = 3 ,1 , 0) ) as tsll, sum(if " +
            "(func_id = 4 ,1 , 0) ) as znzd, sum(if (func_id = 5 ,1 , 0) ) as xlcx, sum(if (func_id = 6 ," +
            "1 , 0) ) as xlgis from syslog where $where and time >= ? and time <= ?  group by dep," +
            "func_id  ";
    private final String SQL_COUNT_FUNC_BY_USER = "select user, sum(if (func_id = 1 ,1 , 0) ) as fire," +
            "sum(if (func_id = 2 ,1 , 0) ) as xdxc, sum(if (func_id = 3 ,1 , 0) ) as tsll, sum(if " +
            "(func_id = 4 ,1 , 0) ) as znzd, sum(if (func_id = 5 ,1 , 0) ) as xlcx, sum(if (func_id = 6 ," +
            "1 , 0) ) as xlgis from syslog where $where and time >= ? and time <= ?  group by user," +
            "func_id  ";

    private final String SQL_COUNT_FUNC = "select a.func_id,b.func_desc, count(*) cnt from syslog a inner JOIN " +
            "func b on a.func_id = b.id where $where and time >= ? and time <= ?   group by a.func_id,b" +
            ".func_desc ";
    private final String SQL_SYSLOG_LIST = "select user,time,b.func_desc,tel from syslog a inner join func b on a" +
            ".func_id =b.id where $where and time >= ? and time <= ?";

    private final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    private final String DE_DATE_SD_STR = "2000-01-01";
    private final String DE_DATE_ED_STR = "2100-01-01";
    private final String PARA_SD = "sd";
    private final String PARA_ED = "ed";
    private Object rows;


    public void countByFuncEnter() {
        setAttr("funcList", FuncDao.dao.find("select id,func_desc from func"));
        renderFreeMarker("/syslog/count_by_func.html");
    }

    public void countByDepEnter() {
        setAttr("depList", LogDao.dao.find("select dep from syslog group by dep"));
        renderFreeMarker("/syslog/count_by_dep.html");
    }


    /**
     * 模块使用频次统计（按部门）
     */
    public void countFuncBydep() throws ParseException {

        String dep = getPara("dep");
        String sql = dep == null ? SQL_COUNT_FUNC_BY_DEP.replace("$where", "1=1") : SQL_COUNT_FUNC_BY_DEP.replace
                ("$where", "dep = ?");

        Date sd = sdf.parse(getPara(PARA_SD, DE_DATE_SD_STR));
        Date ed = sdf.parse(getPara(PARA_ED, DE_DATE_ED_STR));
        if (dep == null)
            renderJson(LogDao.dao.find(sql, sd, ed));
        else
            renderJson(LogDao.dao.find(sql, dep, sd, ed));
    }


    /**
     * 模块使用频次统计（按账号）
     */
    public void countFuncByUser() throws ParseException {
        String user = getPara("user");
        String sql = user == null ? SQL_COUNT_FUNC_BY_USER.replace("$where", "1=1") : SQL_COUNT_FUNC_BY_USER.replace
                ("$where", "user like ?");
        Date sd = sdf.parse(getPara(PARA_SD, DE_DATE_SD_STR));
        Date ed = sdf.parse(getPara(PARA_ED, DE_DATE_ED_STR));
        if (user == null)
            renderJson(LogDao.dao.find(sql, sd, ed));
        else
            renderJson(LogDao.dao.find(sql, "%" + user + "%", sd, ed));
    }

    /**
     * 模块使用频次明细（按账号）
     */
    public void listByUser() throws ParseException {
        String user = getPara("user");
        String sql = user == null ? SQL_SYSLOG_LIST.replace("$where", "1=1") : SQL_SYSLOG_LIST.replace
                ("$where", "user like ?");
        Date sd = sdf.parse(getPara(PARA_SD, DE_DATE_SD_STR));
        Date ed = sdf.parse(getPara(PARA_ED, DE_DATE_ED_STR));
        List<LogDao> list = null;
        if (user == null)
            list = (LogDao.dao.find(sql, sd, ed));
        else
            list = (LogDao.dao.find(sql, "%" + user + "%", sd, ed));

        list.remove(0);
        list.remove(0);
        list.remove(0);
        list.remove(0);
        list.remove(0);
        list.remove(0);


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
        String sql = func == null ? SQL_COUNT_FUNC.replace("$where", "1=1") : SQL_COUNT_FUNC.replace
                ("$where", "b.id = ?");
        Date sd = sdf.parse(getPara(PARA_SD, DE_DATE_SD_STR));
        Date ed = sdf.parse(getPara(PARA_ED, DE_DATE_ED_STR));
        if (func == null)
            renderJson(LogDao.dao.find(sql, sd, ed));
        else
            renderJson(LogDao.dao.find(sql, func, sd, ed));

    }
}

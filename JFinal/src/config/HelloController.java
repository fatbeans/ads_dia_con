package config;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import dao.UserDetailsDao;
import dao.Pager;

/**
 * Created by xinxin on 2015/7/13.
 */
public class HelloController extends Controller {
    public void index() {
        renderText("Hello JFinal World.");
    }

    public void fire() {
        renderJson("[[1," + Math.random() * 40 + ",true,true]]");
    }

    public void jqgdata() {

        String s = "[{\"name\":\"joe\",\"age\":56,\"sex\":\"man\",\"num\":\"1\"},{\"name\":\"joe\",\"age\":55," +
                "\"sex\":\"man\",\"num\":\"1\"},{\"name\":\"joe\",\"age\":65,\"sex\":\"man\",\"num\":\"1\"}]";
        System.out.printf(s);
        renderJson(s);
    }

    public void ztreeData() {
        String s = "[\n" +
                "    {\"id\": \"1\", \"pId\": \"0\", \"name\": \"手机上网智能诊断平台-客服\", \"url\": \"http://www.ztree.me/\", " +
                "\"target\": \"_blank\"},\n" +
                "    {\"id\": \"2\", \"pId\": \"1\", \"name\": \"手机上网智能诊断平台-运维\", \"url\": \"http://code.google" +
                ".com/p/jquerytree/\", \"target\": \"_blank\"},\n" +
                "    {\"id\": \"3\", \"pId\": \"2\", \"name\": \"用户投诉履历\", \"url\": \"http://ztreeapi.iteye.com/\", " +
                "\"target\": \"_blank\"},\n" +
                "    {\"id\": \"4\", \"pId\": \"2\", \"name\": \"用户信令查询\", \"url\": \"#\", \"target\": \"_blank\", " +
                "\"click\": \"alert('我是不会跳转的...');\"},\n" +
                "    {\"id\": \"5\", \"pId\": \"4\", \"name\": \"用户信令明细\", \"url\": \"#\", \"target\": \"_blank\", " +
                "\"click\": \"alert('我是不会跳转的...');\"},\n" +
                "    {\"id\": \"6\", \"pId\": \"2\", \"name\": \"用户信令GIS查询\", \"url\": \"#\", \"target\": \"_blank\"," +
                " \"click\": \"alert('我是不会跳转的...');\"},\n" +
                "    {\"id\": \"7\", \"pId\": \"2\", \"name\": \"定界流程界面\", \"url\": \"#\", \"target\": \"_blank\", " +
                "\"click\": \"alert('我是不会跳转的...');\"},\n" +
                "    {\"id\": \"8\", \"pId\": \"1\", \"name\": \"用户详单查询界面\", \"url\": \"#\", \"target\": \"_blank\", " +
                "\"click\": \"alert('我是不会跳转的...');\"},\n" +
                "    {\"id\": \"9\", \"pId\": \"8\", \"name\": \"详单-2/3G\", \"url\": \"#\", \"target\": \"_blank\", " +
                "\"click\": \"alert('我是不会跳转的...');\"},\n" +
                "    {\"id\": \"10\", \"pId\": \"8\", \"name\": \"详单-LTE\", \"url\": \"#\", \"target\": \"_blank\", " +
                "\"click\": \"alert('我是不会跳转的...');\"},\n" +
                "    {\"id\": \"11\", \"pId\": \"1\", \"name\": \"系统功能\", \"url\": \"#\", \"target\": \"_blank\", " +
                "\"click\": \"alert('我是不会跳转的...');\"}\n" +
                "    ]";
        renderJson(s);
    }

    public void pageDemo() {
        int page = getParaToInt("page", 1);
        int size = getParaToInt("rows", 10);
        Integer where = getParaToInt("q", 100);

        Page<UserDetailsDao> p = UserDetailsDao.dao.paginate(page, size, "select *", " from actor where actor_id > ?", where);

        renderJson(new Pager().toJsonString(p));


    }

    public void gpPageDemo() {
        int page = getParaToInt("page", 1);
        int size = getParaToInt("rows", 10);
        Page<UserDetailsDao> p = UserDetailsDao.dao.paginate(page, size, "select *", " from s1u_http");
        String jsonStr = new Pager().toJsonString(p);
        renderJson(jsonStr);
    }


}

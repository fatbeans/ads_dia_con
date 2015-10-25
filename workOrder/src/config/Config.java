package config;

import com.jfinal.config.*;
import com.jfinal.config.JFinalConfig;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.activerecord.dialect.OracleDialect;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;
import controller.WorkCotronller;


/**
 * Created by xinxin on 2015/7/13.
 */
public class Config extends JFinalConfig {



    public void configConstant(Constants me) {
        me.setDevMode(true);
        me.setViewType(ViewType.JSP);
    }


    public void configRoute(Routes me) {
        me.add("/work", WorkCotronller.class,"work");
        System.out.println(me.getViewPath("test"));
    }


    public void configPlugin(Plugins me) {
        loadPropertyFile("prop.properties", "utf-8");
        if(!getProperty("CONDB").equals("false")){
            System.out.println(getProperty("CONDB"));
            configOrcl(me);
        }
    }


    private void configOrcl(Plugins me) {
        String url = getProperty("ORCL_URL");
        String user = getProperty("ORCL_USER");
        String pwd = getProperty("ORCL_PWD");
        String jdbc = getProperty("ORCL_JDBC");

        System.out.println(url);
        System.out.println(user);
        System.out.println(pwd);
        System.out.println(jdbc);



        C3p0Plugin orclCp = new C3p0Plugin(url, user, pwd, jdbc);
        me.add(orclCp);

        ActiveRecordPlugin arp = new ActiveRecordPlugin("orcl", orclCp);
        arp.setContainerFactory(new CaseInsensitiveContainerFactory(false));
        arp.setDialect(new OracleDialect());
        arp.setShowSql(true);
        me.add(arp);
    }


    public void configInterceptor(Interceptors me) {
    }

    public void configHandler(Handlers me) {

    }

}

package config;

import com.jfinal.config.*;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.activerecord.dialect.OracleDialect;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;
import controller.*;
import dao.ComplaintDao;
import dao.LogDao;
import dao.UserDetailsDao;
import dao.adsDiaCon.*;
import dialect.XGbaseDialect;
import dialect.XGpDialect;
import dic.DbType;
import log.LogInterceptor;
import org.apache.commons.lang.StringUtils;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;


/**
 * Created by xinxin on 2015/7/13.
 */
public class DemoConfig extends JFinalConfig {

    public static Configuration conf=null;

    public void configConstant(Constants me) {
        me.setDevMode(true);
        me.setViewType(ViewType.JSP);
    }

    public void configRoute(Routes me) {

//        me.add("/hello", HelloController.class);
        me.add(("/syslog"), SystemUseController.class);
        me.add("/", IndexCotroller.class);
        me.add("/user_det", UserDetailsController.class);
        me.add("/home", HomePageController.class);
        me.add("/signalling", SignallingController.class);
        me.add("/delimitflow", DelimitFlowController.class);
        me.add("/comp", ComplaintController.class);
        me.add("/conc", ConclusionStatController.class);

    }


    public void configPlugin(Plugins me) {
        loadPropertyFile("prop.properties", "utf-8");
        PropKit.use("colName.properties", "utf-8");
        String[] dbTypes = StringUtils.split(getProperty("dbPre",""), ",");
        for (String dbType : dbTypes) {
            if (dbType.equalsIgnoreCase("GP")) {
                System.out.println("use gp");
                configGp(me);
            } else if (dbType.indexOf("ORCL") > -1) {
                System.out.println("use orcl:" + dbType);
                configOrcl(me, dbType);
            }else if (dbType.equalsIgnoreCase("HABSE")) {
                System.out.println("use hbase");
                configHbase();
            }else if (dbType.equals("GBASE")) {
                System.out.println("use gbase");
                configGbase(me);
            }else if (dbType.equals("NXGIS")) {
                configNxGis(me);
                System.out.println("NxGis");
            }
        }

    }

    private void configNxGis(Plugins me) {
        C3p0Plugin cp = new C3p0Plugin(prop.get("NXGIS_URL"), prop.get("NXGIS_USER"), prop.get
                ("NXGIS_PWD"), prop.get("NXGIS_JDBC"));
        me.add(cp);

        ActiveRecordPlugin arp = new ActiveRecordPlugin(DbType.GISORCL.getValue(), cp);
        arp.setContainerFactory(new CaseInsensitiveContainerFactory(false));
        arp.setDialect(new OracleDialect());
        arp.setShowSql(true);
        me.add(arp);
        arp.addMapping("v_total_all", ComplaintDao.class);
    }

    private void configHbase() {
        conf= HBaseConfiguration.create();//hbase的配置信息
        conf.set("hbase.zookeeper.quorum", prop.get("HBASE_URL"));  //zookeeper的地址
    }




    private void configGbase(Plugins me) {
        C3p0Plugin cp = new C3p0Plugin(prop.get("GBASE_URL"), prop.get("GBASE_USER"), prop.get
                ("GBASE_PWD"), prop.get("GBASE_JDBC"));
        me.add(cp);
        ActiveRecordPlugin arp = new ActiveRecordPlugin(DbType.GBASE.getValue(), cp);
        arp.setContainerFactory(new CaseInsensitiveContainerFactory(false));
        arp.setShowSql(true);
        arp.setDialect(new XGbaseDialect());
        me.add(arp);
        arp.addMapping("F_MS_S1U_HTTP", UserDetailsDao.class);
        arp.addMapping("F_USER_COMPLAIN", ComplaintDao.class);

    }


    private void configGp(Plugins me) {
        C3p0Plugin cp = new C3p0Plugin(prop.get("GP_URL"), prop.get("GP_USER"), prop.get
                ("GP_PWD"), prop.get("GP_JDBC"));
        me.add(cp);


        ActiveRecordPlugin arp = new ActiveRecordPlugin(DbType.GP.getValue(), cp);

        arp.setContainerFactory(new CaseInsensitiveContainerFactory(false));
                arp.setDialect(new XGpDialect());
        arp.setShowSql(true);
        me.add(arp);
//        arp.addMapping("syslog", LogDao.class);
//        arp.addMapping("func",  FuncDao.class);
        arp.addMapping("ads.ads_4g_gnhttp", UserDetailsDao.class);
        arp.addMapping("stage.eoms_total_hz1", ComplaintDao.class);
    }

    private void configOrcl(Plugins me, String pref) {
        String url = pref + "_URL";
        String user = pref + "_USER";
        String pwd = pref + "_PWD";
        String jdbc = pref + "_JDBC";

        System.out.println(url);
        System.out.println(user);
        System.out.println(pwd);
        System.out.println(jdbc);

        C3p0Plugin orclCp = new C3p0Plugin(prop.get(url), prop.get(user), prop.get(pwd), prop.get
                (jdbc));
        me.add(orclCp);
        ActiveRecordPlugin arp = new ActiveRecordPlugin(DbType.ORACLE.getValue(), orclCp);
        arp.setDialect(new OracleDialect());
        arp.setShowSql(true);
        me.add(arp);
        arp.addMapping("ADS_DIA_CON_SYSLOG", LogDao.class);
//        arp.addMapping("ADS_DIA_CON_HTTP_CELL", HttpCell.class);
//        arp.addMapping("ADS_DIA_CON_CTL_MME", CtlMme.class);
//        arp.addMapping("ADS_DIA_CON_HTTP_SGW", HttpSgw.class);
//        arp.addMapping("ADS_DIA_CTL", CtlCell.class);
//        arp.addMapping("ADS_DIA_CON_DNS_EC", DnsEc.class);
//        arp.addMapping("ADS_DIA_CON_DNS_DELAY", DnsDelay.class);
//        arp.addMapping("ADS_DIA_CON_CTL_USR_EC", CtlUsrEc.class);
//        arp.addMapping("ADS_DIA_CON_USR_VIR", UsrVir.class);
//        arp.addMapping("ADS_DIA_CON_USR_IL_IP", UsrIlIp.class);
//        arp.addMapping("ADS_DIA_CON_USR_HI_FLO_SRV", UsrHiFloSrv.class);
//        arp.addMapping("ADS_DIA_CON_CTL_TE", CtlTe.class);
//        arp.addMapping("ADS_DIA_CON_HTTP_LIST", HttpList.class);
//        arp.addMapping("ADS_DIA_CON_HTTP_TE", HttpTe.class);
//        arp.addMapping("ADS_DIA_CON_CTL_S_EC", CtlSEc.class);
//        arp.addMapping("ADS_DIA_CON_HTTP_SP", HttpSp.class);
        arp.addMapping("ADS_DIA_CON", "ADS_DIA_CON_CFG", AdsDiaCon.class);
//        arp.addMapping("ADS_DIA_HTTP_USR_SRV", UsrSrv.class);
//        arp.addMapping("ADS_DIA_HTTP", AdsDiaHttp.class);
        arp.addMapping("ADS_DIA_USR", Usr.class);
        arp.addMapping("ADS_DIA_CON_HTTP_SERV_IP", HttpServIp.class);
    }


    public void configInterceptor(Interceptors me) {

        me.addGlobalActionInterceptor(new LogInterceptor());
    }

    public void configHandler(Handlers me) {

    }

}

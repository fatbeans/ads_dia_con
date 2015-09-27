package log;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import dao.LogDao;
import org.apache.commons.lang.time.DateFormatUtils;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by xinxin on 2015/7/17.
 */
public class LogInterceptor implements Interceptor {
    private final String COL_DEP = "DEP";
    private final String COL_USER = "USR";
    private final String COL_TEL = "TEL";
    private final String COL_FUNCNAME = "FUNC_NAME";
    private final String COL_TIME = "TIME";
    private final String COL_FUNCTION_ID = "FUNC_ID";
    private final String COL_ID = "ID";
    private final String FUNCTIONSQL = "select * from func";
    private final Map<String, Integer> funcMap = new HashMap<String, Integer>();
    private final String def = "-1";


    public LogInterceptor() {

    }


    public void intercept(Invocation inv) {
        String methodName = inv.getMethodName();


        String usr = null;
        String dep = null;
        String tel = null;
        try {
            usr = URLDecoder.decode(inv.getController().getCookie("usr", "未知"), "utf-8");
            dep = URLDecoder.decode(inv.getController().getCookie("dep", "未知"), "utf-8");

            tel = inv.getController().getPara("msisdn") != null ? inv.getController().getPara("msisdn") : inv
                    .getController().getPara("phone");

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

//        首页-客服
        if (methodName.equals("cust")) {
            saveLog(dep, usr, "4", tel);
        }
//        投诉履历
        else if (methodName.equals("searchHistory")) {
            saveLog(dep, usr, "3", tel);
        }
//        信令查询
        else if (methodName.equals("getSignallingList")) {
            saveLog(dep, usr, "5", tel);
        }
//        详单查询
        else if (methodName.equals("searchLTE")) {
            saveLog(dep, usr, "2", tel);
        }
        inv.invoke();
    }

    public void saveLog(String dep, String user, String functionId, String tel) {
        new LogDao().set(COL_DEP, dep).set(COL_USER, user).set(COL_TIME, DateFormatUtils.format(new Date(),
                "yyyyMMddHHmmss")).set(COL_FUNCTION_ID, Long.parseLong(functionId)).set(COL_TEL, Long.parseLong(tel))
                .save();
        System.out.println("日志保存完成");

    }

}

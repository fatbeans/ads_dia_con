package log;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import dao.LogDao;
import dao.FuncDao;
import dic.Lv2Con;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by xinxin on 2015/7/17.
 */
public class LogInterceptor implements Interceptor {
    private final String COL_DEP = "dep";
    private final String COL_USER = "user";
    private final String COL_TEL = "tel";
    private final String COL_FUNCNAME = "function_name";
    private final String COL_TIME = "time";
    private final String COL_FUNCTION_ID = "function_id";
    private final String COL_ID = "id";
    private final String FUNCTIONSQL = "select * from func";
    private final Map<String, Integer> funcMap = new HashMap<String,Integer>();
    private final String def = "-1";


    public LogInterceptor() {
        for (FuncDao mmd : FuncDao.dao.find(FUNCTIONSQL)) {
            funcMap.put(mmd.getStr(COL_FUNCNAME), mmd.getInt(COL_ID));


        }

        System.out.println(funcMap);
    }

    @Override
    public void intercept(Invocation inv) {
        String methodName = inv.getMethodName();
        Map<String, String[]> paraMap = inv.getController().getParaMap();
        String dep = paraMap.get(COL_DEP)[0];
        if(dep == null) dep = def;
        String user = paraMap.get(COL_USER)[0];
        if (user == null) user = def;
        String tel = paraMap.get(COL_TEL)[0];
        if(tel == null) tel = def;
        String methodId = funcMap.containsKey(methodName) ? def : funcMap.get(methodName)+"";

        saveLog(dep, user, methodId, tel);
        inv.invoke();
    }

    public void saveLog(String dep, String user, String functionId, String tel) {
        new LogDao().set(COL_DEP, dep).set(COL_USER, user).set(COL_TIME, new Date()).set(COL_FUNCTION_ID, functionId)
                .set
                        ("tel", tel).save();

    }

}

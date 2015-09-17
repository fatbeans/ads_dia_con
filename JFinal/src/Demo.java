import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.kit.HashKit;
import com.jfinal.kit.JsonKit;
import com.jfinal.kit.PathKit;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;

import java.net.URISyntaxException;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Created by xinxin on 2015/8/20.
 */
public class Demo {

    public static void main(String[] args) throws URISyntaxException {
        String s = "COMP_SQL=SELECT TOTALFLOWID, ACCEPT_TIME, PRO_MAN_BELONG, PRO_CONTENT, PROSECUTE_TYPE, IS_OVER " +
                "FROM" +
                " F_USER_COMPLAIN WHERE " +
                "  CALLING_NO = ? AND ACCEPT_TIME >= ? AND ACCEPT_TIME < ? ORDER BY ACCEPT_TIME";
        String p = "CALLING_NO = ? AND";
        System.out.println(StringUtils.replaceOnce(s,p," "));

    }


    static abstract class e1 {


        public abstract void test();
    }

    static  class e11 extends e1 {

        public void test() {
            System.out.println("e11");
        }
    }

    static  class e12 extends e1 {

        public void test() {
            System.out.println("e12");
        }
    }

}

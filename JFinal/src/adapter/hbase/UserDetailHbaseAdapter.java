package adapter.hbase;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.jfinal.log.Logger;
import model.UserDetHbaseEntity;
import org.apache.commons.lang.StringUtils;

import com.hbase.nx.base.XDataHBaseHelper;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang.time.DateUtils;

/**
 * Created by xinxin on 2015/8/27.
 */
public class UserDetailHbaseAdapter {

    public static void main(String[] args) {
        String imsi = "460027950740073";
        String startTime = "2015111600";
        String endTime = "2015111623";

        String startKey = StringUtils.rightPad(imsi + startTime, 36, "0");
        String endKey = StringUtils.rightPad(imsi + endTime, 36, "9");

        System.out.println("startKey = " + startKey);
        System.out.println("endKey = " + endKey);
    }


    public static List<UserDetHbaseEntity> getPage(String imsi,
                                                   String startTime, String endTime)
            throws ParseException, IOException {
        long utime = 0L;
        long eutime = 0L;
        long useTime = 0L;
        long count = 0L;

        String startKey = null;
        String endKey = null;
        String tableName = "S_M_HTTP";
        StringBuffer sql = new StringBuffer();
        utime = System.currentTimeMillis();
//        List<String[]> listTimes = TimeTools.getTimeKeys(startTime, endTime)
        List<String[]> listTimes = new ArrayList<String[]>();
//        if (listTimes.isEmpty()) {
//            return;
//        }
        // 需要修改执行sql;
        List<UserDetHbaseEntity> rows = new ArrayList<UserDetHbaseEntity>();
        XDataHBaseHelper xDataHBaseHelper = XDataHBaseHelper.getHelper();


        Date s1 = DateUtils.parseDate(startTime.substring(0, 8), new String[]{"yyyyMMdd"});
        Date s2 = DateUtils.parseDate(endTime.substring(0, 8), new String[]{"yyyyMMdd"});

        int tabCnt = (int) (s2.getTime() - s1.getTime()) / (24 * 60 * 60 * 1000) + 2;


        try {
            for (int i = 0; i < tabCnt; i++) {
                // 关闭事务自动提交
                String day = DateFormatUtils.format(s1, "yyyyMMdd");
                startKey = StringUtils.rightPad(imsi + startTime, 36, "0");
                endKey = StringUtils.rightPad(imsi + endTime, 36, "9");
                String tableNameTemp = tableName + "_" + day;
                System.out.println("tableNameTemp = " + tableNameTemp);
                // 判断表名是否存在content:other
                if (xDataHBaseHelper.tableExists(tableNameTemp)) {
                    List<String> col = new ArrayList<String>();
                    col.add("content,other");
                    List<Map<String, String>> dataList = xDataHBaseHelper.get(
                            tableNameTemp, startKey, endKey, col);

                    for (Map<String, String> data : dataList) {
                        rows.add(new UserDetHbaseEntity(data.get("other")));
                    }
                }
                s1 = DateUtils.addDays(s1, 1);

            }

            // 关闭hbase 链接
            xDataHBaseHelper.close();
            // 关闭oracle链接

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return rows;
    }

    public static long getCnt(String startTime, String endTime, String imsi) throws Throwable {
        String tableName = "S_M_HTTP";
        String day = startTime.substring(0, 8);
        String tableNameTemp = tableName + "_" + day;
        String startKey = StringUtils.rightPad(imsi + startTime, 36, "0");
        String endKey = StringUtils.rightPad(imsi + endTime, 36, "9");
        return XDataHBaseHelper.getHelper().getTotal(tableNameTemp, null, startKey, endKey);
    }
}
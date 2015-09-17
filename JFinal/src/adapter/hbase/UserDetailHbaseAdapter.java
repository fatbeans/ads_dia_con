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
import java.util.List;
import java.util.Map;

import com.jfinal.log.Logger;
import model.UserDetHbaseEntity;
import org.apache.commons.lang.StringUtils;

import com.hbase.nx.base.XDataHBaseHelper;

/**
 * Created by xinxin on 2015/8/27.
 */
public class UserDetailHbaseAdapter {


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
        try {
            // 关闭事务自动提交
            String day = startTime.substring(0, 8);
            startKey = StringUtils.rightPad(imsi + startTime, 34, "0");
            endKey = StringUtils.rightPad(imsi + endTime, 34, "9");
            String tableNameTemp = tableName + "_" + day;

            // 判断表名是否存在content:other
            if (xDataHBaseHelper.tableExists(tableNameTemp)) {
                List<String> col = new ArrayList<String>();
                col.add("content,other");
                List<Map<String, String>> dataList = xDataHBaseHelper.get(
                        tableNameTemp, startKey, endKey, col);

                for (Map<String, String> data : dataList) {
                    System.out.println(data);
                    rows.add(new UserDetHbaseEntity(data.get("other")));
                }
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

    public static long getCnt( String startTime, String endTime,String imsi) throws Throwable {
        String tableName = "S_M_HTTP";
        String day = startTime.substring(0, 8);
        String tableNameTemp = tableName + "_" + day;
        String startKey = StringUtils.rightPad(imsi + startTime, 34, "0");
        String endKey = StringUtils.rightPad(imsi + endTime, 34, "9");
        return XDataHBaseHelper.getHelper().getTotal(tableNameTemp, null, startKey, endKey);
    }
}
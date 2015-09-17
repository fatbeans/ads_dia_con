package controller;

import com.jfinal.core.Controller;
import com.jfinal.kit.HashKit;
import config.DemoConfig;
import org.apache.hadoop.hbase.KeyValue;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.util.Bytes;

import java.io.IOException;

/**
 * Created by xinxin on 2015/7/13.
 */
public class IndexCotroller extends Controller {
    public void index() {
        redirect("/index_cust.jsp");
    }

    public void test() throws IOException {
        hbaseTest();
    }

    private void hbaseTest() throws IOException {
        /**
         * 扫描所有数据或特定数据
         * @param tableName
         * **/
        System.out.println(DemoConfig.conf == null);
        HTable h = new HTable(DemoConfig.conf, "user");

        Scan scan = new Scan();
        //扫描特定区间
        //Scan scan=new Scan(Bytes.toBytes("开始行号"),Bytes.toBytes("结束行号"));
        ResultScanner scanner = h.getScanner(scan);
        for (Result r : scanner) {
            System.out.println("==================================");
            for (KeyValue k : r.raw()) {

                System.out.println("行号:  " + Bytes.toStringBinary(k.getRow()));
                System.out.println("时间戳:  " + k.getTimestamp());
                System.out.println("列簇:  " + Bytes.toStringBinary(k.getFamily()));
                System.out.println("列:  " + Bytes.toStringBinary(k.getQualifier()));

                String ss = Bytes.toString(k.getValue());
                System.out.println("值:  " + ss);
                //}

            }
        }
        h.close();


    }



}
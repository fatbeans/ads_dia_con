package model;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;

/**
 * Created by xinxin on 2015/8/27.
 */
public class UserDetHbaseEntity {


    public String MSISDN, PROCEDURE_STARTTIME_MS, PROCEDURE_ENDTIME_MS, TACTYPE, TACBRND, APP_TYPE_NAME,
            APP_SUB_TYPE_NAME,
            HOST, URI1, STATUS_CODE, ERROR_CODE, UL_DATA, DL_DATA, BUS_LANTENCY, APN, RAT_CODE, CELL_NAME, TAC_SYS,
            IS_MODE_2G, IS_MODE_3G, IS_MODE_4G, FIAL_SCENE_EN, FIAL_SCENE_CH;


    public UserDetHbaseEntity() {
    }

//    public static void main(String[] args) {
//        String s = "460027096092516|8615209576118|20150918110030467|20150918110050677|20150918|11|166041377555319|2
// |5" +
//                "||HTTP|-1|未知|35602206|三星-SM-A5000|15|130|10.82.222.123|223.6.248" +
//                ".170|null|3|502|服务器侧问题|1586|1324|0|0|0|0|4|4|20150918110050677|1|0|2|3|1|1|0|cpp-checkin/log
// /upload" +
//                "/post?appId=mci-multimediamagazine&filenam|checkin.svc.mcitech.cn|2|application/octet-stream;" +
//                "boundar|Dalvik/1.6.0 (Linux; U; Android ||-|10.82.222.123, key=4600270960925162015091811003046714";
//
//        String[] ss = StringUtils.splitByWholeSeparatorPreserveAllTokens(s, "|");
//
//        for (String sss : ss) {
//            System.out.println(sss);
//        }
//        System.out.println(ss.length);
//
//    }


    public UserDetHbaseEntity(String dataStr) {
        if (dataStr == null) {
            return;
        }
        String[] data = StringUtils
                .splitByWholeSeparatorPreserveAllTokens(dataStr, "|");

        if (data.length < 47) {
            return;
        }
        MSISDN = data[1];
        PROCEDURE_STARTTIME_MS = data[2];
        PROCEDURE_ENDTIME_MS = data[3];
        TACTYPE = data[14];
        TACBRND = null;
        APP_TYPE_NAME = data[15];
        APP_SUB_TYPE_NAME = data[16];
        HOST = data[40];
        URI1 = data[39];
        STATUS_CODE = NumberUtils.toInt(data[21], 0) >= 400 ? "失败" : "成功";
        ERROR_CODE = NumberUtils.toInt(data[21], 0) + "";
        UL_DATA = data[23];
        DL_DATA = data[24];
        BUS_LANTENCY = data[25];
        APN = null;
        RAT_CODE = "4G";
        CELL_NAME = data[12];
        TAC_SYS = null;
        IS_MODE_2G = null;
        IS_MODE_3G = null;
        IS_MODE_4G = null;
        FIAL_SCENE_EN = null;
        FIAL_SCENE_CH = null;
    }
}

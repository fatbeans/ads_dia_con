package model;

import org.apache.commons.lang.StringUtils;

/**
 * Created by xinxin on 2015/8/27.
 */
public class UserDetHbaseEntity {


    public String MSISDN, PROCEDURE_STARTTIME_MS, PROCEDURE_ENDTIME_MS, TACTYPE, TACBRND, APP_TYPE_NAME,
            APP_SUB_TYPE_NAME,
            HOST, URI1, STATUS_CODE, ERROR_CODE, UL_DATA, DL_DATA, BUS_LANTENCY, APN, RAT_CODE, CELL_NAME, TAC_SYS,
            IS_MODE_2G, IS_MODE_3G, IS_MODE_4G;



    public UserDetHbaseEntity(){}

    public UserDetHbaseEntity(String dataStr) {
        if(dataStr == null) {
            return ;
        }
        String[] data = StringUtils
                .splitByWholeSeparatorPreserveAllTokens(dataStr, "|");

        if(data.length<47){
            return ;
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
        STATUS_CODE = data[20];
        ERROR_CODE = data[21];
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
    }
}

package model;

import org.apache.commons.lang.StringUtils;

/**
 * Created by xinxin on 2015/9/18.
 */
public class AppInfoEntity {

    public int appTypeID, appSubTypeID;
    public String appTypeName, appSubTypeName;

    public AppInfoEntity(int appTypeID, String appTypeName, int appSubTypeID, String appSubTypeName) {
        this.appSubTypeID = appSubTypeID;
        this.appSubTypeName = appSubTypeName;
        this.appTypeID = appTypeID;
        this.appTypeName = appTypeName;
    }

    public String getKey() {
        return StringUtils.leftPad(appTypeID + "", 3, "0") + StringUtils.leftPad(appSubTypeID + "", 5, "0");
    }

    public static String getKey(int appTypeID, int appSubTypeID) {
        return StringUtils.leftPad(appTypeID + "", 3, "0") + StringUtils.leftPad(appSubTypeID + "", 5, "0");
    }
}

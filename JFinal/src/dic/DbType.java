package dic;

/**
 * Created by xinxin on 2015/8/27.
 */
public enum DbType {
    GBASE("gbase"),
    GP("gp"),
    HBASE("hbase"),
    ORACLE("orcl"),
    GISORCL("gisorcl");



    private String value;

    public String getValue() {
        return value;
    }

    DbType(String value) {
        this.value = value;
    }


}

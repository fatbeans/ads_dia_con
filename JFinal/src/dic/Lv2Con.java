package dic;

/**
 * Created by xinxin on 2015/8/10.
 */
public enum Lv2Con {

    弱覆盖(10010001, "CTL_CELL"),
    质差小区(10010002, "CTL_CELL"),
    小区高负荷(10010003, "CTL_CELL"),
    小区时延问题(10010004, "HTTP_CELL"),
    无线侧_工程预约(10010005, null),
    小区核查参数(10010006, "CTL_CELL"),
    MME高负荷(10020001, "CTL_MME"),
    MME质量问题(10020002, "CTL_MME"),
    SGW时延问题(10020003, "HTTP_SGW"),
    核心侧_工程预约(10020004, null),
    DNS服务器出错(10020005, "DNS_EC"),
    DNS域名服务器不支持请求的类型(10020006, "DNS_EC"),
    DNS拒绝服务(10020007, "DNS_EC"),
    核心侧_DNS解析时延问题(10020008, "DNS_DELAY"),
    MME核查参数(10020009, "CTL_MME"),
    用户未签约或被关闭4G业务(10030001, "CTL_USR_EC"),
    用户感染手机病毒(10030002, "USR_VIR"),
    用户访问非法地址(10030003, "USR_IL_IP"),
    用户没有产生上网记录(10030004, null),
    用户访问较多容易产生高流量的业务(10030005, "USR_HI_FLO_SRV"),
    DNS格式错误(10030006, "DNS_EC"),
    DNS请求的域名错误(10030007, "DNS_EC"),
    用户侧_DNS解析时延问题(10030008, "DNS_DELAY"),
    终端质量问题(10040001, "CTL_TE"),
    上网记录返回终端侧错误(10040002, "HTTP_SERV_IP"),
    终端时延问题(10040003, "HTTP_TE"),
    用户终端有异常(10040004, null),
    终端APN设置问题(10040005, "CTL_S_EC"),
    业务属网外资源(10050001, "HTTP_LIST"),
    上网日志返回业务侧错误(10060001, "HTTP_SERV_IP"),
    业务时延问题(10060002, "HTTP_SP");


    private String pref;

    public String getPref() {
        return pref;
    }

    private int value;

    public int getValue() {
        return value;
    }


    Lv2Con(int value, String pref) {
        this.value = value;
        this.pref = pref;

    }

    public static Lv2Con getLv2Con(int value) {
        for (Lv2Con item : Lv2Con.values()) {
            if (value == item.getValue()) {
                return item;
            }
        }
        return null;
    }


}

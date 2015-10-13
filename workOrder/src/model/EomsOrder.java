package model;

import org.apache.commons.lang.time.DateFormatUtils;

import java.util.Date;
import java.util.Map;

/**
 * @author Eoms 下单模型
 */
public class EomsOrder {
    //任务编号
    private String eomsOrderId;
    //任务主题
    private String eomsOrderTitle;
    //地市
    private String cityKey;
    //地市名称
    private String cityName;
    //任务大类Id：
    private String typeId;
    //任务大类名称
    private String typeName;
    //任务子类Id
    private String typeSubId;
    //任务子类名称
    private String typeSubName;
    //问题对象Id
    private String rangeId;
    //问题对象名称
    private String rangeName;
    //派单内容
    private String content;
    //任务处理对象 小区/核心网/内容源/用户/终端/业务
    private String neType;
    //任务派单方式 自动派单/人工派单
    private String sendWay;
    //任务建单时间
    private String createTime;
    //任务派单时间
    private String sendTime;
    //文件路径
    private String fileName;
    //详情Url
    private String detailUrl;

    public String getEomsOrderId() {
        return eomsOrderId;
    }

    public void setEomsOrderId(String eomsOrderId) {
        this.eomsOrderId = eomsOrderId;
    }

    public String getEomsOrderTitle() {
        return eomsOrderTitle;
    }

    public void setEomsOrderTitle(String eomsOrderTitle) {
        this.eomsOrderTitle = eomsOrderTitle;
    }

    public String getCityKey() {
        return cityKey;
    }

    public void setCityKey(String cityKey) {
        this.cityKey = cityKey;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getTypeSubId() {
        return typeSubId;
    }

    public void setTypeSubId(String typeSubId) {
        this.typeSubId = typeSubId;
    }

    public String getTypeSubName() {
        return typeSubName;
    }

    public void setTypeSubName(String typeSubName) {
        this.typeSubName = typeSubName;
    }

    public String getRangeId() {
        return rangeId;
    }

    public void setRangeId(String rangeId) {
        this.rangeId = rangeId;
    }

    public String getRangeName() {
        return rangeName;
    }

    public void setRangeName(String rangeName) {
        this.rangeName = rangeName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getNeType() {
        return neType;
    }

    public void setNeType(String neType) {
        this.neType = neType;
    }

    public String getSendWay() {
        return sendWay;
    }

    public void setSendWay(String sendWay) {
        this.sendWay = sendWay;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getSendTime() {
        return sendTime;
    }

    public void setSendTime(String sendTime) {
        this.sendTime = sendTime;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getDetailUrl() {
        return detailUrl;
    }

    public void setDetailUrl(String detailUrl) {
        this.detailUrl = detailUrl;
    }

    public static EomsOrder initEomsOrder(Map<String, String[]> map) {
        EomsOrder eo = new EomsOrder();
        eo.eomsOrderId = map.get("eomsOrderId") != null ? map.get("eomsOrderId")[0] : null;
        eo.eomsOrderTitle = map.get("eomsOrderTitle") != null ? map.get("eomsOrderTitle")[0] : null;
        eo.cityKey = map.get("cityKey") != null ? map.get("cityKey")[0] : null;
        eo.cityName = map.get("cityName") != null ? map.get("cityName")[0] : null;
        eo.typeId = map.get("typeId") != null ? map.get("typeId")[0] : null;
        eo.typeName = map.get("typeName") != null ? map.get("typeName")[0] : null;
        eo.typeSubId = map.get("typeSubId") != null ? map.get("typeSubId")[0] : null;
        eo.typeSubName = map.get("typeSubName") != null ? map.get("typeSubName")[0] : null;
        eo.rangeId = map.get("rangeId") != null ? map.get("rangeId")[0] : null;
        eo.rangeName = map.get("rangeName") != null ? map.get("rangeName")[0] : null;
        eo.content = map.get("content") != null ? map.get("content")[0] : null;
        eo.neType = map.get("neType") != null ? map.get("neType")[0] : null;
        eo.sendWay = map.get("sendWay") != null ? map.get("sendWay")[0] : null;
        eo.createTime = map.get("createTime") != null ? map.get("createTime")[0] : null;
        eo.sendTime = map.get("sendTime") != null ? map.get("sendTime")[0] : null;
        eo.fileName = map.get("fileName") != null ? map.get("fileName")[0] : null;
        eo.detailUrl = map.get("detailUrl") != null ? map.get("detailUrl")[0] : null;
        eo.eomsOrderTitle = map.get("eomsOrderTitle") != null ? map.get("eomsOrderTitle")[0] : null;
        return eo;
    }

    @Override
    public String toString() {
        return "EomsOrder{" +
                "eomsOrderId='" + eomsOrderId + '\'' +
                ", eomsOrderTitle='" + eomsOrderTitle + '\'' +
                ", cityKey='" + cityKey + '\'' +
                ", cityName='" + cityName + '\'' +
                ", typeId='" + typeId + '\'' +
                ", typeName='" + typeName + '\'' +
                ", typeSubId='" + typeSubId + '\'' +
                ", typeSubName='" + typeSubName + '\'' +
                ", rangeId='" + rangeId + '\'' +
                ", rangeName='" + rangeName + '\'' +
                ", content='" + content + '\'' +
                ", neType='" + neType + '\'' +
                ", sendWay='" + sendWay + '\'' +
                ", createTime='" + createTime + '\'' +
                ", sendTime='" + sendTime + '\'' +
                ", fileName='" + fileName + '\'' +
                ", detailUrl='" + detailUrl + '\'' +
                '}';
    }
}
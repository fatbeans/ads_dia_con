package dao;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import model.UserDetHbaseEntity;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xinxin on 2015/7/22.
 */
public class Pager {

    private long page;
    private long records;
    private long total;
    private long size;
    private List<Model> rows;

    public long getPage() {
        return page;
    }

    public void setPage(long page) {
        this.page = page;
    }

    public long getRecords() {
        return records;
    }

    public void setRecords(long records) {
        this.records = records;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public long getSize() {
        return size;
    }

    public void setSize(long size) {
        this.size = size;
    }

    public List getRows() {
        return rows;
    }

    public void setRows(List rows) {
        this.rows = rows;
    }

    public String toJsonString() {

        return toJson().toJSONString();
    }

    public JSONObject toJson(){
        JSONObject json = new JSONObject();
        json.put("rows", JSON.parse(JsonKit.toJson(rows)));
        json.put("page", page);
        json.put("total", total);
        json.put("records", records);
        return json;
    }

    public String toJsonString(Page p){
        setPage(p.getPageNumber());
        setRecords(p.getTotalRow());
        setTotal(p.getTotalPage());
        setRows(p.getList());
        return toJsonString();

    }






}

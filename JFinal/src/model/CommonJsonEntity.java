package model;

import com.alibaba.fastjson.JSONArray;

/**
 * 通用JSON实体类
 * @author LeiYun
 * 2015年9月1日
 */
public class CommonJsonEntity {
	
	/**
	 * 列字段多个以逗号分开
	 */
	private String cols;
	
	/**
	 * 中文字段
	 */
	private String colsCN;
	
	/**
	 * 总条数
	 */
	private long totalNum;
	
	/**
	 * 内容JSON
	 */
	private JSONArray jsonArray;

	public String getCols() {
		return cols;
	}

	public void setCols(String cols) {
		this.cols = cols;
	}
	
	public String getColsCN() {
		return colsCN;
	}

	public void setColsCN(String colsCN) {
		this.colsCN = colsCN;
	}
	
	public long getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(long totalNum) {
		this.totalNum = totalNum;
	}
	
	public JSONArray getJsonArray() {
		return jsonArray;
	}

	public void setJsonArray(JSONArray jsonArray) {
		this.jsonArray = jsonArray;
	}

}

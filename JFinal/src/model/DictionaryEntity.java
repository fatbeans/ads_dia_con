package model;

/**
 * 字典实体类
 * @author LeiYun
 * 2015年8月25日
 */
public class DictionaryEntity {

	private String key;
	
	private String name;
	
	private String prop1;
	
	private String prop2;

	public String getProp1() {
		return prop1;
	}

	public void setProp1(String prop1) {
		this.prop1 = prop1;
	}

	public String getProp2() {
		return prop2;
	}

	public void setProp2(String prop2) {
		this.prop2 = prop2;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}

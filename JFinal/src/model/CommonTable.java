package model;

import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(javax.xml.bind.annotation.XmlAccessType.FIELD)
public class CommonTable {
	
	@XmlAttribute(name="id")
	private String id;
	
	@XmlAttribute(name="name")
	private String name;
	
	@XmlElement(name = "fields")
	private String fields;
	
	@XmlElement(name = "fieldsCN")
	private String fieldsCN;
	
	
	@XmlElement(name = "condition")
	private String condition;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFields() {
		return fields;
	}

	public void setFields(String fields) {
		this.fields = fields;
	}

	public String getFieldsCN() {
		return fieldsCN;
	}

	public void setFieldsCN(String fieldsCN) {
		this.fieldsCN = fieldsCN;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}
}

package model;

import java.io.Serializable;


import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;



/**
 * 
 * @author LeiYun
 * 2015年8月24日
 */
@XmlAccessorType(javax.xml.bind.annotation.XmlAccessType.FIELD)
public class Adapter implements Serializable{
	
	@XmlAttribute(name="interface")
	private String interfaceName;
	
	@XmlAttribute(name="class")
	private String adapterName;
	
	public Adapter() {
		
	}
	
	public String getInterfaceName() {
		return interfaceName;
	}
	
	public String getAdapterName() {
		return adapterName;
	}
	
	public void setInterfaceName(String interfaceName) {
		this.interfaceName=interfaceName;
	}
	
	public void setAdapterName(String adapterName) {
		this.adapterName=adapterName;
	}
}

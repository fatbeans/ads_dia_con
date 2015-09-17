package model;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "tables")
public class CommonTables extends ArrayList<CommonTable>{

	@XmlElement(name = "table")  
    public List<CommonTable> getTables() {  
        return this;  
    } 
}

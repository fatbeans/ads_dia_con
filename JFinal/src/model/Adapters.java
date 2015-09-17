package model;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "adapters")  
public class Adapters extends ArrayList<Adapter> {
	@XmlElement(name = "adapter")  
    public List<Adapter> getAdapters() {  
        return this;  
    }  
}

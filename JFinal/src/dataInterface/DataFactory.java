package dataInterface;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import model.Adapter;
import model.Adapters;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;



/**
 * 
 * @author LeiYun
 * 2015年8月20日
 */
public class DataFactory  {
	
	private static String filePath = null;
	
	static{
		filePath=DataFactory.class.getClassLoader().getResource("/config/adapter.xml").getFile();
	}
	
	public static String getFile() throws IOException {
		StringBuffer buffer = new StringBuffer();
		FileInputStream stream = null;
		InputStreamReader ireader = null;
		BufferedReader breader = null;
		try {
			stream = new FileInputStream(filePath);
			ireader = new InputStreamReader(stream);
			breader = new BufferedReader(ireader);

			String line = null;
			while ((line = breader.readLine()) != null) {
				buffer.append(line);
			}
			return buffer.toString();
		} finally {
			try{
				if(stream!=null)
					stream.close();
				if(ireader!=null)
					ireader.close();
				if(breader!=null)
					breader.close();
			}catch(Exception ex){
				
			}
		}	
	}
	
	public static String getRealizeFile(String interfaceName) throws JAXBException {
		String realieClass="";
		JAXBContext cxt = JAXBContext.newInstance(model.Adapters.class);  
		Unmarshaller unmarshaller = cxt.createUnmarshaller();  
		
		@SuppressWarnings("unchecked")
		Adapters adapters=(Adapters)unmarshaller.unmarshal(new File(filePath));
		List<Adapter> adapterList=adapters.getAdapters();
		if(adapterList!=null){
			for(int i=0;i<adapterList.size();i++){
				Adapter adapter=adapterList.get(i);
				if(adapter.getInterfaceName().toLowerCase().equals(interfaceName.toLowerCase())){
					realieClass=adapter.getAdapterName();
					break;
				}
			}
		}
		return realieClass;
	}
	
	@SuppressWarnings("unchecked")
	public static <T> T getInstance(Class<T> clazz){
		T instance=null;
		try{
			String interfaceName= clazz.getName();
			String realize=getRealizeFile(interfaceName);
			instance=(T) Class.forName(realize).newInstance();
		}catch(Exception ex){
			
		}
		return instance;
	}
}
 


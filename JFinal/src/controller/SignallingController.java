package controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.text.ParseException;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import model.DictionaryEntity;
import model.SignallingCommon;
import model.SignallingDetailEntity;
import model.SignallngObjEntity;

import org.xml.sax.SAXException;

import service.signalling.SignallingService;
import utility.ExceptionHelper;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;

/**
 * 
 * @author LeiYun
 * 2015年8月13日
 */
public class SignallingController extends Controller{



	public void getProp() {
		JSONObject obj = new JSONObject();
		JSONObject json = new JSONObject();
		json.put("gishost", PropKit.get("gishost"));
		
		obj.put("obj", json);
		this.renderJson(obj);
	}
	
	/**
	 * 
	 * @author LeiYun
	 * 2015年8月13日
	 * @throws SAXException 
	 * @throws ParserConfigurationException 
	 * @throws URISyntaxException 
	 * @throws IOException 
	 * @throws ParseException 
	 */
	public void getSignallingList(){
		
		JSONObject json = new JSONObject();
		try{
			
			int pageSize=this.getParaToInt("pageSize",10);
			int pageIndex=this.getParaToInt("pageIndex",0);
			long startDate=this.getParaToLong("startDate");
			long endDate=this.getParaToLong("endDate");
			String phone=this.getPara("phone").trim();
			String imsi=this.getPara("imsi").trim();
			String failStatus=this.getPara("failStatus","-1").trim();
			String interfaceType=this.getPara("interfaceType","").trim();
			String procedure_type=this.getPara("procedure_type","").trim();
			String pageDate=this.getPara("pageDate","").trim();
					
			SignallingService signallingService=new SignallingService();
			SignallngObjEntity signallingObj= signallingService.getSignallingList(pageSize, pageIndex, startDate, endDate, phone, imsi, failStatus, interfaceType, procedure_type,pageDate);
			
			json.put("obj", signallingObj);
			json.put("status", 1);
		}catch(Exception ex){
			json.put("status", 0);
			json.put("message", ExceptionHelper.getExceptionAllinformation(ex));
		}
		
		this.renderJson(json);
	}
	
	/**
	 * 
	 * @author LeiYun
	 * 2015年8月19日
	 */
	public void getSignallingDetail(){
		JSONObject json = new JSONObject();
		try{
			String tabName=this.getPara("tabName").trim();
			String procedure_starttime_ms=this.getPara("procedure_starttime_ms").trim();
			String procedure_endtime_ms=this.getPara("procedure_endtime_ms").trim();
			String xdr_id=this.getPara("xdr_id").trim();
			String phone=this.getPara("msisdn").trim();
			String rowKey=this.getPara("rowKey").trim();
			
			SignallingService signallingService=new SignallingService();
			SignallingDetailEntity resultJson=signallingService.getSignallingDetail(tabName, procedure_starttime_ms, procedure_endtime_ms, phone, xdr_id,rowKey);
			json.put("cols", resultJson.getCols());
			json.put("obj", resultJson.getJsonArray());
			json.put("status", 1);
			
		}catch(Exception ex){
			json.put("status", 0);
			json.put("message", ExceptionHelper.getExceptionAllinformation(ex));
		}
		this.renderJson(json);
	}

	public void getFlowType() {
		JSONObject json = new JSONObject();
		try{
			List<DictionaryEntity> dictionaryList=new service.signalling.SignallingService().getFlowType();
			json.put("obj", dictionaryList);
			json.put("status", 1);
		}catch(Exception ex){
			json.put("status", 0);
			json.put("message", ExceptionHelper.getExceptionAllinformation(ex));
		}
		this.renderJson(json);
	}
}

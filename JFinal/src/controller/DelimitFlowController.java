package controller;



import java.util.List;

import model.CommonJsonEntity;
import model.ConclusionEntity;
import service.delimitFlow.ConclusionService;
import utility.ExceptionHelper;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.kit.HashKit;


/**
 * 
 * @author LeiYun
 * 2015年8月13日
 */
public class DelimitFlowController extends Controller{
	
	public void getConclusion(){
		JSONObject json = new JSONObject();
		try{
			String phone=this.getPara("phone");
			String startDate=this.getPara("startDate");
			String endDate=this.getPara("endDate");
			
			String sessionId = (Long.valueOf(HashKit.md5(startDate + endDate + phone).substring(9, 24), 16) + "");

			List<ConclusionEntity> conclusionList=new ConclusionService().getConclusion(sessionId, null);
			int resultCount=conclusionList.size();
			if(resultCount==0){
				boolean excuteResult= HomePageController.sendAnalyse(startDate, endDate, phone, sessionId);
				if(excuteResult){
					conclusionList=new ConclusionService().getConclusion(sessionId, null);
				}
			}
			json.put("obj", conclusionList);
			json.put("status", 1);
		}catch(Exception ex){
			json.put("status", 0);
			json.put("message", ExceptionHelper.getExceptionAllinformation(ex));
		}
		this.renderJson(json);
	}
	
    public void getConclusionDetail() {
    	JSONObject json = new JSONObject();
    	try{
    		String phone=this.getPara("phone");
			String startDate=this.getPara("startDate");
			String endDate=this.getPara("endDate");
			String lv1Id=this.getPara("lv1");
			String cid=this.getPara("cid");
			String sessionId = (Long.valueOf(HashKit.md5(startDate + endDate + phone).substring(9, 24), 16) + "");
			int pageSize=this.getParaToInt("pageSize",10);
			int pageIndex=this.getParaToInt("pageIndex",0);
			String condition="";
			CommonJsonEntity commonJson=new ConclusionService().getConclusionDetail(sessionId,lv1Id, cid, condition, pageSize, pageIndex);
			json.put("obj", commonJson);
			json.put("status", 1);
    	}catch(Exception ex){
    		json.put("status", 0);
			json.put("message", ExceptionHelper.getExceptionAllinformation(ex));
    	}
    	this.renderJson(json);
	}
}

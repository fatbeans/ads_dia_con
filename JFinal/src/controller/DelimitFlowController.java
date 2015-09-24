package controller;



import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import model.CommonJsonEntity;
import model.ConclusionEntity;
import service.delimitFlow.ConclusionService;
import utility.ExceptionHelper;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.core.Controller;
import com.jfinal.kit.HashKit;
import com.jfinal.plugin.activerecord.DbKit;


/**
 * 
 * @author LeiYun
 * 2015年8月13日
 */
public class DelimitFlowController extends Controller{
	
	public void getConclusion(){
		JSONObject json = new JSONObject();
		try{
			String phone=this.getPara("phone","").trim();
			String startDate=this.getPara("startDate","").trim();
			String endDate=this.getPara("endDate","").trim();
			if(StringUtils.isBlank(phone) && phone.length()<11){
				json.put("status", 0);
				json.put("message", "用户标识格式错误.");
			}else if(StringUtils.isBlank(startDate)){
				json.put("status", 0);
				json.put("message", "开始时间格式错误.");
			}else if(StringUtils.isBlank(endDate)){
				json.put("status", 0);
				json.put("message", "结束时间格式错误.");
			}else{
				if(phone.length()==11){
					phone=getImsi(phone);
				}
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
			}
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

    private String getImsi(String phone) throws Exception{
		String imsi="";
		Statement statement = null;
		ResultSet resultSet = null;
		String smsiSql="select imsi from map_imsi_mdn where mdn ="+phone;
		try{
			statement = DbKit.getConfig("orcl").getConnection().createStatement();
			resultSet = statement.executeQuery(smsiSql);
			while (resultSet.next()) {
				imsi=resultSet.getString("imsi");
			}
		}catch(Exception ex){
			throw ex;
		}finally{
			if (statement != null) {
				statement.close();
			}
			if (resultSet != null) {
				resultSet.close();
			}
		}
		return imsi;
	}
}

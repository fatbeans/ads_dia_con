package adapter.hbase.signalling;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hbase.nx.base.XDataHBaseHelper;
import com.jfinal.plugin.activerecord.DbKit;

import utility.dateTime;
import model.DictionaryEntity;
import model.SignallingCommon;
import model.SignallingDetailEntity;
import model.SignallngObjEntity;
import dataInterface.Isignalling;

public class SignallingAdapter  implements Isignalling{

	@Override
	public List<DictionaryEntity> getFlowType() throws Exception {
		return null;
	}

	@Override
	public SignallngObjEntity getSignallingList(int pageSize,
			int pageIndex, long startDate, long endDate, String phone,
			String imsi, String failStatus, String interfaceType,
			String procedureType,String pageDate) throws Exception {
		// TODO Auto-generated method stub
		if(imsi.length()<=11){
			imsi=getImsi(phone);
		}
        //System.getProperties().put("hadoop.home.dir", "D:\\hadoop-common-2.2.0-bin-master"); 
		SignallngObjEntity signallngObj=new SignallngObjEntity();
		List<SignallingCommon> signallingList=new ArrayList<SignallingCommon>();
		XDataHBaseHelper hbaseHelper=null;
		
		boolean isQueryHttp=false;
		boolean isQueryMME=false;
		
		if(interfaceType!=null && !interfaceType.equals("")){
			if(procedureType!=null && !procedureType.equals("")){
				isQueryMME=true;
				if(procedureType.contains("-2")){
					isQueryHttp=true;
				}
			}else{
				if(interfaceType.contains("5")){
					isQueryMME=true;
				}
				if(interfaceType.contains("5")&&interfaceType.contains("11")){
					isQueryMME=true;
					isQueryHttp=true;
				}else if(interfaceType.equals("11")){
					isQueryHttp=true;
				}
			}
		}else{
			isQueryMME=true;
			isQueryHttp=true;
		}
		System.out.println("isQueryMME:"+isQueryMME+",isQueryHttp:"+isQueryHttp);
		
		
		try{
			hbaseHelper=XDataHBaseHelper.getHelper();
			String sql="";
			Date sDate=dateTime.converTo("yyyyMMddhh", String.valueOf(startDate));
			Date eDate=dateTime.converTo("yyyyMMddhh", String.valueOf(endDate));
			if(pageDate!=null && !pageDate.equals("")){
				eDate=dateTime.converTo("yyyyMMddHHmmssSSS", String.valueOf(pageDate));
			}
			boolean isFirst=true;
			while(dateTime.converToLong("yyyyMMdd", sDate) <= dateTime.converToLong("yyyyMMdd", eDate) && signallingList.size()<11){
				
				String sRrowKey=StringUtils.rightPad(imsi, 15,"0")+StringUtils.rightPad(String.valueOf(startDate), 17,"0")+"00";
				String eRowKey=StringUtils.rightPad(imsi, 15,"0")+StringUtils.rightPad(String.valueOf(endDate), 17,"9")+"99";
				if(pageDate!=null && !pageDate.equals("") && isFirst){
					eRowKey=StringUtils.rightPad(imsi, 15,"0")+StringUtils.rightPad(String.valueOf(dateTime.converToLong("yyyyMMddHHmmssSSS", eDate)), 17,"9")+"99";
				}
				if(!isFirst){
					eRowKey=StringUtils.rightPad(imsi, 15,"0")+StringUtils.rightPad(String.valueOf(dateTime.converToLong("yyyyMMddHHmmssSSS", eDate)), 17,"9")+"99";
				}
				
				//HHTP
				if(isQueryHttp){
					String httpTable="S_M_HTTP_"+String.valueOf(dateTime.converToLong("yyyyMMdd", eDate));
					if(hbaseHelper.tableExists(httpTable)){
						System.out.println("table:"+httpTable+",startRow:"+sRrowKey+",endRow:"+eRowKey);
						List<Map<String, String>> result= hbaseHelper.get(httpTable,sRrowKey,eRowKey,null);
						System.out.println(httpTable+"总共：" +result.size());
						for(Map<String, String> item:result){
							SignallingCommon signalling=getHttpSignalling(item.get("other"));
							if(signalling!=null){
								boolean isStatus=(failStatus!=null && !failStatus.equals("-1") && signalling.getProcedureStatus().equals("3"))||failStatus==null ||failStatus.equals("-1");
								if(isStatus){
									signalling.setRowKey(item.get("key"));
									signallingList.add(signalling);

								}
							}
						}
						
					}else{
						System.out.println(httpTable+"表不存在.");
					}
				}
				//MME
				if(isQueryMME){
					String mmeEMMTable="S_M_S1MME_EMM_"+String.valueOf(dateTime.converToLong("yyyyMMdd", eDate));
					String mmeESMTable="S_M_S1MME_ESM_"+String.valueOf(dateTime.converToLong("yyyyMMdd", eDate));
					String mmeS1APTable="S_M_S1MME_S1AP_"+String.valueOf(dateTime.converToLong("yyyyMMdd", eDate));
					if(hbaseHelper.tableExists(mmeEMMTable)){
						System.out.println("table:"+mmeEMMTable+",startRow:"+sRrowKey+",endRow:"+eRowKey);
						List<Map<String, String>> result= hbaseHelper.get(mmeEMMTable,sRrowKey,eRowKey,null);
						System.out.println(mmeEMMTable+"总共：" +result.size());
						for(Map<String, String> item:result){
							SignallingCommon signalling=getMMEEMMTableSignalling(item.get("other"));
							if(signalling!=null){
								boolean isStatus=(failStatus!=null && !failStatus.equals("-1") && signalling.getProcedureStatus().equals("3"))||failStatus==null ||failStatus.equals("-1");
								boolean isProcedureType =procedureType==null || procedureType.equals("") || (procedureType.contains(signalling.getProcedureType()));
								if(isStatus && isProcedureType){
									signalling.setRowKey(item.get("key"));
									signallingList.add(signalling);
								}
							}
						}
						
					}else{
						System.out.println(mmeEMMTable+"表不存在.");
					}
					if(hbaseHelper.tableExists(mmeESMTable)){
						System.out.println("table:"+mmeESMTable+",startRow:"+sRrowKey+",endRow:"+eRowKey);
						List<Map<String, String>> result= hbaseHelper.get(mmeESMTable,sRrowKey,eRowKey,null);
						System.out.println(mmeESMTable+"总共：" +result.size());
						for(Map<String, String> item:result){
							SignallingCommon signalling=getMMEESMTableSignalling(item.get("other"));
							if(signalling!=null){
								boolean isStatus=(failStatus!=null && !failStatus.equals("-1") && signalling.getProcedureStatus().equals("3"))||failStatus==null ||failStatus.equals("-1");
								boolean isProcedureType =procedureType==null || procedureType.equals("") || (procedureType.contains(signalling.getProcedureType()));
								if(isStatus && isProcedureType){
									signalling.setRowKey(item.get("key"));
									signallingList.add(signalling);
								}
							}
						}
						
					}else{
						System.out.println(mmeESMTable+"表不存在.");
					}
					if(hbaseHelper.tableExists(mmeS1APTable)){
						System.out.println("table:"+mmeS1APTable+",startRow:"+sRrowKey+",endRow:"+eRowKey);
						List<Map<String, String>> result= hbaseHelper.get(mmeS1APTable,sRrowKey,eRowKey,null);
						System.out.println(mmeS1APTable+"总共：" +result.size());
						for(Map<String, String> item:result){
							SignallingCommon signalling=getMMES1APTableSignalling(item.get("other"));
							if(signalling!=null){
								boolean isStatus=(failStatus!=null && !failStatus.equals("-1") && signalling.getProcedureStatus().equals("3"))||failStatus==null ||failStatus.equals("-1");
								boolean isProcedureType =procedureType==null || procedureType.equals("") || (procedureType.contains(signalling.getProcedureType()));
								if(isStatus && isProcedureType){
									signalling.setRowKey(item.get("key"));
									signallingList.add(signalling);
								}
							}
						}
						
					}else{
						System.out.println(mmeS1APTable+"表不存在.");
					}
				}
				
				Calendar calendar=Calendar.getInstance();
				calendar.setTime(eDate);
				calendar.set(Calendar.DAY_OF_MONTH,calendar.get(Calendar.DAY_OF_MONTH)-1);
				calendar.set(Calendar.HOUR_OF_DAY,23);
				calendar.set(Calendar.MINUTE,59);
				calendar.set(Calendar.SECOND,59);
				calendar.set(Calendar.MILLISECOND,999);
				eDate=calendar.getTime();
				isFirst=false;
				
			}
			System.out.println("数量："+ signallingList.size());
			
			for(int i=0;i<signallingList.size();i++){
				if(signallingList.get(i).getProcedure_starttime_ms()!=null && !signallingList.get(i).getProcedure_starttime_ms().equals("")){
					for(int j=i;j<signallingList.size();j++){
						long startDate1=Long.parseLong(signallingList.get(i).getProcedure_starttime_ms());
						SignallingCommon item2= signallingList.get(j);
						if(item2.getProcedure_starttime_ms()!=null && !item2.getProcedure_starttime_ms().equals("")){
							long startDate2=Long.parseLong(item2.getProcedure_starttime_ms());
							if(startDate1<startDate2){
								SignallingCommon temp=signallingList.get(i);
								signallingList.set(i, signallingList.get(j));
								signallingList.set(j, temp);
							}
						}
					}
				}
				
			}
			if(signallingList.size()>11){
				for(int i=signallingList.size()-1;i>=11;i--){
					signallingList.remove(i);
				}
			}
			if(signallingList.size()>0){
				List<DictionaryEntity> statusDictList=getStatus();
				for(int i=0;i<signallingList.size();i++){
					String statusCode=signallingList.get(i).getProcedureStatus();
					for(int j=0;j<statusDictList.size();j++){
						if(statusCode!=null && statusDictList.get(j).getKey()!=null && statusCode.trim().equals(statusDictList.get(j).getKey().trim())){
							signallingList.get(i).setProcedureStatusText(statusDictList.get(j).getName());
							if(statusCode.equals("3")){
								signallingList.get(i).setProcedureStatus("1");
							}
							break;
						}
					}
				}
			}
			
			
			signallngObj.setSql(sql);
			signallngObj.setSignallingList(signallingList);
		}catch(Exception ex){
			System.out.println(ex.getMessage());
		}finally{
			if(hbaseHelper!=null){
				hbaseHelper.close();
			}
		}

		return signallngObj;
	}

	@Override
	public SignallingDetailEntity getSignallingDetail(String tabName,
			String startDate, String endDate, String phone, String xdrId,String rowKey)
			throws Exception {
		Date sDate=dateTime.converTo("yyyyMMddHHmmssSSS", String.valueOf(startDate));
		SignallingDetailEntity signallingDetail=new SignallingDetailEntity();
		XDataHBaseHelper hbaseHelper=null;
		try{
			hbaseHelper=XDataHBaseHelper.getHelper();
			String tableName="";
			if(tabName.equals("http")){
				tableName="S_M_HTTP";
				signallingDetail.setCols("Imsi,电话号码,连接开始时间,连接结束时间,日期,小时,XDR_ID,接入类型,接口类型,流程类型,协议类型,小区标识,小区名称,终端标识,终端名称,业务大类,业务小类,客户端IP,服务的IP,NAI,连接状态,连接错误码,首要原因定界,上行流量,下行流量,平均响应时间,总响应,响应类型,负载类型,上行数据包,下行数据包,会话最后更新时间,连接行数,连接ID,总事件数,服务状态,TCP同步,TCP同步确认,TCP同步重置,url,host,方法,内容类型,用户代理,引用类型,更新数,最终用户IP");
			}else if(tabName.equals("mmeemm")){
				tableName="S_M_S1MME_EMM";
				signallingDetail.setCols("Imsi,连接开始时间,连接结束时间,日期,小时,XDR_ID,接入类型,接口类型,流程类型,协议类型,小区标识,小区名称,终端标识,终端名称,客户端IP,服务的IP,RAI,连接状态,连接错误码,FirstEvent,LastEvent,首要原因定界,上行流量,下行流量,平均响应时间,总响应,响应类型,负载类型,上行数据包,下行数据包,会话最后更新时间,连接行数,连接ID,总事件数,服务状态,TCP同步,TCP同步确认,TCP同步重置,FirstMTmsi,FirstMMEIp,LastMTmsi");
			}else if(tabName.equals("mmeesm")){
				tableName="S_M_S1MME_ESM";
				signallingDetail.setCols("Imsi,连接开始时间,连接结束时间,日期,小时,XDR_ID,接入类型,接口类型,流程类型,协议类型,小区标识,小区名称,终端标识,终端名称,客户端IP,服务的IP,RAI,连接状态,连接错误码,FirstEvent,LastEvent,首要原因定界,上行流量,下行流量,平均响应时间,总响应,响应类型,负载类型,上行数据包,下行数据包,会话最后更新时间,连接行数,连接ID,总事件数,服务状态,TCP同步,TCP同步确认,TCP同步重置,ParentEmmXdrId,最终用户IP,最终用户IPV6");
			}else if(tabName.equals("mmes1ap")){
				tableName="S_M_S1MME_S1AP";
				signallingDetail.setCols("Imsi,连接开始时间,连接结束时间,日期,小时,XDR_ID,接入类型,接口类型,流程类型,协议类型,小区标识,小区名称,终端标识,终端名称,客户端IP,服务的IP,RAI,连接状态,连接错误码,首要原因定界,上行流量,下行流量,平均响应时间,总响应,响应类型,负载类型,上行数据包,下行数据包,会话最后更新时间,连接行数,连接ID,总事件数,服务状态,TCP同步,TCP同步确认,TCP同步重置,EmmXdrId,MMEUeApId,eNodeBUeApId");
			}
			tableName=tableName+"_"+String.valueOf(dateTime.converToLong("yyyyMMdd", sDate));
			System.out.println(tableName);
			if(hbaseHelper.tableExists(tableName)){
				System.out.println("table:"+tableName+",rowKey:"+rowKey);
				Map<String, String> result= hbaseHelper.get(tableName,rowKey,null);
				if(result!=null && result.get("other")!=null){

					String[] colArray=StringUtils.splitByWholeSeparatorPreserveAllTokens(signallingDetail.getCols(), ",");
					String[] dataArray = StringUtils.splitByWholeSeparatorPreserveAllTokens(result.get("other"), "|");
					JSONArray array = new JSONArray();  
					if(colArray.length==dataArray.length){
						JSONObject jsonObj = new JSONObject(); 
						for(int i=0;i<colArray.length;i++){
							String columnName =colArray[i];  
				            String value = dataArray[i];
				            jsonObj.put(columnName, value);  
						}
						array.add(jsonObj);
					}
					String sql="";
					signallingDetail.setSql(sql);
				    signallingDetail.setJsonArray(array);
				}else{
					System.out.println("table:"+tableName+",rowKey:"+rowKey+";未查到数据");
				}
			}else{
				System.out.println(tableName+"不存在");
			}
		}catch(Exception ex){
			throw ex;
		}finally{
			if(hbaseHelper!=null){
				hbaseHelper.close();
			}
		}
		return signallingDetail;
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

	private List<DictionaryEntity> getStatus() throws Exception{
		List<DictionaryEntity> dictionaryList=new ArrayList<DictionaryEntity>();
		Statement statement=null;
		ResultSet resultSet=null;
		try{
			
			statement= DbKit.getConfig("orcl").getConnection().createStatement();
			String sql="select STATUS,STATUS_CODE from ads_dia_http_status";
			resultSet= statement.executeQuery(sql);
			while (resultSet.next()){
				DictionaryEntity dictionary=new DictionaryEntity();
				dictionary.setKey(resultSet.getString("STATUS"));
				dictionary.setName(resultSet.getString("STATUS_CODE"));
				dictionaryList.add(dictionary);
			}
		}catch(Exception ex){
			throw ex;
		}finally{
			if(statement!=null){
				statement.close();
			}
			if(!resultSet.equals(null)){
				resultSet.close();
			}
		}
		return dictionaryList;
	}
	
	private SignallingCommon getHttpSignalling(String dataStr) throws ParseException{
		String[] dataArray = StringUtils.splitByWholeSeparatorPreserveAllTokens(dataStr, "|");
		SignallingCommon signalling=new SignallingCommon();
		if(dataArray.length==47){
			signalling.setTabname("http");
			signalling.setImsi(dataArray[0]);
			signalling.setMsisdn(dataArray[1]);
			signalling.setOldStartDate(dataArray[2]);
			signalling.setOldEndDate(dataArray[3]);
			if(signalling.getOldStartDate()!=null && !signalling.getOldStartDate().equals("")){
				Date d1=new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").parse(signalling.getOldStartDate());
				signalling.setProcedure_starttime_ms(String.valueOf(d1.getTime()));
			}
			if(signalling.getOldEndDate()!=null && !signalling.getOldEndDate().equals("")) {
				Date d2=new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").parse(signalling.getOldEndDate());
				signalling.setProcedure_endtime_ms(String.valueOf(d2.getTime()));
			}
			signalling.setXdrId(dataArray[6]);
			signalling.setRat(dataArray[7]);
			signalling.setInterfaceType("11");
			signalling.setProcedureType("-2");
			signalling.setProtocolType(dataArray[10]);
			
			signalling.setCellId(dataArray[12]);
			signalling.setUserIp4(dataArray[17]);
			signalling.setServerIp(dataArray[18]);
			signalling.setProcedureStatus(dataArray[20]);
			signalling.setFailureCause(dataArray[21]);
			signalling.setBusLantency(dataArray[25]);
		}
		return signalling;
	}

	private SignallingCommon getMMEEMMTableSignalling(String dataStr) throws ParseException{
		String[] dataArray = StringUtils.splitByWholeSeparatorPreserveAllTokens(dataStr, "|");
		SignallingCommon signalling=new SignallingCommon();
		if(dataArray.length==41){
			signalling.setTabname("mmeemm");
			signalling.setImsi(dataArray[0]);
			signalling.setOldStartDate(dataArray[1]);
			signalling.setOldEndDate(dataArray[2]);
			if(signalling.getOldStartDate()!=null && !signalling.getOldStartDate().equals("")){
				Date d1=new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").parse(signalling.getOldStartDate());
				signalling.setProcedure_starttime_ms(String.valueOf(d1.getTime()));
			}
			if(signalling.getOldEndDate()!=null && !signalling.getOldEndDate().equals("")) {
				Date d2=new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").parse(signalling.getOldEndDate());
				signalling.setProcedure_endtime_ms(String.valueOf(d2.getTime()));
			}
			signalling.setXdrId(dataArray[5]);
			signalling.setCity("");
			signalling.setTac("");
			signalling.setCellId(dataArray[11]);
			signalling.setRat(dataArray[6]);
			signalling.setInterfaceType(dataArray[7]);
			signalling.setProcedureType(dataArray[8]);
			signalling.setBusLantency(dataArray[24]);
			signalling.setUserIp4(dataArray[14]);
			signalling.setServerIp(dataArray[15]);
			signalling.setProcedureStatus(dataArray[17]);
			signalling.setFailureCause(dataArray[18]);
			signalling.setProtocolType(dataArray[9]);
		}
		return signalling;
	}
	
	private SignallingCommon getMMEESMTableSignalling(String dataStr) throws ParseException{
		String[] dataArray = StringUtils.splitByWholeSeparatorPreserveAllTokens(dataStr, "|");
		SignallingCommon signalling=new SignallingCommon();
		if(dataArray.length==41){
			signalling.setTabname("mmeesm");
			signalling.setImsi(dataArray[0]);
			signalling.setOldStartDate(dataArray[1]);
			signalling.setOldEndDate(dataArray[2]);
			if(signalling.getOldStartDate()!=null && !signalling.getOldStartDate().equals("")){
				Date d1=new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").parse(signalling.getOldStartDate());
				signalling.setProcedure_starttime_ms(String.valueOf(d1.getTime()));
			}
			if(signalling.getOldEndDate()!=null && !signalling.getOldEndDate().equals("")) {
				Date d2=new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").parse(signalling.getOldEndDate());
				signalling.setProcedure_endtime_ms(String.valueOf(d2.getTime()));
			}
			signalling.setXdrId(dataArray[5]);
			signalling.setCity("");
			signalling.setTac("");
			signalling.setRat(dataArray[6]);
			signalling.setCellId(dataArray[11]);
			signalling.setInterfaceType(dataArray[7]);
			signalling.setProcedureType(dataArray[8]);
			signalling.setBusLantency(dataArray[24]);
			signalling.setUserIp4(dataArray[14]);
			signalling.setServerIp(dataArray[15]);
			signalling.setProcedureStatus(dataArray[17]);
			signalling.setFailureCause(dataArray[18]);
			signalling.setProtocolType(dataArray[9]);
		}
		return signalling;
	}

	private SignallingCommon getMMES1APTableSignalling(String dataStr) throws ParseException{
		String[] dataArray = StringUtils.splitByWholeSeparatorPreserveAllTokens(dataStr, "|");
		SignallingCommon signalling=new SignallingCommon();
		if(dataArray.length==39){
			signalling.setTabname("mmes1ap");
			signalling.setImsi(dataArray[0]);
			signalling.setOldStartDate(dataArray[1]);
			signalling.setOldEndDate(dataArray[2]);
			if(signalling.getOldStartDate()!=null && !signalling.getOldStartDate().equals("")){
				Date d1=new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").parse(signalling.getOldStartDate());
				signalling.setProcedure_starttime_ms(String.valueOf(d1.getTime()));
			}
			if(signalling.getOldEndDate()!=null && !signalling.getOldEndDate().equals("")) {
				Date d2=new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").parse(signalling.getOldEndDate());
				signalling.setProcedure_endtime_ms(String.valueOf(d2.getTime()));
			}
			signalling.setXdrId(dataArray[5]);
			signalling.setCity("");
			signalling.setTac("");
			signalling.setRat(dataArray[6]);
			signalling.setCellId(dataArray[11]);
			signalling.setInterfaceType(dataArray[7]);
			signalling.setProcedureType(dataArray[8]);
			signalling.setBusLantency(dataArray[22]);
			signalling.setUserIp4(dataArray[14]);
			signalling.setServerIp(dataArray[15]);
			signalling.setProcedureStatus(dataArray[17]);
			signalling.setFailureCause(dataArray[18]);
			signalling.setProtocolType(dataArray[9]);
		}
		return signalling;
	}

	
}

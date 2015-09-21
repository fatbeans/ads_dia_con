package adapter.gbase.signalling;


import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import utility.dateTime;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.DbKit;

import model.DictionaryEntity;
import model.SignallingCommon;
import model.SignallingDetailEntity;
import model.SignallngObjEntity;
import dataInterface.Isignalling;

/**
 * 
 * @author LeiYun
 * 2015年8月24日
 */
public class SignallingAdapter implements Isignalling{

	@Override
	public List<DictionaryEntity> getFlowType() throws Exception {
		// TODO Auto-generated method stub
		
		List<DictionaryEntity> dictionaryList=new ArrayList<DictionaryEntity>();
		Statement statement=null;
		ResultSet resultSet=null;
		try{
			
			statement= DbKit.getConfig("gbase").getConnection().createStatement();
			String sql="select procedure_type_code,procedure_type,`proto_type_code`,`proto_type` from dw.ADS_DIA_PRO_EVNET_MAP";
			resultSet= statement.executeQuery(sql);
			while (resultSet.next()){
				DictionaryEntity dictionary=new DictionaryEntity();
				dictionary.setKey(resultSet.getString("procedure_type_code"));
				dictionary.setName(resultSet.getString("procedure_type"));
				dictionary.setProp1(resultSet.getString("proto_type_code"));
				dictionary.setProp2(resultSet.getString("proto_type"));
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
	
	@Override
	public SignallngObjEntity getSignallingList(int pageSize,
			int pageIndex, long startDate, long endDate, String phone,
			String imsi, String failStatus, String interfaceType,
			String procedureType,String pageDate) throws Exception {
		
		SignallngObjEntity signallngObj=new SignallngObjEntity();
		List<SignallingCommon> signallingList=new ArrayList<SignallingCommon>();
		
		Statement statement=null;
		ResultSet resultSet=null;
		try{
			startDate=Long.parseLong(Long.toString(startDate)+"0001");
			endDate=Long.parseLong(Long.toString(endDate)+"5959");
			
			statement= DbKit.getConfig("gbase").getConnection().createStatement();
			
			StringBuilder gnSql=new StringBuilder();
			StringBuilder httpSql=new StringBuilder();
			StringBuilder dnsSql=new StringBuilder();
			StringBuilder imSql=new StringBuilder();
			StringBuilder mmeSql=new StringBuilder();
			
			
			gnSql.append("SELECT 'gn' as tabname,gn.`start_time` as procedure_start_time ,gn.`end_time` as procedure_end_time,gn.`msisdn` as msisdn,gn.`imsi` as imsi,gn.`xdr_id` as xdr_id,'' as city,gn.`tac` as tac,gn.eci  as eci,'4G' as rat,'11' as interface,'-1' as procedure_type,to_char(gn.`tcplink_response_time2`) as BUS_LANTENCY,gn.`user_ip` as USER_IPv4,gn.`appserver_ip` as APP_SERVER_IP_IPV4,to_char(gn.`app_status`) as Procedure_Status,'' as failure_cause,to_char(gn.`protocol`) as PROTOCOL_TYPE FROM dw.F_MS_S1U_GENERAL gn where 2>1");
			httpSql.append("SELECT 'http' as tabname,http.`start_time` as procedure_start_time ,http.`end_time` as procedure_end_time,http.`msisdn` as msisdn,http.`imsi` as imsi,http.`xdr_id` as xdr_id,'' as city,http.`tac` as tac,http.eci  as eci,'4G' as rat,'11' as interface,'-2' as procedure_type,to_char(http.`action_delay`) as BUS_LANTENCY,http.`user_ip` as USER_IPv4,http.`appserver_ip` as APP_SERVER_IP_IPV4,to_char(http.`succ_flag`) as Procedure_Status,to_char(http.http_status_code) as failure_cause,to_char(http.`protocol`) as PROTOCOL_TYPE FROM dw.F_MS_S1U_HTTP http where 2>1");
			dnsSql.append("SELECT  'dns' as tabname,dns.`start_time` as procedure_start_time ,dns.`end_time` as procedure_end_time,dns.`msisdn` as msisdn,dns.`imsi` as imsi,dns.`xdr_id` as xdr_id,'' as city,dns.`tac` as tac,dns.eci  as eci,'4G' as rat,'11' as interface,'-3' as procedure_type,to_char(dns.`tcplink_response_time2`) as BUS_LANTENCY,dns.`user_ip` as USER_IPv4,dns.`appserver_ip` as APP_SERVER_IP_IPV4,to_char(dns.`app_status`) as Procedure_Status,to_char(dns.dns_reply_code) as failure_cause,to_char(dns.`protocol`) as PROTOCOL_TYPE FROM dw.F_MS_S1U_DNS dns where 2>1");
			imSql.append("SELECT 'im' as tabname,im.`start_time` as procedure_start_time ,im.`end_time` as procedure_end_time,im.`msisdn` as msisdn,im.`imsi` as imsi,im.`xdr_id` as xdr_id,'' as city,im.`tac` as tac,im.eci  as eci,'4G' as rat,'11' as interface,'-4' as procedure_type,to_char(im.`tcplink_response_time2`) as BUS_LANTENCY,im.`user_ip` as USER_IPv4,im.`appserver_ip` as APP_SERVER_IP_IPV4,to_char(im.`app_status`) as Procedure_Status,'' as failure_cause,to_char(im.`protocol`) as PROTOCOL_TYPE FROM dw.F_MS_S1U_IM im where 2>1");
			mmeSql.append("SELECT 'mme' as tabname,mme.`start_time` as procedure_start_time,mme.`end_time` as procedure_end_time,mme.`msisdn` as msisdn,mme.`imsi` as imsi,mme.`xdr_id` as xdr_id,'' as city,mme.`tac` as tac,mme.`eci` as eci,'4G' as rat ,'5' as interface,to_char(mme.`procedure_type`) as procedure_type,'' as BUS_LANTENCY,'' as USER_IPv4,mme.`mme_ip` as APP_SERVER_IP_IPV4,to_char(mme.`procedure_status`) as Procedure_Status,to_char(mme.`failure_cause`) as failure_cause,'' as PROTOCOL_TYPE FROM `dw`.`F_MS_S1MME` mme where 2>1");
			
			
			
			gnSql.append(" and gn.start_time>="+startDate).append(" and gn.end_time<="+endDate);
			httpSql.append(" and http.start_time>="+startDate).append(" and http.end_time<="+endDate);
			dnsSql.append(" and dns.start_time>="+startDate).append(" and dns.end_time<="+endDate);
			imSql.append(" and im.start_time>="+startDate).append(" and im.end_time<="+endDate);
			mmeSql.append(" and mme.start_time>="+startDate).append(" and mme.end_time<="+endDate);
			
			if(!phone.equals("")){
				gnSql.append(" and gn.`msisdn`="+phone);
				httpSql.append(" and http.`msisdn`="+phone);
				dnsSql.append(" and dns.`msisdn`="+phone);
				imSql.append(" and im.`msisdn`="+phone);
				mmeSql.append(" and mme.`msisdn`="+phone);
				
			}
			if(!imsi.equals("")){
				gnSql.append(" and gn.`imsi`="+imsi);
				httpSql.append(" and http.`imsi`="+imsi);
				dnsSql.append(" and dns.`imsi`="+imsi);
				imSql.append(" and im.`imsi`="+imsi);
				mmeSql.append(" and mme.`imsi`="+imsi);
			}
			if(!failStatus.equals("-1")){
				gnSql.append(" and gn.`app_status`="+failStatus);
				httpSql.append(" and http.`succ_flag`="+failStatus);
				dnsSql.append(" and dns.`app_status`="+failStatus);
				imSql.append(" and dns.`app_status`="+failStatus);
				mmeSql.append(" and mme.procedure_status="+failStatus);
				
			}
			if(!procedureType.equals("")){
				mmeSql.append(" and mme.`procedure_type` in("+procedureType+")");
			}
			gnSql.append(" order by gn.`start_time` desc");
			httpSql.append(" order by http.`start_time` desc");
			dnsSql.append(" order by dns.`start_time` desc");
			imSql.append(" order by im.`start_time` desc");
			mmeSql.append(" order by mme.`start_time` desc");
			
			
			StringBuilder sql=new StringBuilder();
			sql.append("select *from(");
			if(interfaceType!=null && !interfaceType.equals("")){
				if(procedureType!=null && !procedureType.equals("")){
					sql.append("("+ mmeSql+")");
					if(procedureType.contains("-1")){
						sql.append("UNION ALL ("+gnSql+")");
					}
					if(procedureType.contains("-2")){
						sql.append("UNION ALL ("+httpSql+")");
					}
					if(procedureType.contains("-3")){
						sql.append("UNION ALL ("+dnsSql+")");
					}
					if(procedureType.contains("-4")){
						sql.append("UNION ALL ("+imSql+")");
					}
				}else{
					if(interfaceType.contains("5")){
						sql.append("("+ mmeSql+")");
					}
					if(interfaceType.contains("5")&&interfaceType.contains("11")){
						sql.append("UNION ALL ("+gnSql+")");
						sql.append("UNION ALL ("+httpSql+")");
						sql.append("UNION ALL ("+dnsSql+")");
						sql.append("UNION ALL ("+imSql+")");
					}else if(interfaceType.equals("11")){
						sql.append("("+gnSql+")");
						sql.append("UNION ALL ("+httpSql+")");
						sql.append("UNION ALL ("+dnsSql+")");
						sql.append("UNION ALL ("+imSql+")");
					}
				}
			}else{
				sql.append("("+ mmeSql+")");
				sql.append("UNION ALL ("+gnSql+")");
				sql.append("UNION ALL ("+httpSql+")");
				sql.append("UNION ALL ("+dnsSql+")");
				sql.append("UNION ALL ("+imSql+")");
			}
						
			sql.append(")t");
			sql.append(" limit "+(pageIndex*pageSize)+" ,"+(pageIndex*pageSize+pageSize+1));
			System.out.println(sql.toString());
			resultSet= statement.executeQuery(sql.toString());
			while (resultSet.next()) {
				SignallingCommon signalling=new SignallingCommon();
				signalling.setTabname(resultSet.getString("tabname"));
				String sdate=resultSet.getString("procedure_start_time");
				String edate=resultSet.getString("procedure_end_time");
				signalling.setOldStartDate(sdate);
				signalling.setOldEndDate(edate);
				if(sdate!=null && !sdate.equals("")){
					Date d1=new java.text.SimpleDateFormat("yyyyMMddHHmmss").parse(sdate);
					signalling.setProcedure_starttime_ms(String.valueOf(d1.getTime()));
				}
				if(edate!=null && !edate.equals("")){
					Date d2=new java.text.SimpleDateFormat("yyyyMMddHHmmss").parse(edate);
					signalling.setProcedure_endtime_ms(String.valueOf(d2.getTime()));
				}
				signalling.setMsisdn(resultSet.getString("msisdn"));
				signalling.setImsi(resultSet.getString("imsi"));
				signalling.setXdrId(resultSet.getString("xdr_id"));
				signalling.setCity(resultSet.getString("city"));
				signalling.setTac(resultSet.getString("tac"));
				signalling.setCellId(resultSet.getString("eci"));
				signalling.setRat(resultSet.getString("rat"));
				signalling.setInterfaceType(resultSet.getString("interface"));
				signalling.setProcedureType(resultSet.getString("procedure_type"));
				signalling.setBusLantency(resultSet.getString("BUS_LANTENCY"));
				signalling.setUserIp4(resultSet.getString("USER_IPv4"));
				signalling.setServerIp(resultSet.getString("APP_SERVER_IP_IPV4"));
				String statusCode=resultSet.getString("Procedure_Status");
				String stautsText="";
				if(statusCode.equals("0")){
					stautsText="成功";
				}else if(statusCode.equals("1")){
					stautsText="失败";
				}else{
					stautsText="未知";
				}
				signalling.setProcedureStatus(statusCode);
				signalling.setProcedureStatusText(stautsText);
				signalling.setFailureCause(resultSet.getString("failure_cause"));
				signalling.setProtocolType(resultSet.getString("PROTOCOL_TYPE"));
				signallingList.add(signalling);
			}
			List<DictionaryEntity> flowTypeList= getFlowType();
			
			for(SignallingCommon sigitem: signallingList){
				for(DictionaryEntity dictionaryint:flowTypeList){
					if(sigitem.getProcedureType()!=null && sigitem.getInterfaceType()!=null &&sigitem.getInterfaceType().equals("5") 
							&& sigitem.getProcedureType().equals(dictionaryint.getKey())){
						sigitem.setProcedureStatusText(dictionaryint.getName());
						sigitem.setProtocolType(dictionaryint.getProp2());
						break;
					}
				}
			}
			signallngObj.setSql(sql.toString());
			signallngObj.setSignallingList(signallingList);
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
		return signallngObj;
	}
	
	@Override
	public SignallingDetailEntity getSignallingDetail(String tabName, String startDate,
			String endDate, String phone, String xdrId,String rowKey) throws Exception {
		SignallingDetailEntity signallingDetail=new SignallingDetailEntity();
		Statement statement=null;
		ResultSet resultSet=null;
		try{
			statement=DbKit.getConfig("gbase").getConnection().createStatement();
			String sql="";
			if(tabName.equals("gn")){
				sql="SELECT `xdr_id`,`imsi`,`msisdn`,`imei`,`imei_tac`,`tac`,`eci`,`sgw_ip`,`sgw_port`,`apn`,`start_time`,`end_time`,`time_hour`,`time_day`,`protocol`,`app_type`,`app_subtype`,`app_content`,`app_status`,`user_ip`,`user_ip_type`,`user_port`,`l4_protocol`,`appserver_ip`,`appserver_ip_type`,`appserver_port`,`ulthroughput`,`dlthroughput`,`ulpackets`,`dlpackets`,`ultcp_disorder_packets`,`dltcp_disorder_packets`,`ultcp_retransfer_packets`,`dltcp_retransfer_packets`,`ultcp_response_time`,`dltcp_response_time`,`ultcp_flag_packets`,`dltcp_flag_packets`,`tcplink_response_time1`,`tcplink_response_time2`,`window_size`,`mss_size`,`tcplink_count`,`tcplink_state`,`finish`,`session_duration` FROM `dw`.`f_ms_s1u_general`";
				sql+=" where 2>1";
				if(startDate!=null){
					sql+=" and start_time="+startDate;
				}
				if(endDate!=null){
					sql+=" and end_time="+endDate;
				}
				if(xdrId!="" && xdrId!=null){
					sql+=" and xdr_id='"+xdrId+"'";
				}
				if(phone!="" && phone!=null){
					sql+=" and msisdn="+phone;
				}
				sql+=" limit 0,1";
			}else if(tabName.equals("http")){
				sql="  SELECT `xdr_id`,`imsi`,`msisdn`,`imei`,`imei_tac`,`tac`,`eci`,`sgw_ip`,`sgw_port`,`apn`,`start_time`,`end_time`,`time_hour`,`time_day`,`protocol`,`app_type`,`app_subtype`,`app_content`,`app_status`,`user_ip`,`user_ip_type`,`user_port`,`l4_protocol`,`appserver_ip`,`appserver_ip_type`,`appserver_port`,`ulthroughput`,`dlthroughput`,`ulpackets`,`dlpackets`,`ultcp_disorder_packets`,`dltcp_disorder_packets`,`ultcp_retransfer_packets`,`dltcp_retransfer_packets`,`ultcp_response_time`,`dltcp_response_time`,`ultcp_flag_packets`,`dltcp_flag_packets`,`tcplink_response_time1`,`tcplink_response_time2`,`window_size`,`mss_size`,`tcplink_count`,`tcplink_state`,`finish`,`http_version`,`trans_type`,`http_status_code`,`response_time`,`lastpacket_delay`,`lastpacket_ack_delay`,`host`,`uri1`,`x_online_host`,`useragent`,`content_type`,`refer_uri`,`cookie`,`content_length`,`target_behavior`,`wtp_suspend_type`,`wtp_suspend_cause`,`title`,`keyword`,`action`,`succ_flag`,`action_delay`,`browse_tool`,`portals`,`session_duration` FROM `dw`.`f_ms_s1u_http`";
				sql+=" where 2>1";
				if(startDate!=null){
					sql+=" and start_time="+startDate;
				}
				if(endDate!=null){
					sql+=" and end_time="+endDate;
				}
				if(xdrId!="" && xdrId!=null){
					sql+=" and xdr_id='"+xdrId+"'";
				}
				if(phone!="" && phone!=null){
					sql+=" and msisdn="+phone;
				}
				sql+=" limit 0,1";
			}else if(tabName.equals("dns")){
				sql="SELECT `xdr_id`,`imsi`,`msisdn`,`imei`,`imei_tac`,`tac`,`eci`,`sgw_ip`,`sgw_port`,`apn`,`start_time`,`end_time`,`time_hour`,`time_day`,`protocol`,`app_type`,`app_subtype`,`app_content`,`app_status`,`user_ip`,`user_ip_type`,`user_port`,`l4_protocol`,`appserver_ip`,`appserver_ip_type`,`appserver_port`,`ulthroughput`,`dlthroughput`,`ulpackets`,`dlpackets`,`ultcp_disorder_packets`,`dltcp_disorder_packets`,`ultcp_retransfer_packets`,`dltcp_retransfer_packets`,`ultcp_response_time`,`dltcp_response_time`,`ultcp_flag_packets`,`dltcp_flag_packets`,`tcplink_response_time1`,`tcplink_response_time2`,`window_size`,`mss_size`,`tcplink_count`,`tcplink_state`,`finish`,`domain`,`query_result_ip`,`dns_reply_code`,`dns_request_count`,`dns_response_count`,`dns_licensed_content`,`dns_add_content`,`session_duration` FROM `dw`.`f_ms_s1u_dns`";
				sql+=" where 2>1";
				if(startDate!=null){
					sql+=" and start_time="+startDate;
				}
				if(endDate!=null){
					sql+=" and end_time="+endDate;
				}
				if(xdrId!="" && xdrId!=null){
					sql+=" and xdr_id='"+xdrId+"'";
				}
				if(phone!="" && phone!=null){
					sql+=" and msisdn="+phone;
				}
				sql+=" limit 0,1";
			}else if(tabName.equals("im")){
				sql="SELECT `xdr_id`,`imsi`,`msisdn`,`imei`,`imei_tac`,`tac`,`eci`,`sgw_ip`,`sgw_port`,`apn`,`start_time`,`end_time`,`time_hour`,`time_day`,`protocol`,`app_type`,`app_subtype`,`app_content`,`app_status`,`user_ip`,`user_ip_type`,`user_port`,`l4_protocol`,`appserver_ip`,`appserver_ip_type`,`appserver_port`,`ulthroughput`,`dlthroughput`,`ulpackets`,`dlpackets`,`ultcp_disorder_packets`,`dltcp_disorder_packets`,`ultcp_retransfer_packets`,`dltcp_retransfer_packets`,`ultcp_response_time`,`dltcp_response_time`,`ultcp_flag_packets`,`dltcp_flag_packets`,`tcplink_response_time1`,`tcplink_response_time2`,`window_size`,`mss_size`,`tcplink_count`,`tcplink_state`,`finish`,`username`,`version`,`client_type`,`content_type`,`session_duration` FROM `dw`.`f_ms_s1u_im`";
				sql+=" where 2>1";
				if(startDate!=null){
					sql+=" and start_time="+startDate;
				}
				if(endDate!=null){
					sql+=" and end_time="+endDate;
				}
				if(xdrId!="" && xdrId!=null){
					sql+=" and xdr_id='"+xdrId+"'";
				}
				if(phone!="" && phone!=null){
					sql+=" and msisdn="+phone;
				}
				sql+=" limit 0,1";
			}else if(tabName.equals("mme")){
				sql="SELECT `xdr_id`,`imsi`,`msisdn`,`imei`,`imei_tac`,`tac`,`eci`,`other_tac`,`other_eci`,`apn`,`mme_ip`,`mme_port`,`start_time`,`end_time`,`time_hour`,`time_day`,`procedure_type`,`procedure_status`,`request_cause`,`failure_cause`,`eps_bearer_number`,`bearer_1_id`,`bearer_1_type`,`bearer_1_qci`,`bearer_1_status`,`bearer_1_request_cause`,`bearer_1_failure_cause`,`bearer_1_enb_gtp_teid`,`bearer_1_sgw_gtp_teid`,`bearer_2_id`,`bearer_2_type`,`bearer_2_qci`,`bearer_2_status`,`bearer_2_request_cause`,`bearer_2_failure_cause`,`bearer_2_enb_gtp_teid`,`bearer_2_sgw_gtp_teid`,`session_duration` FROM `dw`.`f_ms_s1mme`";
				sql+=" where 2>1";
				if(startDate!=null){
					sql+=" and start_time="+startDate;
				}
				if(endDate!=null){
					sql+=" and end_time="+endDate;
				}
				if(xdrId!="" && xdrId!=null){
					sql+=" and xdr_id='"+xdrId+"'";
				}
				if(phone!="" && phone!=null){
					sql+=" and msisdn="+phone;
				}
				sql+=" limit 0,1";
			}
			
			System.out.println(sql);
			resultSet= statement.executeQuery(sql);
			
			
		   String cols="";
		   JSONArray array = new JSONArray();  
		   ResultSetMetaData metaData = resultSet.getMetaData();  
		   int columnCount = metaData.getColumnCount();  
		   for (int i = 1; i <= columnCount; i++) {  
	            String columnName =metaData.getColumnLabel(i);  
	            if(!cols.equals("")){
	            	cols+=",";
	            }
	            cols+=columnName;
	        }  
		    while (resultSet.next()) {  
		        JSONObject jsonObj = new JSONObject();  
		        
		        for (int i = 1; i <= columnCount; i++) {  
		            String columnName =metaData.getColumnLabel(i);  
		            String value = resultSet.getString(columnName);  
		            jsonObj.put(columnName, value);  
		        }   
		        array.add(jsonObj);
		    }  
		    signallingDetail.setSql(sql);
		    signallingDetail.setCols(cols);
		    signallingDetail.setJsonArray(array);
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

		return signallingDetail;
	}

	
}

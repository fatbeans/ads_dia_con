package adapter.gbase.signalling;


<<<<<<< .mine

=======
import java.sql.Connection;
import java.sql.DatabaseMetaData;
>>>>>>> .r16833
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

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
			String sql=" SELECT `procedure_type_code`,`procedure_type`,`proto_type_code`,`proto_type`,`event_type_code`,`event_type`,`interface_id`,`interface_name` FROM `dw`.`ads_dia_pro_evnet_map`";
			resultSet= statement.executeQuery(sql);
			while (resultSet.next()){
				DictionaryEntity dictionary=new DictionaryEntity();
				dictionary.setKey(resultSet.getString("procedure_type_code"));
				dictionary.setName(resultSet.getString("procedure_type"));
				dictionary.setProp1key(resultSet.getString("proto_type_code"));
				dictionary.setProp1Name(resultSet.getString("proto_type"));
				dictionary.setProp2key(resultSet.getString("interface_id"));
				dictionary.setProp2Name(resultSet.getString("interface_name"));
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
			
			
			gnSql.append("SELECT 'gn' as tabname,gn.`start_time` as procedure_start_time ,gn.`end_time` as procedure_end_time,gn.`msisdn` as msisdn,gn.`imsi` as imsi,gn.`xdr_id` as xdr_id,'' as city,gn.`tac` as tac,gn.eci  as eci,'4G' as rat,'11' as interface,'800' as procedure_type,to_char(gn.`tcplink_response_time2`) as BUS_LANTENCY,gn.`user_ip` as USER_IPv4,gn.`appserver_ip` as APP_SERVER_IP_IPV4,to_char(gn.`app_status`) as Procedure_Status,'' as failure_cause,to_char(gn.`protocol`) as PROTOCOL_TYPE FROM dw.F_MS_S1U_GENERAL gn where 2>1");
			httpSql.append("SELECT 'http' as tabname,http.`start_time` as procedure_start_time ,http.`end_time` as procedure_end_time,http.`msisdn` as msisdn,http.`imsi` as imsi,http.`xdr_id` as xdr_id,'' as city,http.`tac` as tac,http.eci  as eci,'4G' as rat,'11' as interface,'500' as procedure_type,to_char(http.`action_delay`) as BUS_LANTENCY,http.`user_ip` as USER_IPv4,http.`appserver_ip` as APP_SERVER_IP_IPV4,to_char(http.`succ_flag`) as Procedure_Status,to_char(http.http_status_code) as failure_cause,to_char(http.`protocol`) as PROTOCOL_TYPE FROM dw.F_MS_S1U_HTTP http where 2>1");
			dnsSql.append("SELECT  'dns' as tabname,dns.`start_time` as procedure_start_time ,dns.`end_time` as procedure_end_time,dns.`msisdn` as msisdn,dns.`imsi` as imsi,dns.`xdr_id` as xdr_id,'' as city,dns.`tac` as tac,dns.eci  as eci,'4G' as rat,'11' as interface,'600' as procedure_type,to_char(dns.`tcplink_response_time2`) as BUS_LANTENCY,dns.`user_ip` as USER_IPv4,dns.`appserver_ip` as APP_SERVER_IP_IPV4,to_char(dns.`app_status`) as Procedure_Status,to_char(dns.dns_reply_code) as failure_cause,to_char(dns.`protocol`) as PROTOCOL_TYPE FROM dw.F_MS_S1U_DNS dns where 2>1");
			imSql.append("SELECT 'im' as tabname,im.`start_time` as procedure_start_time ,im.`end_time` as procedure_end_time,im.`msisdn` as msisdn,im.`imsi` as imsi,im.`xdr_id` as xdr_id,'' as city,im.`tac` as tac,im.eci  as eci,'4G' as rat,'11' as interface,'700' as procedure_type,to_char(im.`tcplink_response_time2`) as BUS_LANTENCY,im.`user_ip` as USER_IPv4,im.`appserver_ip` as APP_SERVER_IP_IPV4,to_char(im.`app_status`) as Procedure_Status,'' as failure_cause,to_char(im.`protocol`) as PROTOCOL_TYPE FROM dw.F_MS_S1U_IM im where 2>1");
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
				imSql.append(" and im.`app_status`="+failStatus);
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
			
			String gnTemp=gnSql.toString();
			String httpTemp=httpSql.toString();
			String dnsTemp=dnsSql.toString();
			String imtemp=imSql.toString();
			String mmeTemp=mmeSql.toString();
			
			gnSql=new StringBuilder();
			httpSql=new StringBuilder();
			dnsSql=new StringBuilder();
			imSql=new StringBuilder();
			mmeSql=new StringBuilder();
			
			List<String> dateList=getDateList(String.valueOf(startDate) ,String.valueOf(endDate));
			for(int i=0;i<dateList.size();i++){
				String itemGN= gnTemp.replace("dw.F_MS_S1U_GENERAL", "dw.F_MS_S1U_GENERAL_"+dateList.get(i));
				String itemHTTP=httpTemp.replace("dw.F_MS_S1U_HTTP", "dw.F_MS_S1U_HTTP_"+dateList.get(i));
				String itemDNS=dnsTemp.replace("dw.F_MS_S1U_DNS", "dw.F_MS_S1U_DNS_"+dateList.get(i));
				String itemIM=imtemp.replace("dw.F_MS_S1U_IM", "dw.F_MS_S1U_IM_"+dateList.get(i));
				String itemMME=mmeTemp.replace("`dw`.`F_MS_S1MME`", "dw.F_MS_S1MME_"+dateList.get(i));
				if(tableExist("F_MS_S1U_GENERAL_"+dateList.get(i))){
					if(!StringUtils.isBlank(gnSql.toString())){
						gnSql.append("UNION ALL ("+itemGN+")");
					}else{
						gnSql.append("("+itemGN+")");
					}
				}
				if(tableExist("F_MS_S1U_HTTP_"+dateList.get(i))){
					if(!StringUtils.isBlank(httpSql.toString())){
						httpSql.append("UNION ALL ("+itemHTTP+")");
					}else{
						httpSql.append("("+itemHTTP+")");
					}
				}
				if(tableExist("F_MS_S1U_DNS_"+dateList.get(i))){
					if(!StringUtils.isBlank(dnsSql.toString())){
						dnsSql.append("UNION ALL ("+itemDNS+")");
					}else{
						dnsSql.append("("+itemDNS+")");
					}
				}
				if(tableExist("F_MS_S1U_IM_"+dateList.get(i))){
					if(!StringUtils.isBlank(imSql.toString())){
						imSql.append("UNION ALL ("+itemIM+")");
					}else{
						imSql.append("("+itemIM+")");
					}
				}
				if(tableExist("F_MS_S1MME_"+dateList.get(i))){
					if(!StringUtils.isBlank(mmeSql.toString())){
						mmeSql.append("UNION ALL ("+itemMME+")");
					}else{
						mmeSql.append("("+itemMME+")");
					}
				}
			}

			StringBuilder sql=new StringBuilder();
			//sql.append("select *from(");
			if(!StringUtils.isBlank(interfaceType)){
				if(!StringUtils.isBlank(procedureType)){
					if(!StringUtils.isBlank(mmeSql.toString())){
						sql.append(""+ mmeSql+"");
					}
					if(procedureTypeExist(procedureType,"800") && !StringUtils.isBlank(gnSql.toString())){
						if(!StringUtils.isBlank(sql.toString())){
							sql.append(" UNION ALL ");
						}
						sql.append(gnSql);
					}
					if(procedureTypeExist(procedureType,"500") && !StringUtils.isBlank(httpSql.toString())){
						if(!StringUtils.isBlank(sql.toString())){
							sql.append(" UNION ALL ");
						}
						sql.append(httpSql);
					}
					if(procedureTypeExist(procedureType,"600")&& !StringUtils.isBlank(dnsSql.toString())){
						if(!StringUtils.isBlank(sql.toString())){
							sql.append(" UNION ALL ");
						}
						sql.append(dnsSql);
					}
					if(procedureTypeExist(procedureType,"700")&& !StringUtils.isBlank(imSql.toString())){
						if(!StringUtils.isBlank(sql.toString())){
							sql.append(" UNION ALL ");
						}
						sql.append(imSql);
					}
				}else{
					if(interfaceType.contains("5")){
						if(!StringUtils.isBlank(mmeSql.toString())){
							sql.append(""+ mmeSql+"");
						}
					}
					if(interfaceType.contains("5")&&interfaceType.contains("11")){
						if(!StringUtils.isBlank(gnSql.toString())){
							if(!StringUtils.isBlank(sql.toString())){
								sql.append(" UNION ALL ");
							}
							sql.append(gnSql);
						}
						if(!StringUtils.isBlank(httpSql.toString())){
							if(!StringUtils.isBlank(sql.toString())){
								sql.append(" UNION ALL ");
							}
							sql.append(httpSql);
						}
						if(!StringUtils.isBlank(dnsSql.toString())){
							if(!StringUtils.isBlank(sql.toString())){
								sql.append(" UNION ALL ");
							}
							sql.append(dnsSql);
						}
						if(!StringUtils.isBlank(dnsSql.toString())){
							if(!StringUtils.isBlank(sql.toString())){
								sql.append(" UNION ALL ");
							}
							sql.append(imSql);
						}
					}else if(interfaceType.equals("11")){
						if(!StringUtils.isBlank(gnSql.toString())){
							if(!StringUtils.isBlank(sql.toString())){
								sql.append(" UNION ALL ");
							}
							sql.append(gnSql);
						}
						if(!StringUtils.isBlank(httpSql.toString())){
							if(!StringUtils.isBlank(sql.toString())){
								sql.append(" UNION ALL ");
							}
							sql.append(httpSql);
						}
						if(!StringUtils.isBlank(dnsSql.toString())){
							if(!StringUtils.isBlank(sql.toString())){
								sql.append(" UNION ALL ");
							}
							sql.append(dnsSql);
						}
						if(!StringUtils.isBlank(imSql.toString())){
							if(!StringUtils.isBlank(sql.toString())){
								sql.append(" UNION ALL ");
							}
							sql.append(imSql);
						}
					}
				}
			}else{
				if(!StringUtils.isBlank(mmeSql.toString())){
					if(!StringUtils.isBlank(sql.toString())){
						sql.append(" UNION ALL ");
					}
					sql.append(""+ mmeSql+"");
				}
				if(!StringUtils.isBlank(gnSql.toString())){
					if(!StringUtils.isBlank(sql.toString())){
						sql.append(" UNION ALL ");
					}
					sql.append(""+gnSql+"");
				}
				if(!StringUtils.isBlank(httpSql.toString())){
					if(!StringUtils.isBlank(sql.toString())){
						sql.append(" UNION ALL ");
					}
					sql.append(httpSql);
				}
				if(!StringUtils.isBlank(dnsSql.toString())){
					if(!StringUtils.isBlank(sql.toString())){
						sql.append(" UNION ALL ");
					}
					sql.append(dnsSql);
				}
				if(!StringUtils.isBlank(imSql.toString())){
					if(!StringUtils.isBlank(sql.toString())){
						sql.append(" UNION ALL ");
					}
					sql.append(imSql);
				}
			}
			
			if(!StringUtils.isBlank(sql.toString())){
				sql.append(")t");
				sql.append(" limit "+(pageIndex*pageSize)+" ,"+(pageIndex*pageSize+pageSize+1));
				System.out.println("select *from(" + sql.toString());
				resultSet= statement.executeQuery("select *from(" + sql.toString());
				
				List<DictionaryEntity> statusList=getStatus();
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
					for(int i=0;i<statusList.size();i++){
						if(!StringUtils.isBlank(statusCode) && statusList.get(i).getKey().trim().equals(statusCode.trim())){
							stautsText=statusList.get(i).getName();
						}
					}
					if(StringUtils.isBlank(stautsText)){
						stautsText=statusCode;
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
							sigitem.setProtocolType(dictionaryint.getProp1Name());
							break;
						}
					}
				}
				signallngObj.setSql(sql.toString());
			}
			signallngObj.setSignallingList(signallingList);
		}catch(Exception ex){
			throw ex;
		}finally{
			if(statement!=null){
				statement.close();
			}
			if(resultSet!=null){
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

	/**
	 * 获取状态集合
	 * @author LeiYun
	 * 2015年9月24日
	 * @return
	 * @throws Exception
	 */
	private List<DictionaryEntity> getStatus() throws Exception{
		List<DictionaryEntity> dictionaryList=new ArrayList<DictionaryEntity>();
		Statement statement=null;
		ResultSet resultSet=null;
		try{
			
			statement= DbKit.getConfig("gbase").getConnection().createStatement();
			String sql="select status,status_code from ads_dia_http_status";
			resultSet= statement.executeQuery(sql);
			while (resultSet.next()){
				DictionaryEntity dictionary=new DictionaryEntity();
				dictionary.setKey(resultSet.getString("status"));
				dictionary.setName(resultSet.getString("status_code"));
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

	private Boolean procedureTypeExist(String procedureTypeArray,String val){
		Boolean result=false;
		if(!StringUtils.isBlank(procedureTypeArray) && !StringUtils.isBlank(val)){
			String[] dataArray = StringUtils.splitByWholeSeparatorPreserveAllTokens(procedureTypeArray, ",");
			for(int i=0;i<dataArray.length;i++){
				String[] dataItemArray = StringUtils.splitByWholeSeparatorPreserveAllTokens(dataArray[i], "-");
				if(dataItemArray.length==2){
					if(dataItemArray[1].trim().equals(val)){
						result=true;
						break;
					}
				}
			}
		}
		return result;
	}

	private List<String> getDateList(String startDate,String endDate) throws Exception{
		List<String> result=new ArrayList<String>();
		Date sDate=dateTime.converTo("yyyyMMddHHmmss", String.valueOf(startDate));
		Date eDate=dateTime.converTo("yyyyMMddHHmmss", String.valueOf(endDate));
		while(dateTime.converToLong("yyyyMMdd", sDate) <= dateTime.converToLong("yyyyMMdd", eDate)){
			String dateLab= String.valueOf(dateTime.converToLong("yyyyMMdd", eDate));
			result.add(dateLab);
			Calendar calendar=Calendar.getInstance();
			calendar.setTime(eDate);
			calendar.set(Calendar.DAY_OF_MONTH,calendar.get(Calendar.DAY_OF_MONTH)-1);
			calendar.set(Calendar.HOUR_OF_DAY,23);
			calendar.set(Calendar.MINUTE,59);
			calendar.set(Calendar.SECOND,59);
			calendar.set(Calendar.MILLISECOND,999);
			eDate=calendar.getTime();
		}
		return result;
	}

	private boolean tableExist(String tableName){
		boolean result=false;
		ResultSet resultSet=null;
		try{
			Connection conn=DbKit.getConfig("gbase").getConnection();
			DatabaseMetaData dma = conn.getMetaData();
			resultSet= dma.getTables(null, null, tableName.toUpperCase(), null);
			boolean more = resultSet.next();
			if(more){
				result=true;
			}
		}catch(Exception ex){
			
		}
		return result;

	}
}

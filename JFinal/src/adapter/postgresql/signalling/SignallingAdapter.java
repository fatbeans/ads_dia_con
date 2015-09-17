package adapter.postgresql.signalling;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.protobuf.ByteString.Output;
import com.jfinal.plugin.activerecord.DbKit;

import model.SignallingCommon;
import model.DictionaryEntity;
import model.SignallingDetailEntity;
import model.SignallngObjEntity;
import dataInterface.Isignalling;

public class SignallingAdapter implements Isignalling {

	/**
	 * 获取流程类型
	 */
	@Override
	public List<DictionaryEntity> getFlowType() throws Exception {
		// TODO Auto-generated method stub
		List<DictionaryEntity> dictionaryList=new ArrayList<DictionaryEntity>();
		Statement statement=null;
		ResultSet resultSet=null;
		try{
			
			statement= DbKit.getConfig("gp").getConnection().createStatement();
			String sql="select procedure_type_code,procedure_type from ads.ADS_DIA_PRO_EVNET_MAP";
			resultSet= statement.executeQuery(sql);
			while (resultSet.next()){
				DictionaryEntity dictionary=new DictionaryEntity();
				dictionary.setKey(resultSet.getString("procedure_type_code"));
				dictionary.setName(resultSet.getString("procedure_type"));
				dictionaryList.add(dictionary);
			}
		}catch(SQLException ex){
			throw ex;
		}finally{
			if(statement!=null){
				statement.close();
			}
			if(resultSet!=null){
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
			statement= DbKit.getConfig("gp").getConnection().createStatement();
			StringBuilder mmeSql=new StringBuilder();
			mmeSql.append("SELECT 'mme' as tabname,mme.procedure_starttime_ms, mme.procedure_endtime_ms,mme.msisdn,mme.imsi,mme.xdr_id,mme.city,mme.tac,mme.cell_id,mme.rat,mme.interface,map.procedure_type,'' AS bus_lantency, mme.user_ipv4,mme.mme_ip_add,mme.procedure_status::varchar(32),mme.failure_cause::varchar(32),map.proto_type  FROM ads.ads_4g_s1mme mme left join ads.ADS_DIA_PRO_EVNET_MAP map on mme.procedure_type=map.procedure_type_code  where 2>1");
			
			StringBuilder httpSql=new StringBuilder();
			httpSql.append("SELECT  'http' as tabname, http.procedure_starttime_ms,http.procedure_endtime_ms, http.msisdn,http.imsi,http.xdr_id,http.city,http.tac,http.cell_id,http.rat::varchar(32),http.interface,'HTTP' AS procedure_type,http.bus_lantency::varchar(32),http.user_ipv4,http.app_server_ip_ipv4,http.bus_ok,http.http_wap_status,http.l4_protocal::varchar(32)  FROM ads.ads_4g_gnhttp http where 2>1");
			
			mmeSql.append(" and mme.procedure_starttime>="+startDate);
			mmeSql.append(" and mme.procedure_endtime<="+endDate);
			httpSql.append(" and http.procedure_starttime>="+startDate);
			httpSql.append(" and http.procedure_endtime<="+endDate);
			
			if(!phone.equals("")){
				mmeSql.append(" and mme.msisdn="+phone);
				httpSql.append(" and http.msisdn="+phone);
			}
			if(!imsi.equals("")){
				mmeSql.append(" and mme.imsi="+imsi);
				httpSql.append(" and http.imsi="+imsi);
			}
			if(!failStatus.equals("-1")){
				mmeSql.append(" and mme.procedure_status="+failStatus);
				httpSql.append(" and http.bus_ok="+failStatus);
			}
			if(!interfaceType.equals("")){
				mmeSql.append(" and mme.interface in("+interfaceType+")");
				httpSql.append(" and http.interface in("+interfaceType+")");
			}
			if(!procedureType.equals("")){
				mmeSql.append(" and mme.procedure_type in("+procedureType+")");
			}
			
			mmeSql.append(" order by mme.procedure_starttime_ms desc ");
			httpSql.append(" order by http.procedure_endtime_ms desc ");
			
			
			StringBuilder sql=new StringBuilder();
			sql.append("select *from(");
			if(interfaceType.equals("") || interfaceType.contains("5")){
				sql.append("("+ mmeSql+")");
			}
			if(interfaceType.equals("") || (interfaceType.contains("5")&&interfaceType.contains("11"))){
				sql.append("UNION ALL");
			}
			if(interfaceType.equals("") || interfaceType.contains("11")){
				sql.append("("+httpSql+")");
			}
			sql.append(")t");
			sql.append(" limit "+pageSize+" offset "+(pageIndex*pageSize));
			System.out.println(sql.toString());
			resultSet= statement.executeQuery(sql.toString());
			while (resultSet.next()) {
				SignallingCommon signalling=new SignallingCommon();
				signalling.setTabname(resultSet.getString("tabname"));
				signalling.setProcedure_starttime_ms(resultSet.getString("procedure_starttime_ms"));
				signalling.setProcedure_endtime_ms(resultSet.getString("procedure_endtime_ms"));
				signalling.setOldStartDate(resultSet.getString("procedure_starttime_ms"));
				signalling.setOldEndDate(resultSet.getString("procedure_endtime_ms"));
				signalling.setMsisdn(resultSet.getString("msisdn"));
				signalling.setImsi(resultSet.getString("imsi"));
				signalling.setXdrId(resultSet.getString("xdr_id"));
				signalling.setCity(resultSet.getString("city"));
				signalling.setTac(resultSet.getString("tac"));
				signalling.setCellId(resultSet.getString("cell_id"));
				signalling.setRat(resultSet.getString("rat"));
				signalling.setInterfaceType(resultSet.getString("interface"));
				signalling.setProcedureType(resultSet.getString("procedure_type"));
				signalling.setProcedureStatusText(resultSet.getString("procedure_type"));
				signalling.setBusLantency(resultSet.getString("bus_lantency"));
				signalling.setUserIp4(resultSet.getString("user_ipv4"));
				signalling.setServerIp(resultSet.getString("mme_ip_add"));
				signalling.setProcedureStatus(resultSet.getString("procedure_status"));
				signalling.setFailureCause(resultSet.getString("failure_cause"));
				signalling.setProtocolType(resultSet.getString("proto_type"));
				signallingList.add(signalling);
			}
			signallngObj.setSql(sql.toString());
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
	public SignallingDetailEntity getSignallingDetail(String tabName,
			String startDate, String endDate, String phone, String xdrId,String rowKey)
			throws Exception {
		
		SignallingDetailEntity signallingDetail=new SignallingDetailEntity();
		Statement statement=null;
		ResultSet resultSet=null;
		try{
			statement=DbKit.getConfig("gp").getConnection().createStatement();
			String sql="";
			if(tabName.equals("http")){
				sql=" SELECT time_day,city,interface,xdr_id,rat,imsi,imei,msisdn,machine_ip_addtype,sgw_ggsn_ip_add,enb_sgsn_ip_add,sgw_ggsn_port,enb_sgsn_port,enb_sgsn_gtp_teid,sgw_ggsn_gtp_teid,tac,cell_id,apn,app_type_code,procedure_starttime,procedure_endtime,protocol_type,app_type,app_sub_type,app_content,app_status,user_ipv4,user_ipv6,user_port,l4_protocal,app_server_ip_ipv4,app_server_ip_ipv6,app_server_port,ul_data,dl_data,ul_ip_packet,dl_ip_packet,up_tcp_disorder_packet,down_tcp_disorder_packet,up_tcp_retran_packet,down_tcp_retran_packet,tcp_build_re_lantency,tcp_build_ack_lantency,ul_ip_frag_packets,dl_ip_frag_packets,tcp_build_first_lantency,tcp_fst_to_first_lantency,tcp_window_size,mss_size,tcp_rebuild,tcp_status,is_status,http_version,http_type,http_wap_status,req,http_first_re_time,http_last_packet_time,host,uri,x_online_host,user_agent,http_content_type,refer_uri,cookie,content_length,target_behav,wtp_interrupt_type,wtp_interrupt_cause,title,key_word,bus_behav,bus_ok,bus_lantency,tool,app_sum,procedure_starttime_ms,procedure_endtime_ms  FROM ads.ads_4g_gnhttp";
				sql+=" where 2>1";
				if(startDate!=null){
					sql+=" and procedure_starttime_ms="+startDate;
				}
				if(endDate!=null){
					sql+=" and procedure_endtime_ms="+endDate;
				}
				if(xdrId!="" && xdrId!=null){
					sql+=" and xdr_id='"+xdrId+"'";
				}
				if(phone!="" && phone!=null){
					sql+=" and msisdn="+phone;
				}
				sql+=" limit 1 offset 0";
				
			}else if(tabName.equals("mme")){
				sql="  SELECT time_day,city,interface,xdr_id,rat,imsi,imei,msisdn,procedure_type,procedure_starttime,procedure_endtime,procedure_status,request_cause,failure_cause,keyword_1,keyword_2,keyword_3,keyword_4,mme_ue_s1ap_id,old_mme_group_id,old_mme_code,old_m_tmsi,mme_group_id,mme_code,m_tmsi,tmsi,user_ipv4,user_ipv6,mme_ip_add,enb_ip_add,mme_port,enb_port,tac,cell_id,other_tac,other_eci,apn,eps_bearer_number,bearer_1_id,bearer_1_type,bearer_1_qci,bearer_1_status,bearer_1_request_cause,bearer_1_failure_cause,bearer_1_enb_gtp_teid,bearer_1_sgw_gtp_teid,bearer_2_id,bearer_2_type,bearer_2_qci,bearer_2_status,bearer_2_request_cause,bearer_2_failure_cause,bearer_2_enb_gtp_teid,bearer_2_sgw_gtp_teid,procedure_starttime_ms,procedure_endtime_ms  FROM ads.ads_4g_s1mme ";
				sql+=" where 2>1";
				if(startDate!=null){
					sql+=" and procedure_starttime_ms="+startDate;
				}
				if(endDate!=null){
					sql+=" and procedure_endtime_ms="+endDate;
				}
				if(xdrId!="" && xdrId!=null){
					sql+=" and xdr_id='"+xdrId+"'";
				}
				if(phone!="" && phone!=null){
					sql+=" and msisdn="+phone;
				}
				sql+=" limit 1 offset 0";
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
			if(resultSet!=null){
				resultSet.close();
			}
		}
		return signallingDetail;
	}
	

}

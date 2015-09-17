package model;

import org.apache.commons.lang.StringUtils;

import utility.dateTime;

import java.text.ParseException;
import java.util.Date;

public class SignallingCommon implements Comparable<SignallingCommon>{
	private String tabname,
	procedure_starttime_ms, 
	procedure_endtime_ms,
	msisdn,
	imsi,
	xdrId,
	city,
	tac,
	cellId,
	rat,
	interfaceType,
	procedureType,
	busLantency,
	userIp4,
	serverIp,
	procedureStatus,
	procedureStatusText,
	failureCause,
	protocolType;
	private String rowKey;
	
	public String getRowKey() {
		return rowKey;
	}

	public void setRowKey(String rowKey) {
		this.rowKey = rowKey;
	}

	public SignallingCommon() {
		
	}
	
	private String oldStartDate;
	private String oldEndDate;

	public String getOldStartDate() {
		return oldStartDate;
	}

	public void setOldStartDate(String oldStartDate) {
		this.oldStartDate = oldStartDate;
	}

	public String getOldEndDate() {
		return oldEndDate;
	}

	public void setOldEndDate(String oldEndDate) {
		this.oldEndDate = oldEndDate;
	}

	public String getProcedureStatusText() {
		return procedureStatusText;
	}

	public void setProcedureStatusText(String procedureStatusText) {
		this.procedureStatusText = procedureStatusText;
	}

	public String getTabname() {
		return tabname;
	}

	public void setTabname(String tabname) {
		this.tabname = tabname;
	}

	public String getProcedure_starttime_ms() {
		return procedure_starttime_ms;
	}

	public void setProcedure_starttime_ms(String procedure_starttime_ms) {
		this.procedure_starttime_ms = procedure_starttime_ms;
	}

	public String getProcedure_endtime_ms() {
		return procedure_endtime_ms;
	}

	public void setProcedure_endtime_ms(String procedure_endtime_ms) {
		this.procedure_endtime_ms = procedure_endtime_ms;
	}

	public String getMsisdn() {
		return msisdn;
	}

	public void setMsisdn(String msisdn) {
		this.msisdn = msisdn;
	}

	public String getImsi() {
		return imsi;
	}

	public void setImsi(String imsi) {
		this.imsi = imsi;
	}

	public String getXdrId() {
		return xdrId;
	}

	public void setXdrId(String xdrId) {
		this.xdrId = xdrId;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getTac() {
		return tac;
	}

	public void setTac(String tac) {
		this.tac = tac;
	}

	public String getCellId() {
		return cellId;
	}

	public void setCellId(String cellId) {
		this.cellId = cellId;
	}

	public String getRat() {
		return rat;
	}

	public void setRat(String rat) {
		this.rat = rat;
	}

	public String getInterfaceType() {
		return interfaceType;
	}

	public void setInterfaceType(String interfaceType) {
		this.interfaceType = interfaceType;
	}

	public String getProcedureType() {
		return procedureType;
	}

	public void setProcedureType(String procedureType) {
		this.procedureType = procedureType;
	}

	public String getBusLantency() {
		return busLantency;
	}

	public void setBusLantency(String busLantency) {
		this.busLantency = busLantency;
	}

	public String getUserIp4() {
		return userIp4;
	}

	public void setUserIp4(String userIp4) {
		this.userIp4 = userIp4;
	}

	public String getServerIp() {
		return serverIp;
	}

	public void setServerIp(String serverIp) {
		this.serverIp = serverIp;
	}

	public String getProcedureStatus() {
		return procedureStatus;
	}

	public void setProcedureStatus(String procedureStatus) {
		this.procedureStatus = procedureStatus;
	}

	public String getFailureCause() {
		return failureCause;
	}

	public void setFailureCause(String failureCause) {
		this.failureCause = failureCause;
	}

	public String getProtocolType() {
		return protocolType;
	}

	public void setProtocolType(String protocolType) {
		this.protocolType = protocolType;
	}

	@Override
	public int compareTo(SignallingCommon o) {
		int rst=0;
		if(this.getProcedure_starttime_ms()!=null && o.getProcedure_starttime_ms()!=null){
			long result= Long.parseLong(this.getProcedure_starttime_ms())-Long.parseLong(o.getProcedure_starttime_ms());
			rst=Integer.parseInt(String.valueOf(result));
		}
		return rst;
	}
}

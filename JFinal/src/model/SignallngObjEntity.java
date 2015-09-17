package model;

import java.util.List;

public class SignallngObjEntity {
	
	private String sql;
	
	private List<SignallingCommon> signallingList;
	
	
	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public List<SignallingCommon> getSignallingList() {
		return signallingList;
	}

	public void setSignallingList(List<SignallingCommon> signallingList) {
		this.signallingList = signallingList;
	}
}

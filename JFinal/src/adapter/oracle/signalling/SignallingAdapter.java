package adapter.oracle.signalling;

import java.util.List;

import model.DictionaryEntity;
import model.SignallingCommon;
import model.SignallingDetailEntity;
import model.SignallngObjEntity;
import dataInterface.Isignalling;

public class SignallingAdapter implements Isignalling {

	@Override
	public List<DictionaryEntity> getFlowType() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public SignallngObjEntity getSignallingList(int pageSize,
			int pageIndex, long startDate, long endDate, String phone,
			String imsi, String failStatus, String interfaceType,
			String procedureType,String pageDate) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public SignallingDetailEntity getSignallingDetail(String tabName,
			String startDate, String endDate, String phone, String xdrId,String rowKey)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	

}

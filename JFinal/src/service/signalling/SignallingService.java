package service.signalling;

import java.util.List;

import model.DictionaryEntity;
import model.SignallingCommon;
import model.SignallingDetailEntity;
import model.SignallngObjEntity;
import dataInterface.DataFactory;
import dataInterface.Isignalling;

public class SignallingService {

	public List<DictionaryEntity> getFlowType() throws Exception{
		Isignalling signalling=DataFactory.getInstance(Isignalling.class);
		return signalling.getFlowType();
	}
	
	public SignallngObjEntity getSignallingList(int pageSize,int pageIndex,long startDate,long endDate,
			String phone,String imsi,String failStatus,String interfaceType,String procedureType,String pageDate) throws Exception {
		
		Isignalling signalling=DataFactory.getInstance(Isignalling.class);
		if(signalling==null){
			System.out.println("Isignalling未找到适配器");
		}
		return signalling.getSignallingList(pageSize, pageIndex, startDate, endDate, phone, imsi, failStatus, interfaceType, procedureType,pageDate);
		
	}
	
	public SignallingDetailEntity getSignallingDetail(String tabName,String startDate,String endDate,String phone,String xdrId,String rowKey) throws Exception{
		Isignalling signalling=DataFactory.getInstance(Isignalling.class);
		if(signalling==null){
			System.out.println("Isignalling未找到适配器");
		}
		return signalling.getSignallingDetail(tabName, startDate, endDate, phone, xdrId,rowKey);
	}
}

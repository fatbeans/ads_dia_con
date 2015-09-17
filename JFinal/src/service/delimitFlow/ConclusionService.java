package service.delimitFlow;

import java.util.List;

import dataInterface.DataFactory;
import dataInterface.Iconclusion;
import model.CommonJsonEntity;
import model.ConclusionEntity;

public class ConclusionService {

	/**
	 * 获取定界流程结论
	 * @author LeiYun
	 * 2015年9月1日
	 * @param sessionId
	 * @param conId
	 * @return
	 * @throws Exception
	 */
	public List<ConclusionEntity> getConclusion(String sessionId,String conId) throws Exception{
		Iconclusion conclusion=DataFactory.getInstance(Iconclusion.class);
		if(conclusion==null){
			System.out.println("Iconclusion未找到适配器");
		}
		return conclusion.getConclusion(sessionId, conId);
	}
	
	public CommonJsonEntity getConclusionDetail(String sessionId,String lv1Id, String cid,String condition,int pageSize,int pageIndex) throws Exception{
		Iconclusion conclusion=DataFactory.getInstance(Iconclusion.class);
		if(conclusion==null){
			System.out.println("Iconclusion未找到适配器");
		}
		return conclusion.getConclusionDetail(sessionId, lv1Id,cid, condition,pageSize,pageIndex);
	}
}

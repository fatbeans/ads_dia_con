package dataInterface;

import java.util.List;

import model.CommonJsonEntity;
import model.ConclusionEntity;

public interface Iconclusion {
	
	/**
	 * 获取定界流程结论
	 * @author LeiYun
	 * 2015年9月1日
	 * @param sessionId
	 * @param conId
	 * @return
	 * @throws Exception
	 */
	List<ConclusionEntity> getConclusion(String sessionId,String conId)throws Exception;
	
	/**
	 * 获取明细
	 * @author LeiYun
	 * 2015年9月1日
	 * @param sessionId
	 * @param cid
	 * @param condition
	 * @return
	 * @throws Exception
	 */
	CommonJsonEntity getConclusionDetail(String sessionId,String lv1Id, String cid,String condition,int pageSize,int pageIndex)throws Exception;;
}

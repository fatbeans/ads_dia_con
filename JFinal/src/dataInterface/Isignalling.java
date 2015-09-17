/**
 * 
 */
package dataInterface;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import model.SignallingCommon;
import model.DictionaryEntity;
import model.SignallingDetailEntity;
import model.SignallngObjEntity;

/**
 * @author LeiYun
 * 2015年8月20日
 */
public interface Isignalling {
	
	/**
	 * 获取流程类型
	 * @author LeiYun
	 * 2015年8月25日
	 * @return
	 */
	List<DictionaryEntity> getFlowType() throws Exception;
	
	/**
	 * 获取信令
	 * @author LeiYun
	 * 2015年8月25日
	 * @param pageSize
	 * @param pageIndex
	 * @param startDate
	 * @param endDate
	 * @param phone
	 * @param imsi
	 * @param failStatus
	 * @param interfaceType
	 * @param procedureType
	 * @return
	 * @throws SQLException
	 */
	SignallngObjEntity getSignallingList(int pageSize,int pageIndex,long startDate,long endDate,
			String phone,String imsi,String failStatus,String interfaceType,String procedureType,String pageDate)throws Exception;
	
	/**
	 * 
	 * @author LeiYun
	 * 2015年9月15日
	 * @param tabName
	 * @param startDate
	 * @param endDate
	 * @param phone
	 * @param xdrId
	 * @return
	 * @throws Exception
	 */
	SignallingDetailEntity getSignallingDetail(String tabName,String startDate,String endDate,String phone,String xdrId,String rowKey)throws Exception;
}

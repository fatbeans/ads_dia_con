package adapter.oracle.delimitFlow;

import java.io.File;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.DbKit;

import model.CommonJsonEntity;
import model.CommonTable;
import model.CommonTables;
import model.ConclusionEntity;
import dataInterface.DataFactory;
import dataInterface.Iconclusion;

public class conclusionAdapter implements Iconclusion {

	@Override
	public List<ConclusionEntity> getConclusion(String sessionId, String conId)
			throws Exception {

		List<ConclusionEntity> conclusionList = new ArrayList<ConclusionEntity>();
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			statement = DbKit.getConfig("orcl").getConnection()
					.createStatement();
			String sql = "select SESSION_ID,DAY_KEY,LV1_CON_ID,LV1_CON_NAME,LV2_CON_ID,LV2_CON_NAME,CON_NUM from ADS_DIA_CON where 2>1";
			if (sessionId != null && !sessionId.equals("")) {
				sql += " and SESSION_ID=" + sessionId;
			}
			if (conId != null && !conId.equals("")) {
				sql += " and LV1_CON_ID=" + conId;
			}
			System.out.println(sql);
			resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				ConclusionEntity itemData = new ConclusionEntity();
				itemData.setSessionId(resultSet.getString("SESSION_ID"));
				itemData.setLv1ConId(resultSet.getString("LV1_CON_ID"));
				itemData.setLv1ConName(resultSet.getString("LV1_CON_NAME"));
				itemData.setLv2ConId(resultSet.getString("LV2_CON_ID"));
				itemData.setLv2ConName(resultSet.getString("LV2_CON_NAME"));
				itemData.setConNum(resultSet.getString("CON_NUM"));
				conclusionList.add(itemData);
			}
		} catch (Exception ex) {
			throw ex;
		} finally {
			if (statement != null) {
				statement.close();
			}
			if (resultSet != null) {
				resultSet.close();
			}
		}

		return conclusionList;
	}

	@Override
	public CommonJsonEntity getConclusionDetail(String sessionId, String lv1Id,
			String cid, String condition, int pageSize, int pageIndex)
			throws Exception {

		CommonJsonEntity commonJson = new CommonJsonEntity();

		Statement statement = null;
		ResultSet resultSet = null;
		try {
			CommonTable clConfig = null;
			try{
				clConfig =getConclusionConfig(cid);
				if (clConfig == null) {
					System.out.println("未找到配置表.");
					throw new Exception("未找到配置表.");
				}
			}catch(Exception ex){
				System.out.println("读取配置表异常.");
			}
			
			statement = DbKit.getConfig("orcl").getConnection()
					.createStatement();
			String sql = "select  rownum as rn," + clConfig.getFields()+ " from " + clConfig.getName() + " where 2>1";
			String totalSql = "select count(*)  as totalNum from "+ clConfig.getName() + " where 2>1";
			if (clConfig.getCondition() != null && !clConfig.getCondition().equals("")) {
				sql += " and " + clConfig.getCondition();
				totalSql += " and " + clConfig.getCondition();
			}
			sql+=" and SESSION_ID="+sessionId;
			totalSql+=" and SESSION_ID="+sessionId;
			sql = "select *from (" + sql + ") where rn>"+ (pageSize * pageIndex) + " and rn<="+ (pageSize * pageIndex + 10);

			System.out.println(sql);
			System.out.println(totalSql);
			resultSet = statement.executeQuery(sql);

			JSONArray array = new JSONArray();
			ResultSetMetaData metaData = resultSet.getMetaData();
			int columnCount = metaData.getColumnCount();
			while (resultSet.next()) {
				JSONObject jsonObj = new JSONObject();

				for (int i = 1; i <= columnCount; i++) {
					String columnName = metaData.getColumnLabel(i);
					String value = resultSet.getString(columnName);
					jsonObj.put(columnName, value);
				}
				array.add(jsonObj);
			}
			commonJson.setCols(clConfig.getFields());
			commonJson.setColsCN(clConfig.getFieldsCN());
			commonJson.setJsonArray(array);
			// 总条数
			System.out.println(sql);
			resultSet = statement.executeQuery(totalSql);
			if (resultSet.next()) {
				commonJson.setTotalNum(resultSet.getLong("totalNum"));
			}

		} catch (Exception ex) {
			throw ex;
		} finally {
			if (statement != null) {
				statement.close();
			}
			if (resultSet != null) {
				resultSet.close();
			}
		}

		return commonJson;
	}

	private CommonTable getConclusionConfig(String cid) throws Exception {

		CommonTable commonTable = null;
		String filePath = DataFactory.class.getClassLoader().getResource("/config/conclusionDetail.xml").getFile();
		System.out.println(filePath);
		JAXBContext cxt = JAXBContext.newInstance(model.CommonTables.class);
		Unmarshaller unmarshaller = cxt.createUnmarshaller();
		@SuppressWarnings("unchecked")
		CommonTables tables = (CommonTables) unmarshaller.unmarshal(new File(filePath));
		List<CommonTable> tableList = tables.getTables();
		for (CommonTable ct : tableList) {
			if (ct.getId().equals(cid)) {
				commonTable = ct;
				break;
			}
		}

		return commonTable;
	}

}

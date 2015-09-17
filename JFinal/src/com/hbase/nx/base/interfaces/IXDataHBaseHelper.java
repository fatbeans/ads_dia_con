package com.hbase.nx.base.interfaces;

import java.util.List;
import java.util.Map;

public interface IXDataHBaseHelper {
	/**
	 * check the table existence
	 * @param tableName
	 * @return
	 */
	public boolean tableExists(String tableName);
	/**
	 * construct the hex splits
	 * @param startKey
	 * @param endKey
	 * @param numRegions
	 * @return
	 */
	public byte[][] getHexSplits(String startKey, String endKey, int numRegions);
	/**
	 * create table
	 * @param tableName
	 * @param ifSnappy
	 * @param colfams
	 */
	public void createTable(String tableName, boolean ifSnappy, String... colfams);
	/**
	 * create table with startKey,endKey,numRegions
	 * @param tableName
	 * @param startKey
	 * @param endKey
	 * @param numRegions
	 * @param ifSnappy
	 * @param colfams
	 */
	public void createTable(String tableName, String startKey, String endKey, int numRegions, boolean ifSnappy,
							String... colfams);
	/**
	 * create table with splitKeys
	 * @param tableName
	 * @param splitKeys
	 * @param ifSnappy
	 * @param colfams
	 */
	public void createTable(String tableName, byte[][] splitKeys, boolean ifSnappy, String... colfams);
	
	
	/**
	 * disable table
	 * @param tableName
	 */
	public void disableTable(String tableName);
	/**
	 * drop table, disable table first
	 * @param tableName
	 */
	public void dropTable(String tableName);
	
	
	/**
	 * generalize data between startRow and endRow with no padding
	 * @param tableName
	 * @param startRow
	 * @param endRow
	 * @param numCols
	 * @param colfams
	 */
	public void generalizeTableData(String tableName, int startRow, int endRow, int numCols,
									String... colfams);
	/**
	 * generalize data between startRow and endRow with no padding but setTimestamp
	 * @param tableName
	 * @param startRow
	 * @param endRow
	 * @param numCols
	 * @param setTimestamp
	 * @param colfams
	 */
	public void generalizeTableData(String tableName, int startRow, int endRow, int numCols,
									boolean setTimestamp, String... colfams);
	/**
	 * generalize data between startRow and endRow with padding and setTimestamp
	 * @param tableName
	 * @param startRow
	 * @param endRow
	 * @param numCols
	 * @param padBits
	 * @param setTimestamp
	 * @param colfams
	 */
	public void generalizeTableData(String tableName, int startRow, int endRow, int numCols,
									int padBits, boolean setTimestamp, String... colfams);
	/**
	 * generalize data between startRow and endRow with padding and setTimestamp and random
	 * @param tableName
	 * @param startRow
	 * @param endRow
	 * @param numCols
	 * @param padBits
	 * @param setTimestamp
	 * @param random
	 * @param colfams
	 */
	public void generalizeTableData(String tableName, int startRow, int endRow, int numCols,
									int padBits, boolean setTimestamp, boolean random, String... colfams);
	
	
	/**
	 * put single row
	 * @param tableName
	 * @param rowKey
	 * @param family
	 * @param qualifier
	 * @param value
	 */
	public void put(String tableName, String rowKey, String family, String qualifier, String value);
	/**
	 * put single row with timestamp
	 * @param tableName
	 * @param rowKey
	 * @param family
	 * @param qualifier
	 * @param timestamp
	 * @param value
	 */
	public void put(String tableName, String rowKey, String family, String qualifier, long timestamp, String value);
	/**
	 * put multiple rows with one family
	 * @param tableName
	 * @param rowKeys
	 * @param family
	 * @param qualifiers
	 * @param values
	 */
	public void put(String tableName, List<String> rowKeys, String family, List<String> qualifiers, List<String> values);
	/**
	 * put multiple rows with one family and timestamps
	 * @param tableName
	 * @param rowKeys
	 * @param family
	 * @param qualifiers
	 * @param timestamps
	 * @param values
	 */
	public void put(String tableName, List<String> rowKeys, String family, List<String> qualifiers, long[]
			timestamps, List<String> values);
	/**
	 * put multiple rows with multiple families and timestamps
	 * @param tableName
	 * @param rowKeys
	 * @param families
	 * @param qualifiers
	 * @param timestamps
	 * @param values
	 */
	public void put(String tableName, List<String> rowKeys, List<String> families, List<String> qualifiers, long[]
			timestamps, List<String> values);
	/**
	 * increment the column counter based on single rowkey
	 * @param tableName
	 * @param rowKey
	 * @param family
	 * @param qualifier
	 * @param amount
	 */
	public long increment(String tableName, String rowKey, String family, String qualifier, int amount);
	/**
	 * increment the column counter based on rowkeys
	 * @param tableName
	 * @param rowKeys
	 * @param family
	 * @param qualifier
	 * @param amount
	 * @return
	 */
	public void increment(String tableName, List<String> rowKeys, String family, String qualifier, int amount);
	
	/**
	 * if the row exists
	 * @param tableName
	 * @param rowKey
	 * @return
	 */
	public boolean rowExists(String tableName, String rowKey);
	/**
	 * get single row
	 * @param tableName
	 * @param rowKey
	 * @param returnColumns conform to format: [[family,column1],[family,column2],,,], 
	 *                      if null return all columns
	 * @return
	 */
	public Map<String, String> get(String tableName, String rowKey, List<String> returnColumns);
	/**
	 * get list of rows with one rpc
	 * @param tableName
	 * @param rowKeys rowKeys.size() should not be too large, need not to be paginated 
	 * @param returnColumns conform to format: [[family,column1],[family,column2],,,], 
	 *                      if null return all columns
	 * @return
	 */
	public List<Map<String, String>> get(String tableName, List<String> rowKeys, List<String> returnColumns);
	/**
	 * get multiple rows between startRow and endRow
	 * @param tableName
	 * @param startRow
	 * @param endRow
	 * @param returnColumns conform to format: [[family,column1],[family,column2],,,], 
	 *                      if null return all columns
	 * @return
	 */
	public List<Map<String, String>> get(String tableName, String startRow, String endRow, List<String> returnColumns);
	/**
	 * get multiple rows between startRow and endRow and filterd by column conditions
	 * @param tableName
	 * @param startRow
	 * @param endRow
	 * @param columnConditionList conform to format: [[family,column1,value1],[family,column2,value2],,,]
	 *                                               when the value ends with L, means that the value type is long like column counter
	 * @param returnColumns conform to format: [[family,column1],[family,column2],,,], 
	 *                      if null return all columns
	 * @return
	 */
	public List<Map<String, String>> get(String tableName, String startRow, String endRow, List<String>
			columnConditions, List<String> returnColumns);
	/**
	 * get pagination rows based on lastRow
	 * @param tableName
	 * @param startRow can be null
	 * @param endRow can be null
	 * @param lastRow at the first time lastRow would be null
	 * @param pageSize
	 * @param returnColumns conform to format: [[family,column1],[family,column2],,,], 
	 *                      if null return all columns
	 * @return
	 */
	public List<Map<String, String>> get(String tableName, String startRow, String endRow, String lastRow, int pageSize, List<String> returnColumns);
	/**
	 * get pagination rows based on lastRow and filterd by column conditions
	 * @param tableName
	 * @param startRow can be null
	 * @param endRow can be null
	 * @param lastRow
	 * @param pageSize at the first time lastRow would be null
	 * @param columnConditionList conform to format: [[family,column1,value1],[family,column2,value2],,,]
	 *                                               when the value ends with L, means that the value type is long like column counter
	 * @param returnColumns conform to format: [[family,column1],[family,column2],,,], 
	 *                      if null return all columns
	 * @return
	 */
	public List<Map<String, String>> get(String tableName, String startRow, String endRow, String lastRow, int
			pageSize, List<String> columnConditions, List<String> returnColumns);
	
	/**
	 * get pagination rows based on lastRow and filterd by column conditions
	 * @param tableName
	 * @param startRow can be null
	 * @param endRow can be null
	 * @param lastRow
	 * @param pageSize at the first time lastRow would be null
	 * @param columnConditionList conform to format: [[family,column1,value1],[family,column2,value2],,,]
	 *                                               when the value ends with L, means that the value type is long like column counter
	 * @param returnColumns conform to format: [[family,column1],[family,column2],,,], 
	 *                      if null return all columns
	 * @param rowkeyStructure
	 * @author LVDAPENG
	 * @return
	 */
	public List<Map<String, String>> get(String tableName, String startRow, String endRow, String lastRow, int
			pageSize, List<String> columnConditions, List<String> returnColumns, String rowkeyStructure);
	
	/**
	 * get Aggregation rows based on lastRow and filterd by column conditions
	 * @param tableName
	 * @param startRow
	 * @param endRow
	 * @param lastRow
	 * @param pageSize
	 * @param columnConditions
	 * @param returnColumns
	 * @param rowkeyStructure
	 * @author LVDAPENG
	 * @return
	 */
	public List<Map<String, Object>> get(String tableName, String startRow, String endRow, String lastRow, int
			pageSize, List<String> columnConditions, List<String> returnColumns, List<String> aggreColumns, String rowkeyStructure);
	
	/**
	 * get total number of rows
	 * @param tableName
	 * @param familyName
	 * @param startRow
	 * @param endRow
	 * @return
	 */
	public long getTotal(String tableName, String familyName, String startRow, String endRow) throws Throwable;
	/**
	 * get original row keys from the corresponding ESI table
	 * ESI table name format: esi_tableName
	 * @param tableName
	 * @param esiTempTableName put this table name from server to client, so it will be null at the first time, not null at later
	 * @param isFirstTime
	 * @param lastRow
	 * @param pageSize
	 * @param columnConditions conform to format: [[family,column1,value1],[family,column2,value2],,,]
	 * @return
	 */
	public List<String> getOriginalRowKeys(String tableName, String esiTempTableName, boolean isFirstTime, String
			lastRow, int pageSize, List<String> columnConditions);
	/**
	 * get rows by extended secondary index table
	 * ESI table name format: esi_tableName
	 * @param tableName 
	 * @param esiTempTableName put this table name from server to client, so it will be null at the first time, not null at later
	 * @param lastRow
	 * @param pageSize
	 * @param columnConditions conform to format: [[family,column1,value1],[family,column2,value2],,,]
	 * @param returnColumns conform to format: [[family,column1],[family,column2],,,], 
	 *                      if null return all columns
	 * @return
	 */
	public List<Map<String, String>> getByESI(String tableName, String esiTempTableName, String lastRow, int pageSize,
											  List<String> columnConditions, List<String> returnColumns);

}

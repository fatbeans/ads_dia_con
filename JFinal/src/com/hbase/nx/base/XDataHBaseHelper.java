package com.hbase.nx.base;

import java.io.IOException;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.jfinal.kit.PropKit;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.*;
import org.apache.hadoop.hbase.client.Get;
import org.apache.hadoop.hbase.client.HBaseAdmin;
import org.apache.hadoop.hbase.client.HConnection;
import org.apache.hadoop.hbase.client.HConnectionManager;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.HTableInterface;
//import org.apache.hadoop.hbase.client.HTablePool;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
//import org.apache.hadoop.hbase.client.coprocessor.AggregationClient;
import org.apache.hadoop.hbase.client.coprocessor.AggregationClient;
import org.apache.hadoop.hbase.client.coprocessor.LongColumnInterpreter;
import org.apache.hadoop.hbase.filter.Filter;
import org.apache.hadoop.hbase.filter.FilterList;
import org.apache.hadoop.hbase.filter.PageFilter;
import org.apache.hadoop.hbase.filter.SingleColumnValueFilter;
import org.apache.hadoop.hbase.filter.SubstringComparator;
import org.apache.hadoop.hbase.filter.CompareFilter.CompareOp;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.log4j.Logger;

import com.hbase.nx.base.interfaces.IXDataHBaseHelper;

public class XDataHBaseHelper implements IXDataHBaseHelper {
    private static final Logger log = Logger.getLogger(XDataHBaseHelper.class);

    private Configuration conf = null;
    private HBaseAdmin admin = null;
    //	private HTablePool hTablePool = null;
    private HConnection hConnection = null;
    private volatile static XDataHBaseHelper hBaseHelper = null;

    private int scanCaching = 0;
    private String mapKeyOfRow = "";
    private int poolSizeForSingleTable = 0;
    private boolean scanCacheBlocks = false;

    private final byte[] postFix = new byte[]{0x00};

    public Configuration getConf() {
        return conf;
    }

    public void setConf(Configuration conf) {
        this.conf = conf;
    }

    public HBaseAdmin getAdmin() {
        return admin;
    }

    public void setAdmin(HBaseAdmin admin) {
        this.admin = admin;
    }

    public int getScanCaching() {
        return scanCaching;
    }

    public void setScanCaching(int scanCaching) {
        this.scanCaching = scanCaching;
    }

    public String getMapKeyOfRow() {
        return mapKeyOfRow;
    }

    public void setMapKeyOfRow(String mapKeyOfRow) {
        this.mapKeyOfRow = mapKeyOfRow;
    }

    public byte[] getPostFix() {
        return postFix;
    }

    //	public HTablePool getHTablePool() {
//		return hTablePool;
//	}
//	public void setHTablePool(HTablePool tablePool) {
//		hTablePool = tablePool;
//	}
    public int getPoolSizeForSingleTable() {
        return poolSizeForSingleTable;
    }

    public void setPoolSizeForSingleTable(int poolSizeForSingleTable) {
        this.poolSizeForSingleTable = poolSizeForSingleTable;
    }

    public boolean isScanCacheBlocks() {
        return scanCacheBlocks;
    }

    public void setScanCacheBlocks(boolean scanCacheBlocks) {
        this.scanCacheBlocks = scanCacheBlocks;
    }

    public HConnection getHConnection() {
        return hConnection;
    }

    public void setHConnection(HConnection hConnection) {
        this.hConnection = hConnection;
    }

    static Configuration cfg = null;

    static {
        Configuration HBASE_CONFIG = new Configuration();
        HBASE_CONFIG.set("hbase.zookeeper.quorum", PropKit.get("hbase.zookeeper.quorum", "XXX"));//10.18.12.13
        HBASE_CONFIG.set("hbase.zookeeper.property.clientPort", PropKit.get("hbase.zookeeper.property.clientPort",
                "-1"));


        cfg = HBaseConfiguration.create(HBASE_CONFIG);
        System.out.println("init|hbase.zookeeper.quorum=" + cfg.get("hbase.zookeeper.quorum"));
        System.out.println("init|hbase.zookeeper.println.clientPort =" + cfg.get("hbase.zookeeper.property" +
                ".clientPort"));

    }

    private XDataHBaseHelper() throws IOException {

        this.conf = cfg;///HBaseConfiguration.create();
        System.out.println("get|hbase.zookeeper.quorum=" + cfg.get("hbase.zookeeper.quorum"));
        System.out.println("get|hbase.zookeeper.println.clientPort =" + cfg.get("hbase.zookeeper.property" +
                ".clientPort"));
        this.admin = new HBaseAdmin(this.conf);
        System.out.println("admin|hbase.zookeeper.quorum=" + this.admin.getConfiguration().get("hbase.zookeeper" +
                ".quorum"));
        System.out.println("admin|hbase.zookeeper.println.clientPort =" + this.admin.getConfiguration().get("hbase" +
                ".zookeeper.property.clientPort"));
        this.scanCaching = 100;
        this.mapKeyOfRow = "rowkey";
        this.poolSizeForSingleTable = 10;
        this.scanCacheBlocks = false;

        this.hConnection = HConnectionManager.createConnection(this.conf);
        log.info("hTablePool has been successfully initialized with poolSizeForSingleTable " + poolSizeForSingleTable);


    }


    public static XDataHBaseHelper getHelper() throws IOException {
        if (hBaseHelper == null) {
            synchronized (XDataHBaseHelper.class) {
                if (hBaseHelper == null) {
                    return new XDataHBaseHelper();
                } else {
                    return hBaseHelper;
                }
            }
        } else {
            return hBaseHelper;
        }
    }

    public boolean contains(String[] stringArray, String source) {
        List<String> tempList = Arrays.asList(stringArray);
        if (tempList.contains(source)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * close the whole pool
     */

    public void close() {
        try {
            if (this.hConnection != null) {
                this.hConnection.close();
            }
            log.info("the whole Connection has been closed.");
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (this.hConnection != null) {
                    this.hConnection.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
    }

    /**
     * check the table existence
     *
     * @param tableName
     * @return
     */
    public boolean tableExists(String tableName) {

        try {
            return admin.tableExists(tableName);
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        return false;
    }

    /**
     * construct the hex splits
     *
     * @param startKey   16进制数字字符串
     * @param endKey     16进制数字字符串
     * @param numRegions
     * @return
     */
    public byte[][] getHexSplits(String startKey, String endKey, int numRegions) {

        byte[][] splits = new byte[numRegions - 1][];
        BigInteger lowestKey = new BigInteger(startKey, 16);
        BigInteger highestKey = new BigInteger(endKey, 16);

        BigInteger range = highestKey.subtract(lowestKey);
        BigInteger regionIncrement = range.divide(BigInteger.valueOf(numRegions));
        lowestKey = lowestKey.add(regionIncrement);

        for (int i = 0; i < numRegions - 1; i++) {
            BigInteger key = lowestKey.add(regionIncrement.multiply(BigInteger.valueOf(i)));
            byte[] b = String.format("%016x", key).getBytes();
            splits[i] = b;
        }
        return splits;
    }

    /**
     * create table
     *
     * @param tableName
     * @param ifSnappy
     * @param colfams
     */
    public void createTable(String tableName, boolean ifSnappy, String... colfams) {
        this.createTable(tableName, null, ifSnappy, colfams);
    }

    /**
     * create table with startKey,endKey,numRegions
     *
     * @param tableName
     * @param startKey
     * @param endKey
     * @param numRegions
     * @param ifSnappy
     * @param colfams
     */
    public void createTable(String tableName, String startKey, String endKey, int numRegions, boolean ifSnappy,
                            String... colfams) {
        this.createTable(tableName, this.getHexSplits(startKey, endKey, numRegions), ifSnappy, colfams);
    }

    /**
     * create table with splitKeys
     *
     * @param tableName
     * @param splitKeys
     * @param ifSnappy
     * @param colfams
     */
    @SuppressWarnings("deprecation")
    public void createTable(String tableName, byte[][] splitKeys, boolean ifSnappy, String... colfams) {

        try {
            if (!this.tableExists(tableName)) {

                HTableDescriptor desc = new HTableDescriptor(tableName);

                for (String cf : colfams) {
                    HColumnDescriptor coldef = new HColumnDescriptor(cf);
                    if (ifSnappy) {
//			    		coldef.setCompressionType(Compression.Algorithm.SNAPPY);
                    }
                    desc.addFamily(coldef);
                }

                if (splitKeys != null) {
                    admin.createTable(desc, splitKeys);
                } else {
                    admin.createTable(desc);
                }
            } else {
                log.error("HBase table " + tableName + " already exists.");
            }
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

    /**
     * disable table
     *
     * @param tableName
     */
    public void disableTable(String tableName) {
        try {
            admin.disableTable(tableName);
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

    /**
     * drop table, disable table first
     *
     * @param tableName
     */
    public void dropTable(String tableName) {

        try {
            if (this.tableExists(tableName)) {
                this.disableTable(tableName);
                admin.deleteTable(tableName);
            } else {
                log.error("HBase table " + tableName + " does not exist.");
            }
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

    /**
     * generalize data between startRow and endRow with no padding
     *
     * @param tableName
     * @param startRow
     * @param endRow
     * @param numCols
     * @param colfams
     */
    public void generalizeTableData(String tableName, int startRow, int endRow, int numCols, String... colfams) {
        generalizeTableData(tableName, startRow, endRow, numCols, -1, false, colfams);
    }

    /**
     * generalize data between startRow and endRow with no padding but setTimestamp
     *
     * @param tableName
     * @param startRow
     * @param endRow
     * @param numCols
     * @param setTimestamp
     * @param colfams
     */
    public void generalizeTableData(String tableName, int startRow, int endRow, int numCols,
                                    boolean setTimestamp, String... colfams) {
        generalizeTableData(tableName, startRow, endRow, numCols, -1, setTimestamp, colfams);
    }

    /**
     * generalize data between startRow and endRow with padding and setTimestamp
     *
     * @param tableName
     * @param startRow
     * @param endRow
     * @param numCols
     * @param padBits
     * @param setTimestamp
     * @param colfams
     */
    public void generalizeTableData(String tableName, int startRow, int endRow, int numCols,
                                    int padBits, boolean setTimestamp, String... colfams) {
        generalizeTableData(tableName, startRow, endRow, numCols, padBits, setTimestamp, false, colfams);
    }

    /**
     * generalize data between startRow and endRow with padding and setTimestamp and random
     *
     * @param tableName
     * @param startRow
     * @param endRow
     * @param numCols
     * @param padBits
     * @param setTimestamp
     * @param random
     * @param colfams
     */
    @SuppressWarnings("deprecation")
    public void generalizeTableData(String tableName, int startRow, int endRow, int numCols,
                                    int padBits, boolean setTimestamp, boolean random, String... colfams) {

        HTableInterface hTable = null;
        try {
            if (this.tableExists(tableName)) {
//				hTable = hTablePool.getTable(tableName);
                hTable = hConnection.getTable(tableName);
                hTable.setAutoFlush(false);
                Random rnd = new Random();

                for (int row = startRow; row <= endRow; row++) {
                    for (int col = 0; col < numCols; col++) {
                        String padRow = padNum(row, padBits);
                        String padCol = padNum(col, padBits);

                        Put put = new Put(Bytes.toBytes("row-" + padRow));
                        for (String cf : colfams) {
                            String colName = "col-" + padCol;
                            String val = "val-" + (random ? Integer.toString(rnd.nextInt(numCols)) : padRow + "." +
                                    padCol);

                            if (setTimestamp) {
                                put.add(Bytes.toBytes(cf), Bytes.toBytes(colName), col, Bytes.toBytes(val));
                            } else {
                                put.add(Bytes.toBytes(cf), Bytes.toBytes(colName), Bytes.toBytes(val));
                            }
                        } //for (String cf : colfams) {
                        hTable.put(put);

                    } //for (int col = 0; col < numCols; col++) {
                } //for (int row = startRow; row <= endRow; row++) {

                hTable.flushCommits();
                hTable.close();
            } else {
                log.error("HBase table " + tableName + " does not exist.");
            }
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
    }

    /**
     * pad "0" to the left
     *
     * @param num
     * @param padBits
     * @return
     */
    public String padNum(int num, int padBits) {

        String res = Integer.toString(num);
        if (padBits > 0) {
            while (res.length() < padBits) {
                res = "0" + res;
            }
        }
        return res;
    }

    /**
     * put single row
     *
     * @param tableName
     * @param rowKey
     * @param family
     * @param qualifier
     * @param value
     */
    public void put(String tableName, String rowKey, String family, String qualifier, String value) {
        this.put(tableName, rowKey, family, qualifier, -1L, value);
    }

    /**
     * put single row with timestamp
     *
     * @param tableName
     * @param rowKey
     * @param family
     * @param qualifier
     * @param timestamp
     * @param value
     */
    public void put(String tableName, String rowKey, String family, String qualifier, long timestamp, String value) {

        if (!this.tableExists(tableName)) {
            log.error("HBase table " + tableName + " does not exist.");
            return;
        }

        HTableInterface hTable = null;
        try {
//			hTable = hTablePool.getTable(tableName);
            hTable = hConnection.getTable(tableName);
            Put put = new Put(Bytes.toBytes(rowKey));
            if (timestamp > 0) {
                put.add(Bytes.toBytes(family), Bytes.toBytes(qualifier), timestamp, Bytes.toBytes(value));
            } else {
                put.add(Bytes.toBytes(family), Bytes.toBytes(qualifier), Bytes.toBytes(value));
            }
            hTable.put(put);

            hTable.close();
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
    }

    /**
     * put multiple rows with one family
     *
     * @param tableName
     * @param rowKeys
     * @param family
     * @param qualifiers
     * @param values
     */
    public void put(String tableName, List<String> rowKeys, String family, List<String> qualifiers, List<String>
            values) {
        List<String> families = new ArrayList<String>(1);
        families.add(family);

        this.put(tableName, rowKeys, families, qualifiers, null, values);
    }

    /**
     * put multiple rows with one family and timestamps
     *
     * @param tableName
     * @param rowKeys
     * @param family
     * @param qualifiers
     * @param timestamps
     * @param values
     */
    public void put(String tableName, List<String> rowKeys, String family, List<String> qualifiers, long[]
            timestamps, List<String> values) {
        List<String> families = new ArrayList<String>(1);
        families.add(family);

        this.put(tableName, rowKeys, families, qualifiers, timestamps, values);
    }

    /**
     * put multiple rows with multiple families and timestamps
     *
     * @param tableName
     * @param rowKeys
     * @param families
     * @param qualifiers
     * @param timestamps
     * @param values
     */
    @SuppressWarnings("deprecation")
    public void put(String tableName, List<String> rowKeys, List<String> families, List<String> qualifiers, long[]
            timestamps, List<String> values) {

        if (!this.tableExists(tableName)) {
            log.error("HBase table " + tableName + " does not exist.");
            return;
        }

        HTableInterface hTable = null;
        try {
//			hTable = hTablePool.getTable(tableName);
            hTable = hConnection.getTable(tableName);
            hTable.setAutoFlush(false);

            for (String row : rowKeys) {
                Put put = new Put(Bytes.toBytes(row));
                for (String fam : families) {
                    int v = 0;
                    for (String qual : qualifiers) {
                        String val = values.get(v < values.size() ? v : values.size() - 1);

                        if (timestamps != null && timestamps.length > 0) {
                            long t = timestamps[v < timestamps.length ? v : timestamps.length - 1];
                            put.add(Bytes.toBytes(fam), Bytes.toBytes(qual), t, Bytes.toBytes(val));
                        } else {
                            put.add(Bytes.toBytes(fam), Bytes.toBytes(qual), Bytes.toBytes(val));
                        }

                        v++;
                    } //for (String qual : qualifiers) {
                } //for (String fam : families) {
                hTable.put(put);
            } //for (String row : rowKeys) {

            hTable.flushCommits();
            hTable.close();
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
    }

    /**
     * increment the column counter based on single rowkey
     *
     * @param tableName
     * @param rowKey
     * @param family
     * @param qualifier
     * @param amount
     */
    public long increment(String tableName, String rowKey, String family, String qualifier, int amount) {

        if (!this.tableExists(tableName)) {
            log.error("HBase table " + tableName + " does not exist.");
            return -1L;
        }

        HTableInterface hTable = null;
        try {
//			hTable = hTablePool.getTable(tableName);
            hTable = hConnection.getTable(tableName);
            long incre = hTable.incrementColumnValue(
                    Bytes.toBytes(rowKey),
                    Bytes.toBytes(family),
                    Bytes.toBytes(qualifier),
                    amount
            );

            hTable.close();
            return incre;
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
        return -1L;
    }

    /**
     * increment the column counter based on rowkeys
     *
     * @param tableName
     * @param rowKeys
     * @param family
     * @param qualifier
     * @param amount
     * @return
     */
    @SuppressWarnings("deprecation")
    public void increment(String tableName, List<String> rowKeys, String family, String qualifier, int amount) {

        if (!this.tableExists(tableName)) {
            log.error("HBase table " + tableName + " does not exist.");
        }

        HTableInterface hTable = null;
        try {
//			hTable = hTablePool.getTable(tableName);
            hTable = hConnection.getTable(tableName);
            hTable.setAutoFlush(false);

            if (rowKeys != null && rowKeys.size() > 0) {
                for (String rowKey : rowKeys) {
                    hTable.incrementColumnValue(
                            Bytes.toBytes(rowKey),
                            Bytes.toBytes(family),
                            Bytes.toBytes(qualifier),
                            amount
                    );
                }
            }

            hTable.flushCommits();
            hTable.close();
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
    }

    /**
     * if the row exists
     *
     * @param tableName
     * @param rowKey
     * @return
     */
    public boolean rowExists(String tableName, String rowKey) {

        if (!this.tableExists(tableName)) {
            log.error("HBase table " + tableName + " does not exist.");
            return false;
        }

        HTableInterface hTable = null;
        try {
//			hTable = hTablePool.getTable(tableName);
            hTable = hConnection.getTable(tableName);
            Get get = new Get(Bytes.toBytes(rowKey));
            boolean exists = hTable.exists(get);

            hTable.close();
            return exists;
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
        return false;
    }

    /**
     * get single row
     *
     * @param tableName
     * @param rowKey
     * @param returnColumns conform to format: [[family,column1],[family,column2],,,],
     *                      if null return all columns
     * @return
     */
    @SuppressWarnings("deprecation")
    public Map<String, String> get(String tableName, String rowKey, List<String> returnColumns) {

        if (!this.tableExists(tableName)) {
            log.error("HBase table " + tableName + " does not exist.");
            return null;
        }

        HTableInterface hTable = null;
        try {
            Map<String, String> resultMap = new HashMap<String, String>();
//			hTable = hTablePool.getTable(tableName);
            hTable = hConnection.getTable(tableName);
            Get get = new Get(Bytes.toBytes(rowKey));
            if (returnColumns != null && returnColumns.size() > 0) {
                for (String col : returnColumns) {
                    String[] cola = col.split(",");
                    if (cola != null && cola.length == 2) {
                        get.addColumn(Bytes.toBytes(cola[0]), Bytes.toBytes(cola[1]));
                    }
                }
            }
            Result result = hTable.get(get);

            for (KeyValue kv : result.raw()) {
                resultMap.put(Bytes.toString(kv.getQualifier()), new String(kv.getValue(), "UTF-8"));
            }

            hTable.close();
            return resultMap;
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
        return null;
    }

    /**
     * get list of rows with one rpc
     *
     * @param tableName
     * @param rowKeys       rowKeys.size() should not be too large, need not to be paginated
     * @param returnColumns conform to format: [[family,column1],[family,column2],,,],
     *                      if null return all columns
     * @return
     */
    @SuppressWarnings("deprecation")
    public List<Map<String, String>> get(String tableName, List<String> rowKeys, List<String> returnColumns) {

        if (!this.tableExists(tableName)) {
            log.error("HBase table " + tableName + " does not exist.");
            return null;
        }

        long utime = 0L;
        long eutime = 0L;
        long useTime = 0L;
        int count = 0;
        HTableInterface hTable = null;
        try {
            utime = System.currentTimeMillis();

            List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();
//			hTable = hTablePool.getTable(tableName);
            hTable = hConnection.getTable(tableName);
            List<Get> gets = new ArrayList<Get>();

            if (rowKeys != null && rowKeys.size() > 0) {
                for (String rowkey : rowKeys) {
                    Get get = new Get(Bytes.toBytes(rowkey));
                    if (returnColumns != null && returnColumns.size() > 0) {
                        for (String col : returnColumns) {
                            String[] cola = col.split(",");
                            if (cola != null && cola.length == 2) {
                                get.addColumn(Bytes.toBytes(cola[0]), Bytes.toBytes(cola[1]));
                            }
                        }
                    }
                    gets.add(get);
                }
            }

            Result[] results = hTable.get(gets);
            for (Result result : results) {
                count++;

                Map<String, String> resultMap = new HashMap<String, String>();
                resultMap.put("key", Bytes.toString(result.getRow()));
                for (KeyValue kv : result.raw()) {
                    resultMap.put(Bytes.toString(kv.getQualifier()), new String(kv.getValue(), "UTF-8"));
                }
                resultList.add(resultMap);
            }

            eutime = System.currentTimeMillis();
            useTime = eutime - utime;
            log.info("Fetching " + count + " rows during " + useTime + " milliseconds.");

            hTable.close();
            return resultList;
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
        return null;
    }

    /**
     * get multiple rows between startRow and endRow
     *
     * @param tableName
     * @param startRow
     * @param endRow
     * @param returnColumns conform to format: [[family,column1],[family,column2],,,],
     *                      if null return all columns
     * @return
     */
    @SuppressWarnings("deprecation")
    public List<Map<String, String>> get(String tableName, String startRow, String endRow, List<String> returnColumns) {

        if (!this.tableExists(tableName)) {
            log.error("HBase table " + tableName + " does not exist.");
            return null;
        }

        long utime = 0L;
        long eutime = 0L;
        long useTime = 0L;
        int count = 0;
        HTableInterface hTable = null;
        ResultScanner rs = null;
        List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();

        try {
            utime = System.currentTimeMillis();
//			hTable = hTablePool.getTable(tableName);
            hTable = hConnection.getTable(tableName);
            Scan scan = new Scan();
            if (startRow != null && !"".equals(startRow)) {
                scan.setStartRow(Bytes.toBytes(startRow));
            }
            if (endRow != null && !"".equals(endRow)) {
                scan.setStopRow(Bytes.toBytes(endRow));
            }

            scan.setCaching(this.getScanCaching());
            scan.setCacheBlocks(this.isScanCacheBlocks());

            if (returnColumns != null && returnColumns.size() > 0) {
                for (String col : returnColumns) {
                    String[] cola = col.split(",");
                    if (cola != null && cola.length == 2) {
                        scan.addColumn(Bytes.toBytes(cola[0]), Bytes.toBytes(cola[1]));
                    }
                }
            }

            rs = hTable.getScanner(scan);
            for (Result r : rs) {
                count++;
                Map<String, String> map = new HashMap<String, String>();
                map.put("key", Bytes.toString(r.getRow()));
                for (KeyValue kv : r.raw()) {
                    map.put(Bytes.toString(kv.getQualifier()), new String(kv.getValue(), "UTF-8"));
                }
                map.put(this.getMapKeyOfRow(), Bytes.toString(r.getRow()));

                resultList.add(map);
            }

            eutime = System.currentTimeMillis();
            useTime = eutime - utime;
            log.info("Fetching " + count + " rows during " + useTime + " milliseconds.");
            rs.close();
            hTable.close();
            return resultList;
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
        return null;
    }

    /**
     * get multiple rows between startRow and endRow and filterd by column conditions
     *
     * @param tableName
     * @param startRow
     * @param endRow
     * @param columnConditions conform to format: [[family,column1,value1],[family,column2,value2],,,]
     *                         when the value ends with L, means that the value type is long like column counter
     * @param returnColumns    conform to format: [[family,column1],[family,column2],,,],
     *                         if null return all columns
     * @return
     */
    @SuppressWarnings("deprecation")
    public List<Map<String, String>> get(String tableName, String startRow, String endRow, List<String>
            columnConditions, List<String> returnColumns) {

        if (!this.tableExists(tableName)) {
            log.error("HBase table " + tableName + " does not exist.");
            return null;
        }

        long utime = 0L;
        long eutime = 0L;
        long useTime = 0L;
        int count = 0;
        HTableInterface hTable = null;
        ResultScanner rs = null;
        List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();

        try {
            utime = System.currentTimeMillis();
//			hTable = hTablePool.getTable(tableName);
            hTable = hConnection.getTable(tableName);
            Scan scan = new Scan();
            if (startRow != null && !"".equals(startRow)) {
                scan.setStartRow(Bytes.toBytes(startRow));
            }
            if (endRow != null && !"".equals(endRow)) {
                scan.setStopRow(Bytes.toBytes(endRow));
            }

            scan.setCaching(this.getScanCaching());
            scan.setCacheBlocks(this.isScanCacheBlocks());

            if (returnColumns != null && returnColumns.size() > 0) {
                for (String col : returnColumns) {
                    String[] cola = col.split(",");
                    if (cola != null && cola.length == 2) {
                        scan.addColumn(Bytes.toBytes(cola[0]), Bytes.toBytes(cola[1]));
                    }
                }
            }

            FilterList flist = new FilterList();
            if (columnConditions != null && columnConditions.size() > 0) {
                for (String condition : columnConditions) {
                    String[] fcv = condition.split(",");
                    if (fcv != null && fcv.length == 3) {
                        if (fcv[2] != null && !"".equals(fcv[2]) && fcv[2].endsWith("L")) {
                            SingleColumnValueFilter filter = new SingleColumnValueFilter(Bytes.toBytes(fcv[0]),
                                    Bytes.toBytes(fcv[1]), CompareOp.EQUAL, Bytes.toBytes(Long.parseLong(fcv[2]
                                    .replaceAll("L", ""))));
                            filter.setFilterIfMissing(true);
                            flist.addFilter(filter);
                        } else {
                            SingleColumnValueFilter filter = new SingleColumnValueFilter(Bytes.toBytes(fcv[0]),
                                    Bytes.toBytes(fcv[1]), CompareOp.EQUAL, Bytes.toBytes(fcv[2]));
                            filter.setFilterIfMissing(true);
                            flist.addFilter(filter);
                        }
                    }
                }
            }
            scan.setFilter(flist);

            rs = hTable.getScanner(scan);
            for (Result r : rs) {
                count++;

                Map<String, String> map = new HashMap<String, String>();
                for (KeyValue kv : r.raw()) {
                    //map.put(Bytes.toString(kv.getQualifier()), Bytes.toLong(kv.getValue())+"");
                    map.put(Bytes.toString(kv.getQualifier()), new String(kv.getValue(), "UTF-8"));
                }
                map.put(this.getMapKeyOfRow(), Bytes.toString(r.getRow()));

                resultList.add(map);
            }

            eutime = System.currentTimeMillis();
            useTime = eutime - utime;
            log.info("Fetching " + count + " rows during " + useTime + " milliseconds.");

            rs.close();
            hTable.close();
            return resultList;
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
        return null;
    }

    /**
     * get pagination rows based on lastRow
     *
     * @param tableName
     * @param startRow      can be null
     * @param endRow        can be null
     * @param lastRow       at the first time lastRow would be null
     * @param pageSize
     * @param returnColumns conform to format: [[family,column1],[family,column2],,,],
     *                      if null return all columns
     * @return
     */
    @SuppressWarnings("deprecation")
    public List<Map<String, String>> get(String tableName, String startRow, String endRow, String lastRow, int
            pageSize, List<String> returnColumns) {

        if (!this.tableExists(tableName)) {
            log.error("HBase table " + tableName + " does not exist.");
            return null;
        }

        if (pageSize <= 0) {
            log.error("HBase table pageSize " + pageSize + " must be greater than zero.");
            return null;
        }

        long utime = 0L;
        long eutime = 0L;
        long useTime = 0L;
        int count = 0;
        byte[] lastRowByte = null;
        HTableInterface hTable = null;
        ResultScanner rs = null;
        List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();

        try {
            utime = System.currentTimeMillis();
//			hTable = hTablePool.getTable(tableName);
            hTable = hConnection.getTable(tableName);
            Scan scan = new Scan();
            if (startRow != null && !"".equals(startRow)) {
                scan.setStartRow(Bytes.toBytes(startRow));
            }
            if (endRow != null && !"".equals(endRow)) {
                scan.setStopRow(Bytes.toBytes(endRow));
            }

            scan.setCaching(pageSize);
            scan.setCacheBlocks(this.isScanCacheBlocks());

            if (returnColumns != null && returnColumns.size() > 0) {
                for (String col : returnColumns) {
                    String[] cola = col.split(",");
                    if (cola != null && cola.length == 2) {
                        scan.addColumn(Bytes.toBytes(cola[0]), Bytes.toBytes(cola[1]));
                    }
                }
            }

            if (lastRow != null && !"".equals(lastRow)) {
                lastRowByte = Bytes.toBytes(lastRow);
                scan.setStartRow(Bytes.add(lastRowByte, this.getPostFix()));
            }

            Filter filter = new PageFilter(pageSize);
            scan.setFilter(filter);

            rs = hTable.getScanner(scan);

            for (Result r : rs) {
                count++;

                Map<String, String> map = new HashMap<String, String>();
                for (KeyValue kv : r.raw()) {
                    map.put(Bytes.toString(kv.getQualifier()), new String(kv.getValue(), "UTF-8"));
                }
                map.put(this.getMapKeyOfRow(), Bytes.toString(r.getRow()));

                resultList.add(map);
            }

            eutime = System.currentTimeMillis();
            useTime = eutime - utime;
            log.info("Fetching " + count + " rows during " + useTime + " milliseconds.");

            rs.close();
            hTable.close();
            return resultList;
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
        return null;
    }

    /**
     * get pagination rows based on lastRow and filterd by column conditions
     *
     * @param tableName
     * @param startRow         can be null
     * @param endRow           can be null
     * @param lastRow
     * @param pageSize         at the first time lastRow would be null
     * @param columnConditions conform to format: [[family,column1,value1],[family,column2,value2],,,]
     *                         when the value ends with L, means that the value type is long like column counter
     * @param returnColumns    conform to format: [[family,column1],[family,column2],,,],
     *                         if null return all columns
     * @return
     */
    @SuppressWarnings("deprecation")
    public List<Map<String, String>> get(String tableName, String startRow, String endRow, String lastRow, int
            pageSize, List<String> columnConditions, List<String> returnColumns) {

        if (!this.tableExists(tableName)) {
            log.error("HBase table " + tableName + " does not exist.");
            return null;
        }

        if (pageSize <= 0) {
            log.error("HBase table pageSize " + pageSize + " must be greater than zero.");
            return null;
        }

        long utime = 0L;
        long eutime = 0L;
        long useTime = 0L;
        int count = 0;
        byte[] lastRowByte = null;
        HTableInterface hTable = null;
        ResultScanner rs = null;
        List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();

        try {
            utime = System.currentTimeMillis();
//			hTable = hTablePool.getTable(tableName);
            hTable = hConnection.getTable(tableName);
            Scan scan = new Scan();
            if (startRow != null && !"".equals(startRow)) {
                scan.setStartRow(Bytes.toBytes(startRow));
            }
            if (endRow != null && !"".equals(endRow)) {
                scan.setStopRow(Bytes.toBytes(endRow));
            }

            scan.setCaching(pageSize);
            scan.setCacheBlocks(this.isScanCacheBlocks());

            if (returnColumns != null && returnColumns.size() > 0) {
                for (String col : returnColumns) {
                    String[] cola = col.split(",");
                    if (cola != null && cola.length == 2) {
                        scan.addColumn(Bytes.toBytes(cola[0]), Bytes.toBytes(cola[1]));
                    }
                }
            }

            if (lastRow != null && !"".equals(lastRow)) {
                lastRowByte = Bytes.toBytes(lastRow);
                scan.setStartRow(Bytes.add(lastRowByte, this.getPostFix()));
            }

            FilterList flist = new FilterList();
            Filter pageFilter = new PageFilter(pageSize);
            flist.addFilter(pageFilter);

            if (columnConditions != null && columnConditions.size() > 0) {
                for (String condition : columnConditions) {
                    String[] fcv = condition.split(",");
                    if (fcv != null && fcv.length == 3) {
                        if (fcv[2] != null && !"".equals(fcv[2]) && fcv[2].endsWith("L")) {
                            SingleColumnValueFilter filter = new SingleColumnValueFilter(Bytes.toBytes(fcv[0]),
                                    Bytes.toBytes(fcv[1]), CompareOp.EQUAL, Bytes.toBytes(Long.parseLong(fcv[2]
                                    .replaceAll("L", ""))));
                            filter.setFilterIfMissing(true);
                            flist.addFilter(filter);
                        } else {
                            SubstringComparator sComparator = new SubstringComparator(fcv[2]);
                            SingleColumnValueFilter filter = new SingleColumnValueFilter(Bytes.toBytes(fcv[0]),
                                    Bytes.toBytes(fcv[1]), CompareOp.EQUAL, sComparator);
                            filter.setFilterIfMissing(true);
                            flist.addFilter(filter);
                        }
                    }
                }
            }
            scan.setFilter(flist);

            rs = hTable.getScanner(scan);
            rs.next();
            for (Result r = rs.next(); r != null; r = rs.next()) {
                count++;

                Map<String, String> map = new HashMap<String, String>();
                for (KeyValue kv : r.raw()) {
                    //map.put(Bytes.toString(kv.getQualifier()), Bytes.toLong(kv.getValue())+"");
                    map.put(Bytes.toString(kv.getQualifier()), new String(kv.getValue(), "UTF-8"));
                }
                map.put(this.getMapKeyOfRow(), Bytes.toString(r.getRow()));

                resultList.add(map);
            }

            eutime = System.currentTimeMillis();
            useTime = eutime - utime;
            log.info("Fetching " + count + " rows during " + useTime + " milliseconds.");

            rs.close();
            hTable.close();
            return resultList;
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
        return null;
    }

    /**
     * get pagination rows based on lastRow and filterd by column conditions
     *
     * @param tableName
     * @param startRow         can be null
     * @param endRow           can be null
     * @param lastRow
     * @param pageSize         at the first time lastRow would be null
     * @param columnConditions conform to format: [[family,column1,value1],[family,column2,value2],,,]
     *                         when the value ends with L, means that the value type is long like column counter
     * @param returnColumns    conform to format: [[family,column1],[family,column2],,,],
     *                         if null return all columns
     * @param rowkeyStructure
     * @return
     * @author lvdapeng
     */
    @SuppressWarnings("deprecation")
    public List<Map<String, String>> get(String tableName, String startRow,
                                         String endRow, String lastRow, int pageSize,
                                         List<String> columnConditions, List<String> returnColumns,
                                         String rowkeyStructure) {

        if (pageSize <= 0) {
            log.error("HBase table pageSize " + pageSize + " must be greater than zero.");
            return null;
        }

        long utime = 0L;
        long eutime = 0L;
        long useTime = 0L;
        int count = 0;
        byte[] lastRowByte = null;
        HTable hTable = null;
        ResultScanner rs = null;
        List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();

        try {
            if (this.conf == null) {
                this.conf = HBaseConfiguration.create();
            }

            if (admin == null) {
                this.admin = new HBaseAdmin(this.conf);
            }

//		    if(!this.tableExists(tableName)) {
//				log.error("HBase table "+tableName+" does not exist.");
//				return null;
//			}

            utime = System.currentTimeMillis();

            hTable = new HTable(conf, tableName);
            Scan scan = new Scan();
            if (startRow != null && !"".equals(startRow)) {
                scan.setStartRow(Bytes.toBytes(startRow));
            }
            if (endRow != null && !"".equals(endRow)) {
                scan.setStopRow(Bytes.toBytes(endRow));
            }

            scan.setCaching(pageSize);
//			log.info("cacheBlock-------"+this.isScanCacheBlocks());
            scan.setMaxVersions();
            scan.setBatch(pageSize);
            scan.setCaching(pageSize);
            scan.setCacheBlocks(false);

            if (returnColumns != null && returnColumns.size() > 0) {
                for (String col : returnColumns) {
                    String[] cola = col.split(",");
                    if (cola != null && cola.length == 2) {
                        scan.addColumn(Bytes.toBytes(cola[0].trim()), Bytes.toBytes(cola[1].trim()));
                    }
                }
            }

            if (columnConditions != null && columnConditions.size() > 0) {
                for (String col : columnConditions) {
                    String[] cola = col.split(",");
                    if (cola != null && cola.length == 3) {
                        scan.addColumn(Bytes.toBytes(cola[0].trim()), Bytes.toBytes(cola[1].trim()));
                    }
                }
            }

            if (lastRow != null && !"".equals(lastRow)) {
                lastRowByte = Bytes.toBytes(lastRow);
                scan.setStartRow(Bytes.add(lastRowByte, this.getPostFix()));
            }

            FilterList flist = new FilterList();

            PageFilter pageFilter = new PageFilter(pageSize);
            flist.addFilter(pageFilter);

            scan.setFilter(flist);
            rs = hTable.getScanner(scan);

            for (Result r : rs) {
                count++;
                Map<String, String> map = new HashMap<String, String>();
                map.put("rowkey", Bytes.toString(r.getRow()));
                for (KeyValue kv : r.raw()) {
                    map.put(Bytes.toString(kv.getQualifier()), new String(kv.getValue(), "UTF-8"));
                }
                resultList.add(map);
            }
            eutime = System.currentTimeMillis();
            useTime = eutime - utime;
            log.info("Fetching " + count + " rows during " + useTime + " milliseconds.");

            rs.close();
            hTable.close();
            return resultList;
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
        return null;
    }

    /**
     * get Aggregation rows based on lastRow and filterd by column conditions
     *
     * @param tableName
     * @param startRow
     * @param endRow
     * @param lastRow
     * @param pageSize
     * @param columnConditions
     * @param returnColumns
     * @param rowkeyStructure
     * @return
     * @author LVDAPENG
     */
    public List<Map<String, Object>> get(String tableName,
                                         String startRow, String endRow, String lastRow, int pageSize,
                                         List<String> columnConditions, List<String> returnColumns, List<String>
                                                 aggreColumns,
                                         String rowkeyStructure) {
        return null;
    }

    /**
     * get total number of rows
     *
     * @param tableName
     * @param familyName
     * @param startRow
     * @param endRow
     * @return
     */
    public long getTotal(String tableName, String familyName, String startRow,
                         String endRow) throws Throwable {

        System.out.println("startRow=" + startRow);
        System.out.println("endRow=" + endRow);
        System.out.println("tableName=" + tableName);
        if (!this.tableExists(tableName)) {
            log.error("HBase table " + tableName + " does not exist.");
            return 0;
        }

        long useTime = 0L;
        long rowCount = 0L;

        long stime = System.currentTimeMillis();

        Scan scan = new Scan();
        if (startRow != null && !"".equals(startRow))
            scan.setStartRow(Bytes.toBytes(startRow));
        if (endRow != null && !"".equals(endRow))
            scan.setStopRow(Bytes.toBytes(endRow));

        conf = cfg;
        conf.setLong("hbase.rpc.timeout", 600000);
        conf.setLong("hbase.client.scanner.caching", 10000);
        conf = HBaseConfiguration.create(conf);
        AggregationClient aggregationClient = new AggregationClient(conf);
        rowCount = aggregationClient.rowCount(TableName.valueOf(tableName), new LongColumnInterpreter(), scan);
        long etime = System.currentTimeMillis();
        useTime = etime - stime;
        log.info("Fetching " + rowCount + " rows during " + useTime + " milliseconds.");


        return rowCount;
    }

    /**
     * get original row keys from the corresponding ESI table
     * ESI table name format: esi_tableName
     *
     * @param tableName
     * @param esiTempTableName put this table name from server to client, so it will be null at the first time, not
     *                         null at later
     * @param isFirstTime
     * @param lastRow
     * @param pageSize
     * @param columnConditions conform to format: [[family,column1,value1],[family,column2,value2],,,]
     * @return
     */
    @SuppressWarnings("deprecation")
    public List<String> getOriginalRowKeys(String tableName, String esiTempTableName, boolean isFirstTime, String
            lastRow, int pageSize, List<String> columnConditions) {

        String esiTableName = "esi_" + tableName;
        if (!this.tableExists(tableName) || !this.tableExists(esiTableName)) {
            log.error("HBase table " + tableName + " or " + esiTableName + " does not exist.");
            return null;
        }

        if (pageSize <= 0) {
            log.error("HBase table pageSize " + pageSize + " must be greater than zero.");
            return null;
        }

        long utime = 0L;
        long eutime = 0L;
        long useTime = 0L;
        int count = 0;
        byte[] lastRowByte = null;
        HTableInterface hTable = null;
        ResultScanner rs = null;
        List<String> resultList = new ArrayList<String>();

        try {
            utime = System.currentTimeMillis();
//			hTable = hTablePool.getTable(esiTableName);
            hTable = hConnection.getTable(esiTableName);
            if (columnConditions != null && columnConditions.size() > 0) {

                if (isFirstTime) {
                    Scan scan = new Scan();
                    scan.setCaching(this.scanCaching);
                    scan.setCacheBlocks(this.isScanCacheBlocks());

                    List<String> originalRowKeys = new ArrayList<String>(1000);
                    for (String condition : columnConditions) {
                        String[] fcv = condition.split(",");

                        if (fcv != null && fcv.length == 3) {
                            scan.setStartRow(Bytes.toBytes(fcv[1] + ":" + fcv[2] + ":0000000000000"));
                            scan.setStopRow(Bytes.toBytes(fcv[1] + ":" + fcv[2] + ":9999999999999"));

                            rs = hTable.getScanner(scan);

                            for (Result r : rs) {
                                for (KeyValue kv : r.raw()) {
                                    originalRowKeys.add(Bytes.toString(kv.getValue()));
                                }
                            }
                            rs.close();
                            this.increment(esiTempTableName, originalRowKeys, "cf", "click", 1);
                            originalRowKeys.clear();
                        }
                    } //for(String condition : columnConditions) {
                } //if(isFirstTime) {


//				hTable = hTablePool.getTable(esiTempTableName);
                hTable = hConnection.getTable(esiTempTableName);
                Scan scan2 = new Scan();
                scan2.setCaching(pageSize);
                scan2.setCacheBlocks(this.isScanCacheBlocks());

                if (lastRow != null && !"".equals(lastRow)) {
                    lastRowByte = Bytes.toBytes(lastRow);
                    scan2.setStartRow(Bytes.add(lastRowByte, this.getPostFix()));
                }

                FilterList flist = new FilterList();
                SingleColumnValueFilter filter = new SingleColumnValueFilter(Bytes.toBytes("cf"),
                        Bytes.toBytes("click"), CompareOp.EQUAL, Bytes.toBytes((long) columnConditions.size()));
                filter.setFilterIfMissing(true);
                flist.addFilter(filter);

                Filter pageFilter = new PageFilter(pageSize);
                flist.addFilter(pageFilter);
                scan2.setFilter(flist);

                rs = hTable.getScanner(scan2);
                for (Result r : rs) {
                    count++;

                    resultList.add(Bytes.toString(r.getRow()));
                }

            } //if(columnConditions != null && columnConditions.size() > 0) {


            eutime = System.currentTimeMillis();
            useTime = eutime - utime;
            log.info("Fetching " + count + " rows from esi table during " + useTime + " milliseconds.");

            rs.close();
            hTable.close();
            //this.dropTable(esiTempTableName_);

            return resultList;
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (hTable != null) {
                    hTable.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
        return null;
    }

    /**
     * get rows by extended secondary index table
     * ESI table name format: esi_tableName
     *
     * @param tableName
     * @param esiTempTableName put this table name from server to client, so it will be null at the first time, not
     *                         null at later
     * @param lastRow
     * @param pageSize
     * @param columnConditions conform to format: [[family,column1,value1],[family,column2,value2],,,]
     * @param returnColumns    conform to format: [[family,column1],[family,column2],,,],
     *                         if null return all columns
     * @return
     */
    public List<Map<String, String>> getByESI(String tableName, String esiTempTableName, String lastRow, int
            pageSize, List<String> columnConditions, List<String> returnColumns) {

        boolean isFirstTime = true;
        String esiTempTableName_ = "esitemp_";
        if (esiTempTableName != null && esiTempTableName.startsWith("esitemp_")) {
            isFirstTime = false;
            esiTempTableName_ = esiTempTableName;
        } else {
            synchronized (esiTempTableName_) {
                esiTempTableName_ = esiTempTableName_ + System.currentTimeMillis();
            }
            if (esiTempTableName_ == null || "esitemp_".equals(esiTempTableName_)) {
                log.error("HBase esiTempTable " + esiTempTableName_ + " is not created correctly.");
                return null;
            } else {
                this.createTable(esiTempTableName_, true, "cf");
            }
        }

        List<String> originalRowKeys = this.getOriginalRowKeys(tableName, esiTempTableName_, isFirstTime, lastRow,
                pageSize, columnConditions);
        if (originalRowKeys != null && originalRowKeys.size() > 0) {
            List<Map<String, String>> list = this.get(tableName, originalRowKeys, returnColumns);
            Map<String, String> esiTempMap = new HashMap<String, String>();
            esiTempMap.put("esitemp", esiTempTableName_);
            list.add(esiTempMap);
            return list;
        } else {
            return null;
        }
    }
}

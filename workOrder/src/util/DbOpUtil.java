package util;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by xinxin on 2015/9/29.
 */
public class DbOpUtil {

    public static List<Map<String,String>> query(String sql,Statement statement) throws SQLException {
        ResultSet resultSet = statement.executeQuery(sql);
        List<Map<String, String>> list = new ArrayList<Map<String, String>>();
        while (resultSet.next()) {
            Map<String, String> row = new HashMap<String, String>();
            for (int i = 0; i < resultSet.getMetaData().getColumnCount(); i++) {
                if(resultSet.getString(i+1)!=null) {
                    row.put(resultSet.getMetaData().getColumnLabel(i + 1).toUpperCase(), resultSet.getString(i + 1));
                }
            }
            list.add(row);
        }
        resultSet.close();
        return list;
    }

    public static boolean exec(String sql,Statement statement) throws SQLException {
        return statement.execute(sql);
    }
}

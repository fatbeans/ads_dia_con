package utility;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

	public static void main(String[] args) {
		DBConnection p = new DBConnection();
		p.getOracleConnection();
	}
	public Properties getProp() {
		DBConnection loadProp = new DBConnection();
		String path = loadProp.getClass().getProtectionDomain().getCodeSource()
				.getLocation().getPath();
		String[] paths = path.split("/");
		int index = paths.length - 1;
		// System.out.println(paths[index]);
		File propFile = new File(path.substring(0, path.indexOf(paths[index]))
				+ "/config/conn.properties");
		InputStream in = loadProp.getClass().getResourceAsStream(
				"/config/conn.properties");
		// System.out.println(propFile);
		Properties prop = new Properties();
		try {
			if (propFile.exists()) {
				prop.load(new FileInputStream(propFile));
			} else {
				prop.load(in);
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return prop;
	}
	public static Properties getThProp() {
		DBConnection loadProp = new DBConnection();
		String path = loadProp.getClass().getProtectionDomain().getCodeSource()
				.getLocation().getPath();
		String[] paths = path.split("/");
		int index = paths.length - 1;
		// System.out.println(paths[index]);
		File propFile = new File(path.substring(0, path.indexOf(paths[index]))
				+ "/config/threshold.properties");
		InputStream in = loadProp.getClass().getResourceAsStream(
				"/config/threshold.properties");
		 System.out.println(propFile);
		Properties prop = new Properties();
		try {
			if (propFile.exists()) {
				prop.load(new FileInputStream(propFile));
			} else {
				prop.load(in);
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return prop;
	}

	public static Connection getOracleConnection() {
		DBConnection loadProp = new DBConnection();
		Connection conn = null;
		Properties prop = loadProp.getProp();
		// 湖南正式环境
		// String ip = "10.154.3.9";
		// String port ="1521";
		// String instance = "zhfx";
		// String UserName = "npm_ads";
		// String Password = "My_678#";
		// 济南测试环境
		String ipadd = prop.getProperty("ora_ip");

		String port = prop.getProperty("ora_port");
		String instance = prop.getProperty("ora_instance");
		String UserName = prop.getProperty("ora_username");
		String Password = prop.getProperty("ora_password");
		String[] ipaddrs = ipadd.split(",");
		if (ipaddrs.length == 1) {
			String ip = ipaddrs[0];
			try {
				// 加载oracle驱动
				Class.forName("oracle.jdbc.driver.OracleDriver");
				// 连接字符串
				String url = "jdbc:oracle:thin:@" + ip + ":" + port + "/"
						+ instance;
				// 建立连接
			
				conn = DriverManager.getConnection(url, UserName, Password);
			//	System.out.println(url);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {

			String iplist = "";
			try {
				for (int i = 0; i < ipaddrs.length; i++) {
					iplist += "(address=(host=" + ipaddrs[i]
							+ ")(protocol=tcp)(port=" + port + "))";
				}
				// 加载oracle驱动
				Class.forName("oracle.jdbc.driver.OracleDriver");
				// 连接字符串
				String url = "jdbc:oracle:thin:@(description= (address_list="
						+ iplist
						+ "(load_balance=yes)(failover=yes))(connect_data=(service_name="
						+ instance + ")))";
				// 建立连接
				 System.out.println(url);
				conn = DriverManager.getConnection(url, UserName, Password);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		
		return conn;
	}

	public static Connection getGpConnection() throws ClassNotFoundException,
			SQLException {
		DBConnection loadProp = new DBConnection();
		Connection conn = null;
		Properties prop = loadProp.getProp();
		//prop.list(System.out);
		String ip = prop.getProperty("gp_ip");
		String port = prop.getProperty("gp_port");
		String instance = prop.getProperty("gp_instance");
		String UserName = prop.getProperty("gp_username");
		String Password = prop.getProperty("gp_password");

		// 加载postgresql驱动
		Class.forName("org.postgresql.Driver");
		// 连接字符串
		String url = "jdbc:postgresql://" + ip + ":" + port + "/" + instance;
		// 建立连接
		//System.out.println(url);
		conn = DriverManager.getConnection(url, UserName, Password);

		return conn;
	}

	public static Connection getGbConnection() throws ClassNotFoundException,
			SQLException {
		DBConnection loadProp = new DBConnection();
		Connection conn = null;
		Properties prop = loadProp.getProp();
		String ip = prop.getProperty("gb_ip");
		String port = prop.getProperty("gb_port");
		String instance = prop.getProperty("gb_instance");
		String UserName = prop.getProperty("gb_username");
		String Password = prop.getProperty("gb_password");

		// 加载gbase驱动
		Class.forName("com.gbase.jdbc.Driver");
		// 连接字符串
		String url = "jdbc:gbase://" + ip + ":" + port + "/" + instance;
		// 建立连接
		conn = DriverManager.getConnection(url, UserName, Password);

		return conn;
	}

	public static Connection getSourConnection() throws ClassNotFoundException,
			SQLException {
		DBConnection loadProp = new DBConnection();
		Connection conn = null;
		Properties prop = loadProp.getProp();
		String url = prop.getProperty("sour_url",
				"jdbc:oracle:thin:10.18.11.171:1521/nwom");
		String UserName = prop.getProperty("sour_username");
		String Password = prop.getProperty("sour_password");
		String className = prop.getProperty("sour_class",
				"com.gbase.jdbc.Driver");

		// 加载gbase驱动
		Class.forName(className);

		// 建立连接
		conn = DriverManager.getConnection(url, UserName, Password);
		return conn;
	}

	public static Connection getTarConnection() throws ClassNotFoundException,
			SQLException {
		DBConnection loadProp = new DBConnection();
		Connection conn = null;
		Properties prop = loadProp.getProp();
		String url = prop.getProperty("tar_url",
				"jdbc:oracle:thin:10.18.11.171:1521/nwom");
		String UserName = prop.getProperty("tar_username");
		String Password = prop.getProperty("tar_password");
		String className = prop.getProperty("tar_class",
				"com.gbase.jdbc.Driver");

		// 加载gbase驱动
		Class.forName(className);

		// 建立连接
		conn = DriverManager.getConnection(url, UserName, Password);
		return conn;
	}
}

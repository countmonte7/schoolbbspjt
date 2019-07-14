package app.model;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;

public class DB {
	public Connection doConnect() {
		Connection conn = null;
	    try {
	    	Properties prop = new Properties();
			FileInputStream ip = new FileInputStream("C:/spring/schoolboard/config.properties");
			prop.load(ip);
			String id = prop.getProperty("dbId");
			String pw = prop.getProperty("dbPw");
	  		Class.forName("com.mysql.cj.jdbc.Driver");
	  		String url="jdbc:mysql://localhost:3306/schoolboard?serverTimezone=UTC";
	  		conn = DriverManager.getConnection(url, id, pw);
	    }catch(Exception e) {
	    	e.printStackTrace();
	    }
	    return conn;
	}
}

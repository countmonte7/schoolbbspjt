package app.model;

import java.sql.Connection;
import java.sql.DriverManager;

import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;

public class DB {
	public Connection doConnect() {
		Connection conn = null;
	    try {
	    	String id ="root";
	  		String pw="47690eo5dh";
	  		Class.forName("com.mysql.cj.jdbc.Driver");
	  		String url="jdbc:mysql://localhost:3306/schoolboard?serverTimezone=UTC";
	  		conn = DriverManager.getConnection(url, id, pw);
	    	
	    }catch(Exception e) {
	    	e.printStackTrace();
	    }
	    return conn;
	}
}

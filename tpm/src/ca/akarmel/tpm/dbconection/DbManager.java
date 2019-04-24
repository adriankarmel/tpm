package ca.akarmel.tpm.dbconection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbManager {
	
	private String urlNativo = "jdbc:mysql://localhost/tpm";
	private Connection connetionDriver = null;
	
	public Connection getConnection()
	{	
		if (connetionDriver == null){
			try{
			//	Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection(urlNativo,"root","");
				return conn;
			}catch(SQLException s){
				System.out.println("ERROR AL CAPTURAR LA Connection");
				s.printStackTrace();
				return null;
			}catch (ClassNotFoundException e){
				System.out.println("ERROR AL REGISTRAR LA CLASE JDBC");
				e.printStackTrace();
				return null;
			}
		}
		return connetionDriver;
	}


}

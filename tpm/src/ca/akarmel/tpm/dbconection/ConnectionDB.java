package ca.akarmel.tpm.dbconection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionDB {


	private String urlNativo = "jdbc:mysql://localhost:3306/tpm?user=Admin&password=Admin";
	private Connection connetionDriver = null;

	public ConnectionDB() throws ClassNotFoundException {
		Class.forName("com.mysql.jdbc.Driver"); 
	}


	public Connection getConnection()
	{	
		if (connetionDriver == null){
			try{		
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection conn = DriverManager.getConnection(urlNativo);
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

	/**
	 * Cierra una conexión abierta
	 * @param ConnectionDB
	 */

	public void closeConnection(Connection connetion)
	{
		if (connetionDriver != null){
			try{
				connetionDriver.close();
			}catch (Exception e){
				System.out.println("Error Close to connection");
				e.printStackTrace();
			}
		}
	}
}
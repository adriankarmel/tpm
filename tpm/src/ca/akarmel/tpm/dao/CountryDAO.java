package ca.akarmel.tpm.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import ca.akarmel.tpm.dbconection.ConnectionDB;
import ca.akarmel.tpm.entities.Country;

public class CountryDAO {
	
	public List<Country> list() throws Exception {
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();
		 
	     ResultSet rs = null;
	     String sSql = "";
	     
	     List<Country> result = new ArrayList<Country>();
	     try
	       {	  
		         Statement stmt = conn.createStatement();
		         sSql = "SELECT id, name " +
		 	 		    "  FROM country";
		         
		         // System.out.println(sSql);
		         rs = stmt.executeQuery(sSql);
		         
		         while (rs.next()) {
		        	 Country theCountry = new Country();
		        	 
		        	 theCountry.setId(rs.getInt("id"));
		        	 theCountry.setName(rs.getString("name"));	        	 
	
		        	 result.add(theCountry);
		         }
	        }
	        catch (Exception e){       
	            System.out.println(e);
	        } finally {
	            if (null != rs) {
	              try { rs.close();} catch(Exception ex) {};
	            }
	            if (null != conn) {
	              try { conn.close();} catch(Exception ex) {};
	            }
	        }
	     
	        return result;
	  }
}
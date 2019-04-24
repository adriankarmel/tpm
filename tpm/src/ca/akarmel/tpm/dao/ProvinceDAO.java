package ca.akarmel.tpm.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import ca.akarmel.tpm.dbconection.ConnectionDB;
import ca.akarmel.tpm.entities.Province;

public class ProvinceDAO {
	
	public List<Province> list(String pCountryId) throws Exception {
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();
	     ResultSet rs = null;
	     String sSql = "";
	     
	     List<Province> result = new ArrayList<Province>();
	     try
	       {	  
		         Statement stmt = conn.createStatement();
		         sSql =  "SELECT id, name " +
		 	 			"  FROM province" + 
		 	 			" WHERE country_id = " + pCountryId;
		         
		         // System.out.println(sSql);
		         rs = stmt.executeQuery(sSql);
		         
		         while (rs.next()) {
		        	 Province theProvince = new Province();
		        	 
		        	 theProvince.setId(rs.getInt("id"));
		        	 theProvince.setName(rs.getString("name"));
		        	 
		        	 result.add(theProvince);
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

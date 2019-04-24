package ca.akarmel.tpm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ca.akarmel.tpm.dbconection.ConnectionDB;

public class ConfigDAO {
	
	public static void UpdateConfig(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException {
		
		String sCompanyName = request.getParameter("CompanyName");
		String sAddress = request.getParameter("Address");
		String sCountryId = request.getParameter("CountryId");
		String sProvinceId = request.getParameter("ProvinceId");
		String sPostalCode = request.getParameter("PostalCode");
		String sPhoneOne = request.getParameter("PhoneOne");
		String sPhoneTwo = request.getParameter("PhoneTwo");
		String sPhoneThree = request.getParameter("PhoneThree");
		String sEmailOne = request.getParameter("EmailOne");
		String sEmailTwo = request.getParameter("EmailTwo");
		String sEmailThree = request.getParameter("EmailThree");
	//	String sDisplaySettings = request.getParameter("DisplaySettings");
		String sDisplaySettings = "css/style.css";
		String sOperStartTime = request.getParameter("OperStartTime");
		String sOperEndTime = request.getParameter("OperEndTime");	

		ConnectionDB db = new ConnectionDB();
		Connection conn = db.getConnection();		 
		PreparedStatement prep = null;
	
		String sSql = "";		
		 
		 try {
			 
			 if(conn != null) {	
				 
				 sSql = "UPDATE config " + 
			 		    "   SET company_name = ?," + 					 		 
			 		    "       address = ?, "     +			 		    
			 		    "  		country_id = ?,"   + 
			 		    " 	    province_id = ?,"  + 
			 		    "  		postal_code = ?,"  + 
			 		    "  		phone_one = ?, "   +
			 		    "  		phone_two = ?, "   +
			 		    "  		phone_three = ?, " +
			 		    "  		email_one = ?, "   +
			 		    "  		email_two = ?, "   +
			 		    "  		email_three = ?, " +
			 		    "	    display_settings = ?, " +
			 		    "		operation_start_time = ?, " +
			 		    " 	    operation_end_time = ? " +
			 		    " WHERE id = " + 1;			
 
				 prep = conn.prepareStatement (sSql);				 
				 
				 prep.setString (1, sCompanyName);
				 prep.setString (2, sAddress);				 
				 prep.setString (3, sCountryId);
				 prep.setString (4, sProvinceId);
				 prep.setString (5, sPostalCode);				 
				 prep.setString (6, sPhoneOne);
				 prep.setString (7, sPhoneTwo);
				 prep.setString (8, sPhoneThree);
				 prep.setString (9, sEmailOne);
				 prep.setString (10,sEmailTwo );				 				 
				 prep.setString (11,sEmailThree);	
				 prep.setString (12,sDisplaySettings);
				 prep.setString (13,sOperStartTime);
				 prep.setString (14,sOperEndTime);
				 
				 prep.executeUpdate();
				 
			     prep.close();
			 }		 
			
      }catch(SQLException error){
          System.out.println("Error: " + error.getMessage());
      }	
	}

	public String getCSS() throws ClassNotFoundException {	
		
		 String Display = "styleLight";
		 
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();
	     ResultSet rs = null;
	     String sSql = "";     
		     
         try{	  
		      Statement stmt = conn.createStatement();
		         
		      sSql = "SELECT display_settings " +
		    		 "  FROM config" +
		 	  	     " WHERE id = " + 1;
		         
		      rs = stmt.executeQuery(sSql);
		         
	         while (rs.next()) {
	        	 Display = rs.getString("display_settings");	
	         }
	     }catch (Exception e){       
	            System.out.println(e);
	     } finally {
            if (null != rs) {
              try { rs.close();} catch(Exception ex) {};
            }
            if (null != conn) {
              try { conn.close();} catch(Exception ex) {};
            }
        }
     
        return Display;
    }		
	
	public String[] getWorkingHours() throws ClassNotFoundException {	
					
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();
	     ResultSet rs = null;
	     
	     String HoursWork[] = new String[2];
	  
	     String sSql = "";     
		     
         try{	  
		      Statement stmt = conn.createStatement();
		         
		      sSql = "SELECT operation_start_time AS Start, " + 
		    		 "		 operation_end_time AS End " +
		    		 "  FROM config" +
		 	  	     " WHERE id = " + 1;
		         
		      rs = stmt.executeQuery(sSql);
		         
	          while (rs.next()) {
	        	 HoursWork[0] = rs.getString("Start");
	      	     HoursWork[1] = rs.getString("End");	
	          }
	          
	     }catch (Exception e){       
	            System.out.println(e);
	     } finally {
           if (null != rs) {
             try { rs.close();} catch(Exception ex) {};
           }
           if (null != conn) {
             try { conn.close();} catch(Exception ex) {};
           }
       }
    
       return HoursWork;
   }		
	
}
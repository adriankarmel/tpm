package ca.akarmel.tpm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ca.akarmel.tpm.dbconection.ConnectionDB;
import ca.akarmel.tpm.entities.Worker;

public class WorkerDAO {

	public List<Worker> list(String pSearWorker, String pInactive) throws Exception {
		
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();
		 
	     ResultSet rs = null;
	     
	     String sSql = "";
	     String sInactive = " AND inactive = 'N' "; 
	     
	     List<Worker> result = new ArrayList<Worker>();
	     
	   //  System.out.println("pInactive: " + pInactive);
	     
	     if (pInactive.equals("on")) {
	    	 sInactive = " AND (inactive = 'Y' OR inactive = 'N') ";	    
	     }
	     
	     try
	       {	  
	         Statement stmt = conn.createStatement();
	         
	         sSql = "SELECT id, first_name, last_name," + 
	         		"       email, phone, hour_rate, comments, inactive " +
	 	 			"  FROM worker" + 
	 	 			" WHERE (first_name LIKE '%" + pSearWorker + "%'" + " OR " + 
	 	 		    " 		 last_name  LIKE '%" + pSearWorker + "%'" + " OR " +
	 	 			"        email  	LIKE '%" + pSearWorker + "%'" + " OR " +
	 	 			"        phone  	LIKE '%" + pSearWorker + "%'" + " OR " +
	 	 			"        hour_rate 	LIKE '%" + pSearWorker + "%'" + " OR " +
	 	 			" 		 comments   LIKE '%" + pSearWorker + "%'" + ")"    +
	 	 			sInactive;
	         
	         //  System.out.println(sSql);
	         rs = stmt.executeQuery(sSql);
	         
	         while (rs.next()) {
	        	 Worker theWorker = new Worker();
	        	 
	        	 theWorker.setId(rs.getInt("id"));
	        	 theWorker.setFirstName(rs.getString("first_name"));
	        	 theWorker.setLastName(rs.getString("last_name"));
	        	 theWorker.setEmail(rs.getString("email"));
	        	 theWorker.setPhone(rs.getString("phone"));
	        	 theWorker.setInactive(rs.getString("inactive"));

	        	 result.add(theWorker);
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
	
	public static void NewWorker(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException {
		
		 String sFirstName = request.getParameter("FirstName");
		 String sLastName = request.getParameter("LastName");
		 String sEmail = request.getParameter("Email");
		 String sPhone = request.getParameter("Phone");
		 String sHourRate = request.getParameter("HourRate");
		 String sComments = request.getParameter("Comments");
		 String sInactive = request.getParameter("Inactive");		 										  
		 
		 // System.out.println("sInactive: " + sInactive);
		
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();		 
		 PreparedStatement prep = null;
	
		 String sSql = "";		
		 
		 try {
			 
			 if(conn != null) {	
				 
				 sSql = "INSERT INTO worker" + 
				 		   " (first_name," + 					 		 
				 		   "  last_name, " +
				 		   "  email, " +
				 		   "  phone, " +
				 		   "  hour_rate, " +
				 		   "  comments, " + 
				 		   "  inactive ) VALUES (?,?,?,?,?,?,?)";			
  
				 prep = conn.prepareStatement (sSql);				 
				 
				 prep.setString (1, sFirstName);
				 prep.setString (2, sLastName);
				 prep.setString (3, sEmail);
				 prep.setString (4, sPhone);
				 prep.setString (5, sHourRate);
				 prep.setString (6, sComments);	
				 prep.setString (7, sInactive);
				 
				 // System.out.println("worker insert : " + prep.toString());
				 
				 prep.executeUpdate();				 
			     prep.close();
			 }		 
			
       }catch(SQLException error){
           System.out.println("Error: " + error.getMessage());
       }	       	 
	}
	
	public static void InactivateWorker(String  pWorkerId) throws ClassNotFoundException { 
		 
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();		 
		
		 PreparedStatement prep = null;
		 
		 String sInactive = "Y";
		 String sSql = "";		
		 
		 try {
			 
			 if(conn != null) {	
				 
				 sSql = "UPDATE worker " + 
			 		    "   SET inactive = ? "	 + 
			 		    " WHERE id = ?";			
 
				 prep = conn.prepareStatement (sSql);	
			
				 prep.setString (1, sInactive);
				 prep.setString (2, pWorkerId);				 
				 
				 prep.executeUpdate();
				 
			     prep.close();
			 }		 
			
      }catch(SQLException error){
          System.out.println("Error: " + error.getMessage());
      }	
  }
	
	public static void UpdateWorker(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException {
			
		String sWorkerId = request.getParameter("WorkerId");

		String sFirstName = request.getParameter("FirstName");
		String sLastName = request.getParameter("LastName");
		String sEmail = request.getParameter("Email");
		String sPhone = request.getParameter("Phone");
		String sHourRate = request.getParameter("HourRate");
		String sComments = request.getParameter("Comments");
		String sInactive = request.getParameter("Inactive");
		
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();		 
		 PreparedStatement prep = null;
	
		 String sSql = "";		
		 
		 try {
			 
			 if(conn != null) {	
				 
				 sSql = "UPDATE worker " + 
			 		    "   SET first_name = ?," + 					 		 
			 		    "       last_name = ?, " +
			 		    "       email = ?, " 	 +
			 		    "       phone = ?, " 	 +
			 		    "       hour_rate = ?, " +
			 		    "       category = ?, "  +
			 		    " 		inactive = ? "	 + 
			 		    " WHERE id = ?";			
 
				 prep = conn.prepareStatement (sSql);				 
				 
				 prep.setString (1, sFirstName);
				 prep.setString (2, sLastName);
				 prep.setString (3, sEmail);
				 prep.setString (4, sPhone);
				 prep.setString (5, sHourRate);
				 prep.setString (6, sComments);
				 prep.setString (7, sInactive);
				 prep.setString (8, sWorkerId);				 
				 
				 prep.executeUpdate();
				 
			     prep.close();
			 }		 
			
      }catch(SQLException error){
          System.out.println("Error: " + error.getMessage());
      }	
   }
	
   public static String getWorkerName(String pId) throws ClassNotFoundException, SQLException {  
	    String WorkerName = "";
	   	String sSql = "";
	   
		ConnectionDB db = new ConnectionDB();			
		Connection conn = db.getConnection();
		ResultSet rs = null;
		
		try
	       {
				Statement stmt = conn.createStatement();	
				
			    sSql = "SELECT CONCAT(first_name, ', ', last_name) AS workerName " +
					   "  FROM worker " + 
					   " WHERE id = " + Integer.parseInt(pId);
			   
			    rs = stmt.executeQuery(sSql);
			    
				while(rs.next()){	
					WorkerName = rs.getString("workerName");
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
		return WorkerName;
   }
}
package ca.akarmel.tpm.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import ca.akarmel.tpm.dbconection.ConnectionDB;
import ca.akarmel.tpm.entities.Job;

public class JobDAO {
	
	public static void InsertJob(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, JSONException {
		 
		 String sCustomerId = request.getParameter("CustomerId");
		 String sJobDate = request.getParameter("JobDate");
		 String sWorkerInfo = request.getParameter("wInfo");	
		 String sComments = request.getParameter("Comments");
		
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();		 
		 PreparedStatement prep = null;
	
		 String sSqlJob = "";
		 int last_inserted_id = 0;			 
		
		 JSONArray jsonarray = new JSONArray(sWorkerInfo);		 
	 
		  try {
			 
			 if(conn != null) {	
				 
				 sSqlJob = "INSERT INTO job" + 
				 		   " (customer_id," + 					 		 
				 		   "  date, " +
				 		   "  comments) VALUES (?,?,?)";
				  
				 prep = conn.prepareStatement (sSqlJob, Statement.RETURN_GENERATED_KEYS);				 
				 prep.setString (1, sCustomerId);
				 prep.setString (2, sJobDate);
				 prep.setString (3, sComments);
				 
				 prep.executeUpdate();
				 
				 ResultSet rs = prep.getGeneratedKeys();
                 if(rs.next()) {
                     last_inserted_id = rs.getInt(1);                   
                 }
                 
             	 for(int i=0; i<jsonarray.length(); i++){
    		        JSONObject obj = jsonarray.getJSONObject(i);

    		        String sWorkerId = obj.getString("id");
    		        String sStartTime = obj.getString("startTime");
    		        String sEndTime = obj.getString("endTime");

    		        InsertJobDetail(last_inserted_id, sWorkerId, sStartTime, sEndTime);		      
    		     }   
				 			 
           	    // prep.close();
			 }
			 
			// conn.close();
        }catch(SQLException error){
            System.out.println("Error: " + error.getMessage());
        }	       	 
	}
	
	public static void UpdateJob(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, JSONException {
		
		 String sJobId = request.getParameter("JobId");
		 
		 String sCustomerId = request.getParameter("CustomerId");
		 String sJobDate = request.getParameter("JobDate");
		 String sWorkerInfo = request.getParameter("wInfo");
		 String sComments = request.getParameter("Comments");
		 		
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();		 
		 PreparedStatement prep = null;
	
		 String sSql = "";				 
		
		 JSONArray jsonarray = new JSONArray(sWorkerInfo);		 
	 
		 DeleteWorkerOnJobDetails(sJobId, jsonarray);
		 
		 try {
			 
			 if(conn != null) {					 
				 sSql = "UPDATE job" + 
			 		    "   SET customer_id = ?, " + 					 		 
			 		    " 	    date = ?," + 
			 		    "	    Comments = ?" + 
			 		    " WHERE id = ?";
				  
				 prep = conn.prepareStatement (sSql);				 
				 prep.setInt(1, Integer.parseInt(sCustomerId));
				 prep.setString (2, sJobDate);	
				 prep.setString (3, sComments);
				 
				 prep.setInt (4, Integer.parseInt(sJobId));
				 
				 prep.executeUpdate();
				 
		      	 for(int i=0; i<jsonarray.length(); i++){
	   		        JSONObject obj = jsonarray.getJSONObject(i);
	
	   		        String sWorkerId = obj.getString("id");
	   		        String sStartTime = obj.getString("startTime");
	   		        String sEndTime = obj.getString("endTime");
	
	   		        if(isJobDetailNew(Integer.parseInt(sJobId), sWorkerId)) {
	   		        	InsertJobDetail(Integer.parseInt(sJobId), sWorkerId, sStartTime, sEndTime);
	   		        }else {	
	   		        	UpdateJobDetail(Integer.parseInt(sJobId), sWorkerId, sStartTime, sEndTime);
	   		        }	
	   		     }   			 			 
              
			    // prep.close();
			 }
			 
			// conn.close();
       }catch(SQLException error){
           System.out.println("Error: " + error.getMessage());
       }	       	 
	}		
	
	private static void UpdateJobDetail(int pJobId, String pWorkerId, String pStartTime, String pEndTime) throws ClassNotFoundException {
		
		 ConnectionDB db1 = new ConnectionDB();
		 Connection conn1 = db1.getConnection();	
		 
		 PreparedStatement prep1 = null;
		 String sSqlJDetail = "";
		  
		 try {
			 sSqlJDetail = " UPDATE job_details"     + 
				  	       " 	SET	start_time = ?," + 
					 	   "  		end_time = ?"    + 
					 	   "  WHERE job_id = ? "     +
					 	   "    AND worker_id = ? "; 		 	  	
			  
			 prep1 = conn1.prepareStatement (sSqlJDetail);				 
			
			 prep1.setString (1, pStartTime);
			 prep1.setString (2, pEndTime);				 
			 prep1.setInt(3, pJobId);
			 prep1.setInt(4, Integer.parseInt(pWorkerId));	
			 
			 // System.out.println("After : " + prep1.toString());
			 
			 prep1.executeUpdate();      
		     prep1.close();	 
		 
		    // conn1.close();
		  }catch(SQLException error){
		      System.out.println("Error: " + error.getMessage());
		  }	       
	}	
	
	public static void DeleteJob(String pJobId) throws ClassNotFoundException, SQLException {
			
	    ConnectionDB dbDel = new ConnectionDB();
	    Connection connDel = dbDel.getConnection();			
	    
	    Statement s = connDel.createStatement();
		String s1 = "DELETE FROM job WHERE id = " + Integer.parseInt(pJobId); 				
		String s2 = "DELETE FROM job_details WHERE job_id = " + Integer.parseInt(pJobId); 
		s.addBatch(s1);
		s.addBatch(s2);     
		s.executeBatch();	
		s.close();
		
	}	
	
	private static void DeleteWorkerOnJobDetails(String pJobId, JSONArray pJsonArrayWorkers) throws JSONException, ClassNotFoundException {
		
		String sWorkerIdDel = "";
		String sSqlDel = "";
		
	    ConnectionDB dbDel = new ConnectionDB();
	    Connection connDel = dbDel.getConnection();	
	    ResultSet rsDel = null;
	    
		for(int i=0; i<pJsonArrayWorkers.length(); i++){
			JSONObject obj = pJsonArrayWorkers.getJSONObject(i);
		    sWorkerIdDel = sWorkerIdDel + " " + obj.getString("id") + ",";			
		}
		
		if(sWorkerIdDel.length() >=1) {
			//System.out.println("sWorkerId: " + sWorkerIdDel.substring(0, sWorkerIdDel.length()-1));
		try {	 
		  
	         Statement stmt = connDel.createStatement();
	         
	         sSqlDel = "DELETE FROM job_details " + 
	        		   " WHERE job_id = " + Integer.parseInt(pJobId) + 
	        		   "   AND worker_id NOT IN ( " + sWorkerIdDel.substring(0, sWorkerIdDel.length()-1) + ")";
	         
	         // System.out.println("delete:" + sSqlDel);
	         stmt.executeUpdate(sSqlDel);
	         
	         //stmt.close();	         
        
		}catch(SQLException error){
		      System.out.println("Error: " + error.getMessage());
		}catch (Exception e){       
            System.out.println(e);
	    } finally {
	            if (null != rsDel) {
	              try { rsDel.close();} catch(Exception ex) {};
	            }
	            if (null != connDel) {
	              try { connDel.close();} catch(Exception ex) {};
	            }
	         }
		}
	}
	
	private static boolean isJobDetailNew(int pJobId, String pWorkerId) throws ClassNotFoundException, SQLException {
		boolean isJobDetailNew = true;
		
	    ConnectionDB db = new ConnectionDB();
	    Connection conn = db.getConnection();
		
		Statement stmt = conn.createStatement();
	    ResultSet result = null;   
	    
	    String sSql = "SELECT job_id " + 
	    			  "  FROM job_details " + 
	    		      " WHERE job_id = " + pJobId + 
	    			  "   AND worker_id = " + Integer.parseInt(pWorkerId);
	    
	    result = stmt.executeQuery(sSql);
	    
	    if(result.next()){
	       isJobDetailNew = false;
	    }
	    
	    result.close();
	    conn.close();
	    
        return isJobDetailNew;		
	}

	private static void InsertJobDetail(int pJobId, String pWorkerId, String pStartTime, String pEndTime) throws ClassNotFoundException {
	
		 ConnectionDB db1 = new ConnectionDB();
		 Connection conn1 = db1.getConnection();	
		 
		 PreparedStatement prep1 = null;
		 String sSqlJDetail = "";
		  
		 try {
				 sSqlJDetail = " INSERT INTO job_details" + 
					  	       " 		(job_id," 	  + 
						 	   "  		 worker_id,"  + 
						 	   "  		 start_time," + 
						 	   "  		 end_time) "  + 
						 	   " VALUES (?, ?, ?, ?)"; 		 	  	
				  
				 prep1 = conn1.prepareStatement (sSqlJDetail, Statement.RETURN_GENERATED_KEYS);				 
				 prep1.setInt(1, pJobId);
				 prep1.setInt (2, Integer.parseInt(pWorkerId));	
				 prep1.setString (3, pStartTime);
				 prep1.setString (4, pEndTime);
				 
				 // System.out.println("After : " + prep1.toString());
				 
				 prep1.executeUpdate();      
			     prep1.close();	 
			 
			// conn.close();
		  }catch(SQLException error){
		      System.out.println("Error: " + error.getMessage());
		  }	       	 
	}	
		
	
/*	public static void InsertJobDetail(int pJobId, String pWorkersInformation) throws ClassNotFoundException {
		
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();		 
		 
		 try {
			 if (conn != null) { 
		    	  Statement stmt = conn.createStatement();
		    	  String sSqlJob = "INSERT INTO job_details" + 
		    			  	       " (job_id," + 
							 	   "  worker_id," + 
							 	   "  start_time," + 
							 	   "  end_time) VALUES (" + 
							 	   pJobId + ", " +
							 	   pWorkersInformation + ")" ;		 
									
		 		 stmt.executeUpdate(sSqlJob);		   	  
		  		// System.out.println("sSqlJob: " + sSqlJob);	 
		 	     stmt.close();
			 }
			// conn.close();
       }catch(SQLException error) {
           System.out.println("Error: " + error.getMessage());
       }	       	 
	}		
*/	
	public List<Job> list(String pSearJob) throws Exception {
		
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();
		 
	     ResultSet rs = null;
	     String sSql = "";
	     
	     List<Job> result = new ArrayList<Job>();
	     
	     try
		       {	  
			     Statement stmt = conn.createStatement();
			     
			     if (pSearJob == "") {
				 	 sSql = "SELECT a.id, a.customer_id, b.first_name, " + 
				 			" 		b.last_name, b.address, b.phone_one, a.date " + 
				 		    "  FROM job a" + 
				 			"  LEFT JOIN customer b ON a.customer_id = b.id " + 
				 			"  WHERE a.date > DATE_ADD(NOW(), INTERVAL -7 DAY) " +
				 		    " ORDER BY a.id DESC";	
			     }else {
				 	 sSql = "SELECT a.id, a.customer_id, " + 
				 			" 		b.first_name, b.last_name, " + 
				 		    "		b.address, b.phone_one, a.date " + 
				 		    "  FROM job a" + 
				 			"  LEFT JOIN customer b ON a.customer_id = b.id" + 
			 	 			" WHERE (a.id LIKE '%" + pSearJob + "%'" + " OR " + 
			 	 		    " 		 a.customer_id LIKE '%" + pSearJob + "%'" + " OR " +
			 	 			"        b.first_name  LIKE '%" + pSearJob + "%'" + " OR " +
			 	 			" 		 b.last_name   LIKE '%" + pSearJob + "%'" + " OR " + 
			 	 			" 		 b.address     LIKE '%" + pSearJob + "%'" + " OR " + 
			 	 			" 		 b.phone_one   LIKE '%" + pSearJob + "%'" + " OR " + 
			 	 			" 		 b.phone_two   LIKE '%" + pSearJob + "%'" + " OR " + 
			 	 			" 		 b.email       LIKE '%" + pSearJob + "%'" + ")";
			     }  
			     // System.out.println("jobDao list: " + sSql);
		         rs = stmt.executeQuery(sSql);
		         
		         while (rs.next()) {
		        	 Job theJob = new Job();
		        	 theJob.setId(rs.getInt("a.id"));
		        	 theJob.setCustomer_id(rs.getInt("a.customer_id"));
		        	 theJob.setCustomerName(rs.getString("b.first_name") + ", " + rs.getString("b.last_name"));
		        	 theJob.setCustAddress(rs.getString("b.address"));
		        	 theJob.setCustPhoneOne(rs.getString("b.phone_one"));
		        	 theJob.setDate(rs.getString("a.date"));
	
		        	 result.add(theJob);
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
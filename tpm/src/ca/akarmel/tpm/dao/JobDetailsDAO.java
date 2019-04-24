package ca.akarmel.tpm.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import ca.akarmel.tpm.dbconection.ConnectionDB;
import ca.akarmel.tpm.entities.JobDetails;
import ca.akarmel.tpm.entities.Worker;

public class JobDetailsDAO {
	
	public List<JobDetails> WorkerListByJobId(String JobId, String pInactive) throws Exception {
		
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();
		 
	     ResultSet rs = null;
	     
	     String sSql = "";
	     String sInactive = " AND inactive = 'N' "; 
	     
	     List<JobDetails> result = new ArrayList<JobDetails>();
	     
	   //  System.out.println("pInactive: " + pInactive);
	     
	     if (pInactive.equals("on")) {
	    	 sInactive = " AND (b.inactive = 'Y' OR b.inactive = 'N') ";	    
	     }
	     
	     try
	       {	  
	         Statement stmt = conn.createStatement();
	         
	         sSql = "SELECT a.id, b.first_name, b.last_name" + 	         	
	        		"  FROM job_details a" +
	 	 			"  LEFT JOIN worker b ON a.worker_id = b.id" + 
	 	 			" WHERE a.job_id = " + Integer.parseInt(JobId) + " " + 	 			
	 	 			sInactive;
	         
	         // System.out.println(sSql);
	         rs = stmt.executeQuery(sSql);
	         
	         while (rs.next()) {
	        	 JobDetails theJobDetails = new JobDetails();
	        	 
	        	 theJobDetails.setId(rs.getInt("a.id"));
	        	 theJobDetails.setWorkerName(rs.getString("b.first_name") + ", "+ rs.getString("b.last_name"));	        	
	        	 result.add(theJobDetails);
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

	public List<JobDetails> ParametersReportByWorker(String StartDate, String EndDate) throws Exception {
		
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();
		 
	     ResultSet rs = null;
	     
	     String sSql = "";
	     
	     List<JobDetails> result = new ArrayList<JobDetails>();    	  
	     
	     try
	       {	  
	         Statement stmt = conn.createStatement();
	        
	         sSql = "SELECT distinct c.id, c.first_name, c.last_name" + 	         	
	        		"  FROM job a" +
	 	 			"  LEFT JOIN job_details b ON a.id = b.job_id" +
	        		"  LEFT JOIN worker c on b.worker_id = c.id" + 
	         		" WHERE a.date BETWEEN " + "'" + StartDate + "'" + " AND " + "'" + EndDate + "'"; 
		      	
	         // System.out.println("ParametersReportByWorker:" + sSql);
	         rs = stmt.executeQuery(sSql);
	         
	         while (rs.next()) {
	        	 JobDetails theJobDetails = new JobDetails();
	        	 
	        	 theJobDetails.setId(rs.getInt("c.id"));
	        	 theJobDetails.setWorkerName(rs.getString("c.first_name") + ", "+ rs.getString("c.last_name"));	        	
	  	        	 
	        	 result.add(theJobDetails);
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
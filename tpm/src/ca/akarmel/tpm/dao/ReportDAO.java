package ca.akarmel.tpm.dao;


import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JFrame;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

import ca.akarmel.tpm.dbconection.ConnectionDB;
import ca.akarmel.tpm.entities.Customer;
import ca.akarmel.utilities.Utilities;
import ca.akarmel.utilities.lecteurPDF;

public class ReportDAO {
	
	public List<Customer> ReportOne(String pStartDate, String pEndDate, String pCategory) throws Exception {
		
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();
		 
	     ResultSet rs = null;
	     
	     String sSql = "";
	          
	     List<Customer> result = new ArrayList<Customer>();
	     
	     try
	       {	  
		      Statement stmt = conn.createStatement();
			     sSql = " SELECT a.id AS jobId, a.date AS jobDate," +   
				    		"		 d.id AS workerId, " +	
				    		"		 CONCAT(d.first_name, ', ', d.last_name) AS workerName," +
				    		"	  	 d.email, " +
				    		"		 CONCAT(c.first_name , ', ', c.last_name ) AS customerName, " + 	             
				    		"		 TIME_FORMAT(b.start_time, '%H:%i') AS start_time, " + 	    
				    		"		 TIME_FORMAT(b.end_time, '%H:%i') AS end_time, d.hour_rate, " + 		
				    		"		 TIME_FORMAT(TIMEDIFF(b.end_time, b.start_time), '%H:%i') AS TimeDiff " +  
				    		"		 FROM job a " + 
				    		"		 LEFT JOIN job_details b ON a.id = b.job_id " + 
				    		"		 LEFT JOIN customer c ON a.customer_id = c.id " +  
				    		"		 LEFT JOIN worker d on b.worker_id = d.id " +
				    		"  WHERE a.date BETWEEN " + "'" + pStartDate + "'" + " AND " + "'" + pEndDate + "' " + 
				    		"  ORDER BY workerId, jobDate";
		      
			     //   System.out.println("ReportDAO.ReportOne:" + sSql);
		         rs = stmt.executeQuery(sSql);
		         
		         while (rs.next()) {
		        	 Customer theCustomer = new Customer();
		        	 
		        	 theCustomer.setId(rs.getInt("workerId"));
		        	 theCustomer.setFirstName(rs.getString("workerName"));
		        	
		        	 result.add(theCustomer);
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

	public List<Customer> ReportHoursByWorker(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException{
		 
		 String dStartDate = request.getParameter("StartDate");
		 String dEndDate = request.getParameter("EndDate");
		 				
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();
		 
	     ResultSet rs = null;	     
	     String sSql = "";
	          
	     List<Customer> result = new ArrayList<Customer>();
	     
	     try
	       {	  
		      Statement stmt = conn.createStatement();
			     sSql = " SELECT a.id AS jobId, a.date AS jobDate," +   
				    		"		 d.id AS workerId, " +	
				    		"		 CONCAT(d.first_name, ', ', d.last_name) AS workerName," +
				    		"	  	 d.email, " +
				    		"		 CONCAT(c.first_name , ', ', c.last_name ) AS customerName, " + 	             
				    		"		 TIME_FORMAT(b.start_time, '%H:%i') AS start_time, " + 	    
				    		"		 TIME_FORMAT(b.end_time, '%H:%i') AS end_time, d.hour_rate, " + 		
				    		"		 TIME_FORMAT(TIMEDIFF(b.end_time, b.start_time), '%H:%i') AS TimeDiff " +  
				    		"		 FROM job a " + 
				    		"		 LEFT JOIN job_details b ON a.id = b.job_id " + 
				    		"		 LEFT JOIN customer c ON a.customer_id = c.id " +  
				    		"		 LEFT JOIN worker d on b.worker_id = d.id " +
				    		"  WHERE a.date BETWEEN " + "'" + dStartDate + "'" + " AND " + "'" + dEndDate + "' " + 
				    		"  ORDER BY workerId, jobDate";
		      
			     //   System.out.println("ReportDAO.ReportOne:" + sSql);
		         rs = stmt.executeQuery(sSql);
		         
		         while (rs.next()) {
		        	 Customer theCustomer = new Customer();
		        	 
		        	 theCustomer.setId(rs.getInt("workerId"));
		        	 theCustomer.setFirstName(rs.getString("workerName"));
		        	
		        	 result.add(theCustomer);
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
	
	
	public void pdfTest1() throws Exception {
		PDDocument doc = new PDDocument();
		
        try{
            
      //  PDFManager pdf = new PDFManager();
        	//  System.out.println("Create Simple PDF file with Text");
        String fileName = "www.akarmel.ca/tpm/example.pdf"; // name of our file        
        
        PDPage page = new PDPage();
        PDFont font = PDType1Font.HELVETICA_BOLD;

        doc.addPage(page);

        PDPageContentStream content = new PDPageContentStream(doc, page);
        
        content.beginText();
        content.setFont(font, 12);
        content.newLineAtOffset(220, 750);
        content.showText("Registration Form");
        content.endText();       
        
        content.beginText();
        content.setFont(font, 12);
        content.newLineAtOffset(80, 700);
        content.showText("hola");
        content.endText();        
        
        content.beginText();
        content.setFont(font, 16);
        content.newLineAtOffset(80,650);
        content.showText("Father Name : ");
        content.endText();
        
        content.beginText();
        content.newLineAtOffset(80,600);
        content.showText("DOB ss: ");
        content.endText();        
        
        content.close();
        doc.save(fileName);      
 
        }
        catch(IOException e){
        
        	System.out.println(e.getMessage());
        
        }
        finally
        {
           if( doc != null )
           {
              doc.close();
              // System.out.println("cloese");
           }
        }
	}	
}
package ca.akarmel.tpm.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

import ca.akarmel.tpm.dao.ReportDAO;
import ca.akarmel.tpm.dao.WorkerDAO;
import ca.akarmel.tpm.dbconection.ConnectionDB;
import ca.akarmel.utilities.Utilities;

@WebServlet("/Reports")
public class Reports extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public Reports() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		 String sAction = request.getParameter("Action");
		 // System.out.println("sAction: " + sAction);
		 
		 switch (sAction) {
	        case "HoursByCustomer":	        	  
				try {
					ReportHoursByCustomer(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
		        break;
	        case "HoursByWorker":	
				try {	
					ReportDAO report = new ReportDAO();
						
					request.setAttribute("theReportOne", report.ReportHoursByWorker(request, response)); 
					Utilities.redispatcher(request, response, "/reports.jsp", this);	
					
				} catch (Exception e) {
					e.printStackTrace();
				}
	        	//System.out.println("HoursByWorker");
	        	break;
	        case "RunHoursByWorker":
	        	request.setAttribute("ReportId", "HoursByWorkers");
			    Utilities.redispatcher(request, response, "/results.jsp", this);				
	        	break;

	        case "RunHoursByCustomer":
	        	request.setAttribute("ReportId", "HoursByCustomerId");
			    Utilities.redispatcher(request, response, "/results.jsp", this);				
	        	break;	        	
	        case "SendEmail":
				try {
					pdf(request);
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	
	        	Utilities.redispatcher(request, response, "/reports.jsp", this);
	        	break;
	        default:
	        	System.out.println("Nada");
	    }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doGet(request, response);
	}

	private void pdf(HttpServletRequest request) throws ClassNotFoundException, IOException, SQLException {
		
		ConnectionDB db = new ConnectionDB();			
		Connection conn = db.getConnection();
		ResultSet rs = null;
		
	    String sWorkerId = request.getParameter("wId");	
	    
	    String sWorkerName = WorkerDAO.getWorkerName(sWorkerId);
	    String sStart = request.getParameter("startD");
	    String sEnd = request.getParameter("endD");
	    float TotalAmountByWorker = 0;
	    
	    String sSql = "";
	    
	    String filename = "adrian3.pdf";
	    PDDocument doc = new PDDocument();
	    
	    try
	       {	
	    		PDPage page = new PDPage();
                doc.addPage(page);
                PDFont font = PDType1Font.HELVETICA_BOLD;

	            PDPageContentStream contents = new PDPageContentStream(doc, page);
	            contents.beginText();
	            contents.setFont(font, 12);
	            contents.newLineAtOffset(100, 700);             
	    	
	            Statement stmt = conn.createStatement();	         
		
			    sSql = " SELECT a.id AS jobId, a.date AS jobDate," +   
			    	   "        d.id AS workerId, " +				    	
			    	   "	    d.email AS Email, " +
			    	   "  		CONCAT(c.first_name , ', ', c.last_name ) AS customerName, " + 	             
		    	 	   " 		CONCAT(TIME_FORMAT(b.start_time, '%H:%i') , '-' , " +	    
		    		   "		TIME_FORMAT(b.end_time, '%H:%i')) AS time, "  + 
		    		   " 		d.hour_rate AS HourRate, " + 		
		    		   "		TIME_FORMAT(TIMEDIFF(b.end_time, b.start_time), '%H:%i') AS TimeDiff, " +
		    		   "		HOUR(TIMEDIFF(b.end_time,b.start_time)) as hour, " + 
		    		   "		Minute(TIMEDIFF(b.end_time,b.start_time)) as minutes " + 
		    		   "   FROM job a " + 
		    		   "   LEFT JOIN job_details b ON a.id = b.job_id " + 
		     		   "   LEFT JOIN customer c ON a.customer_id = c.id " +  
		    		   "   LEFT JOIN worker d on b.worker_id = d.id " +
		    		   "  WHERE a.date BETWEEN " + "'" + sStart + "'" + " AND " + "'" + sEnd + "' " + 
		    		   "    AND d.id = " + Integer.parseInt(sWorkerId) +		    		
		    		   "  ORDER BY workerId, jobDate";
	    
			    // System.out.println("Reports.java pdf - sSql: " + sSql);
		     	
		     	rs = stmt.executeQuery(sSql);
		     	contents.showText("Worker Name: " + sWorkerName);
		     	contents.newLineAtOffset(0, -15);
		     	
		     	contents.setFont(font, 10);
		     	
		     	while(rs.next()){	
		     		Utilities getAmount = new Utilities();
	 				String Amount = getAmount.getTotalHourAmount(rs.getInt("hour"), rs.getInt("minutes"), rs.getFloat("HourRate"));
	 				TotalAmountByWorker = TotalAmountByWorker + Float.parseFloat(Amount); 	 				 
		     		
		     		contents.showText("(" + rs.getString("jobDate") + ") " + rs.getString("customerName") + ":  " + rs.getString("time") + "   " + rs.getString("TimeDiff") + "   $" + Amount);
		     		contents.newLineAtOffset(0, -15);		     		
		     	}	
		     	
		     	contents.endText();
		        contents.close();
		            
		        doc.save(filename);
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
	          doc.close(); 
	      }
	}
	
	private void ReportHoursByCustomer(HttpServletRequest request, HttpServletResponse response) throws Exception {
		 
		 String dStartDate = request.getParameter("StartDate");
		 String dEndDate = request.getParameter("EndDate");
		 String sCategory = request.getParameter("Category");
		
		 ReportDAO ReportOne = new ReportDAO();		 
		 request.setAttribute("theReportOne", ReportOne.ReportOne(dStartDate, dEndDate,sCategory)); 
		 Utilities.redispatcher(request, response, "/reports.jsp", this);
	}		
}	
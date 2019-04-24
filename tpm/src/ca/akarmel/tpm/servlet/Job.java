package ca.akarmel.tpm.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONString;

import ca.akarmel.tpm.dao.JobDAO;
import ca.akarmel.tpm.dbconection.ConnectionDB;
import ca.akarmel.utilities.Utilities;


/**
 * Servlet implementation class job
 */
@WebServlet("/Job")
public class Job extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Job() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String sAction = request.getParameter("Action");
	    String sJobId = request.getParameter("JobId");	
	    String sCustomerName = request.getParameter("CustomerName");
		
		if (sAction.equals("Save")){
			if (sJobId == "") {
				// System.out.println("uno");
				try {
					JobDAO.InsertJob(request,response);	
					
					request.setAttribute("Msg", "The Job for the Customer: " + sCustomerName + " has been saved");
					Utilities.redispatcher(request, response, "/job.jsp", this);	
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				} catch (SQLException e) {
					e.printStackTrace();
				} catch (JSONException e) {
					e.printStackTrace();
				}					
			}else {
				try {
					
					JobDAO.UpdateJob(request, response);
					
					request.setAttribute("Msg", "The Job for the Customer: " + sCustomerName + " has been saved"); 
				    Utilities.redispatcher(request, response, "/job.jsp", this);
					
				} catch (ClassNotFoundException | SQLException | JSONException e) {
					e.printStackTrace();
				}			
			}
		} else if(sAction.equals("Edit")) {
			try {				
				getJob(request,response); 	
						
			} catch (Exception e) {
				e.printStackTrace();
			}			
		} else if(sAction.equals("Search")) { 			
			try {
				//SearchJobs(request,response);
				
				 String sSearchJob = request.getParameter("theSearchJob");
				 JobDAO jobDAO = new JobDAO();		 
				 
				 request.setAttribute("theJob", jobDAO.list(sSearchJob)); 			
		         
				 Utilities.redispatcher(request, response, "/index.jsp", this);   
				
			} catch (Exception e) {
				e.printStackTrace();
			}			
		} else if(sAction.equals("Delete")) {
			try {
				JobDAO.DeleteJob(sJobId);
				Utilities.redispatcher(request, response, "/index.jsp", this);
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}	
	
	private void getJob(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException {
		 
		String pJobId =  request.getParameter("JobId"); 	
		
		 ConnectionDB db = new ConnectionDB();		
		 Connection conn = db.getConnection();
		 
	     ResultSet rs = null;
	     String sSql = "";
  	 
	     try
	       {	  
	         Statement stmt = conn.createStatement();
	         
	         sSql = "SELECT a.id, a.customer_id, " + 
	        		" 		b.first_name, b.last_name, a.date, a.comments " + 
	         		"  FROM job a" +
	        		"  LEFT JOIN customer b ON a.customer_id = b.id" +  
	 	 			" WHERE a.id = " + pJobId;
	         
	         //  System.out.println(sSql);
	         rs = stmt.executeQuery(sSql);
	         
	         while (rs.next()) {
	        	 request.setAttribute("JobId", rs.getString("a.id"));
	        	 request.setAttribute("CustomerId", rs.getString("a.customer_id"));	 
	        	 request.setAttribute("CustomerName", rs.getString("b.first_name") + ", "+ rs.getString("b.last_name"));	 
	        	 request.setAttribute("JobDate", rs.getString("a.date"));
	        	 request.setAttribute("Comments", rs.getString("a.comments"));	       
	         }
	         Utilities.redispatcher(request, response, "/job.jsp", this);
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
	}
	
	private void SearchJobs(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		 String sSearchJob = request.getParameter("theSearchJob");
		 
		 JobDAO jobDAO = new JobDAO();		 
		 
		 request.setAttribute("theJob", jobDAO.list(sSearchJob)); 			
         
		 Utilities.redispatcher(request, response, "/index.jsp", this);  		 
	 }	
}
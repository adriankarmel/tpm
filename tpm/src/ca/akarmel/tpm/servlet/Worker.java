package ca.akarmel.tpm.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ca.akarmel.tpm.dao.WorkerDAO;
import ca.akarmel.tpm.dbconection.ConnectionDB;
import ca.akarmel.utilities.Utilities;

/**
 * Servlet implementation class Workers
 */
@WebServlet("/Worker")
public class Worker extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Worker() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	    response.setContentType("text/html");
	    PrintWriter out = response.getWriter();
	    
	    String sAction = request.getParameter("Action");
	    String sWorkerId = request.getParameter("WorkerId");
	    String sFirstName = request.getParameter("FirstName");
	    String sLastName = request.getParameter("LastName");
	
		if (sAction.equals("Save")){
			if (sWorkerId == "") {				
				try {
					WorkerDAO.NewWorker(request,response);
					request.setAttribute("theWorker", "");
					
					request.setAttribute("Msg", "The Worker " + sLastName + ", " + sFirstName + " has been saved"); 
					Utilities.redispatcher(request, response, "/worker.jsp", this);
				} catch (ClassNotFoundException e) {					
					e.printStackTrace();
				}					
			}else {
				try {
					WorkerDAO.UpdateWorker(request, response);
					
					request.setAttribute("Msg", "The Worker " + sLastName + ", " + sFirstName + " has been saved"); 
				    Utilities.redispatcher(request, response, "/worker.jsp", this);	
				} catch (ClassNotFoundException e) {					
					e.printStackTrace();
				}		
			}
		} else if(sAction.equals("Edit")) {
			try {				
				getWorker(request,response);
				
				Utilities.redispatcher(request, response, "/worker.jsp", this);	
						
			} catch (Exception e) {
				e.printStackTrace();
			}			
		} else if(sAction.equals("Search")) { 			
			try {
				SearchWorkers(request,response);
				
				//Utilities.redispatcher(request, response, "/workers.jsp", this);	
				
			} catch (Exception e) {
				e.printStackTrace();
			}			
		} else if(sAction.equals("Inactivate")) {
			try {
				WorkerDAO.InactivateWorker(sWorkerId);
				
				Utilities.redispatcher(request, response, "/workers.jsp", this);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}	
		}
	}
	
	private void getWorker(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		 String pWorkerId =  request.getParameter("WorkerId"); 	
		 ConnectionDB db = new ConnectionDB();
		
		 Connection conn = db.getConnection();
	     ResultSet rs = null;
	     String sSql = "";
   	 
	     try
	       {	  
	         Statement stmt = conn.createStatement();
	         
	         sSql = "SELECT id, first_name, last_name," + 
	         		"       email, phone, hour_rate, category, " +  
	        		" 	    comments, inactive, create_dt " +
	 	 			"  FROM worker" + 
	 	 			" WHERE id = " + pWorkerId;
	         
	         //   System.out.println(sSql);
	         rs = stmt.executeQuery(sSql);
	         
	          while (rs.next()) {
	        	 request.setAttribute("WorkerId", rs.getString("id"));
	        	 request.setAttribute("FirstName", rs.getString("first_name"));	        	 
	        	 request.setAttribute("LastName", rs.getString("last_name"));
	        	 request.setAttribute("Email", rs.getString("email"));
	        	 request.setAttribute("Phone", rs.getString("phone"));
	        	 request.setAttribute("HourRate", rs.getString("hour_rate"));
	        	 request.setAttribute("Category", rs.getString("category"));
	        	 request.setAttribute("Comments", rs.getString("comments"));
	        	 request.setAttribute("Inactive", rs.getString("inactive"));
    			 request.setAttribute("CreateDt",rs.getString("create_dt"));    			 
	         }
	         
	         Utilities.redispatcher(request, response, "/worker.jsp", this);
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
 
  private void SearchWorkers(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
	 String sSearchWorker = request.getParameter("theSearch");
	 String sInactive = request.getParameter("Inactive");		 	 
	 
	 if (sInactive == null) {
		 sInactive = "N";
	 }
	 
	 WorkerDAO WorkerDAO = new WorkerDAO();		 
	 
	 request.setAttribute("theWorker", WorkerDAO.list(sSearchWorker, sInactive)); 
	 Utilities.redispatcher(request, response, "/workers.jsp", this);  	 
  }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
package ca.akarmel.tpm.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ca.akarmel.tpm.dao.CustomerDAO;
import ca.akarmel.tpm.dbconection.ConnectionDB;
import ca.akarmel.utilities.Utilities;

/**
 * Servlet implementation class Customer
 */
@WebServlet("/Customer")
public class Customer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Customer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());

		String sAction = request.getParameter("Action");
	    String sCustomerId = request.getParameter("CustomerId");
	    String sFirstName = request.getParameter("FirstName");
	    String sLastName = request.getParameter("LastName");
		
		if (sAction.equals("Save")){
			if (sCustomerId == "") {
				//System.out.println("uno");
				try {
					CustomerDAO.NewCustomer(request,response);					
					request.setAttribute("theCustomer", "");

					request.setAttribute("Msg", "The Customer " + sLastName + ", " + sFirstName + " has been saved"); 
					Utilities.redispatcher(request, response, "/customer.jsp", this);					
				} catch (ClassNotFoundException e) {					
					e.printStackTrace();
				}		
			}else{
				try {
					CustomerDAO.UpdateCustomer(request,response);					

					request.setAttribute("Msg", "The Customer " + sLastName + ", " + sFirstName + " has been saved");
					Utilities.redispatcher(request, response, "/customer.jsp", this);
					
				} catch (ClassNotFoundException e) {					
					e.printStackTrace();
				}				
			}
		} else if(sAction.equals("Edit")) {
			try {				
				getCustomer(request,response);		
				Utilities.redispatcher(request, response, "/customer.jsp", this);
			    
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(sAction.equals("Search")) { 			
			try {
				SearchCustomers(request,response);
					
			} catch (Exception e) {
				e.printStackTrace();
			}			
		} else if(sAction.equals("Inactivate")) {
			try {
				CustomerDAO.InactivateCustomer(sCustomerId);
				
				Utilities.redispatcher(request, response, "/customers.jsp", this);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}	
		}
}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	 private void SearchCustomers(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		 String sSearchCustomer = request.getParameter("theSearch");
		 String sInactive = request.getParameter("Inactive");
		 
		 if (sInactive == null) {
			 sInactive = "N";
		 }
		 
		 CustomerDAO CustDAO = new CustomerDAO();
		 request.setAttribute("theCustomer", CustDAO.list(sSearchCustomer, sInactive)); 
		 Utilities.redispatcher(request, response, "/customers.jsp", this);
	 }
	
	 private void getCustomer(HttpServletRequest request, HttpServletResponse response) throws Exception {	
						  	
			 ConnectionDB db = new ConnectionDB();			
			 Connection conn = db.getConnection();
			 
			 String pCustomerId = request.getParameter("CustomerId");
		     ResultSet rs = null;
		     String sSql = "";	     	   	     
	   	 
		     try
		       {	  
		         Statement stmt = conn.createStatement();
		         
		         sSql = "SELECT id, first_name, last_name," + 
		         		"    	address, country_id, province_id, postal_code, " +
		         		"    	address_new, country_id_new, province_id_new, postal_code_new, " +
		         		"		phone_one, phone_two," + 
		         		"       email, comments, inactive, create_dt" +
		 	 			"  FROM customer" + 
		 	 			" WHERE id = " + pCustomerId;
		         
		         //    System.out.println(sSql);
		         rs = stmt.executeQuery(sSql);
		         
		         while (rs.next()) {
		        	 request.setAttribute("CustomerId", rs.getString("id"));
		        	 request.setAttribute("FirstName", rs.getString("first_name"));	        	 
		        	 request.setAttribute("LastName", rs.getString("last_name"));
		        	 request.setAttribute("Address", rs.getString("address"));
		        	 request.setAttribute("CountryId", rs.getString("country_id"));
		        	 request.setAttribute("ProvinceId", rs.getString("province_id"));
		        	 request.setAttribute("PostalCode", rs.getString("postal_code"));
		        	 request.setAttribute("AddressNew", rs.getString("address_new"));
		        	 request.setAttribute("CountryIdNew", rs.getString("country_id_new"));
		        	 request.setAttribute("ProvinceIdNew", rs.getString("province_id_new"));
		        	 request.setAttribute("PostalCodeNew", rs.getString("postal_code_new"));
		        	 
		        	 request.setAttribute("PhoneOne", rs.getString("phone_one"));
		        	 request.setAttribute("PhoneTwo", rs.getString("phone_two"));
		        	 request.setAttribute("Email", rs.getString("email"));
		        	 request.setAttribute("Comments", rs.getString("comments"));
		        	 request.setAttribute("Inactive", rs.getString("inactive"));
	    			 request.setAttribute("CreateDt",rs.getString("create_dt"));
		         }
		        // Utilities.redispatcher(request, response, "/customer.jsp", this);
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
}
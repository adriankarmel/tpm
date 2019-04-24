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
import ca.akarmel.tpm.entities.Customer;

public class CustomerDAO {
	
	public List<Customer> list(String pSearCustomer, String pInactive) throws Exception {
		
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();
		 
	     ResultSet rs = null;
	     
	     String sSql = "";
	     String sInactive = " AND inactive = 'N' ";
	     
	     List<Customer> result = new ArrayList<Customer>();
	     
	    // System.out.println("pInactive: " + pInactive);
	     
	     if (pInactive.equals("on")) {
	    	 sInactive = " AND (inactive = 'Y' OR inactive = 'N') ";
	     }	     
	     
	     try
	       {	  
		      Statement stmt = conn.createStatement();
		         
	          sSql = "SELECT id, first_name, last_name, " + 
	         		 " 		 address, email, phone_one, inactive " +
	 	 			 "  FROM customer" + 
	 	 			 " WHERE (first_name LIKE '%" + pSearCustomer + "%'" + " OR " + 
	 	 		     " 		 last_name   LIKE '%" + pSearCustomer + "%'" + " OR " +
	 	 			 "       email  	 LIKE '%" + pSearCustomer + "%'" + " OR " +
	 	 			 " 		 phone_one   LIKE '%" + pSearCustomer + "%'" + ")"    +
		 	 		 sInactive;
		         
		     // System.out.println("customerDAO List: " + sSql);
		      rs = stmt.executeQuery(sSql);
		         
		      while (rs.next()) {
	        	 Customer theCustomer = new Customer();
	        	 
	        	 theCustomer.setId(rs.getInt("id"));
	        	 theCustomer.setFirstName(rs.getString("first_name"));
	        	 theCustomer.setLastName(rs.getString("last_name"));
	        	 theCustomer.setAddress(rs.getString("address"));		        	 
	        	 theCustomer.setPhoneOne(rs.getString("phone_one"));
	        	 theCustomer.setEmail(rs.getString("email"));
	        	 theCustomer.setInactive(rs.getString("inactive"));

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
	
	public static void NewCustomer(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException {

		String sFirstName = request.getParameter("FirstName");
		String sLastName = request.getParameter("LastName");
		String sAddress = request.getParameter("Address");
		String sCountryId = request.getParameter("CountryId");
		String sProvinceId = request.getParameter("ProvinceId");
		String sPostalCode = request.getParameter("PostalCode");
		
		String sAddressNew = request.getParameter("AddressNew");
		String sCountryIdNew = request.getParameter("CountryIdNew");
		String sProvinceIdNew = request.getParameter("ProvinceIdNew");
		String sPostalCodeNew = request.getParameter("PostalCodeNew");
		
		String sPhoneOne = request.getParameter("PhoneOne");
		String sPhoneTwo = request.getParameter("PhoneTwo");
		String sEmail = request.getParameter("Email");
		String sInactive = request.getParameter("Inactive");
		
		String sComments = request.getParameter("Comments");
		
		ConnectionDB db = new ConnectionDB();
		Connection conn = db.getConnection();		 
		 
		PreparedStatement prep = null;
	
		String sSql = "";		
		 
		 try {
			 
			 if(conn != null) {	
				 
				 sSql = "INSERT INTO customer" + 
				 		   " (first_name,"  + 					 		 
				 		   "  last_name, "  +
				 		   "  address, "    + 
				 		   "  country_id,"  + 
				 		   "  province_id," + 
				 		   "  postal_code," + 
				 		   "  address_new, "    + 
				 		   "  country_id_new,"  + 
				 		   "  province_id_new," + 
				 		   "  postal_code_new," + 
				 		   "  phone_one, "  +
				 		   "  phone_two, "  +
				 		   "  email, " 		+
				 		   "  comments, "   +
				 		   "  inactive) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";			
 
				 prep = conn.prepareStatement (sSql);				 
				 
				 prep.setString (1, sFirstName);
				 prep.setString (2, sLastName);
				 prep.setString (3, sAddress);				 
				 prep.setInt (4, Integer.parseInt(sCountryId));
				 prep.setInt (5, Integer.parseInt(sProvinceId));
				 prep.setString (6, sPostalCode);
				 prep.setString (7, sAddressNew);				 
				 prep.setInt (8, Integer.parseInt(sCountryIdNew));
				 prep.setInt (9, Integer.parseInt(sProvinceIdNew));
				 prep.setString (10, sPostalCodeNew);
				 prep.setString (11, sPhoneOne);
				 prep.setString (12, sPhoneTwo);
				 prep.setString (13, sEmail);
				 prep.setString (14, sComments);
				 prep.setString (15, sInactive);			 
				 
				 prep.executeUpdate();
				 
				// System.out.println("After : " + prep.toString());
				 
			     prep.close();
			 }		 
			
      }catch(SQLException error){
          System.out.println("Error: " + error.getMessage());
      }	       	 
	}
	
	public static void InactivateCustomer(String pCustomerId) throws ClassNotFoundException {
		 
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();		 
		
		 PreparedStatement prep = null;
		 
		 String sInactive = "Y";
		 String sSql = "";		
		 
		 try {
			 
			 if(conn != null) {	
				 
				 sSql = "UPDATE customer " + 
			 		    "   SET inactive = ? "	 + 
			 		    " WHERE id = ?";			

				 prep = conn.prepareStatement (sSql);	
			
				 prep.setString (1, sInactive);
				 prep.setString (2, pCustomerId);				 
				 
				 prep.executeUpdate();
				 
			     prep.close();
			 }		 
			
	     }catch(SQLException error){
	         System.out.println("Error: " + error.getMessage());
	     }			
	}
	
	public static void UpdateCustomer(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException {
		
		 String sCustomerId = request.getParameter("CustomerId");

		 String sFirstName = request.getParameter("FirstName");
		 String sLastName = request.getParameter("LastName");
		 String sAddress = request.getParameter("Address");
		 String sCountryId = request.getParameter("CountryId");
		 String sProvinceId = request.getParameter("ProvinceId");
		 String sPostalCode = request.getParameter("PostalCode");
		 
		 String sAddressNew = request.getParameter("AddressNew");
		 String sCountryIdNew = request.getParameter("CountryIdNew");
		 String sProvinceIdNew = request.getParameter("ProvinceIdNew");
		 String sPostalCodeNew = request.getParameter("PostalCodeNew");
		 
		 String sPhoneOne = request.getParameter("PhoneOne");
		 String sPhoneTwo = request.getParameter("PhoneTwo");
		 String sEmail = request.getParameter("Email");
		 String sComments = request.getParameter("Comments");
		 String sInactive = request.getParameter("Inactive");
		
		 ConnectionDB db = new ConnectionDB();
		 Connection conn = db.getConnection();		 
		 PreparedStatement prep = null;
	
		 String sSql = "";		
		 
		 try {
			 
			 if(conn != null) {	
				 
				 sSql = "UPDATE customer " + 
			 		    "   SET first_name = ?,"  + 					 		 
			 		    "       last_name = ?, "  +
			 		    " 	    address = ?," 	  +
			 		    "  		country_id = ?,"  + 
			 		    " 	    province_id = ?," + 
			 		    "  		postal_code = ?," + 
			 		    " 	    address_new = ?," 	  +
			 		    "  		country_id_new = ?,"  + 
			 		    " 	    province_id_new = ?," + 
			 		    "  		postal_code_new = ?," +  
			 		    "  		phone_one = ?, "  +
			 		    "  		phone_two = ?, "  +
			 		    "  		email = ?, " 	  +
			 		    "  		comments = ?, "   +
			 		    "	    inactive = ? " 	  +
			 		    " WHERE id = ?";			
 
				 prep = conn.prepareStatement (sSql);				 
				 
				 prep.setString(1, sFirstName);
				 prep.setString(2, sLastName);
				 prep.setString(3, sAddress);
				 prep.setInt(4, Integer.parseInt(sCountryId));
				 prep.setInt(5, Integer.parseInt(sProvinceId));
				 prep.setString(6, sPostalCode);				 
				 prep.setString(7, sAddressNew);
				 prep.setInt(8, Integer.parseInt(sCountryIdNew));
				 prep.setInt(9, Integer.parseInt(sProvinceIdNew));
				 prep.setString(10, sPostalCodeNew);				 
				 prep.setString(11, sPhoneOne);
				 prep.setString(12, sPhoneTwo);
				 prep.setString(13, sEmail);
				 prep.setString(14, sComments);				 
				 prep.setString(15, sInactive);
				 
				 prep.setInt(16, Integer.parseInt(sCustomerId));	
				 
				 prep.executeUpdate();
				 
				 // System.out.println("After : " + prep.toString());
				 
			     prep.close();
			 }		 
			
        }catch(SQLException error){
          System.out.println("Error: " + error.getMessage());
        }	
	}	
}
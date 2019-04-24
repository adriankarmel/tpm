<%@page 
	import = "java.io.*"	
	import = "java.sql.*"	
	import = "javax.servlet.*"
	import = "javax.servlet.jsp.*"
	import = "javax.servlet.http.*"
	import = "java.text.*"	
	import = "java.util.List"
    import = "java.util.ArrayList"
    import = "ca.akarmel.tpm.dbconection.ConnectionDB"
%>  
	
<% 
	ConnectionDB db = new ConnectionDB();
	Connection conn = db.getConnection();
	
	String sSql = "";  
	String SearCustomer = request.getParameter("SearCustomer") ;

	if (!SearCustomer.equals("")){
	if(conn != null) { 
		
	 	sSql =  "SELECT id, first_name, last_name " + 
	 			"  FROM customer" + 
	 			" WHERE (first_name LIKE '%" + SearCustomer + "%'" + " OR " + 
	 		    " 		last_name   LIKE '%" + SearCustomer + "%'" + " OR " +
	 			"       email  		LIKE '%" + SearCustomer + "%'" + " OR " +
	 			" 		phone_one   LIKE '%" + SearCustomer + "%'" + ") "   + 
	 			"   AND inactive = 'N' ";
	 	//System.out.println(sSql);
	 
	    Statement stmt = conn.createStatement();
	    ResultSet rsC  = stmt.executeQuery(sSql); 
	 
	    while (rsC.next()) { %>
			 <div class="row">
			 	<div class="custom-control custom-radio">
					<input type="radio" 
						   class="custom-control-input"
						   name="SearchCustomerId"
						   id="SearchCustomerId<%= rsC.getString("id") %>"
						   onclick="AsignaCustomer('<%= rsC.getString("id") %>','<%= rsC.getString("first_name") %>', '<%= rsC.getString("last_name")%>' );" 
						   value="<%= rsC.getString("id") %>"> 
					<label class="custom-control-label labelColorSmall" for="SearchCustomerId<%= rsC.getString("id") %>">
					  	 <%= rsC.getString("first_name") %>, <%= rsC.getString("last_name") %>
					</label>
				</div>				
			 </div>		
			 <hr>
<% 	   }	
		 
	   rsC.close();
	 }
	}
	 conn.close();
 %>	
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
    import = "ca.akarmel.tpm.dao.ConfigDAO"
    import = "ca.akarmel.tpm.dao.WorkerDAO"
 %>    
	
<% 
	 ConnectionDB db = new ConnectionDB();
	 Connection conn = db.getConnection();
	 String sSql = "";

	 if(conn != null) {
	 	 sSql =  " SELECT name FROM province " + 
	 			 "  WHERE name LIKE '%" + request.getParameter("q") + "%'" + 
	 			 "  LIMIT 10";				 
	 		
		 Statement stmt = conn.createStatement();
		 ResultSet rs  = stmt.executeQuery(sSql); 
	 
		 while (rs.next()) { %>
		 <%= rs.getString("name") %>
	     
	  <% }			    	
	  	rs.close();
	 } %> 

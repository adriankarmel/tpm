<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
			<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<meta http-equiv="x-ua-compatible" content="ie=edge">
			 
			<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
			<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
			<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
			  
			<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
			<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
			<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
			<%@page import="net.viralpatel.autocomplete.DummyDB"%>	 		
	</head>
	<body>
		<form name="jobs" action="jobs" method="get">
			<div class="container">
				<%@include file="menu.jsp"%>
			</div>
			<div class="container">
				<div class="row">
					<div class="col font-weight-bold labelAzul">Id</div>
					<div class="col font-weight-bold labelAzul">Customer</div>
					<div class="col font-weight-bold labelAzul">Date</div>
					<div class="col font-weight-bold labelAzul" style="display:table-cell; vertical-align:middle; text-align:center">Action</div>
				</div>		
				<% 
				 ConnectionDB db = new ConnectionDB();
				 Connection conn = db.getConnection();
				 String sSql = "";
				 
				 if(conn != null) {
				 	sSql =  "SELECT id, customer_id, date FROM job";				 
				 
					 Statement stmt = conn.createStatement();
					 ResultSet rs  = stmt.executeQuery(sSql); 
				 
					 while (rs.next()) { %>
						 <div class="row trt">
							 <div class="col"><a href="job.jsp?id=<%= rs.getString("id") %>"><%= rs.getString("id") %></a></div>
							 <div class="col"><%= rs.getString("customer_id") %></div>
							 <div class="col"><%= rs.getString("date") %></div>
					  		 <div class="col" style="display:table-cell; vertical-align:middle; text-align:center">
					  		 	<a href="">
									 <img border="0" src="../tpm/img/delete.png" width="20" height="20">									 
							    </a>	
							 </div>	
					  	 </div>	 			 		
				  <% }			    	
				 
	 			 	rs.close();
				 }
	 			 %>
		 	</div>	
		</form>
	</body>
</html>
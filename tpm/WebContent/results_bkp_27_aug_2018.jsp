<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page 
	import = "java.io.*"	
	import = "java.sql.*"	
	import = "javax.servlet.*"
	import = "javax.servlet.jsp.*"
	import = "javax.servlet.http.*"
  
    import = "ca.akarmel.tpm.dbconection.ConnectionDB"
    import = "ca.akarmel.tpm.dao.ConfigDAO" 
    import = "ca.akarmel.utilities.Utilities" 
 %> 
   
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
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
		
		<script type='text/javascript' src='../tpm/js/moment.min.js'></script>
		
		<% ConfigDAO cssStyle = new ConfigDAO();%>			
		<link rel="stylesheet" type="text/css" href="<%= cssStyle.getCSS()%>">			
		<script src="js/script.js" type="text/javascript"></script>
</head>
<body>
<br>
<% 
	String sReportId = (String)request.getAttribute("ReportId");

	ConnectionDB db = new ConnectionDB();
	Connection conn = db.getConnection();

	ResultSet rs = null;
	String sSql = "";	
	
	String pStartDate = request.getParameter("StartDate");
	String pEndDate = request.getParameter("EndDate");
	
%>

		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<p>Hours by Day and Worker</p>
				</div>	
				<div class="col-md-2">
					<h6 class="font-weight-bold"> Start Date</h6>
				</div>	
				<div class="col-md-10">	
					<h5 class="font-weight-normal"><%= pStartDate %></h5>
				</div>
			</div>		
			<div class="row">	
				<div class="col-md-2">	
					<h6 class="font-weight-bold">End Date</h6>
				</div>		
				<div class="col-md-10">		
					<h5 class="font-weight-normal"><%= pEndDate %></h5>
				</div>
			</div>			
			<hr>
		</div>	


<% if(sReportId.equals("HoursByCustomerId")){ %>
		
		<%	   	   	     
 
		try	{	  
	         Statement stmt = conn.createStatement();	
			
	         sSql = "SELECT a.id AS jobId, a.date AS jobDate, " + 
	         		" 		CONCAT(c.first_name , ', ', c.last_name ) AS customerName, " + 
				    "       CONCAT(d.first_name, ', ', d.last_name) AS workerName, " +
				    "       TIME_FORMAT(b.start_time, '%H:%i') AS start_time, " + 
				    "	    TIME_FORMAT(b.end_time, '%H:%i') AS end_time, d.hour_rate, " + 
				    "		TIME_FORMAT(TIMEDIFF(b.end_time, b.start_time), '%H:%i') AS TimeDiff " +
				    "  FROM job a " + 
				    "  LEFT JOIN job_details b ON a.id = b.job_id " + 
				    "  LEFT JOIN customer c ON a.customer_id = c.id " + 
				    "  LEFT JOIN worker d on b.worker_id = d.id " + 
				    " WHERE a.date BETWEEN " + "'" + pStartDate + "'" + " AND " + "'" + pEndDate + "'"; 
	         
	         System.out.println("getHoursByCustomer:" + sSql);
	    
	         rs = stmt.executeQuery(sSql); %>
	         
	         <div class="container">
	         <% while (rs.next()) {%>
	         	<div class="row">
	         		<div class="col-md-12">
	        			<h6>
	        			  (<%= rs.getString("jobId") %>)	        			
	        			   <%= rs.getString("customerName") %>
	        			 , <%= rs.getString("workerName") %>
	        			 , <%= rs.getString("start_time") %>
	        			 , <%= rs.getString("end_time") %>
	        			 , <%= rs.getString("TimeDiff") %>
	        			 </h6>
	        		</div>
	        	</div>         	
	         <%}
	         	rs.close();
				stmt.close();%>
	         </div>        
	      		
		<%
		} catch(IOException e) {
			System.out.println(e.getMessage());
		} finally {
		    conn.close();
		}
	} else if (sReportId.equals("HoursByWorkers")){	
	
		try	{	  
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
	 		 
	         System.out.println("getHoursByCustomer:" + sSql);
	 	    
	         rs = stmt.executeQuery(sSql); %>
	         
	         <div class="container">
	         <% while (rs.next()) {%>
	         		<div class="row trt">
	         			<div class="col-sm-3">
	        			  <%= rs.getString("workerName") %>
	        			</div> 	        			
	        			<div class="col-sm-2">
	        			 <%= rs.getString("customerName") %>
	        			</div>
	        			<div class="col-sm-2"> 
	        			  <%= rs.getString("start_time") %>
	        			</div>
	        			<div class="col-sm-2"> 
	        			  <%= rs.getString("end_time") %>
	        			</div>
	        			<div class="col-sm-2"> 
	        			  <%= rs.getString("TimeDiff") %>
	        			 </div>
	        		</div>
	        	        	
	         <%}
	           rs.close();
		  	   stmt.close();
		  	 %>
	         </div>        
	      		
		<%
		} catch(IOException e) {
			System.out.println(e.getMessage());
		} finally {
		    conn.close();
		} 
	}%>
	
 	<div align="center">				
		<button type="button" class="btn btn-outline-info" onclick="window.location.href='reports.jsp'">Go Back</button>						
	</div>	
</body>
</html>
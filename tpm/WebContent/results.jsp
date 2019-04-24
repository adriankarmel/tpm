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
		
		<link rel="stylesheet" href="css/style.css">			
		<script src="js/script.js" type="text/javascript"></script>
		
		<script>
			function SendEmailWorker(id){
				results.wId.value = id;
				results.Action.value = "SendEmail";					
				results.submit();
			}	
		</script>
		
		<style>
			.row {
			  margin-bottom: 0.5rem;
			}
			.row .row {
			  margin-top: 0.5rem;
			  margin-bottom: 0;
			}
			[class*="col-"] {
			  padding-top: 0.3rem;
			  padding-bottom: 0.3rem;
			  border: 1px solid rgba(86, 61, 124, .2);
			}				
		</style>
</head>
<body>
<br>
<% 
	String sReportId = (String)request.getAttribute("ReportId");

	ConnectionDB db = new ConnectionDB();
	Connection conn = db.getConnection();

	ResultSet rs = null;
	ResultSet rsWorker = null;
	String sSqlWorker = "";
	String sSql = "";	
	
	String sReportWorkersId = request.getParameter("reportWorkersId");	
	String pStartDate = request.getParameter("StartDate");
	String pEndDate = request.getParameter("EndDate");	
%>
	<form name="results" id="results" action="Reports" method="post">
		<button onclick="topFunction();return false;" id="myBtn" class="myBtn" title="Go to top">Top</button>
		<div class="container">
				<%@include file="menu.jsp"%>
		</div>	
		<div class="container">
			<div class="row">
				<div class="col labelColorOne">
					<h2><span>Report: Hours by Day and Worker</span></h2>					
				</div>	
			</div>	
		
			<div class="row">
				<div class="col-md-2">
					<h6 class="font-weight-bold"> Start Date: </h6>
				</div>	
				<div class="col-md-10">	
					<h5 class="font-weight-normal"><%= pStartDate %></h5>
				</div>
			</div>		
			<div class="row">	
				<div class="col-md-2">	
					<h6 class="font-weight-bold">End Date: </h6>
				</div>		
				<div class="col-md-10">		
					<h5 class="font-weight-normal"><%= pEndDate %></h5>
				</div>
			</div>			
			<hr>
		</div>	

<% if (sReportId.equals("HoursByWorkers")){	
	
		try	{	  
	         Statement stmt = conn.createStatement();
	         Statement stmt1 = conn.createStatement();
	         
	         sSqlWorker = "SELECT id, " + 
	        			  "		  CONCAT(first_name, ', ', last_name) AS workerName," +
	        			  "	  	  email AS Email " +
		       		   	  "  FROM worker " + 
		       		      " WHERE id IN (" + sReportWorkersId + ") ";	
	        			  
	         rsWorker = stmt.executeQuery(sSqlWorker);          	
	        // System.out.println("results.jsp : sSqlWorker: " + sSqlWorker);
	         String sbody = "<div class=\"container\">" +
		     			"<div class=\"row\">"; 
					
	            
	         while (rsWorker.next()){%>
	         <div class="container">
	        	<div class="row bg-secondary text-white"> 
		        	<div class="col-sm-12">			 		 
					  <a href="javascript:SendEmailWorker(<%= rsWorker.getString("id") %>);" >
						<img border="0" src="../tpm/img/email.png" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Email">
					  </a>
					 	
					 <%= rsWorker.getString("workerName") %>		 		 
					</div>
				</div>
			</div>		
	        	 <% float TotalAmountByWorker = 0; 
	        	 	sSql = " SELECT a.id AS jobId, a.date AS jobDate," +   
			    		   " 	    d.id AS workerId, " +	
			    		   "	    CONCAT(d.first_name, ', ', d.last_name) AS workerName," +
			    		   "	  	d.email AS Email, " +
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
			    		   "  WHERE a.date BETWEEN " + "'" + pStartDate + "'" + " AND " + "'" + pEndDate + "' " + 
			    		   "    AND d.id = " + rsWorker.getInt("id") +		    		
			    		   "  ORDER BY workerId, jobDate";
	        	//    System.out.println("results.jsp : sSql: " + sSql);
	        	    
		 			rs = stmt1.executeQuery(sSql); 
		 			
		 			while(rs.next()) { %>
			            <div class="container">
			            	<div class="row trt"> 
			            		<div class="col-sm-2">
			        				 <%= rs.getString("jobDate") %>
					        	</div>        			        			
			        			<div class="col-sm-4">
			        				 <%= rs.getString("customerName") %>
			        			</div>
			        			<div class="col-sm-2"> 
		        				    <%= rs.getString("time") %>
		        				</div>
		        				<div class="col-sm-2" style="color:#000099"> 
		        			 	    <strong><%= rs.getString("TimeDiff") %></strong>
		        			 	</div>
		        			 	<div class="col-sm-2" style="color:#7f0000"> 
		        			 			<%  Utilities getAmount = new Utilities();
		        			 				String Amount = getAmount.getTotalHourAmount(rs.getInt("hour"), rs.getInt("minutes"), rs.getFloat("HourRate"));
		        			 				TotalAmountByWorker = TotalAmountByWorker + Float.parseFloat(Amount); %>
		        			 			<strong>$<%= Amount %></strong>	
		        			 	</div>	
		        			</div>
	        		 	</div> 
	          <%  } %>
	          
	            <div class="container">
	            	<div class="row bg-success text-white">
	            		<div class="col-sm-10">
	            			<strong>
	            				Total
	            			</strong>	
	            		</div>
	            		<div class="col-sm-2">
	            		 	<strong>
	            		 	    $<%= String.format("%,.2f", TotalAmountByWorker) %>
	            		 	</strong>
	            		</div>
	            	</div>	
	            	<br>            	
	            </div>
	            
	          <% rs.close(); 	            
	         }
	         
	         rsWorker.close();
	         stmt.close();
	         stmt1.close();
		
			} catch(IOException e) {
				System.out.println(e.getMessage());
			} finally {
			    conn.close();
			} 
		}
	%>
		<br>
	 	<div align="center">				
			<button type="button" class="btn btn-outline-dark" onclick="window.location.href='reports.jsp'">Go Back</button>						
			<br>
		</div>	
		<%@include file = "./footer.jsp"%>	
		<input type="hidden" name="Action" value="">
		<input type="hidden" name="wId"	   value="">
				
		<input type="hidden" name="startD" value="<%= pStartDate%>">
		<input type="hidden" name="endD"   value="<%= pEndDate %>">		
	</form>
</body>
</html>
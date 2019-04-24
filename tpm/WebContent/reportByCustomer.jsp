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
		
		<script type="text/javascript">	
		  
			window.onscroll = function() {scrollFunction()};
			
			$(document).ready(function() {	               
	            $("#StartDate").datepicker({
	            	dateFormat: "yy-mm-dd",
	                popup : {
	                   position : "bottom left",
	                   origin   : "top left"
	                }	            
	            }).datepicker("setDate", "0");
	            
	             $("#EndDate").datepicker({
	            	dateFormat: "yy-mm-dd",
	                popup : {
	                   position : "bottom left",
	                   origin   : "top left"
	                }
	            }).datepicker("setDate", "0");
			});    
	       
			function getParameters(){
				
             	var vStartDate = document.getElementById("StartDate").value;
             	var vEndDate = document.getElementById("EndDate").value;
 			    //e.preventDefault();
 				$.ajax({
 					url 	: "ajaxReport.jsp",
 					type	: "POST",
 					dataType: "text",
 					data: {Type     : 'customer',
 						   StartDate: vStartDate, 
 						   EndDate	: vEndDate},
 					success : function(data) { 	
 								///alert(data);
 						$('#ajaxReport').html(data);					
 					}
 				});
            }	 
			
			function submitReportForm(){
				reports.Action.value = "HoursByCustomer";
				reports.submit();
			}
			
			function submitReportByCustomer(){
				reports.Action.value = "RunHoursByCustomer";
				reports.submit();
			}
			
		</script>		

	</head>
	<body id="page-top">
		<button onclick="topFunction();return false;" id="myBtn" class="myBtn" title="Go to top">Top</button>
		<form name="reportByCustomer" id="reportByCustomer" action="Reports" method="post">
			<div class="container">
				<%@include file="menu.jsp"%>				
			</div>	
			<div class="container">	
				<div class="row">
					<div class="col labelColorOne">
						<h2>Reports</h2>
					</div>						
				</div>	
				<hr>
				<ul class="nav nav-tabs">
				  <li class="nav-item">
				    <a class="nav-link" href="reports.jsp">By Customer</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" href="reportByWorker.jsp">By Worker</a>
				  </li>		
				</ul>
			</div>
			<br>
			<div class="container">				
				<div class="row">
					<div class="col labelColorOne">
						<h2>Hours by Day and Customers</h2>
					</div>						
				</div>
				<hr>			
			</div>					
			<div class="container">
				<div class="form-group">
					<div class="row">
						 <div class="col-md-6">	
						    <label for="StartDate" class="col-form-label labelColorSmall">Start Date</label>				 
						 	<input type="text" class="form-control" id="StartDate" name="StartDate" value="" onchange="javascript:getParameters();return false;" >		
							<label class="ErrorLabel" id="Error_StartDate">Field Is Required</label>
						</div>						
						<div class="col-md-6">
						    <label for="datepicker" class="col-form-label labelColorSmall">End Date</label>				 
						 	<input type="text" class="form-control" id="EndDate" name="EndDate" value="" placeholder="End Date">		
							<label class="ErrorLabel" id="Error_EndDate">Field Is Required</label>
						</div>
					</div>						
			 	<hr>	
			</div>	
			
			<div class="container">
				<div class="labelColorOne">
					<h5>Customer(s)</h5>
				</div>
			</div>	
			<div id="ajaxReport">						
			</div>		
			
		 	<div align="center">				
				<button type="button" class="btn btn-outline-info" onclick="submitReportByCustomer();">Run</button>
				<button type="button" class="btn btn-outline-info" onclick="window.location.href='index.jsp'">Go Back</button>						
			</div>
			 <input type="text" name="Action" value="">	
		</form>
	</body>
</html>
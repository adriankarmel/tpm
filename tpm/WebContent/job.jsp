<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>     

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
		
		<script type="text/javascript">	
			var $v_1_12_1 = jQuery.noConflict();
					  
			window.onscroll = function() {scrollFunction()};	
	
			$(document).ready(function() {	               
				$v_1_12_1("#datepicker").datepicker({
	            	dateFormat: "yy-mm-dd",
            	    ignoreReadonly: true,
            	    allowInputToggle: true,	
	                popup : {
	                   position : "bottom left",
	                   origin   : "top left"
	           		 }
	       		 })
            
	            $v_1_12_1("#SearchBtn").on('click', function(e){
	            	var vCustomerSeatch = document.getElementById("theSearchCustomer").value;
				    e.preventDefault();
					$.ajax({
						url 	: "searchCustomer.jsp",
						type	: "POST",
						dataType: "text",
						data: {SearCustomer: vCustomerSeatch},
						success : function(data) { 	
									///alert(data);
							$('#SearchCustomers').html(data);					
						}
					});
	    		})
	        }); 
			
		  	function DiffTime(id){		  	
		  		
		  		var startTime = document.getElementById("startTime_" + id).value;
		  		var endTime   = document.getElementById("endTime_" + id).value; 
		  		
		  		var startTimeHour =	startTime.substring(0,2);	  			
	  			var startTimeMin  = startTime.substring(3,5);
	  				
	  			var endTimeHour = endTime.substring(0,2);
  				var	endTimeMin  = endTime.substring(3,5);		
  			
  				var totHour = document.getElementById("tot_hours_" + id);
  				
  				var calc = CalculateDiff(startTime, endTime)
  				totHour.value = calc;
  			 
			} 			  	
		  	
		  	function CalculateDiff(pStartTime, pEndTime){
		  		
		  		var date1 = new Date("01/01/1970 " + pStartTime);
		  		var date2 = new Date("01/01/1970 " + pEndTime);

		  		var diff = date2.getTime() - date1.getTime();

		  		var msec = diff;
		  		var hh = Math.floor(msec / 1000 / 60 / 60);
		  		msec -= hh * 1000 * 60 * 60;
		  		var mm = Math.floor(msec / 1000 / 60);
		  		msec -= mm * 1000 * 60;
		  		var ss = Math.floor(msec / 1000);
		  		msec -= ss * 1000;

		  		return pad2(hh) + ":" + pad2(mm);	  		  	
		  	}   	
		 
		  	function pad2(number) {
		  	   return (number < 10 ? '0' : '') + number
		  	}	  	
	    </script>				 		
	</head>

	<body id="page-top">
		<button onclick="topFunction();return false;" id="myBtn" class="myBtn" title="Go to top">Top</button>
		<form name="job" id="job" action="Job" method="post">
			<!-- Group of default radios - option 1 -->

			<div class="container">
				<%@include file="menu.jsp"%>
			</div>
			<div class="container">				
				<div class="row">
					<div class="col labelColorOne">
						<h2>Add Job</h2>
					</div>
				</div>
				<hr>
				<div class="row">		
					<div class="col labelColorMsg">
						<%= request.getAttribute("Msg") == null ? "" : request.getAttribute("Msg") %>
					</div>
					<hr>	
				</div>							
			</div>	
			<div class="container">
				<div class="row">
					 <div class="col-md-6">
						<input class="form-control" type="text" name="JobId" id="JobId" value="<%= request.getAttribute("JobId") == null ? "" : request.getAttribute("JobId") %>" readonly placeholder="Job Id"> 
			 		 </div>	
			 		<div class="col-md-6"> 			 		
						<input type="text" class="form-control" id="datepicker" name="JobDate" value="<%= request.getAttribute("JobDate") == null ? "" : request.getAttribute("JobDate") %>" placeholder="Job Date">		
					    <small  id="Error_datepicker" class="ErrorLabel">Field Is Required</small> 					
					</div>	
			 	</div>	 
			 	<hr>
			 	<div class="form-group labelColorOne">
					<h5>Customer
						<!-- <button type="button" class="btn btn-outline-dark btn-sm" onclick="window.location.href='customer.jsp'; return false;" title="Add Customer">+</button> -->
					</h5>
				</div>			
				
				<input type="hidden" class="form-control" name="CustomerId" id="CustomerId" value="<%= request.getAttribute("CustomerId") == null ? "" : request.getAttribute("CustomerId") %>"> 
				
				<div class="form-group">
					<div class="row">
						 <div class="col-md-6">						 
							<input type="text" class="form-control" name="CustomerName" id="CustomerName" placeholder="Customer" value="<%= request.getAttribute("CustomerName") == null ? "" : request.getAttribute("CustomerName") %>" readonly>
							<small id="Error_CustomerName" class="ErrorLabel">Field Is Required</small> 			 	 							
						 </div>
						 <div class="col-md-6">
							<div class="input-group"> 							 
							    <input type="text" class="form-control" name="theSearchCustomer" id="theSearchCustomer" autofocus="autofocus" placeholder="Search Customer">
							    <span class="input-group-btn">
							    	<button type="button" id="SearchBtn" class="btn btn-outline-dark">Search</button>
							  	</span>				  	
							</div>
				 		</div>
					</div>
					<hr>
				</div>

				<div class="container" id="SearchCustomers">
				</div>
				
			
				<div class="labelColorOne">
					<h5>Worker
						<!-- <button type="button" class="btn btn-outline-dark btn-sm" onclick="window.location.href='worker.jsp'; return false;" title="Add Job">+</button> -->
					</h5>
				</div>	
				<div class="container">
				
				<% if (request.getAttribute("JobId") == null){%>						
					<%@include file="newWorker.jsp"%>
				<%}else{ %>
					<%@include file="updateWorker.jsp"%>
				<%} %>
				
				</div>
	 			 <br>
	 			 <div class="container">
		 			<div class="form-group">
		  				<textarea class="form-control" rows="5" id="Comments" name="Comments" maxlength="500" placeholder="Comments"><%= request.getAttribute("Comments") == null ? "" : request.getAttribute("Comments") %></textarea>
					</div>   			 
		 			 <hr>
	 			</div>
	 			<div align="center">						
				 	<button type="button" class="btn btn-outline-dark" onclick="submitJobForm();">Save</button> 
					<!--	<button type="button" class="btn btn-outline-dark" onclick="checkStartTimeGreaterThanEndTime();">Savess</button> -->
					
					<button type="button" class="btn btn-outline-dark" onclick="window.location.href='index.jsp'">Go Back</button>							
					<br>
				</div>
				 <input type="hidden" id="wInfo" name="wInfo">
	 			 <input type="hidden" name="Action" value="0">	
			</div>
			<%@include file = "./footer.jsp"%>	
		</form>	
	</body>
</html>
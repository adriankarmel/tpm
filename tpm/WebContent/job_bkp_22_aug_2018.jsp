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
		
		<% ConfigDAO cssStyle = new ConfigDAO();%>			
		<link rel="stylesheet" type="text/css" href="<%= cssStyle.getCSS()%>">			
		<script src="js/script.js" type="text/javascript"></script>
		
		<script type="text/javascript">	
		  
			window.onscroll = function() {scrollFunction()};	
	
			$(document).ready(function() {	               
	            $("#datepicker").datepicker({
	            	dateFormat: "yy-mm-dd",
	                popup : {
	                   position : "bottom left",
	                   origin   : "top left"
	           		 }
	       		 })
            
	            $("#SearchBtn").on('click', function(e){
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
			
				
			function DiffHourMenorCero(pStartTime, pEndTime){
				
				var isMenorCero = false;
				
				var nStartTime = pStartTime.split(':').join('');
				var pEndTime   = pEndTime.split(':').join('');
  				
  				if (parseInt(nStartTime) > pEndTime){
  					isMenorCero = true;
  				}
  				
  				return isMenorCero;				
			}
	
		  	function ValidTime(id){		  	
		  		
		  		var startTime = document.getElementById("startTime_" + id).value;
		  		var endTime   = document.getElementById("endTime_" + id).value; 
		  		
		  		var startTimeHour =	startTime.substring(0,2);	  			
	  			var startTimeMin  = startTime.substring(3,5);
	  				
	  			var endTimeHour = endTime.substring(0,2);
  				var	endTimeMin  = endTime.substring(3,5);
  				
  				console.log(startTimeHour);
  				console.log(endTimeHour);
  				console.log(startTimeMin);
				console.log(endTimeMin);
  				
  				var vHour = parseInt(startTimeHour) - parseInt(endTimeHour);
  				var vMin  = parseInt(startTimeMin) - parseInt(endTimeMin);
  				var totHour = document.getElementById("tot_hours_" + id);
  				
  				totHour.value = vHour + ":" + vMin;
  				
		  	//	var vError = document.getElementById("endTime_" + id); 		  		
		  	//	var vDivError = document.getElementById("error_" + id);
		  		
		  	//	console.log("vError:" + vError); 
		  		
  			/*	if (DiffHourMenorCero(startTime, endTime)){
  					
  					vDivError.style.Color =  "#cc0066"; 
  					vDivError.innerHTML = "The Start date cannot be bigger than End Date";
  					
  					//console.log("paso");
  					
  					return false;  					
  				}
  		
		  		var timeStart = moment(startTime, "HH:mm:ss a");
		  		var timeEnd   = moment(endTime  , "HH:mm:ss a");
			  	  		
		  		var totHour   = document.getElementById("tot_hours_"+ id);
		  		
		  		totHour.value = getTimeInterval(startTime, endTime, 0);*/
		  		//totHour.value = moment.utc(moment(timeEnd,"HH:mm:ss").diff(moment(timeStart,"HH:mm:ss"))).format("HH:mm:ss");
		  				
			} 		  	
		  	
		  	function getTimeInterval(startTime, endTime, lunchTime){
		  	    var start = moment(startTime, "HH:mm");
		  	    var end = moment(endTime, "HH:mm");
		  	    var minutes = end.diff(start, 'minutes');
		  	    var interval = moment().hour(0).minute(minutes);
		  	    
		  	    interval.subtract(lunchTime, 'minutes');
		  	    
		  	    return interval.format("HH:mm");
		  	}
		  	
		  	function ColorWarning(pDiff){		  		
		  		var Color = "";
		  		
		  		if (pDiff < 0){
		  			Color =  "#cc0066"; 
		  	    }else if (pDiff == 0){
		  	    	Color = "orange";
		  	    }else if (pDiff >= 2){
		  	    	Color = "green";
		  	    }
		  		
		  	    return Color;
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
				<div class="row">		
					<div class="col labelColorMsg">
						<%= request.getAttribute("Msg") == null ? "" : request.getAttribute("Msg") %>
					</div>	
				</div>
				<hr>			
			</div>	
			<div class="container">
				<div class="row">
					 <div class="col-md-12">
						<label class="control-label labelColorSmall" for="JobId">Job Id</label>
						<input class="form-control" type="text" name="JobId" id="JobId" value="<%= request.getAttribute("JobId") == null ? "" : request.getAttribute("JobId") %>" readonly> 
			 		 </div>		
			 	</div>	 
			 	<br>
			 	<hr>
			 	<div class="form-group labelColorOne">
					<h5>Customer</h5>
				</div>			
				<input type="hidden" class="form-control" name="CustomerId" id="CustomerId" value="<%= request.getAttribute("CustomerId") == null ? "" : request.getAttribute("CustomerId") %>"> 
				
				<div class="form-group">
					<div class="row">
						 <div class="col-md-6">
							<label class="control-label labelColorSmall" for="CustomerName">Customer</label>							
							<input type="text" class="form-control labelRedBold" name="CustomerName" id="CustomerName" value="<%= request.getAttribute("CustomerName") == null ? "" : request.getAttribute("CustomerName") %>" readonly>
							<label class="ErrorLabel" id="Error_CustomerName">Field Is Required</label>				 	 							
						 </div>
						 <div class="col-md-6">
						 <label class="control-label labelColorSmall">Search Customer</label>
							<div class="input-group"> 							 
							    <input type="text" class="form-control labelColorSmall" name="theSearchCustomer" id="theSearchCustomer" autofocus="autofocus">
							    <span class="input-group-btn">
							    	<button type="button" id="SearchBtn" class="btn btn-outline-danger">Search</button>
							  	</span>				  	
							</div>
				 		</div>
					</div>
					<hr>
				</div>

				<div class="container" id="SearchCustomers">
				</div>
				
		 		<div class="form-group">	
				    <label for="datepicker" class="col-2 col-form-label labelColorSmall">Date</label>				 
				 	<input type="text" class="form-control" id="datepicker" name="JobDate" value="<%= request.getAttribute("JobDate") == null ? "" : request.getAttribute("JobDate") %>" placeholder="Job Date">		
					<label class="ErrorLabel" id="Error_datepicker">Field Is Required</label>
				</div>	
				<hr>
				<div class="form-group labelColorOne">
					<h5>Worker</h5>
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
		  				<label class="control-label labelColorSmall" for="comment">Comment</label>
		  				<textarea class="form-control" rows="5" id="Comments" name="Comments" maxlength="500" placeholder="Comments"><%= request.getAttribute("Comments") == null ? "" : request.getAttribute("Comments") %></textarea>
					</div>   			 
		 			 <hr>
	 			</div>
	 			<div align="center">						
					<button type="button" class="btn btn-outline-info" onclick="submitJobForm();">Save</button>
					<button type="button" class="btn btn-outline-info" onclick="window.location.href='index.jsp'">Go Back</button>							
				</div>
				 <input type="text" id="wInfo" name="wInfo">
	 			 <input type="text" name="Action" value="0">	
			</div>			
		</form>	
	</body>
</html>
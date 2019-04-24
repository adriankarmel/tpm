<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>    

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@page 
	import = "java.io.*"	
	import = "java.sql.*"	
	import = "javax.servlet.*"
	import = "javax.servlet.jsp.*"
	import = "javax.servlet.http.*"
	import = "java.text.*"
    import = "ca.akarmel.tpm.dao.ConfigDAO"
 %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="x-ua-compatible" content="ie=edge">
			
		<title>List Worker</title>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
		
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
	
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
			
		<link rel="stylesheet" href="css/style.css">		
		<script src="js/script.js" type="text/javascript"></script>	
		
	</head>
	<button onclick="topFunction();return false;" id="myBtn" class="myBtn" title="Go to top">Top</button>
	<body id="page-top">
		<form name="worker" id="worker" action="Worker" method="POST">
			<div class="container">	
				<%@include file="menu.jsp"%>		
			</div>
			<div class="container">				
				<div class="row">
					<div class="col labelColorOne">
						<h2>Add Worker</h2>
					</div>						
				</div>
				<hr>	
				<div class="row">		
					<div class="col labelColorMsg">
						<%= request.getAttribute("Msg") == null ? "" : request.getAttribute("Msg") %>
					</div>
					<hr>	
				</div>
				
				<div class="labelColorOne">
					<h5>Personal Information</h5>
				</div>
				
				<div class="form-group">
					<div class="row">
						 <div class="col-md-6">
							<label class="control-label labelColorSmall" for="FirstName">First Name</label>
							<input class="form-control" type="text" name="FirstName" id="FirstName" placeholder="First Name" value="<%= request.getAttribute("FirstName") == null ? "" : request.getAttribute("FirstName") %>" maxlength="25" autofocus="autofocus" required> 
					 		<label class="ErrorLabel" id="Error_FirstName">Field Is Required</label>
					 	 </div>
						 <div class="col-md-6">
							<label class="control-label labelColorSmall" for="LastName">Last Name</label>
							<input class="form-control" type="text" name="LastName" id="LastName" placeholder="Last Name" value="<%= request.getAttribute("LastName") == null ? "" : request.getAttribute("LastName") %>" maxlength="25" required> 
						 </div>
					</div>
				</div>		
			 	<hr>
			 	<div class="labelColorOne">
					<h5>Contact Information</h5>
				</div>	
				<div class="form-group">
					<div class="row">
						 <div class="col-md-6">
							<label class="control-label labelColorSmall" for="Email">Email
							<a href="mailto:<%= request.getAttribute("Email") == null ? "" : request.getAttribute("Email") %>">
								<img border="0" src="../tpm/img/email.png" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Email">
							</a>
							</label>
							<input class="form-control text-lowercase" type="text" name="Email" id="Email" placeholder="Email" value="<%= request.getAttribute("Email") == null ? "" : request.getAttribute("Email") %>" maxlength="80"> 
					 	 	<label class="ErrorLabel" id="Error_Email">Field Is Required</label>
					 	 </div>
						 <div class="col-md-6">
							<label class="control-label labelColorSmall" for="Phone">Phone
							<a href="tel:<%= request.getAttribute("Phone") == null ? "" : request.getAttribute("Phone") %>">
								<img border="0" src="../tpm/img/phone.png" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Call Phone">
							</a>		
							</label>
							<input class="form-control" type="text" name="Phone" id="Phone" placeholder="Phone" value="<%= request.getAttribute("Phone") == null ? "" : request.getAttribute("Phone") %>" maxlength="20"> 
						 </div>
					</div>
				</div>		
			 	<hr>		
			    <div class="form-group">
				    <div class="row">
				  	    <div class="col-md-12">						 
							<label class="control-label labelColorSmall" for="HourRate">Hour Rate</label>
							<input name="HourRate" id="HourRate" Class="form-control" value="<%= request.getAttribute("HourRate") == null ? "" : request.getAttribute("HourRate") %>" placeholder="Hour Rate">				
				 			<label class="ErrorLabel" id="Error_HourRate">Field Is Required</label>
				 	 	</div>
				 	 </div>
				</div>	 		
			 	<div class="form-group">
			 		<div class="row">
			 			<div class="col-md-12">
  							<label class="control-label labelColorSmall" for="comment">Comment</label>
  							<textarea class="form-control" rows="5" maxlength="500" id="Comments" name="Comments" placeholder="Comments"><%= request.getAttribute("Comments") == null ? "" : request.getAttribute("Comments") %></textarea>
						</div>
					</div>
				</div> 				
			 	<hr>	
				<div class="form-group">
					<div class="row">
						 <div class="col-md-6">
							<label class="control-label labelColorSmall" for="Inactive">Inactive</label>
							<% String sInactive = "";
							   if(request.getAttribute("Inactive") != null){
								   sInactive = request.getAttribute("Inactive").toString(); 
							   }
							%>	

							<select name="Inactive" id="Inactive" class="form-control">
								<option value="N" <%= sInactive.equals("N") ? "selected" : "" %>>No</option>											      
								<option value="Y" <%= sInactive.equals("Y") ? "selected" : "" %>>Yes</option>
							</select>
					 	 </div>
						 <div class="col-md-6">
							<label class="control-label labelColorSmall" for="CreateDt">Create Date</label>
							<input class="form-control" type="text" name="CreateDt" id="CreateDt" value="<%= request.getAttribute("CreateDt") == null ? "" : request.getAttribute("CreateDt") %>" readonly>
						 </div>
					</div>
				</div>		
			 	<hr>			
			</div>				 		
		 	<div align="center">				
				<button type="button" class="btn btn-outline-dark" onclick="submitWorkerForm();">Save</button>
				<button type="button" class="btn btn-outline-dark" onclick="window.location.href='workers.jsp'">Go Back</button>						
				<br>
			</div>
			
			<%@include file = "./footer.jsp"%>
				
			<input type="hidden" name="WorkerId" id="WorkerId" value="<%= request.getAttribute("WorkerId") == null ? "" : request.getAttribute("WorkerId") %>">
			<input type="hidden" name="Action" value="0">				
		</form>
	</body>
</html>
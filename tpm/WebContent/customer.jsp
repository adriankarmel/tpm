<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

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
		
		<link rel="stylesheet" href="css/style.css">
		<script src="js/script.js" type="text/javascript"></script>
		
	</head>
	
	<body id="page-top">
		<button onclick="topFunction();return false;" id="myBtn" class="myBtn" title="Go to top">Top</button>	
		<form name="customer" id="customer" action="Customer" method="POST">
			
			<div class="container">		
				<%@include file="menu.jsp"%>
			</div>
			
			<div class="container">				
				<div class="row">
					<div class="col labelColorOne">
						<h2>Add Customer</h2>
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
							<input class="form-control" type="text" name="FirstName" id="FirstName" placeholder="First Name" value="<%= request.getAttribute("FirstName") == null ? "" : request.getAttribute("FirstName") %>" maxlength="25" autofocus="autofocus">
							<small class="ErrorLabel" id="Error_FirstName">Field Is Required</small> 
					 	 </div>
						 <div class="col-md-6">
							<input class="form-control" type="text" name="LastName" id="LastName" placeholder="Last Name" value="<%= request.getAttribute("LastName") == null ? "" : request.getAttribute("LastName") %>" maxlength="25"> 
							<small class="ErrorLabel" id="Error_LastName">Field Is Required</small>
						 </div>
					</div>
				</div>		
			 	<hr>
			 	<div class="labelColorOne">			 		
					<h5>Current Address Information					
						<a href="https://maps.google.com/maps?q=<%= request.getAttribute("Address") == null ? "" : request.getAttribute("Address") %>" target="_blank">	
							<img border="0" src="../tpm/img/googleMap.jpg" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Google Map">
						</a>
					</h5>	
				</div>	
			 	<div class="form-group">
	   			    <input type="text" class="form-control" id="Address" name="Address" value="<%= request.getAttribute("Address") == null ? "" : request.getAttribute("Address") %>" placeholder="Current Address" maxlength="50">
	  				<small class="ErrorLabel" id="Error_Address">Field Is Required</small>
	  			</div>	
 				<div class="form-group">
						<div class="row">
							 <div class="col-md-4">
								<!-- <label class="control-label labelColorSmall" for="CountryId">Country</label> -->
								<select name="CountryId" id="CountryId" class="form-control">
									
								<% 
									 ConnectionDB db = new ConnectionDB();
									 Connection conn = db.getConnection();
									
									 String sSql = "";
									 String CountryId = "";
									 String CountryName = "";
									 
									 if(conn != null) {
									 	 sSql =  "SELECT id, name FROM country";				 
									 
										 Statement stmt = conn.createStatement();
										 ResultSet rs  = stmt.executeQuery(sSql); 
										 String passedCountryId = (request.getAttribute("CountryId") == null) ? "" : request.getAttribute("CountryId").toString(); %>
									 
									    <option value="0" <%= CountryId.equals(0) ? "selected" : "" %>> Select Country </option>
									    
									    <% while (rs.next()) { 
											CountryId   = rs.getString("id");
											CountryName = rs.getString("name");	%>
											  
											<option value="<%= CountryId %>" <%= CountryId.equals(passedCountryId) ? "selected" : "" %>> <%= CountryName %> </option>		     	
											<%
									     }	
										
										 rs.close();
										 stmt.close();
									 }										
									
									%>										
								</select>
								<small class="ErrorLabel" id="Error_CountryId">Field Is Required</small>
							 </div>
						
							 <div class="col-md-4">
								<!-- <label class="control-label labelColorSmall" for="ProvinceId">Province</label> -->
								<select name="ProvinceId" id="ProvinceId" class="form-control">
								<%								
									
									String ProvinceId = "";
									String ProvinceName = "";
									String sqlProvince = "";
									
									sqlProvince = " SELECT id, name FROM province";
		
									Statement stmtProvince = conn.createStatement();
									ResultSet resProvince  = stmtProvince.executeQuery(sqlProvince);
		
									String passedProvinceId = (request.getAttribute("ProvinceId") == null) ? "" : request.getAttribute("ProvinceId").toString();
									%>
									
									<option value="0" <%= ProvinceId.equals(0) ? "selected" : "" %>> Select Province </option>
									
									<% while(resProvince.next()){
											ProvinceId   = resProvince.getString("id");
											ProvinceName = resProvince.getString("name");	%>
											  
											<option value="<%= ProvinceId %>" <%= ProvinceId.equals(passedProvinceId) ? "selected" : "" %>> <%= ProvinceName %> </option>		     	
											<%
									}	
									
									resProvince.close();
									stmtProvince.close();
									%>										
								</select>
								<small class="ErrorLabel" id="Error_ProvinceId">Field Is Required</small>
							 </div>
							 <div class="col-md-4">
								<!-- <label class="control-label labelColorSmall" for="PostalCode">Postal Code</label> -->
								<input class="form-control text-uppercase" type="text" name="PostalCode" id="PostalCode" placeholder="Postal Code" value="<%= request.getAttribute("PostalCode") == null ? "" : request.getAttribute("PostalCode") %>" maxlength="10"> 
							 	<small class="ErrorLabel" id="Error_PostalCode">Field Is Required</small>
							 </div> 
						</div>	
					</div>						
					<hr>
			 	<div class="labelColorOne">
					<h5>New Address Information
					<a href="https://maps.google.com/maps?q=<%= request.getAttribute("Address") == null ? "" : request.getAttribute("Address") %>" target="_blank">	
						<img border="0" src="../tpm/img/googleMap.jpg" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Google Map">
					</a>
					</h5>
				</div>	
			 	<div class="form-group">
	   				 <input type="text" class="form-control" id="AddressNew" name="AddressNew" value="<%= request.getAttribute("AddressNew") == null ? "" : request.getAttribute("AddressNew") %>" placeholder="New Address" maxlength="50">
	  			</div>	
 				<div class="form-group">
						<div class="row">
							 <div class="col-md-4">
								<!-- <label class="control-label labelColorSmall" for="CountryIdNew">Country</label> -->
								<select name="CountryIdNew" id="CountryIdNew" class="form-control">
								<% 
																
									 String sSqlN = "";
									 String CountryIdN = "";
									 String CountryNameN = "";
									 
									 if(conn != null) {
									 	sSqlN =  "SELECT id, name FROM country";				 
									 
										 Statement stmtN = conn.createStatement();
										 ResultSet rsN   = stmtN.executeQuery(sSqlN); 
										 String passedCountryIdN = (request.getAttribute("CountryIdNew") == null) ? "" : request.getAttribute("CountryIdNew").toString();%>
									 	
									 	 <option value="0" <%= CountryIdN.equals(0) ? "selected" : "" %>> Select Country</option>
										
										 <%while (rsN.next()) { 
											CountryIdN   = rsN.getString("id");
											CountryNameN = rsN.getString("name"); %>
											  
											<option value="<%= CountryIdN %>" <%= CountryIdN.equals(passedCountryIdN) ? "selected" : "" %>> <%= CountryNameN %> </option>		     	
											<%
									     }	
										
										 rsN.close();
										 stmtN.close();
									 }										
									
									%>										
								</select>
							
							 </div>
						
							 <div class="col-md-4">
								<!-- <label class="control-label labelColorSmall" for="ProvinceIdNew">Province</label> -->
								<select name="ProvinceIdNew" id="ProvinceIdNew" class="form-control">
								<%		
								
									String ProvinceIdN = ""; 
									String ProvinceNameN = "";;
								
									String sqlProvinceN = " SELECT id, name FROM province";
		
									Statement stmtProvinceN = conn.createStatement();
									ResultSet resProvinceN  = stmtProvinceN.executeQuery(sqlProvinceN);
		
									String passedProvinceIdN = (request.getAttribute("ProvinceIdNew") == null) ? "" : request.getAttribute("ProvinceIdNew").toString(); %>
									
									<option value="0" <%= ProvinceIdN.equals(0) ? "selected" : "" %>> Select Province</option>
		
									<% while(resProvinceN.next()){
											ProvinceIdN   = resProvinceN.getString("id");
											ProvinceNameN = resProvinceN.getString("name");	%>
											  
											<option value="<%= ProvinceIdN %>" <%= ProvinceIdN.equals(passedProvinceIdN) ? "selected" : "" %>> <%= ProvinceNameN %> </option>		     	
											<%
									}	
									
									resProvinceN.close();
									stmtProvinceN.close();
									%>										
								</select>								
							 </div>
							 <div class="col-md-4">
								<!-- <label class="control-label labelColorSmall" for="PostalCodeNew">Postal Code</label> -->
								<input class="form-control text-uppercase" type="text" name="PostalCodeNew" id="PostalCodeNew" placeholder="New Postal Code" value="<%= request.getAttribute("PostalCodeNew") == null ? "" : request.getAttribute("PostalCodeNew") %>" maxlength="10"> 
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
								<%-- <label class="control-label labelColorSmall" for="PhoneOne">Phone One
								<a href="tel:<%= request.getAttribute("PhoneOne") == null ? "" : request.getAttribute("PhoneOne") %>">
									<img border="0" src="../tpm/img/phone.png" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Call Phone">
								</a>
								</label> --%>
								<input class="form-control" type="text" name="PhoneOne" id="PhoneOne" placeholder="Phone One" value="<%= request.getAttribute("PhoneOne") == null ? "" : request.getAttribute("PhoneOne") %>" maxlength="20"> 
						 	 	<small class="ErrorLabel" id="Error_phoneOne">Field Is Required</small>
						 	 </div>
							 <div class="col-md-6">
					<%-- 			<label class="control-label labelColorSmall" for="PhoneTwo">Phone Two
								<a href="tel:<%= request.getAttribute("PhoneTwo") == null ? "" : request.getAttribute("PhoneTwo") %>">
									<img border="0" src="../tpm/img/phone.png" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Call Phone">
								</a>	
								</label> --%>
								<input class="form-control" type="text" name="PhoneTwo" id="PhoneTwo" placeholder="Phone Two" value="<%= request.getAttribute("PhoneTwo") == null ? "" : request.getAttribute("PhoneTwo") %>" maxlength="20"> 
							 </div>
						</div>
					</div>	
					<div class="form-group">							
					<%-- 	<label class="control-label labelColorSmall" for="Email">Email
						<a href="mailto:<%= request.getAttribute("Email") == null ? "" : request.getAttribute("Email") %>">
							<img border="0" src="../tpm/img/email.png" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Email">
						</a> --%>
						</label>
						<input class="form-control text-lowercase" type="text" name="Email" id="Email" placeholder="Email" value="<%= request.getAttribute("Email") == null ? "" : request.getAttribute("Email") %>" maxlength="80">
					</div> 	
				 	<div class="form-group">
	  					<textarea class="form-control" rows="5" id="Comments" name="Comments" maxlength="500" placeholder="Comments"><%= request.getAttribute("Comments") == null ? "" : request.getAttribute("Comments") %></textarea>
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
				 	<div align="center">						
						<button type="button" class="btn btn-outline-dark" onclick="submitCustomerForm();">Save</button>
						<button type="button" class="btn btn-outline-dark" onclick="window.location.href='customers.jsp'">Go Back</button>							
						<br>
					</div>
					<input type="hidden" name="CustomerId" id="CustomerId" value="<%= request.getAttribute("CustomerId") == null ? "" : request.getAttribute("CustomerId") %>">
					<input type="hidden" name="Action" value="0">	
			</div>
			<%@include file = "./footer.jsp"%>	
		</form>
	</body>
</html>
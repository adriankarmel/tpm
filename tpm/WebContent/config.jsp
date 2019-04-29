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
		
		<script>
			$('config').submit(function (evt) {
			   evt.preventDefault(); 
				}
			)	
		
			function SubmitConfig(){
				config.submit();
			}
		</script>
	</head>
	<body id="page-top">
		<button onclick="topFunction();return false;" id="myBtn" class="myBtn" title="Go to top">Top</button>
		<form name="config" id="config" action="Config" method="post">
			<div class="container">		
				<%@include file="menu.jsp"%>
			</div>	
			
			<%
				 ConnectionDB db = new ConnectionDB();
				 Connection conn = db.getConnection();
				 
				 String sSql = "";
				 String sConfigCountryId = "";
				 String sConfigProvinceId = "";
				 String StartTime = "";
				 String EndTime = "";
 				 
				 if(conn != null) {
				 	sSql =  "SELECT id, company_name, address," + 
				 			" 		country_id, province_id, postal_code," + 
		 					"	 	phone_one, phone_two, phone_three," + 
							" 		email_one, email_two, email_three, display_settings," + 
							"		operation_start_time, operation_end_time" +
							"  FROM config" +
							" WHERE id = 1";				 
				 
					 Statement stmt = conn.createStatement();
					 ResultSet res  = stmt.executeQuery(sSql); 
				 	
				 if (res.next()){ 					 
					 sConfigCountryId = res.getString("country_id");
					 sConfigProvinceId = res.getString("province_id");
					 StartTime = res.getString("operation_start_time");
 				     EndTime = res.getString("operation_end_time");   
			 %>		
					
			<div class="container">				
				<div class="row">
					<div class="col labelColorOne">
						<h2>Configuration</h2>
					</div>	
				</div>	
				<div class="row">		
					<div class="col labelColorMsg">
						<%= request.getAttribute("Msg") == null ? "" : request.getAttribute("Msg") %>
					</div>	
					
				</div>
				<div class="form-group">
					<input type="text" name="CompanyName" id="CompanyName" Class="form-control" value="<%= res.getString("company_name") == null ? "" : res.getString("company_name") %>" placeholder="Company Name" maxlength="50" autofocus="autofocus" />		 	
			 	</div>
			 	<hr>						
			 	<div class="labelColorOne">
					<h5>Address Information</h5>
				</div>			
			 	<div class="form-group">
	   				 <input type="text" class="form-control" id="Address" name="Address" value="<%= res.getString("address") == null ? "" : res.getString("address") %>" placeholder="Address" maxlength="50">
	  			</div>	
				<div class="form-group">
					<div class="row">
						 <div class="col-md-4">
							<!-- <label class="control-label labelColorSmall" for="CountryId">Country</label> -->
							<select name="CountryId" id="CountryId" class="form-control">
							<% 							
								 sSql = "";
								 String CountryId = "";
								 String CountryName = "";	
								
							 	 sSql =  "SELECT id, name FROM country";
							
							 	 Statement stmtCountry = conn.createStatement();
								 ResultSet rs = stmtCountry.executeQuery(sSql); %>
							 
								 <option value="0" <%= CountryId.equals(0) ? "selected" : "" %>> Select Country</option>
								 
								 <% 
								 while (rs.next()) { 
									CountryId   = rs.getString("id");
									CountryName = rs.getString("name");	%>
									  
									<option value="<%= CountryId %>" <%= CountryId.equals(sConfigCountryId) ? "selected" : "" %>> <%= CountryName %> </option>		     	
									<%
							     }	
								
								 rs.close();
								 stmtCountry.close();						 										
								
								%>										
							</select>
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
								ResultSet resProvince  = stmtProvince.executeQuery(sqlProvince); %>
								
								<option value="0" <%= ProvinceId.equals(0) ? "selected" : "" %>> Select Province</option>
	
								<% while(resProvince.next()){
										ProvinceId   = resProvince.getString("id");
										ProvinceName = resProvince.getString("name");	%>
										  
										<option value="<%= ProvinceId %>" <%= ProvinceId.equals(sConfigProvinceId) ? "selected" : "" %>> <%= ProvinceName %> </option>		     	
							   <%}	
								
								resProvince.close();
								stmtProvince.close();
							  %>										
							</select>
						 </div>
						 <div class="col-md-4">
							<!-- <label class="control-label labelColorSmall" for="PostalCode">Postal Code</label> -->
							<input class="form-control" type="text" name="PostalCode" id="PostalCode" style="text-transform:uppercase" placeholder="Postal Code" value="<%= res.getString("postal_code") == null ? "" : res.getString("postal_code") %>" maxlength="10"> 
						 </div> 
					</div>	
				</div>						
				<hr>
			 	<div class="labelColorOne">
					<h5>Contact Information</h5>
				</div>				
				<div class="form-group">
					<div class="row">
						 <div class="col-md-4">
							<input class="form-control bfh-phone" data-format="(ddd) ddd-dddd"" type="text" name="phoneOne" id="phoneOne" placeholder="Phone One" value="<%= res.getString("phone_one") == null ? "" : res.getString("phone_one") %>" maxlength="20"> 
					 	 </div>
						 <div class="col-md-4">
							<input class="form-control" type="text" name="PhoneTwo" id="PhoneTwo" placeholder="Phone Two" value="<%= res.getString("phone_two") == null ? "" : res.getString("phone_two") %>" maxlength="20"> 
						 </div>
						 <div class="col-md-4">
							<input class="form-control" type="text" name="PhoneThree" id="PhoneThree" placeholder="Phone Three" value="<%= res.getString("phone_three") == null ? "" : res.getString("phone_three") %>" maxlength="20"> 
					 	</div>					 
					</div>
				</div>	
				<div class="form-group">
					<div class="row">
						 <div class="col-md-4">
							<input class="form-control" type="text" name="EmailOne" id="EmailOne" placeholder="Email One" <%= res.getString("email_one") == null ? "" : res.getString("email_one") %>" maxlength="80"> 
					 	 </div>
						 <div class="col-md-4">
							<input class="form-control" type="text" name="EmailTwo" id="EmailTwo" placeholder="Email Two" value="<%= res.getString("email_two") == null ? "" : res.getString("email_two") %>" maxlength="80"> 
						 </div>
						 <div class="col-md-4">
							<input class="form-control" type="text" name="EmailThree" id="EmailThree" placeholder="Email Three" value="<%= res.getString("email_three") == null ? "" : res.getString("email_three") %>" maxlength="80"> 
					 	 </div>					 
					</div>
				</div>	
				<hr>
				<div class="labelColorOne">
					<h5>Hours Operation</h5>
				</div>			 
			  	<div class="row">	
					<div class="col-md-6">
						<label class="control-label labelColorSmall" for="OperStartTime">Start Time</label>
						<select name="OperStartTime" id="OperStartTime" class="form-control">
						  	<option value="07:00:00" <%= StartTime.equals("07:00:00") ? "selected" : "" %>>7:00</option>								
						  	<option value="07:30:00" <%= StartTime.equals("07:30:00") ? "selected" : "" %>>7:30</option>
						  	<option value="08:00:00" <%= StartTime.equals("08:00:00") ? "selected" : "" %>>8:00</option>								
						  	<option value="08:30:00" <%= StartTime.equals("08:30:00") ? "selected" : "" %>>8:30</option>
						  	<option value="09:00:00" <%= StartTime.equals("09:00:00") ? "selected" : "" %>>9:00</option>								
						  	<option value="09:30:00" <%= StartTime.equals("09:30:00") ? "selected" : "" %>>9:30</option>
						  	<option value="10:00:00" <%= StartTime.equals("10:00:00") ? "selected" : "" %>>10:00</option>
						  	<option value="10:30:00" <%= StartTime.equals("10:30:00") ? "selected" : "" %>>10:30</option>
						  	<option value="11:00:00" <%= StartTime.equals("11:00:00") ? "selected" : "" %>>11:00</option>
						  	<option value="11:30:00" <%= StartTime.equals("11:30:00") ? "selected" : "" %>>11:30</option>
						  	<option value="12:00:00" <%= StartTime.equals("12:00:00") ? "selected" : "" %>>12:00</option>
						  	<option value="12:30:00" <%= StartTime.equals("12:30:00") ? "selected" : "" %>>12:30</option>
						  	<option value="13:00:00" <%= StartTime.equals("13:00:00") ? "selected" : "" %>>13:00</option>
						  	<option value="13:30:00" <%= StartTime.equals("13:30:00") ? "selected" : "" %>>13:30</option>
						  	<option value="14:00:00" <%= StartTime.equals("14:00:00") ? "selected" : "" %>>14:00</option>
						  	<option value="14:30:00" <%= StartTime.equals("14:30:00") ? "selected" : "" %>>14:30</option>
						  	<option value="15:00:00" <%= StartTime.equals("15:00:00") ? "selected" : "" %>>15:00</option>
						  	<option value="15:30:00" <%= StartTime.equals("15:30:00") ? "selected" : "" %>>15:30</option>
						  	<option value="16:00:00" <%= StartTime.equals("16:00:00") ? "selected" : "" %>>16:00</option>
						  	<option value="16:30:00" <%= StartTime.equals("16:30:00") ? "selected" : "" %>>16:30</option>
						  	<option value="17:00:00" <%= StartTime.equals("17:00:00") ? "selected" : "" %>>17:00</option>
						  	<option value="17:30:00" <%= StartTime.equals("17:30:00") ? "selected" : "" %>>17:30</option>								  	
						   	<option value="18:00:00" <%= StartTime.equals("18:00:00") ? "selected" : "" %>>18:00</option>
						  	<option value="18:30:00" <%= StartTime.equals("18:30:00") ? "selected" : "" %>>18:30</option>	
						  	<option value="19:00:00" <%= StartTime.equals("19:00:00") ? "selected" : "" %>>19:00</option>
						  	<option value="19:30:00" <%= StartTime.equals("19:30:00") ? "selected" : "" %>>19:30</option>									  									  								  	
						  	<option value="20:00:00" <%= StartTime.equals("20:00:00") ? "selected" : "" %>>20:00</option>
						  	<option value="20:30:00" <%= StartTime.equals("20:30:00") ? "selected" : "" %>>20:30</option>	
						  	<option value="21:00:00" <%= StartTime.equals("21:00:00") ? "selected" : "" %>>21:00</option>
						  	<option value="21:30:00" <%= StartTime.equals("21:30:00") ? "selected" : "" %>>21:30</option>									  									  								  	
						  	<option value="22:00:00" <%= StartTime.equals("22:00:00") ? "selected" : "" %>>22:00</option>
						 </select>
				 </div>
				 <div class="col-md-6">	
					<label class="control-label labelColorSmall" for="OperEndTime">End Time</label>
					<select name="OperEndTime" id="OperEndTime" class="form-control">
						<option value="07:00:00" <%= EndTime.equals("07:00:00") ? "selected" : "" %>>7:00</option>								
					  	<option value="07:30:00" <%= EndTime.equals("07:30:00") ? "selected" : "" %>>7:30</option>
					  	<option value="08:00:00" <%= EndTime.equals("08:00:00") ? "selected" : "" %>>8:00</option>								
					  	<option value="08:30:00" <%= EndTime.equals("08:30:00") ? "selected" : "" %>>8:30</option>
					  	<option value="09:00:00" <%= EndTime.equals("09:00:00") ? "selected" : "" %>>9:00</option>								
					  	<option value="09:30:00" <%= EndTime.equals("09:30:00") ? "selected" : "" %>>9:30</option>
					  	<option value="10:00:00" <%= EndTime.equals("10:00:00") ? "selected" : "" %>>10:00</option>
					  	<option value="10:30:00" <%= EndTime.equals("10:30:00") ? "selected" : "" %>>10:30</option>
					  	<option value="11:00:00" <%= EndTime.equals("11:00:00") ? "selected" : "" %>>11:00</option>
					  	<option value="11:30:00" <%= EndTime.equals("11:30:00") ? "selected" : "" %>>11:30</option>
					  	<option value="12:00:00" <%= EndTime.equals("12:00:00") ? "selected" : "" %>>12:00</option>
					  	<option value="12:30:00" <%= EndTime.equals("12:30:00") ? "selected" : "" %>>12:30</option>
					  	<option value="13:00:00" <%= EndTime.equals("13:00:00") ? "selected" : "" %>>13:00</option>
					  	<option value="13:30:00" <%= EndTime.equals("13:30:00") ? "selected" : "" %>>13:30</option>
					  	<option value="14:00:00" <%= EndTime.equals("14:00:00") ? "selected" : "" %>>14:00</option>
					  	<option value="14:30:00" <%= EndTime.equals("14:30:00") ? "selected" : "" %>>14:30</option>
					  	<option value="15:00:00" <%= EndTime.equals("15:00:00") ? "selected" : "" %>>15:00</option>
					  	<option value="15:30:00" <%= EndTime.equals("15:30:00") ? "selected" : "" %>>15:30</option>
					  	<option value="16:00:00" <%= EndTime.equals("16:00:00") ? "selected" : "" %>>16:00</option>
					  	<option value="16:30:00" <%= EndTime.equals("16:30:00") ? "selected" : "" %>>16:30</option>
					  	<option value="17:00:00" <%= EndTime.equals("17:00:00") ? "selected" : "" %>>17:00</option>
					  	<option value="17:30:00" <%= EndTime.equals("17:30:00") ? "selected" : "" %>>17:30</option>								  	
			 		   	<option value="18:00:00" <%= EndTime.equals("18:00:00") ? "selected" : "" %>>18:00</option>
					  	<option value="18:30:00" <%= EndTime.equals("18:30:00") ? "selected" : "" %>>18:30</option>	
					  	<option value="19:00:00" <%= EndTime.equals("19:00:00") ? "selected" : "" %>>19:00</option>
					  	<option value="19:30:00" <%= EndTime.equals("19:30:00") ? "selected" : "" %>>19:30</option>									  									  								  	
					  	<option value="20:00:00" <%= EndTime.equals("20:00:00") ? "selected" : "" %>>20:00</option>
					  	<option value="20:30:00" <%= EndTime.equals("20:30:00") ? "selected" : "" %>>20:30</option>	
					  	<option value="21:00:00" <%= EndTime.equals("21:00:00") ? "selected" : "" %>>21:00</option>
					  	<option value="21:30:00" <%= EndTime.equals("21:30:00") ? "selected" : "" %>>21:30</option>									  									  								  	
					  	<option value="22:00:00" <%= EndTime.equals("22:00:00") ? "selected" : "" %>>22:00</option>
			 		</select>								
				</div>
				</div>	
				<hr>
				<!-- <div class="labelColorOne">
					<h5>Display Settings</h5>
					<% String Display = res.getString("display_settings");%>
				</div>				
				<div class="container">
				    <label class="radio-inline btn btn-outline-dark">    
				 		 <input type="radio" name="DisplaySettings" id="DisplaySettings" value="css/styleLight.css" <%= Display.equals("css/styleLight.css") ? "checked" : "" %>> Light
					</label>
					<label class="radio-inline btn btn-secondary">
					  <input type="radio" name="DisplaySettings" id="DisplaySettings" value="css/styleGrey.css" <%= Display.equals("css/styleGrey.css") ? "checked" : "" %>> Grey
					</label>
					<label class="radio-inline btn btn-dark">
					  <input type="radio" name="DisplaySettings" id="DisplaySettings" value="css/styleDark.css" <%= Display.equals("css/styleDark.css") ? "checked" : "" %>> Dark
					</label>	
				</div>
				 
				<hr>
				-->
				<input type="hidden" name="ConfigId" id="ConfigId" value="<%= res.getString("id") %>">
				<input type="hidden" name="Action" value="0">	
				
				<% }
				 } %>				   
			 	<div align="center">						
					<button type="button" class="btn btn-outline-dark" onclick="javascript:SubmitConfig();return false;">Save</button>
					<button type="button" class="btn btn-outline-dark" onclick="window.location.href='index.jsp'">Go Back</button>							
				</div>				
			</div>	
			<%@include file = "./footer.jsp"%>							
		</form>	
	</body>
</html>
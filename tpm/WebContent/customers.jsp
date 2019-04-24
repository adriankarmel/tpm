<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
 
 <%@page 
	import = "javax.servlet.*"
	import = "javax.servlet.jsp.*"
	import = "javax.servlet.http.*"
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
		
		<script>
			$(function () {
			  $('[data-toggle="tooltip"]').tooltip()
			})
		
			function submitSearchCustomers(){				
				customers.Action.value='Search';
				customers.submit();
			}
			
			function EditCustomer(cId){
				customers.CustomerId.value = cId;
				customers.Action.value='Edit';
				customers.submit();
			}	
			
			function InactivateCustomer(cId){
				customers.CustomerId.value = cId;
				customers.Action.value = 'Inactivate';
				customers.submit();					
			}	
		</script>
	</head>

	<body id="page-top">
		<button onclick="topFunction();return false;" id="myBtn" class="myBtn" title="Go to top">Top</button>
		<form name="customers" id="customers" action="Customer" method="post">
			 <div class="container">		
				<%@include file="menu.jsp"%>
			 </div>	
								
	 		 <div class="container">				
				<div class="row">
					<div class="col labelColorOne">
						<h2>List Customer
							<button type="button" class="btn btn-outline-dark" onclick="window.location.href='customer.jsp'; return false;" title="Add Customer">+</button>
						</h2>
					</div>	
				</div>	
				<hr>				
			 </div>								
			   	
		     <div class="container">	 
		  		<div class="row"> 	
		  		 	<div class="col-md-11">
					   	<div class="input-group">  
						    <input type="text" class="form-control" name="theSearch" autofocus="autofocus">
						    <span class="input-group-btn">
						    	<button type="button" class="btn btn-outline-dark" onclick="submitSearchCustomers();">Search</button>
						  	</span>
						</div>
					</div>
					<div class="col-md-1">		
						<div class="custom-control custom-checkbox">
 							 <input type="checkbox" class="custom-control-input" name="Inactive" id="Inactive">
  							 <label class="custom-control-label" for="Inactive">Inactive</label>
						</div>
					 </div>	
				  </div>
				  <hr>
				 
				<div class="container" id="rowBig">		
					<div class="row" style="background:#e9e9e9;">
						<div class="col-sm-4 font-weight-bold labelColorOne">Name</div>
						<div class="col-sm-3 font-weight-bold labelColorOne">Address</div>
						<div class="col-sm-3 font-weight-bold labelColorOne">Phone</div>
						<div class="col-xs-2 col-sm-2 font-weight-bold labelColorOne text-center">Delete</div>	
					</div>
				</div>
				<div class="container" id="rowSmall">		
					<h6 class="font-weight-bold labelColorOne">Name Address Phone</h6>
				</div>
				<div class="container">	
					<c:forEach var="tempCustomer" items="${theCustomer}">
						<c:if test="${tempCustomer.inactive == 'Y'}">
		  					<div class="row trtDisable">
						</c:if>
						<c:if test="${tempCustomer.inactive == 'N'}">
		 					 <div class="row trt">
						</c:if>	
		    				<div class="col-sm-4">
		    				<!--<a href="mailto:${tempCustomer.email}">
									<img border="0" src="../tpm/img/email.png" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Email">
								</a>
							 -->			    				
		    					<a href="javascript:EditCustomer(${tempCustomer.id});">${tempCustomer.firstName}, ${tempCustomer.lastName}</a>
		    				</div>		    				
							<div class="col-sm-3">
							<!--<a href="https://maps.google.com/maps?q=${tempCustomer.address};" target="_blank">	
									<img border="0" src="../tpm/img/googleMap.jpg" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Google Map">
								</a>
							-->			
								<a href="javascript:EditCustomer(${tempCustomer.id});">${tempCustomer.address}</a>
							</div>
							<div class="col-sm-3">
							<!--	<a href="tel:${tempCustomer.phoneOne}">
									<img border="0" src="../tpm/img/phone.png" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Call Phone">
								</a>
							-->	
								<a href="javascript:EditCustomer(${tempCustomer.id});">${tempCustomer.phoneOne}</a>
							</div>	
							<div class="col-sm-2 labelCenter" style="background:#D3D3D3;">
								<a href="javascript:InactivateCustomer(${tempCustomer.id});" onclick="if (!(confirm('Are you sure you want to Inactivate the Customer Id: ' + ${tempCustomer.id} + '?'))) return false">
									<img border="0" src="../tpm/img/inactive.png" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Inactivate Customer">
								</a>
							</div>
		    			</div>
		     	  </c:forEach>
				</div>			
				<%@include file = "./footer.jsp"%>		
				<input type="hidden" name="CustomerId" id="CustomerId" value="" />
			   	<input type="hidden" name="Action" value="0">	
	     </form>            	
 	</body>
</html>
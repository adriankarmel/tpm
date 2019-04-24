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
				
				function submitSearchWorker(){
					workers.Action.value = 'Search';
					workers.submit();
				}
				
				function EditWorker(wId){
					workers.WorkerId.value = wId;
					workers.Action.value = 'Edit';
					workers.submit();
				}
				
				function InactivateWorker(wId){
					workers.WorkerId.value = wId;
					workers.Action.value = 'Inactivate';
					workers.submit();					
				}
			</script>		
			
		</head>
	<body>
		<form name="workers" id="workers" action="Worker" method="post">
			<button onclick="topFunction();return false;" id="myBtn" class="myBtn" title="Go to top">Top</button>
			<div class="container">
				<%@include file="menu.jsp"%>
			</div>
			<div class="container">				
				<div class="row">
					<div class="col labelColorOne">
						<h2><span>List Workers</span>
							<button type="button" class="btn btn-outline-dark" onclick="window.location.href='worker.jsp'; return false;" title="Add Job">+</button>
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
						    	<button type="button" class="btn btn-outline-dark" onclick="submitSearchWorker();">Search</button>
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
			 </div>					
			<div class="container" id="rowBig">
				<div class="row" style="background:#e9e9e9;">					
					<div class="col-sm-4 font-weight-bold labelColorOne">Name</div>
					<div class="col-sm-4 font-weight-bold labelColorOne">Email</div>
					<div class="col-sm-2 font-weight-bold labelColorOne">Phone</div>
					<div class="col-xs-2 col-sm-2 font-weight-bold labelColorOne text-center">Delete</div>	
				</div>	
			</div>
			<div class="container" id="rowSmall">
				<h6 class="font-weight-bold labelColorOne">Name Email Phone</h6>
			</div>
			<div class="container">					
				<c:forEach var="tempWorker" items="${theWorker}">
					<c:if test="${tempWorker.inactive == 'Y'}">
	  					<div class="row trtDisable">
					</c:if>
					<c:if test="${tempWorker.inactive == 'N'}">
	 					 <div class="row trt">
					</c:if>			
		    				<div class="col-sm-4">
		    					<a href="javascript:EditWorker(${tempWorker.id});">${tempWorker.firstName}, ${tempWorker.lastName}</a>
		    				</div>
							<div class="col-sm-4">
								<a href="javascript:EditWorker(${tempWorker.id});">${tempWorker.email}</a>
							</div>
							<div class="col-sm-2">
								<a href="javascript:EditWorker(${tempWorker.id});">${tempWorker.phone}</a>
							</div>	
							<div class="col-sm-2 labelCenter" style="background:#D3D3D3;">
								<a href="javascript:InactivateWorker(${tempWorker.id});" onclick="if (!(confirm('Are you sure you want to Inactivate the Worker id: ' + ${tempWorker.id} + '?'))) return false">
									<img border="0" src="../tpm/img/inactive.png" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Inactivate Worker">
								</a>
							<!-- 	<a href="mailto:${tempWorker.email}">
									<img border="0" src="../tpm/img/email.png" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Email">
								</a>
								<a href="tel:${tempWorker.phone}">
									<img border="0" src="../tpm/img/phone.png" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Call Phone">
								</a>
							 -->												
							</div>
		    			</div>		    				    			
		     	  </c:forEach>
		     	  <input type="hidden" name="WorkerId" id="WorkerId" value="" />
		     	  <input type="hidden" name="Action" value="0">	
		 	</div>
		 	<%@include file = "./footer.jsp"%>			 	
		</form>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<%@page 
	import = "javax.servlet.*"
	import = "javax.servlet.jsp.*"
	import = "javax.servlet.http.*"
    import = "ca.akarmel.tpm.dao.ConfigDAO"
    import = "ca.akarmel.tpm.dao.JobDAO"
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>	
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<meta http-equiv="x-ua-compatible" content="ie=edge">
		<link href="https://fonts.googleapis.com/css?family=Quicksand" rel="stylesheet"> 
		 
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
			function EditJob(jId){
				index.JobId.value  = jId;
				index.Action.value = 'Edit';
				index.submit();
			}
			
			function DeleteJob(jId){
				index.JobId.value  = jId;
				index.Action.value = 'Delete';
				index.submit();				
			}	
		</script>		
	</head>
	
	<body id="page-top" style="">
		<form name="index" id="index" action="Job" method="post">
			<button onclick="topFunction();return false;" id="myBtn" class="myBtn" title="Go to top">Top</button>
			
			<div class="container">
				<%@include file="menu.jsp"%>
			</div>
			<div class="container">				
				<div class="row">
					<div class="col labelColorOne">
						<h2>List Jobs
							<button type="button" class="btn btn-outline-dark" onclick="window.location.href='job.jsp';return false;" title="Add Job">+</button>
						</h2>
					</div>	
				</div>
				<hr>	
			</div>	
			
			<div class="container">
				<div class="input-group">  
				    <input type="text" class="form-control" name="theSearchJob" autofocus="autofocus">
				    <span class="input-group-btn">
				  		<button type="button" class="btn btn-outline-dark" onclick="submitSearchJobs();">Search</button>
				  	</span>				  	
				</div>
				<hr>
			</div>
									
			<div class="container" id="rowBig" >
				<div class="row" style="background:#e9e9e9;">
					<div class="col-xs-1 col-sm-1 font-weight-bold labelColorOne">Job Id</div>
					<div class="col-xs-2 col-sm-2 font-weight-bold labelColorOne">Date</div>
					<div class="col-xs-3 col-sm-3 font-weight-bold labelColorOne">Customer</div>
					<div class="col-xs-4 col-sm-4 font-weight-bold labelColorOne">Address</div>	
					<div class="col-xs-2 col-sm-2 font-weight-bold labelColorOne text-center">Delete</div>
				</div>	
			</div>
			
			<div class="container" id="rowSmall">				
				<h6 class="font-weight-bold labelColorOne">Job Id Date Customer Address</h6>
			</div>	
			<div class="container rowSmall">
				<c:forEach var="tempJob" items="${theJob}">
	    			<div class="row trt">
	    				<div class="col-sm-1">
							<a href="javascript:EditJob(${tempJob.id});">${tempJob.id}</a>
						</div>	
						<div class="col-sm-2">
							<a href="javascript:EditJob(${tempJob.id});">${tempJob.date}</a>
						</div>					
	    				<div class="col-sm-3">
							<a href="javascript:EditJob(${tempJob.id});">${tempJob.customerName}</a>
						</div>
						<div class="col-sm-4">
							<a href="javascript:EditJob(${tempJob.id});">${tempJob.custAddress}</a>
						</div>	
	    			<!-- 	
	    				<div class="col-sm-3">
							<a href="https://maps.google.com/maps?q=${tempJob.custAddress};" target="_blank">${tempJob.custAddress}</a>
						</div>
					 -->	
						
						<div class="col-sm-2 labelCenter" style="background:#D3D3D3;">
							<a href="javascript:DeleteJob(${tempJob.id});" onclick="if (!(confirm('Are you sure you want to delete this Id: ' + ${tempJob.id} + '?'))) return false">
								<img border="0" src="../tpm/img/delete.png" width="20" height="20">
							</a>
						<!-- 	<a href="https://maps.google.com/maps?q=${tempJob.custAddress};" target="_blank">	
								<img border="0" src="../tpm/img/googleMap.jpg" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Google Map">
							</a>
							<a href="tel:${tempJob.custPhoneOne}">
								<img border="0" src="../tpm/img/phone.png" width="20" height="20" data-toggle="tooltip" data-placement="top" title="Call Phone">
							</a>
						 -->						
						</div>
	    			</div>
	     	  </c:forEach>
	     	  <input type="hidden" name="JobId" id="JobId" value="" />
			  <input type="hidden" name="Action" value="0">
		 	</div>		
		 	<%@include file = "./footer.jsp"%>	 	
		</form>
	</body>
</html>
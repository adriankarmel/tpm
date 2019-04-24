<!DOCTYPE html>
<%@page 
	
    import = "ca.akarmel.tpm.dbconection.ConnectionDB"
    import = "ca.akarmel.tpm.dao.ConfigDAO"  
 %>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
	
	<link rel="stylesheet" href="css/style.css">  			
	<script src="js/script.js" type="text/javascript"></script>

	<style>
		.collapsible {
		  background-color: #ff5733;
		  color: white;
		  cursor: pointer;
		  padding: 18px;
		  width: 100%;
		  border: none;
		  text-align: left;
		  outline: none;
		  font-size: 15px;
		}
		
		.active, .collapsible:hover {
		  background-color: #ff8d33;
		}
		
		.content {
		  padding: 0 18px;
		  max-height: 0;
		  overflow: hidden;
		  transition: max-height 0.2s ease-out;
		  background-color: #f1f1f1;
		}
	</style>
</head>
<body>
	<div class="container">
			<%@include file="menu.jsp"%>
	</div>	
	<div class="container">
		<button class="collapsible">Job</button>
		<div class="content">
  			<ul class="list-group list-group-flush">
			  <li class="list-group-item">Add Job
			  	<ul class="list-group list-group-flush">
			  		<li class="list-group-item">1.- Search and Add a Customer</li>
			  		<li class="list-group-item">2.- Insert Job Date</li>
			  		<li class="list-group-item">3.- Check all the Workers and the Start and End Time</li>
			  		<li class="list-group-item">4.- Save Job</li>
			  	</ul>	
			  </li>
			  <li class="list-group-item">Required Field
			 	 <ul class="list-group list-group-flush">
			  		<li class="list-group-item">Customer, Job Date, Worker(s) and Start and End Time</li>
			  	</ul>	
			  </li>
			  <li class="list-group-item">Edit Job</li>
			  <li class="list-group-item">Search Job</li>
			  <li class="list-group-item">Delete Job</li>
			</ul>
		</div>	
	</div>	
	<div class="container">	
		<button class="collapsible">Customer</button>
		<div class="content">  			
  			<ul class="list-group list-group-flush">
			  <li class="list-group-item">Add Customer</li>
			  <li class="list-group-item">Edit Customer</li>
			  <li class="list-group-item">Search Customer</li>
			  <li class="list-group-item">Inactivate Customer</li>
			</ul>
		</div>		
	</div>	
	<div class="container">
		<button class="collapsible">Worker</button>
		<div class="content">
  			<ul class="list-group list-group-flush">
			  <li class="list-group-item">Add Worker</li>
			  <li class="list-group-item">Edit Worker</li>
			  <li class="list-group-item">Search Worker</li>
			  <li class="list-group-item">Inactivate Worker</li>
			</ul>
		</div>
	</div>
	<div class="container">	
		<button class="collapsible">Report</button>
		<div class="content">
  			<ul class="list-group list-group-flush">
			  <li class="list-group-item">Run Report</li>
			</ul>
		</div>
	</div>
	<%@include file = "./footer.jsp"%>	
	<script>
		var coll = document.getElementsByClassName("collapsible");
		var i;
		
		for (i = 0; i < coll.length; i++) {
		  coll[i].addEventListener("click", function() {
		    this.classList.toggle("active");
		    var content = this.nextElementSibling;
		    if (content.style.maxHeight){
		      content.style.maxHeight = null;
		    } else {
		      content.style.maxHeight = content.scrollHeight + "px";
		    } 
		  });
		}
	</script>
</body>
</html>
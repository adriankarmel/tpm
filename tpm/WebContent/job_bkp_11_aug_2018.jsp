<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
			
			function ShowStarEndTime(CheckId){
				
			//	console.log("pepe:" + document.getElementById("worker_" + CheckId).value);

				var chboxs = document.getElementById("worker_" + CheckId);
				
				//document.getElementById("worker_" + CheckId).style.color = "#ff0000";
				
				if (chboxs.checked){				
				 	document.getElementById("divStartTime_" + CheckId).style.display = "block";
				 	document.getElementById("divEndTime_" + CheckId).style.display = "block";
				 	document.getElementById("divTothours_" + CheckId).style.display = "block";
				 	chboxs.style.color = "#cc0066";
				 	//document.getElementById("worker_" + CheckId).style.fontWeight = "bold";
				 	//document.getElementById("worker_" + CheckId).style.color = "#cc0066"; 
				}else{							 	
					document.getElementById("divStartTime_" + CheckId).style.display = "none";
				 	document.getElementById("divEndTime_" + CheckId).style.display = "none";
				 	document.getElementById("divTothours_" + CheckId).style.display = "none";
				//	document.getElementById("worker_" + CheckId).style.fontWeight = "normal";
		//		 	document.getElementById("worker_" + CheckId).style.color = "black"; 
				 	chboxs.style.color = "blue";
				} 	
		//		console.log("chboxs: " + chboxs + "CheckId: " + CheckId);
			//	chboxs.style.color = '#ff0000';
			}					
	
		$(document).ready(function() {	               
            $("#datepicker").datepicker({
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
		
	 
			function submitJobForm(){
				Workers();
				
				job.Action.value='Save';
				job.submit();
			}
			
			function Workers(){
				
				var sAux = "";
				
				var frm = document.getElementById("job");						
				var vWInfo = document.getElementById("wInfo");		
				
				var vConcatWorker ="";
				
				for (i=0;i<frm.elements.length;i++){
					
					if (frm.elements[i].type == "checkbox"){
						
						var chkName = document.getElementById(frm.elements[i].name);
							
						if (chkName.checked){
							//console.log("adrian:" + frm.elements[i].value);
							vWorkerId =  frm.elements[i].value;
							vStartTimeId = "startTime_" + frm.elements[i].value;
							vEndTimeId   = "endTime_"   + frm.elements[i].value;
				
							var vST =  document.getElementById(vStartTimeId).value;	
							var vED =  document.getElementById(vEndTimeId).value;	
							
							vConcatWorker = vConcatWorker + vWorkerId + "," + "\"" + vST + "\"," + "\"" + vED + "\"" + "--" ;
							
							console.log(vConcatWorker);
						}
					}
			//		console.log("ff : " + vConcatWorker);
					
				    document.getElementById("wInfo").value = vConcatWorker;

				/*	sAux += "NOMBRE: " + frm.elements[i].name + " ";

				sAux += "TIPO :  " + frm.elements[i].type + " "; 

					sAux += "VALOR: " + frm.elements[i].value + "\n" ;
	*/
				

				}

				console.log(sAux);				
		//		console.log("<br> submit form:");
				
			}
			
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
		  	
		  	function AsignaCustomer(pCustomerId, pCustomerFirstName, pCustomerLastName){
		  		//console.log(pCustomerId + "-" + pCustomerFirstName);
		  		var custId = document.getElementById("CustomerId");
		  		var custName = document.getElementById("CustomerName");	  		
				
		  		custId.value = pCustomerId;
		  		custName.value = pCustomerFirstName + "," + pCustomerLastName;
		  		//custName.value = pCustomerFirstName;		  			
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
			</div>
			
					<sql:setDataSource
        var="myDS"
        driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost/tpm"
        user="root" password=""
    />
			<sql:query var="listUsers"  dataSource="${myDS}">
       SELECT id, first_name, last_name, email, phone, hour_rate FROM worker
    </sql:query>
				
				   
    <div align="center">
        <table border="1" cellpadding="5">
            <caption><h2>List of users</h2></caption>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Profession</th>
            </tr>
            <c:forEach var="user" items="${listUsers.rows}">
                <tr>
                    <td><c:out value="${user.id}" /></td>
                    <td><c:out value="${user.first_name}" /></td>
                    <td><c:out value="${user.last_name}" /></td>
                    <td><c:out value="${user.email}" /></td>
                </tr>
            </c:forEach>
        </table>
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
				<br>
				<input type="hidden" class="form-control" name="CustomerId" id="CustomerId" value="<%= request.getAttribute("CustomerId") == null ? "" : request.getAttribute("CustomerId") %>"> 
				
				<div class="form-group">
					<div class="row">
						 <div class="col-md-6">
							<label class="control-label labelColorSmall" for="PhoneOne">Customer</label>
							<input type="text" class="form-control labelRedBold" name="CustomerName" id="CustomerName" value="<%= request.getAttribute("CustomerName") == null ? "" : request.getAttribute("CustomerName") %>" readonly>					 	 </div>
						 <div class="col-md-6">
						 <label class="control-label labelColorSmall" for="PhoneOne">Search Customer</label>
							<div class="input-group"> 							 
							    <input type="text" class="form-control labelColorSmall" name="theSearchCustomer" id="theSearchCustomer" autofocus="autofocus">
							    <span class="input-group-btn">
							    	<button type="button" id="SearchBtn" class="btn btn-primary">Search</button>
							  	</span>				  	
							</div>
				 		</div>
					</div>
				</div>

				<div class="container" id="SearchCustomers">
							
				<hr>				 	
				</div>
				
		 		<div class="form-group">	
				    <label for="datepicker" class="col-form-label labelColorSmall">Date</label>				 
				 	<input type="text" class="form-control" id="datepicker" name="JobDate" value="<%= request.getAttribute("JobDate") == null ? "" : request.getAttribute("JobDate") %>">		
				</div>	
				<hr>

				<div class="form-group labelColorOne">
					<h5>Worker</h5>
				</div>	
				
				<div class="container">
				<%
				
				 ConnectionDB db = new ConnectionDB();
				 Connection conn = db.getConnection();
				 String sSql = "";				
				 
				 if(conn != null) {
				 	 sSql =  "SELECT id, first_name, last_name, email, phone, hour_rate FROM worker";				 
				 
					 Statement stmt = conn.createStatement();
					 ResultSet rs  = stmt.executeQuery(sSql); 
				 
					 while (rs.next()) { %>					 	 
						 <div class="row">
							 <div class="custom-control custom-checkbox">								 
								 	<input type="checkbox" 
								 		   class="custom-control-input"
								 		   name="worker_<%= rs.getString("id") %>" 
								 		   id="worker_<%= rs.getString("id") %>" 
								 		   value="<%= rs.getString("id") %>" 
								 		   onclick="ShowStarEndTime(<%= rs.getString("id")%>);">
								 	<label class="custom-control-label labelColorSmall" 
								 		   for="worker_<%= rs.getString("id") %>">
							 			<%= rs.getString("id") %>
				  					    <%= rs.getString("first_name") %>, <%= rs.getString("last_name") %>
							     	    <%= rs.getString("email") %>
							     	    <%= rs.getString("hour_rate") %>
							        </label>								
							 </div>			  		
					  	 </div>					  	 
						 <div class="row" id="error_<%= rs.getString("id")%>">		

						 </div>
						 
					  	 <div class="row">	
							<div class="col-md-5" id="divStartTime_<%= rs.getString("id")%>" style="display:none">
								<select name="startTime_<%= rs.getString("id")%>" 
										id="startTime_<%= rs.getString("id")%>" 
										class="form-control"
										onchange="ValidTime(<%= rs.getString("id")%>)">
								  	<option value="09:00:00">9:00</option>								
								  	<option value="09:30:00">9:30</option>
								  	<option value="10:00:00">10:00</option>
								  	<option value="10:30:00">10:30</option>
								  	<option value="11:00:00">11:00</option>
								  	<option value="11:30:00">11:30</option>
								  	<option value="12:00:00">12:00</option>
								  	<option value="12:30:00">12:30</option>
								  	<option value="13:00:00">13:00</option>
								  	<option value="13:30:00">13:30</option>
								  	<option value="14:00:00">14:00</option>
								  	<option value="14:30:00">14:30</option>
								  	<option value="15:00:00">15:00</option>
								  	<option value="15:30:00">15:30</option>
								  	<option value="16:00:00">16:00</option>
								  	<option value="16:30:00">16:30</option>
								  	<option value="17:00:00">17:00</option>
								  	<option value="17:30:00">17:30</option>								  	
								 </select>
							</div>
							<div class="col-md-5" id="divEndTime_<%= rs.getString("id")%>" style="display:none">								
								<select name="endTime_<%= rs.getString("id")%>" 
										id="endTime_<%= rs.getString("id")%>" 
										class="form-control"
										onchange="ValidTime(<%= rs.getString("id")%>)">
								  	<option value="09:00:00">9:00</option>								
								  	<option value="09:30:00">9:30</option>
								  	<option value="10:00:00">10:00</option>
								  	<option value="10:30:00">10:30</option>
								  	<option value="11:00:00">11:00</option>
								  	<option value="11:30:00">11:30</option>
								  	<option value="12:00:00">12:00</option>
								  	<option value="12:30:00">12:30</option>
								  	<option value="13:00:00">13:00</option>
								  	<option value="13:30:00">13:30</option>
								  	<option value="14:00:00">14:00</option>
								  	<option value="14:30:00">14:30</option>
								  	<option value="15:00:00">15:00</option>
								  	<option value="15:30:00">15:30</option>
								  	<option value="16:00:00">16:00</option>
								  	<option value="16:30:00">16:30</option>
								  	<option value="17:00:00">17:00</option>
								  	<option value="17:30:00">17:30</option>	
						 		</select>								
							</div>
							<div class="col-md-2" id="divTothours_<%= rs.getString("id")%>" style="display:none">	
								<input type="text" class="form-control" name="tot_hours_<%= rs.getString("id")%>" id="tot_hours_<%= rs.getString("id")%>" value="" readonly>						
							</div>
						</div>
						<hr>
										 		
				  <% }			    	
				 
	 			 	rs.close();
				 }
				 conn.close();
	 			 %>	
	 			 </div>	
	 			 <br>
	 			<div class="form-group">
	  				<label class="control-label labelColorSmall" for="comment">Comment</label>
	  				<textarea class="form-control" rows="5"  id="Comments" name="Comments" maxlength="500"><%= request.getAttribute("Comments") == null ? "" : request.getAttribute("Comments") %></textarea>
				</div>   			 
	 			 <hr>
	 			<div align="center">						
					<button type="button" class="btn btn-outline-danger" onclick="submitJobForm();">Save</button>
					<button type="button" class="btn btn-outline-danger" onclick="window.location.href='index.jsp'">Go Back</button>							
				</div>
				 <input type="text" id="wInfo" name="wInfo">
	 			 <input type="text" name="Action" value="0">	
			</div>			
		</form>	
	</body>
</html>
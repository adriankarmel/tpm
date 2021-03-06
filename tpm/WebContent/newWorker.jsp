<html>
	<head>
		<link rel="stylesheet" type="text/css" href="css/style.css" />
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>  
		 <script type="text/javascript" src="js/jquery.autocomplete.js"></script> 
		
	
		<script>
			var $v_1_4_2 = jQuery.noConflict();
			jQuery(function() {
				$v_1_4_2("#SearchWorker").autocomplete("searchWorker.jsp");
			});
		</script>
		
		<style>
		
		.ac_results {
			padding: 0px;
			border: 1px solid #84a10b;
			background-color: #84a10b;
			overflow: hidden;
		}
		
		.ac_results ul {
			width: 100%;
			list-style-position: outside;
			list-style: none;
			padding: 0;
			margin: 0;
		}
		
		.ac_results li {
			margin: 0px;
			padding: 2px 5px;
			cursor: default;
			display: block;
			color: #fff;
			font-family:verdana;
			/* 
			if width will be 100% horizontal scrollbar will apear 
			when scroll mode will be used
			*/
			/*width: 100%;*/
			font-size: 12px;
			/* 
			it is very important, if line-height not setted or setted 
			in relative units scroll will be broken in firefox
			*/
			line-height: 16px;
			overflow: hidden;
		
		}
		
		.ac_loading {
			background: white url('../images/indicator.gif') right center no-repeat;
		}
		
		.ac_odd {
			background-color: #84a10b;
			color: #ffffff;
		}
		
		.ac_over {
			background-color: #5a6b13;
			color: #ffffff;
		}
		
		
		.input_text{
			font-family:Arial, Helvetica, sans-serif;
			font-size:12px;
			border:1px solid #84a10b;
			padding:2px;
			width:150px;
			color:#000;
			background:white url(../images/search.png) no-repeat 3px 2px;
			padding-left:17px;
		}
		
		</style>
	</head>
<body>
<form method="searchWorker.jsp" action="post">
			<% ConfigDAO workingHours = new ConfigDAO();			
			   String[] theWorkingHours = workingHours.getWorkingHours();
			%>
			<div class="row">
				 <div class="col-md-12">
					<input class="form-control" type="text" name="SearchWorker" id="SearchWorker" value="" placeholder="Search Worker"> 
				 </div>		
			</div>	 
					
			<div class="container">
				<%				
				 ConnectionDB db = new ConnectionDB();
				 Connection conn = db.getConnection();
				 String sSql = "";				
				 
				 if(conn != null) {
					 sSql = "SELECT id, first_name, last_name " + 
				 		    "  FROM worker " +
				 		    " WHERE inactive = 'N' ";				 
				 
					 Statement stmt = conn.createStatement();
					 ResultSet rs  = stmt.executeQuery(sSql); 
				 
					 while (rs.next()) { %>					 	 
						 <div class="row" style="padding-bottom:5px;">
							 <div class="custom-control custom-checkbox">								 
								 	<input type="checkbox" 
								 		   class="custom-control-input"
								 		   name="worker_<%= rs.getString("id") %>" 
								 		   id="worker_<%= rs.getString("id") %>" 
								 		   value="<%= rs.getString("id") %>" 
								 		   onclick="ShowStarEndTime(<%= rs.getString("id")%>);">
								 	<label class="custom-control-label labelColorSmall" 
								 		   for="worker_<%= rs.getString("id") %>">
							 			<%= rs.getString("first_name") %>, <%= rs.getString("last_name") %>
							        </label>								
							 </div>			  		
					  	 </div>					  	 
						 <div class="row" id="error_<%= rs.getString("id")%>">	
						 </div>
						 
					  	 <div class="row">	
							<div class="col-md-5" id="divStartTime_<%= rs.getString("id")%>" style="display:none;padding-bottom:5px;">
								<select name="startTime_<%= rs.getString("id")%>" 
										id="startTime_<%= rs.getString("id")%>" 
										class="form-control"
										onchange="DiffTime(<%= rs.getString("id")%>)">	
									
									<option value="07:00:00" <%= theWorkingHours[0].equals("07:00:00") ? "selected" : "" %>>7:00</option>	
									<option value="07:30:00" <%= theWorkingHours[0].equals("07:30:00") ? "selected" : "" %>>7:30</option>		
									<option value="08:00:00" <%= theWorkingHours[0].equals("08:00:00") ? "selected" : "" %>>8:00</option>		
									<option value="08:30:00" <%= theWorkingHours[0].equals("08:30:00") ? "selected" : "" %>>8:30</option>											
								  	<option value="09:00:00" <%= theWorkingHours[0].equals("09:00:00") ? "selected" : "" %>>9:00</option>								
								  	<option value="09:30:00" <%= theWorkingHours[0].equals("09:30:00") ? "selected" : "" %>>9:30</option>
								  	<option value="10:00:00" <%= theWorkingHours[0].equals("10:00:00") ? "selected" : "" %>>10:00</option>
								  	<option value="10:30:00" <%= theWorkingHours[0].equals("10:30:00") ? "selected" : "" %>>10:30</option>
								  	<option value="11:00:00" <%= theWorkingHours[0].equals("11:00:00") ? "selected" : "" %>>11:00</option>
								  	<option value="11:30:00" <%= theWorkingHours[0].equals("11:30:00") ? "selected" : "" %>>11:30</option>
								  	<option value="12:00:00" <%= theWorkingHours[0].equals("12:00:00") ? "selected" : "" %>>12:00</option>
								  	<option value="12:30:00" <%= theWorkingHours[0].equals("12:30:00") ? "selected" : "" %>>12:30</option>
								  	<option value="13:00:00" <%= theWorkingHours[0].equals("13:00:00") ? "selected" : "" %>>13:00</option>
								  	<option value="13:30:00" <%= theWorkingHours[0].equals("13:30:00") ? "selected" : "" %>>13:30</option>
								  	<option value="14:00:00" <%= theWorkingHours[0].equals("14:00:00") ? "selected" : "" %>>14:00</option>
								  	<option value="14:30:00" <%= theWorkingHours[0].equals("14:30:00") ? "selected" : "" %>>14:30</option>
								  	<option value="15:00:00" <%= theWorkingHours[0].equals("15:00:00") ? "selected" : "" %>>15:00</option>
								  	<option value="15:30:00" <%= theWorkingHours[0].equals("15:30:00") ? "selected" : "" %>>15:30</option>
								  	<option value="16:00:00" <%= theWorkingHours[0].equals("16:00:00") ? "selected" : "" %>>16:00</option>
								  	<option value="16:30:00" <%= theWorkingHours[0].equals("16:30:00") ? "selected" : "" %>>16:30</option>
								  	<option value="17:00:00" <%= theWorkingHours[0].equals("17:00:00") ? "selected" : "" %>>17:00</option>
								  	<option value="17:30:00" <%= theWorkingHours[0].equals("17:30:00") ? "selected" : "" %>>17:30</option>
								  	<option value="18:00:00" <%= theWorkingHours[0].equals("18:00:00") ? "selected" : "" %>>18:00</option>
								  	<option value="18:30:00" <%= theWorkingHours[0].equals("18:30:00") ? "selected" : "" %>>18:30</option>	
								  	<option value="19:00:00" <%= theWorkingHours[0].equals("19:00:00") ? "selected" : "" %>>19:00</option>
								  	<option value="19:30:00" <%= theWorkingHours[0].equals("19:30:00") ? "selected" : "" %>>19:30</option>									  									  								  	
								  	<option value="20:00:00" <%= theWorkingHours[0].equals("20:00:00") ? "selected" : "" %>>20:00</option>
								  	<option value="20:30:00" <%= theWorkingHours[0].equals("20:30:00") ? "selected" : "" %>>20:30</option>	
								  	<option value="21:00:00" <%= theWorkingHours[0].equals("21:00:00") ? "selected" : "" %>>21:00</option>
								  	<option value="21:30:00" <%= theWorkingHours[0].equals("21:30:00") ? "selected" : "" %>>21:30</option>									  									  								  	
								  	<option value="22:00:00" <%= theWorkingHours[0].equals("22:00:00") ? "selected" : "" %>>22:00</option>								  		
								 </select>
							</div>
							<div class="col-md-5" id="divEndTime_<%= rs.getString("id")%>" style="display:none;padding-bottom:5px;">								
								<select name="endTime_<%= rs.getString("id")%>" 
										id="endTime_<%= rs.getString("id")%>" 
										class="form-control"
										onchange="DiffTime(<%= rs.getString("id")%>)">
									<option value="07:00:00" <%= theWorkingHours[1].equals("07:00:00") ? "selected" : "" %>>7:00</option>	
									<option value="07:30:00" <%= theWorkingHours[1].equals("07:30:00") ? "selected" : "" %>>7:30</option>		
									<option value="08:00:00" <%= theWorkingHours[1].equals("08:00:00") ? "selected" : "" %>>8:00</option>		
									<option value="08:30:00" <%= theWorkingHours[1].equals("08:30:00") ? "selected" : "" %>>8:30</option>											
								  	<option value="09:00:00" <%= theWorkingHours[1].equals("09:00:00") ? "selected" : "" %>>9:00</option>								
								  	<option value="09:30:00" <%= theWorkingHours[1].equals("09:30:00") ? "selected" : "" %>>9:30</option>
								  	<option value="10:00:00" <%= theWorkingHours[1].equals("10:00:00") ? "selected" : "" %>>10:00</option>
								  	<option value="10:30:00" <%= theWorkingHours[1].equals("10:30:00") ? "selected" : "" %>>10:30</option>
								  	<option value="11:00:00" <%= theWorkingHours[1].equals("11:00:00") ? "selected" : "" %>>11:00</option>
								  	<option value="11:30:00" <%= theWorkingHours[1].equals("11:30:00") ? "selected" : "" %>>11:30</option>
								  	<option value="12:00:00" <%= theWorkingHours[1].equals("12:00:00") ? "selected" : "" %>>12:00</option>
								  	<option value="12:30:00" <%= theWorkingHours[1].equals("12:30:00") ? "selected" : "" %>>12:30</option>
								  	<option value="13:00:00" <%= theWorkingHours[1].equals("13:00:00") ? "selected" : "" %>>13:00</option>
								  	<option value="13:30:00" <%= theWorkingHours[1].equals("13:30:00") ? "selected" : "" %>>13:30</option>
								  	<option value="14:00:00" <%= theWorkingHours[1].equals("14:00:00") ? "selected" : "" %>>14:00</option>
								  	<option value="14:30:00" <%= theWorkingHours[1].equals("14:30:00") ? "selected" : "" %>>14:30</option>
								  	<option value="15:00:00" <%= theWorkingHours[1].equals("15:00:00") ? "selected" : "" %>>15:00</option>
								  	<option value="15:30:00" <%= theWorkingHours[1].equals("15:30:00") ? "selected" : "" %>>15:30</option>
								  	<option value="16:00:00" <%= theWorkingHours[1].equals("16:00:00") ? "selected" : "" %>>16:00</option>
								  	<option value="16:30:00" <%= theWorkingHours[1].equals("16:30:00") ? "selected" : "" %>>16:30</option>
								  	<option value="17:00:00" <%= theWorkingHours[1].equals("17:00:00") ? "selected" : "" %>>17:00</option>
								  	<option value="17:30:00" <%= theWorkingHours[1].equals("17:30:00") ? "selected" : "" %>>17:30</option>
								  	<option value="18:00:00" <%= theWorkingHours[1].equals("18:00:00") ? "selected" : "" %>>18:00</option>
								  	<option value="18:30:00" <%= theWorkingHours[1].equals("18:30:00") ? "selected" : "" %>>18:30</option>	
								  	<option value="19:00:00" <%= theWorkingHours[1].equals("19:00:00") ? "selected" : "" %>>19:00</option>
								  	<option value="19:30:00" <%= theWorkingHours[1].equals("19:30:00") ? "selected" : "" %>>19:30</option>									  									  								  	
								  	<option value="20:00:00" <%= theWorkingHours[1].equals("20:00:00") ? "selected" : "" %>>20:00</option>
								  	<option value="20:30:00" <%= theWorkingHours[1].equals("20:30:00") ? "selected" : "" %>>20:30</option>	
								  	<option value="21:00:00" <%= theWorkingHours[1].equals("21:00:00") ? "selected" : "" %>>21:00</option>
								  	<option value="21:30:00" <%= theWorkingHours[1].equals("21:30:00") ? "selected" : "" %>>21:30</option>									  									  								  	
								  	<option value="22:00:00" <%= theWorkingHours[1].equals("22:00:00") ? "selected" : "" %>>22:00</option>								  		
						 		</select>								
							</div>
							<div class="col-md-2" id="divTothours_<%= rs.getString("id")%>" style="display:none">	
								<input type="text" class="form-control font-weight-bold" name="tot_hours_<%= rs.getString("id")%>" id="tot_hours_<%= rs.getString("id")%>" value="" readonly>						
							</div>
							<label class="ErrorLabel" id="Error_<%= rs.getString("id")%>">The Start Time cannot be smaller than the End Time</label>
						</div>
						<hr>
										 		
				  <% }			    	
				 
	 			 	rs.close();
				 }
				 conn.close();
	 			 %>	
	 			 </div>	

	</form>
</body>
</html>	 			 
	
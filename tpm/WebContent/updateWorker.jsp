			<div class="container">
				<%
				
				 ConfigDAO workingHours = new ConfigDAO();			
				 String[] theWorkingHours = workingHours.getWorkingHours();
				 //	 System.out.println("updateWorkers: " + theWorkingHours[0]);	
		//	 	 System.out.println("updateWorkers: " + theWorkingHours[1]);	
				 ConnectionDB db = new ConnectionDB();
				 Connection conn = db.getConnection();
				 
				 String sSql = "";	
				 
				 String sJobWorkerId = "";
				 String sStartTime = "";
				 String sEndTime = "";
				 String sFirstName = "";
				 String sLastName = "";
				 String sTimeDiff = "";
				 String sSelectedStartTime = "";
				 
				 String sDisplanyDiv = "display:block";
				 String sChequed = "checked";
				 
				 if(conn != null) {					 
					 sSql = "SELECT a.worker_id AS WorkerId, " + 
				 			"       b.first_name AS FirstName, b.last_name AS LastName, " + 
					 		"       a.start_time AS StartTime, a.end_time AS EndTime," + 
					 		"		TIME_FORMAT(TIMEDIFF(a.end_time, a.start_time), '%H:%i') AS TimeDiff " +
						    "  FROM job_details a " +
							"  LEFT JOIN worker b ON a.worker_id = b.id " + 
							" WHERE a.job_id = " + request.getAttribute("JobId") +
							" UNION " + 
							" SELECT b.id AS WorkerId, " + 
							" 		 b.first_name AS FirstName, b.last_name AS LastName, " + 
							"    	 '' AS StartTime, '' AS EndTime, " +
							"		 '' AS TimeDiff " +
							"   FROM worker b " + 
							"  WHERE b.id NOT IN (SELECT worker_id FROM job_details WHERE job_id = " + request.getAttribute("JobId") + ")" + 
							"    AND b.inactive = 'N' ";
					 
					 System.out.println("updateWorker uno:" + sSql);
				 
					 Statement stmt = conn.createStatement();
					 ResultSet rs  = stmt.executeQuery(sSql); 
				 
					 while (rs.next()) { 
						 sJobWorkerId = rs.getString("WorkerId");
						 sFirstName = rs.getString("FirstName");
					 	 sLastName = rs.getString("LastName");
						 sStartTime = rs.getString("StartTime");
					 	 sEndTime = rs.getString("EndTime");
					 	 sTimeDiff = rs.getString("TimeDiff");
					 	 //System.out.println("sStartTime : " + sStartTime);
					 	 if(sStartTime.equals("") || sEndTime.equals("")){					 		
					 		sDisplanyDiv = "display:none";	
					 		sChequed = "";
					 	 }
					 	 
					 	 if (sStartTime.equals("07:00:00")){
					 		sSelectedStartTime =  "selected"; 
					 	 }else{
					 		if (theWorkingHours[0].equals("07:00:00")){
					 			sSelectedStartTime =  "selected";
					 		}
					 	 }
					 	 
					  %>						 				 	 
						 <div class="row">
							 <div class="custom-control custom-checkbox">								 
								 	<input type="checkbox" 
								 		   class="custom-control-input"
								 		   name="worker_<%= sJobWorkerId %>" 
								 		   id="worker_<%= sJobWorkerId %>" 
								 		   value="<%= sJobWorkerId %>" 
								 		   onclick="ShowStarEndTime(<%= sJobWorkerId %>);"
								 		   <%= sChequed %>>
								 		  
								 	<label class="custom-control-label labelColorSmall" 
								 		   for="worker_<%= sJobWorkerId %>">							 		
				  					    <%= sFirstName %>, <%= sLastName %>
							        </label>								
							 </div>			  		
					  	 </div>					  	 
						 <div class="row" id="error_<%= sJobWorkerId%>">	
						 </div>						 
					  	 <div class="row" style="padding-bottom:10px;">	
							<div class="col-md-5" id="divStartTime_<%= sJobWorkerId %>" style="<%=sDisplanyDiv%>;padding-bottom:10px;" >
								<select name="startTime_<%= sJobWorkerId%>" 
										id="startTime_<%= sJobWorkerId%>" 
										class="form-control"
										onchange="DiffTime(<%= sJobWorkerId%>)">
									<% if(!sStartTime.equals("")){%>	
									  	<option value="07:00:00" <%= sStartTime.equals("07:00:00") ? "selected" : "" %>>7:00</option>								
									  	<option value="07:30:00" <%= sStartTime.equals("07:30:00") ? "selected" : "" %>>7:30</option>
									  	<option value="08:00:00" <%= sStartTime.equals("08:00:00") ? "selected" : "" %>>8:00</option>								
									  	<option value="08:30:00" <%= sStartTime.equals("08:30:00") ? "selected" : "" %>>8:30</option>
									  	<option value="09:00:00" <%= sStartTime.equals("09:00:00") ? "selected" : "" %>>9:00</option>								
									  	<option value="09:30:00" <%= sStartTime.equals("09:30:00") ? "selected" : "" %>>9:30</option>
									  	<option value="10:00:00" <%= sStartTime.equals("10:00:00") ? "selected" : "" %>>10:00</option>
									  	<option value="10:30:00" <%= sStartTime.equals("10:30:00") ? "selected" : "" %>>10:30</option>
									  	<option value="11:00:00" <%= sStartTime.equals("11:00:00") ? "selected" : "" %>>11:00</option>
									  	<option value="11:30:00" <%= sStartTime.equals("11:30:00") ? "selected" : "" %>>11:30</option>
									  	<option value="12:00:00" <%= sStartTime.equals("12:00:00") ? "selected" : "" %>>12:00</option>
									  	<option value="12:30:00" <%= sStartTime.equals("12:30:00") ? "selected" : "" %>>12:30</option>
									  	<option value="13:00:00" <%= sStartTime.equals("13:00:00") ? "selected" : "" %>>13:00</option>
									  	<option value="13:30:00" <%= sStartTime.equals("13:30:00") ? "selected" : "" %>>13:30</option>
									  	<option value="14:00:00" <%= sStartTime.equals("14:00:00") ? "selected" : "" %>>14:00</option>
									  	<option value="14:30:00" <%= sStartTime.equals("14:30:00") ? "selected" : "" %>>14:30</option>
									  	<option value="15:00:00" <%= sStartTime.equals("15:00:00") ? "selected" : "" %>>15:00</option>
									  	<option value="15:30:00" <%= sStartTime.equals("15:30:00") ? "selected" : "" %>>15:30</option>
									  	<option value="16:00:00" <%= sStartTime.equals("16:00:00") ? "selected" : "" %>>16:00</option>
									  	<option value="16:30:00" <%= sStartTime.equals("16:30:00") ? "selected" : "" %>>16:30</option>
									  	<option value="17:00:00" <%= sStartTime.equals("17:00:00") ? "selected" : "" %>>17:00</option>
									  	<option value="17:30:00" <%= sStartTime.equals("17:30:00") ? "selected" : "" %>>17:30</option>								  	
									   	<option value="18:00:00" <%= sStartTime.equals("18:00:00") ? "selected" : "" %>>18:00</option>
									  	<option value="18:30:00" <%= sStartTime.equals("18:30:00") ? "selected" : "" %>>18:30</option>	
									  	<option value="19:00:00" <%= sStartTime.equals("19:00:00") ? "selected" : "" %>>19:00</option>
									  	<option value="19:30:00" <%= sStartTime.equals("19:30:00") ? "selected" : "" %>>19:30</option>									  									  								  	
									  	<option value="20:00:00" <%= sStartTime.equals("20:00:00") ? "selected" : "" %>>20:00</option>
									  	<option value="20:30:00" <%= sStartTime.equals("20:30:00") ? "selected" : "" %>>20:30</option>	
									  	<option value="21:00:00" <%= sStartTime.equals("21:00:00") ? "selected" : "" %>>21:00</option>
									  	<option value="21:30:00" <%= sStartTime.equals("21:30:00") ? "selected" : "" %>>21:30</option>									  									  								  	
									  	<option value="22:00:00" <%= sStartTime.equals("22:00:00") ? "selected" : "" %>>22:00</option>
								 <%}else{%>
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
								 <%} %>
								 </select>
							</div>
							<div class="col-md-5" id="divEndTime_<%= sJobWorkerId %>" style="<%= sDisplanyDiv %>;padding-bottom:10px;">								
								<select name="endTime_<%= sJobWorkerId %>" 
										id="endTime_<%= sJobWorkerId %>" 
										class="form-control"
										onchange="DiffTime(<%= sJobWorkerId %>)">
									<% if(!sEndTime.equals("")){%>	
									  	<option value="07:00:00" <%= sEndTime.equals("07:00:00") ? "selected" : "" %>>7:00</option>								
									  	<option value="07:30:00" <%= sEndTime.equals("07:30:00") ? "selected" : "" %>>7:30</option>
									  	<option value="08:00:00" <%= sEndTime.equals("08:00:00") ? "selected" : "" %>>8:00</option>								
									  	<option value="08:30:00" <%= sEndTime.equals("08:30:00") ? "selected" : "" %>>8:30</option>
								  		<option value="09:00:00" <%= sEndTime.equals("09:00:00") ? "selected" : "" %>>9:00</option>								
									  	<option value="09:30:00" <%= sEndTime.equals("09:30:00") ? "selected" : "" %>>9:30</option>
									  	<option value="10:00:00" <%= sEndTime.equals("10:00:00") ? "selected" : "" %>>10:00</option>
									  	<option value="10:30:00" <%= sEndTime.equals("10:30:00") ? "selected" : "" %>>10:30</option>
									  	<option value="11:00:00" <%= sEndTime.equals("11:00:00") ? "selected" : "" %>>11:00</option>
									  	<option value="11:30:00" <%= sEndTime.equals("11:30:00") ? "selected" : "" %>>11:30</option>
									  	<option value="12:00:00" <%= sEndTime.equals("12:00:00") ? "selected" : "" %>>12:00</option>
									  	<option value="12:30:00" <%= sEndTime.equals("12:30:00") ? "selected" : "" %>>12:30</option>
									  	<option value="13:00:00" <%= sEndTime.equals("13:00:00") ? "selected" : "" %>>13:00</option>
									  	<option value="13:30:00" <%= sEndTime.equals("13:30:00") ? "selected" : "" %>>13:30</option>
									  	<option value="14:00:00" <%= sEndTime.equals("14:00:00") ? "selected" : "" %>>14:00</option>
									  	<option value="14:30:00" <%= sEndTime.equals("14:30:00") ? "selected" : "" %>>14:30</option>
									  	<option value="15:00:00" <%= sEndTime.equals("15:00:00") ? "selected" : "" %>>15:00</option>
									  	<option value="15:30:00" <%= sEndTime.equals("15:30:00") ? "selected" : "" %>>15:30</option>
									  	<option value="16:00:00" <%= sEndTime.equals("16:00:00") ? "selected" : "" %>>16:00</option>
									  	<option value="16:30:00" <%= sEndTime.equals("16:30:00") ? "selected" : "" %>>16:30</option>
									  	<option value="17:00:00" <%= sEndTime.equals("17:00:00") ? "selected" : "" %>>17:00</option>
									  	<option value="17:30:00" <%= sEndTime.equals("17:30:00") ? "selected" : "" %>>17:30</option>								  	
							 		   	<option value="18:00:00" <%= sEndTime.equals("18:00:00") ? "selected" : "" %>>18:00</option>
									  	<option value="18:30:00" <%= sEndTime.equals("18:30:00") ? "selected" : "" %>>18:30</option>	
									  	<option value="19:00:00" <%= sEndTime.equals("19:00:00") ? "selected" : "" %>>19:00</option>
									  	<option value="19:30:00" <%= sEndTime.equals("19:30:00") ? "selected" : "" %>>19:30</option>									  									  								  	
									  	<option value="20:00:00" <%= sEndTime.equals("20:00:00") ? "selected" : "" %>>20:00</option>
									  	<option value="20:30:00" <%= sEndTime.equals("20:30:00") ? "selected" : "" %>>20:30</option>	
									  	<option value="21:00:00" <%= sEndTime.equals("21:00:00") ? "selected" : "" %>>21:00</option>
									  	<option value="21:30:00" <%= sEndTime.equals("21:30:00") ? "selected" : "" %>>21:30</option>									  									  								  	
									  	<option value="22:00:00" <%= sEndTime.equals("22:00:00") ? "selected" : "" %>>22:00</option>
							 	 	<%}else{%>
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
								 <%} %>						 		
						 		</select>								
							</div>
							<div class="col-md-2" id="divTothours_<%= sJobWorkerId %>" style="<%=sDisplanyDiv%>">	
								<input type="text" class="form-control font-weight-bold" name="tot_hours_<%= sJobWorkerId %>" id="tot_hours_<%= sJobWorkerId %>" value="<%= sTimeDiff %>" readonly>						
							</div>
							<label class="ErrorLabel" id="Error_<%= sJobWorkerId %>">The Start Time cannot be smaller than the End Time</label>
						</div>
						<hr>			 		
				  <% 		    	
					}
	 			 	rs.close();
				 }
				 conn.close();
	 			 %>	 			 	
	 			 </div>		
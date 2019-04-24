			<div class="container">
				<%
				
				 ConnectionDB db = new ConnectionDB();
				 Connection conn = db.getConnection();
				 
				 String sSql = "";	
				 String sSqlWA ="";
				 String JobWorkerId ="";
				 String sStartTime ="";
				 String sEndTime ="";		
				 
				 if(conn != null) {					 
					 sSql = "SELECT id, first_name, last_name " + 
				 		    "  FROM worker " +
				 		    " WHERE inactive = 'N' ";
					 
					 System.out.println("updateWorker uno:" + sSql);
				 
					 Statement stmt = conn.createStatement();
					 ResultSet rs  = stmt.executeQuery(sSql); 
				 
					 while (rs.next()) { 
						 String WorkerId = rs.getString("id");	
						 String sDisplanyDiv = "display:none";
					
					 	 sSqlWA = "SELECT a.id, a.worker_id, a.start_time, a.end_time" +		      			 		
		   						  "  FROM job_details a " +		  
		  						  " WHERE a.job_id = " + request.getAttribute("JobId") +
		  						  "   AND a.worker_id = " + WorkerId;						   
					   
					 	 System.out.println("updateWorker dos:" + sSqlWA);
					 	  Statement stmtWA = conn.createStatement();
						  ResultSet rsWA  = stmtWA.executeQuery(sSqlWA);
					  
						  if(rsWA.next()){
					 		  JobWorkerId = rsWA.getString("a.worker_id");
					 		  sStartTime = rsWA.getString("a.start_time");
					 		  sEndTime = rsWA.getString("a.end_time");	
					 		  sDisplanyDiv = "display:block";
						  }
						  
					  %>	
					 				 	 
						 <div class="row">
							 <div class="custom-control custom-checkbox">								 
								 	<input type="checkbox" 
								 		   class="custom-control-input"
								 		   name="worker_<%= rs.getString("id") %>" 
								 		   id="worker_<%= rs.getString("id") %>" 
								 		   value="<%= rs.getString("id") %>" 
								 		   onclick="ShowStarEndTime(<%= rs.getString("id")%>);"
								 		   <%= WorkerId.equals(JobWorkerId) ? "checked" : "" %>>
								 		  
								 	<label class="custom-control-label labelColorSmall" 
								 		   for="worker_<%= rs.getString("id") %>">							 		
				  					    <%= rs.getString("first_name") %>, <%= rs.getString("last_name") %>
							        </label>								
							 </div>			  		
					  	 </div>					  	 
						 <div class="row" id="error_<%= rs.getString("id")%>">	
						 </div>
						 
					  	 <div class="row">	
							<div class="col-md-5" id="divStartTime_<%= rs.getString("id")%>" style="<%=sDisplanyDiv%>" >
								<select name="startTime_<%= rs.getString("id")%>" 
										id="startTime_<%= rs.getString("id")%>" 
										class="form-control"
										onchange="ValidTime(<%= rs.getString("id")%>)">
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
								 </select>
							</div>
							<div class="col-md-5" id="divEndTime_<%= rs.getString("id")%>" style="<%=sDisplanyDiv%>">								
								<select name="endTime_<%= rs.getString("id")%>" 
										id="endTime_<%= rs.getString("id")%>" 
										class="form-control"
										onchange="ValidTime(<%= rs.getString("id")%>)">
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
						 		</select>								
							</div>
							<div class="col-md-2" id="divTothours_<%= rs.getString("id")%>" style="display:none">	
								<input type="text" class="form-control" name="tot_hours_<%= rs.getString("id")%>" id="tot_hours_<%= rs.getString("id")%>" value="" readonly>						
							</div>
						</div>
						<hr>				
										 		
				  <% 	rsWA.close();
				  
					 }			    	
				 
	 			 	rs.close();
				 }
				 conn.close();
	 			 %>
	 			 	
	 			 </div>	
	
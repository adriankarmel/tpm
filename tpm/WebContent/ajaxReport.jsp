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
    import = "ca.akarmel.tpm.dao.JobDetailsDAO"
%>  
	 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	ConnectionDB db = new ConnectionDB();
	Connection conn = db.getConnection();
	
	String pType      = request.getParameter("Type");
	String pStartDate = request.getParameter("StartDate");
	String pEndDate   = request.getParameter("EndDate");	
	
	String sSql = "";
	String body ="";				
	switch(pType) {
		case "customer" :
	
			if(conn != null) { 
				
			      sSql = "SELECT distinct a.id, a.customer_id, b.first_name, " + 
			    		 "	  	 b.last_name, a.date" +
					     "  FROM job a " +
					     "  LEFT JOIN customer b ON a.customer_id = b.id  " +
			     		 " WHERE a.date BETWEEN " + "'" + pStartDate + "'" + " AND " + "'" + pEndDate + "'"; 
				      		 
			      //	System.out.println("ajaxreport:" + sSql);
			 
			    Statement stmt = conn.createStatement();
			    ResultSet rsReport = stmt.executeQuery(sSql); %> 
			    
			  	<div class="container"> 
			    	 <div class="row">
				    	 <div class="col-sm-12">
						     <% while (rsReport.next()) { %>		   					 					 
							 <div class="custom-control custom-checkbox">								 
							 	<input type="checkbox" 
							 		   class="custom-control-input"
							 		   name="Customer_<%= rsReport.getString("a.id") %>"
							 		   id="Customer_<%= rsReport.getString("a.id") %>" 
							 		   value="<%= rsReport.getString("a.id") %>" 
							 		   onclick="CheckCustomer(<%= rsReport.getString("a.id")%>)"
							 		   checked>
							 	<label class="custom-control-label labelColorSmall"
							 		   for="Customer_<%= rsReport.getString("a.id") %>">
						 			   <%= rsReport.getString("b.first_name") %>, 
						 			   <%= rsReport.getString("b.last_name")  %> 
						        </label>							  	
							 </div>  
							 <hr>					
				     	  	 <br>	 	
		 	   <%}%>
			   			</div>
				  		<hr> 	
			  		</div>
			  	</div>	
			   <% rsReport.close();
			 }
			 
			 conn.close();
			 break;
		case "worker" :				
		   	JobDetailsDAO jobDetails = new JobDetailsDAO();
			request.setAttribute("theJobDetail", jobDetails.ParametersReportByWorker(pStartDate, pEndDate));
			%>
			<c:forEach var="tempJobDetail" items="${theJobDetail}">
			   <div class="custom-control custom-checkbox">								 
				<input type="checkbox" 
					   class="custom-control-input"
					   name="JobWorker_${tempJobDetail.id}"
					   id="JobWorker_${tempJobDetail.id}" 
					   value="${tempJobDetail.id}" 					  
					   checked>
				<label class="custom-control-label labelColorSmall"
					   for="JobWorker_${tempJobDetail.id}">
						${tempJobDetail.workerName} 
				</label>
				<hr>
			  </div>			 
			</div>
			</c:forEach>	
			<%break;
	    default :
	        System.out.println("Invalid Report");	
	}	 
 %>	
 	 
		<div id="mySidenav" class="sidenav">
			  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
			  <a href="index.jsp">Jobs</a>
			  <hr style="color: #ffffff; border-top: 1px solid #ccc">
  			  <a href="customers.jsp">Customers</a>
  			  <a href="workers.jsp">Workers</a>
  			  <hr style="color: #ffffff; border-top: 1px solid #ccc">
			  <a href="reports.jsp">Reports</a>
			  <hr style="color: #ffffff; border-top: 1px solid #ccc">
			  <a href="config.jsp">Config</a>
  			  <hr style="color: #ffffff; border-top: 1px solid #ccc">
			  <a href="help.jsp">Help</a>			  	  
		</div>
		
		<div id="main" class="main">
		  <span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776</span>		  
		</div>
		
		<br>
		
		<script type="text/javascript">
			function openNav() {
			    document.getElementById("mySidenav").style.width = "250px";
			    document.getElementById("main").style.marginLeft = "250px";
			}
			
			function closeNav() {
			    document.getElementById("mySidenav").style.width = "0";
			    document.getElementById("main").style.marginLeft= "0";
			}
			
			window.onscroll = function() {scrollFunction()};
			
			function scrollFunction() {
				if (document.body.scrollTop > 2 || document.documentElement.scrollTop > 2) {
					document.getElementById("myBtn").style.display = "block";
				} else {
					document.getElementById("myBtn").style.display = "none";
				}
			}
			
			// When the user clicks on the button, scroll to the top of the document
			function topFunction() {
				document.documentElement.scrollTop = 0;
			}
		</script>	
	function submitSearchJobs(){				
		index.Action.value='Search';
		index.submit();
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
		document.body.scrollTop = 0;
		document.documentElement.scrollTop = 0;
	}

	// ---------- start JOB FORM ------------ //  
		
	function submitJobForm(){
		if(validaJobForm()){
			SoloMuestraHorasWrongEnRojo();
			if (checkStartTimeGreaterThanEndTime()){
				Workers();				
				job.Action.value = 'Save';
				job.submit();
			}	
		}
	}
	
	function SoloMuestraHorasWrongEnRojo(){
 		 	  		
		var frm = document.getElementById("job");						
			
		for (i=0;i<frm.elements.length;i++){
			
			if (frm.elements[i].type == "checkbox"){
				
				var chkName = document.getElementById(frm.elements[i].name);
					
				if (chkName.checked){				
					
					vTothours = "tot_hours_" + frm.elements[i].value;
					vError    = frm.elements[i].value;
					
					var vST = document.getElementById(vTothours).value;	
										
					if (vST.indexOf("-") != -1 || vST == "00:00"){
						getErrorRedColorDiffHourField(vError);
					}	
				}	
			}	
		}			
	}
	
  	function checkStartTimeGreaterThanEndTime(){
  		
  		var isValidHour = true;  	  		
		var frm = document.getElementById("job");						
			
		for (i=0;i<frm.elements.length;i++){
			
			if (frm.elements[i].type == "checkbox"){
				
				var chkName = document.getElementById(frm.elements[i].name);
					
				if (chkName.checked){				
					
					vTothours = "tot_hours_" + frm.elements[i].value;
					vError    = frm.elements[i].value;
					
					var vST = document.getElementById(vTothours).value;	
										
					if (vST.indexOf("-") != -1 || vST == "00:00"){
						getErrorRedColorDiffHourField(vError);
						isValidHour = false;
						break;
					}	
				}	
			}	
		}
		
		return isValidHour;
	}	
	
	function Workers(){		
		var sAux = "";		
		var frm = document.getElementById("job");						
		var vWInfo = document.getElementById("wInfo");
		var vConcatWorker ="";
		
		var theWorker = "";
		
		for (i=0;i<frm.elements.length;i++){
			
			if (frm.elements[i].type == "checkbox"){
				
				var chkName = document.getElementById(frm.elements[i].name);
					
				if (chkName.checked){				
					vWorkerId =  frm.elements[i].value;
					vStartTimeId = "startTime_" + frm.elements[i].value;
					vEndTimeId   = "endTime_"   + frm.elements[i].value;
		
					var vST =  document.getElementById(vStartTimeId).value;	
					var vED =  document.getElementById(vEndTimeId).value;	
					
					theWorker = theWorker + "{" + "\"" + "id" 		 + "\": " + "\"" + vWorkerId + "\"," 
										  + 	  "\"" + "startTime" + "\": " + "\"" + vST       + "\"," 
										  + 	  "\"" + "endTime"	 + "\": " + "\"" + vED	     + "\"" 
										  + "},";
				}	
			}
			
			/*	sAux += "NOMBRE: " + frm.elements[i].name + " ";
				sAux += "TIPO :  " + frm.elements[i].type + " ";
				sAux += "VALOR:  " + frm.elements[i].value + "\n"; */	
		}
		 
		var worker = '[' + theWorker.substring(0, theWorker.length-1) + ']';
		
		document.getElementById("wInfo").value = worker;
		
		console.log(worker);
	}
	
	function AsignaCustomer(pCustomerId, pCustomerFirstName, pCustomerLastName){
		//console.log(pCustomerId + "-" + pCustomerFirstName);
		var custId = document.getElementById("CustomerId");
		var custName = document.getElementById("CustomerName");	  		
		
		custId.value = pCustomerId;
		custName.value = pCustomerFirstName + ", " + pCustomerLastName;		  				  			
	}
	
	function validaJobForm(){
		var isValid = true;
		
		if(document.getElementById("CustomerName").value == ""){
			getErrorRedColor("CustomerName");
			isValid = false;
		}
		
		if(document.getElementById("datepicker").value == ""){
			getErrorRedColor("datepicker");
			isValid = false;
		}
		
		return isValid;
	}
	
	function ShowStarEndTime(CheckId){
		
		//	console.log("pepe:" + document.getElementById("worker_" + CheckId).value);

			var chboxs = document.getElementById("worker_" + CheckId);
			
			//document.getElementById("worker_" + CheckId).style.color = "#ff0000";
			
			if (chboxs.checked){				
			 	document.getElementById("divStartTime_" + CheckId).style.display = "block";
			 	document.getElementById("divEndTime_" + CheckId).style.display = "block";
			 	document.getElementById("divTothours_" + CheckId).style.display = "block";
			 	//chboxs.style.color = "#cc0066";
			 	//document.getElementById("worker_" + CheckId).style.fontWeight = "bold";
			 	//document.getElementById("worker_" + CheckId).style.color = "#cc0066"; 
			}else{							 	
				document.getElementById("divStartTime_" + CheckId).style.display = "none";
			 	document.getElementById("divEndTime_" + CheckId).style.display = "none";
			 	document.getElementById("divTothours_" + CheckId).style.display = "none";			 							 
			//	document.getElementById("worker_" + CheckId).style.fontWeight = "normal";
  		   //	document.getElementById("worker_" + CheckId).style.color = "black"; 
			 	//chboxs.style.color = "blue";
			} 	
		//	console.log("chboxs: " + chboxs + "CheckId: " + CheckId);
		//	chboxs.style.color = '#ff0000';
	}					
	
	//---------- end JOB FORM ------------ //

	
	//---------- start CUSTOMER FORM ------------ //
	
	function submitCustomerForm(){	
		if(validaCustomerForm()){
			customer.Action.value='Save';
			customer.submit();
		}	
	}
	
	function validaCustomerForm(){
		var isValid = true;
		
		if(document.getElementById("FirstName").value == ""){
			getErrorRedColor("FirstName");
			isValid = false;
		}
				
	/*	if(document.getElementById("LastName").value == ""){
			getErrorRedColor("LastName");
			isValid = false;
		}
	*/		
		if(document.getElementById("Address").value == ""){
			getErrorRedColor("Address");
			isValid = false;
		}		
		/*
		if(document.getElementById("CountryId").value == ""){
			getErrorRedColor("CountryId");
			isValid = false;
		}		

		if(document.getElementById("ProvinceId").value == ""){
			getErrorRedColor("ProvinceId");
			isValid = false;
		}		

		if(document.getElementById("PostalCode").value == ""){
			getErrorRedColor("PostalCode");
			isValid = false;
		}		

		if(document.getElementById("PhoneOne").value == ""){
			getErrorRedColor("PhoneOne");
			isValid = false;
		}	
	*/	
		return isValid;
	}
	
	//---------- end CUSTOMER FORM ------------ //
	
	//---------- start WORKER FORM ------------ //
	
	function submitWorkerForm(){
		if(validaWorkerForm()){
			worker.Action.value='Save';
			worker.submit();
		}	
	}	

	function validaWorkerForm(){
		var isValid = true;
		
		if(document.getElementById("FirstName").value == ""){
			getErrorRedColor("FirstName");
			isValid = false;
		}
		
		if(document.getElementById("Email").value == ""){
			getErrorRedColor("Email");
			isValid = false;
		}
		
		if(document.getElementById("HourRate").value == ""){
			getErrorRedColor("HourRate");
			isValid = false;
		}
		
		return isValid;
	}	
	
	// ---------- end WORKER FORM ------------ //	
	
	// ---------- start REPORT FORM ------------ //
	
	function CheckCustomer(CustomerId){
		console.log(CustomerId);
	}
	
	function CheckJobWorker(JobWorkerId){
		console.log(JobWorkerId);
	}
	
	// ---------- end REPORT FORM ------------ //
	
	function getErrorRedColor(pField){	
		
		//console.log("pField: " + pField);
  		var sfield = document.getElementById(pField);
  		var slabel = document.getElementById("Error_" + pField);
  		
  		sfield.style.borderColor = "#CC0000";
  		slabel.style.display = "block";		  		
  	}
	
	function getErrorRedColorDiffHourField(pField){	
		
		var sfield = document.getElementById("tot_hours_" + pField);
  		var slabel = document.getElementById("Error_" + pField);
  		
  		sfield.style.borderColor = "#CC0000";
  		slabel.style.display = "block";		  		
  	}


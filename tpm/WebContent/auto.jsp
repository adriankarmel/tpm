
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    
    	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
   <!--  <script type="text/javascript" src="JS/jquery-1.4.2.min.js"></script> -->
    <script src="js/autocomplete-0.3.0.js"></script>
</head>
<body>
    <div style="width: 300px; margin: 50px auto;">
        <b>Country</b>   : <input type="text" id="country" name="country" class="input_text"/>
    </div>
 
</body>
<script>
$("#country").autocomplete({
    source: availableTags,
    messages: {
        noResults: '',
        results: function() {}
    }
});

  /*  jQuery(function(){
        $("#country").autocomplete("list1.jsp");
    });
  */
</script>
</html>
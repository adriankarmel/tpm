package ca.akarmel.tpm.test;

public class test {

	public static void main(String[] args) {

		String[] words = "1 09:00:00 17:00:00 998 12:30:00 19:00:00".split(",");
	    int itemCount = words.length;
		   System.out.println("The number of words is: " + itemCount);
		    
		   String id = "";
		   String start = "";
		   String end = "";
		   
		   String Mystring ="";
		   
		   for (int i = 0; i < itemCount; i++) {
		     // String word = words[i];  
		     	    	  
	    	  id = words[0];
	    	  start = words[1];
	    	  end = words[2];
	    	  
	    	  if (itemCount % 3 == 1) {
	    		  Mystring = "insert " + words[i] + " " +  words[i+1] + " " +  words[i+1] ;
	    		  System.out.println(Mystring);
	    	  }else{
	    		  Mystring = "";
	    	  }
		    
		   }	 
	}

}

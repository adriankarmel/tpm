package ca.akarmel.utilities;

import java.io.IOException;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

public class Utilities {

	public static void redispatcher(ServletRequest request, ServletResponse response, String target, HttpServlet servlet) throws ServletException, IOException {
		
		  RequestDispatcher rd;
		  
		  rd = servlet.getServletContext().getRequestDispatcher(target);
		  rd.forward(request, response);
	}
	
	public String getTotalHourAmount(int pHour, int pMin, float pHourRate) {
		
		System.out.println("getTotalHourAmount pHour : " + pHour); 
		System.out.println("getTotalHourAmount pMin : " + pMin);
		float TotalAmount = 0;	
		
		float HourAmount = 0;
		float HalftHourAmount = 0;
		float HalfHourRate = 0;
		
		HourAmount = pHour * pHourRate;
		if (pMin == 30) {
			HalfHourRate = pHourRate / 2;
		}
		 		

		System.out.println("getTotalHourAmount HourAmount : " + HourAmount);
		HalftHourAmount = HalfHourRate;
		
		TotalAmount = HourAmount + HalftHourAmount;		
		
		return String.format("%,.2f", TotalAmount);
		
	}
}
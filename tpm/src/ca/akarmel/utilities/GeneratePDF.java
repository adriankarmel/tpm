package ca.akarmel.utilities;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

public class GeneratePDF {	
		
	public static ByteArrayOutputStream xx(HttpServletRequest request, HttpServletResponse response) throws IOException {
		 HttpSession session = request.getSession();
        
		// String jrxmlFile = "../" + request.getContextPath() + "/WEB-INF/pdf/";
		 String filename = "adr.pdf";
        String message = "pdf adrian";        
       
	   
    //    System.out.println("jrxmlFile: " + filename);
        
       PDDocument doc = new PDDocument();
	        try
	        {
	            PDPage page = new PDPage();
	            doc.addPage(page);
	            
	            PDFont font = PDType1Font.HELVETICA_BOLD;

	            PDPageContentStream contents = new PDPageContentStream(doc, page);
	            contents.beginText();
	            contents.setFont(font, 12);
	            contents.newLineAtOffset(100, 700);
	            contents.showText(message);
	            contents.endText();
	            contents.close();
	            
	            doc.save(filename);
	        }
	        finally
	        {
	            doc.close();
	        }
			return null;
	    }
	
	public static ByteArrayOutputStream getPDF(ResultSet rss) throws IOException, SQLException {
		        
		String filename = "adrian.pdf";
		String message  = rss.getString("workerName") + ":=:" +  rss.getString("customerName"); 
       
		PDDocument doc = new PDDocument();
	        try
	        {
	            PDPage page = new PDPage();
	            doc.addPage(page);
	            
	            PDFont font = PDType1Font.HELVETICA_BOLD;

	            PDPageContentStream contents = new PDPageContentStream(doc, page);
	            contents.beginText();
	            contents.setFont(font, 12);
	            contents.newLineAtOffset(100, 700);
	            contents.showText(message);
	            contents.newLine();
	            contents.endText();
	            contents.close();
	            
	            doc.save(filename);
	        }
	        finally
	        {
	            doc.close();
	        }
			return null;
	    }	   	
    }
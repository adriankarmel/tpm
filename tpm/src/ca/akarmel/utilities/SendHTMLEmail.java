package ca.akarmel.utilities;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

public class SendHTMLEmail { 
	
	public static void pepe() {
	 try{

	        Properties props = new Properties();
	        props.put("mail.smtp.host", "smtp.mail.yahoo.com"); // for gmail use smtp.gmail.com
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.debug", "true"); 
	        props.put("mail.smtp.starttls.enable", "true");
	        props.put("mail.smtp.port", "465");
	        props.put("mail.smtp.socketFactory.port", "465");
	        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	        props.put("mail.smtp.socketFactory.fallback", "false");

	        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {

	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication("username@yahoo.com", "password");
	            }
	        });

	        mailSession.setDebug(true); // Enable the debug mode

	        Message msg = new MimeMessage( mailSession );

	        //--[ Set the FROM, TO, DATE and SUBJECT fields
	        msg.setFrom( new InternetAddress( "adriankarmel@hotmail.com" ) );
	        msg.setRecipients( Message.RecipientType.TO,InternetAddress.parse("adriankarmel@gmail.com") );
	        msg.setSentDate( new Date());
	        msg.setSubject( "Hello World!" );

	        //--[ Create the body of the mail
	        msg.setText( "Hello from my first e-mail sent with JavaMail" );

	        //--[ Ask the Transport class to send our mail message
	        Transport.send( msg );

	    }catch(Exception E){
	        System.out.println( "Oops something has gone pearshaped!");
	        System.out.println( E );
	    }
	}
}

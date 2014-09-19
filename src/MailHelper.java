package tunebazaar;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

/**
 *
 * @author jsage8
 */
public class MailHelper {
    public static void sendMail(String to, String from, String subject, String body, boolean bodyIsHTML) throws MessagingException {
        // 1 - get a mail session
        Properties props = new Properties();
//        props.put("mail.smtp.host", "smtp.johnshopkins.edu");
//        Session session = Session.getDefaultInstance(props);
//        session.setDebug(true);
        
        // Test using gmail
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
          new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("jsage8", "neverknowsbest8");
                }
          });
        
        
        // 2 - create a message
        Message message = new MimeMessage(session);
        message.setSubject(subject);
        if(bodyIsHTML) {
            message.setContent(body, "text/html");
        }
        else {
            message.setText(body);
        }
        
        // 3 - address the message
        Address fromAddress = new InternetAddress(from);
        Address toAddress = new InternetAddress(to);
        message.setFrom(fromAddress);
        message.setRecipient(Message.RecipientType.TO, toAddress);
        
        // 4 - send the message
        Transport.send(message);
    }
}

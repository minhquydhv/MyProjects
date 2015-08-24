/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package objects;


import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Admin
 */
public class SendMail {

    public SendMail() {
    }

            
    public boolean send(String to, String from, String psw,
            String subject, String body) throws Exception {
        boolean kt = false;
        try {
            String smtpServer = "smtp.gmail.com";
            Properties props = System.getProperties();
            props.put("mail.smtp.host", smtpServer);
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.starttls.enable", "true");
            final String login = from;
            final String pwd = psw;
            Authenticator pa = null;
            if (login != null && pwd != null) {
                props.put("mail.smtp.auth", "true");
                pa = new Authenticator() {
                    @Override
                    public PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(login, pwd);
                    }
                };
            }
            Session session = Session.getInstance(props, pa);
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(
                    to, false));
            msg.setSubject(subject);
            msg.setText(body);//Để gởi nội dung dạng utf-8 các bạn dùng 
            msg.setContent(body,"text/html; charset=UTF-8");
            msg.setHeader("X-Mailer", "LOTONtechEmail");
            msg.setSentDate(new Date());
            msg.saveChanges();
            Transport.send(msg);
            kt = true;
        } catch (MessagingException e) {
            System.out.print(e.toString());
        }
        return kt;
    }
}

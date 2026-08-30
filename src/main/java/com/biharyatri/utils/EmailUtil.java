package com.biharyatri.utils;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

    // SMTP Settings (can be overridden by environment variables or properties)
    private static final String SMTP_HOST = System.getProperty("smtp.host", "smtp.gmail.com");
    private static final String SMTP_PORT = System.getProperty("smtp.port", "587");
    private static final String SMTP_USER = System.getProperty("smtp.user", ""); // Add email here
    private static final String SMTP_PASS = System.getProperty("smtp.pass", ""); // Add app-password here

    /**
     * Sends an email notification. Falls back to console log if SMTP credentials are not configured.
     */
    public static boolean sendEmail(String toEmail, String subject, String htmlContent) {
        System.out.println("=================================================");
        System.out.println("TRIGGERING EMAIL SEND ACTION:");
        System.out.println("To: " + toEmail);
        System.out.println("Subject: " + subject);
        System.out.println("Content Preview:\n" + htmlContent.replaceAll("<[^>]*>", " ").substring(0, Math.min(200, htmlContent.length())) + "...");
        System.out.println("=================================================");

        // If credentials are not set, return true as mock success
        if (SMTP_USER.isEmpty() || SMTP_PASS.isEmpty()) {
            System.out.println("[Email Service Status] SMTP Credentials not configured. Logged to console as fallback.");
            return true;
        }

        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);

            Session session = Session.getInstance(props, new javax.mail.Authenticator() {
                protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                    return new javax.mail.PasswordAuthentication(SMTP_USER, SMTP_PASS);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_USER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("[Email Service Status] Email sent successfully to " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println("[Email Service Error] Failed to send email via SMTP: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}

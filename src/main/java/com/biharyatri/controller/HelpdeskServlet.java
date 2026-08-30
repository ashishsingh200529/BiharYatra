package com.biharyatri.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biharyatri.config.DBConnection;

@WebServlet("/contact")
public class HelpdeskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/user/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (name == null || email == null || message == null) {
            response.sendRedirect(request.getContextPath() + "/contact?error=Invalid+Form+Data");
            return;
        }

        String sql = "INSERT INTO service_bookings (booking_type, user_name, user_phone, service_title, booking_details, total_amount, status) VALUES ('HELPDESK', ?, ?, ?, ?, 0.00, 'PENDING')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, subject != null ? subject : "General Helpdesk Inquiry");
            ps.setString(4, message);
            ps.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String msg = java.net.URLEncoder.encode("Your complaint/query ticket has been logged and sent to Admin. Ticket Ref: HD-" + (System.currentTimeMillis() % 10000), java.nio.charset.StandardCharsets.UTF_8);
        response.sendRedirect(request.getContextPath() + "/contact?success=" + msg);
    }
}

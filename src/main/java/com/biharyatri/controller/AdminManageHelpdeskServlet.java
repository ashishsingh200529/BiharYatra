package com.biharyatri.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biharyatri.config.DBConnection;

@WebServlet("/admin/helpdesk")
public class AdminManageHelpdeskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Map<String, Object>> tickets = new ArrayList<>();
        String sql = "SELECT * FROM service_bookings WHERE booking_type = 'HELPDESK' ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", rs.getInt("id"));
                map.put("name", rs.getString("user_name"));
                map.put("contact", rs.getString("user_phone"));
                map.put("subject", rs.getString("service_title"));
                map.put("message", rs.getString("booking_details"));
                map.put("status", rs.getString("status"));
                map.put("createdAt", rs.getTimestamp("created_at"));
                tickets.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("tickets", tickets);
        request.getRequestDispatcher("/views/admin/manage-helpdesk.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        String status = request.getParameter("status");

        if (idStr != null && status != null) {
            String sql = "UPDATE service_bookings SET status = ? WHERE id = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                
                ps.setString(1, status);
                ps.setInt(2, Integer.parseInt(idStr));
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/helpdesk?success=Ticket+Status+Updated");
    }
}

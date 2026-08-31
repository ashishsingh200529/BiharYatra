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

@WebServlet("/admin/users")
public class AdminManageUsersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Map<String, Object>> users = new ArrayList<>();
        String sql = "SELECT id, name, email, phone, password, role, status, created_at FROM users ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", rs.getInt("id"));
                map.put("name", rs.getString("name"));
                map.put("email", rs.getString("email"));
                map.put("phone", rs.getString("phone"));
                String pass = rs.getString("password");
                map.put("authMethod", (pass == null || pass.equals("GOOGLE_SSO")) ? "Google 1-Click SSO" : "Local Account (BCrypt Encrypted)");
                map.put("passHash", pass != null ? (pass.length() > 20 ? pass.substring(0, 15) + "..." : pass) : "N/A (Google SSO)");
                map.put("role", rs.getString("role"));
                map.put("status", rs.getString("status"));
                map.put("createdAt", rs.getTimestamp("created_at"));
                users.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("userList", users);
        request.getRequestDispatcher("/views/admin/manage-users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String userIdStr = request.getParameter("userId");
        String status = request.getParameter("status");

        if (userIdStr != null && status != null) {
            String sql = "UPDATE users SET status = ? WHERE id = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                
                ps.setString(1, status);
                ps.setInt(2, Integer.parseInt(userIdStr));
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/users?success=User+Status+Updated");
    }
}

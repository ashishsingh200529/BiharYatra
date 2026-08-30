package com.biharyatri.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

import com.biharyatri.config.DBConnection;
import com.biharyatri.model.Admin;

public class AdminDAO {

    /**
     * Authenticates an admin by username and password.
     */
    public Admin loginAdmin(String username, String password) {
        String sql = "SELECT * FROM admins WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashedPassword = rs.getString("password");
                    if (BCrypt.checkpw(password, hashedPassword)) {
                        return new Admin(
                            rs.getInt("id"),
                            rs.getString("username"),
                            null, // Don't expose password
                            rs.getString("name"),
                            rs.getString("role"),
                            rs.getTimestamp("created_at")
                        );
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

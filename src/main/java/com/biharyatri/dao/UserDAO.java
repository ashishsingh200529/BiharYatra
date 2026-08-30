package com.biharyatri.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

import com.biharyatri.config.DBConnection;
import com.biharyatri.model.User;

public class UserDAO {

    /**
     * Registers a new user. Hashes the password securely with BCrypt.
     */
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (name, email, password, phone, role, status) VALUES (?, ?, ?, ?, 'USER', 'ACTIVE')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Hash the password with BCrypt
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt(10));

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, hashedPassword);
            ps.setString(4, user.getPhone());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Authenticates a user by email and password.
     */
    public User loginUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND status = 'ACTIVE'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashedPassword = rs.getString("password");
                    // Verify bcrypt password
                    if (BCrypt.checkpw(password, hashedPassword)) {
                        return new User(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            null, // Don't expose password
                            rs.getString("phone"),
                            rs.getString("role"),
                            rs.getString("status"),
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

    /**
     * Finds an existing user by email or creates a new Google SSO user.
     */
    public User findOrCreateGoogleUser(String email, String name) {
        String selectSql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(selectSql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        null,
                        rs.getString("phone"),
                        rs.getString("role"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // If user doesn't exist, create new Google user
        String insertSql = "INSERT INTO users (name, email, password, phone, role, status) VALUES (?, ?, ?, ?, 'USER', 'ACTIVE')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            String randomHash = BCrypt.hashpw("GOOGLE_SSO_" + System.currentTimeMillis(), BCrypt.gensalt(10));
            ps.setString(1, name != null && !name.isEmpty() ? name : "Google Tourist");
            ps.setString(2, email);
            ps.setString(3, randomHash);
            ps.setString(4, "+91 99999 99999");

            if (ps.executeUpdate() > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int id = generatedKeys.getInt(1);
                        return new User(id, name, email, null, "+91 99999 99999", "USER", "ACTIVE", new java.sql.Timestamp(System.currentTimeMillis()));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Finds a user by email (useful for forgot password check).
     */
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("role"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Updates user details (profile update).
     */
    public boolean updateUserProfile(int id, String name, String phone) {
        String sql = "UPDATE users SET name = ?, phone = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setInt(3, id);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Resets password (hashes the new password with BCrypt).
     */
    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt(10));
            ps.setString(1, hashedPassword);
            ps.setString(2, email);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lists all registered users (for admin panel).
     */
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                users.add(new User(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    null,
                    rs.getString("phone"),
                    rs.getString("role"),
                    rs.getString("status"),
                    rs.getTimestamp("created_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    /**
     * Toggles a user's status (ACTIVE / BLOCKED) (for admin actions).
     */
    public boolean toggleUserStatus(int id, String status) {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get total user count.
     */
    public int getTotalUsersCount() {
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'USER'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}

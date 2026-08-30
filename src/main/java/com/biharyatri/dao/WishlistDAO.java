package com.biharyatri.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.biharyatri.config.DBConnection;
import com.biharyatri.model.TourPackage;

public class WishlistDAO {

    public boolean addToWishlist(int userId, int packageId) {
        String checkSql = "SELECT id FROM wishlist WHERE user_id = ? AND package_id = ?";
        String insertSql = "INSERT INTO wishlist (user_id, package_id) VALUES (?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkPs = conn.prepareStatement(checkSql)) {
            
            checkPs.setInt(1, userId);
            checkPs.setInt(2, packageId);
            try (ResultSet rs = checkPs.executeQuery()) {
                if (rs.next()) {
                    return true; // Already exists
                }
            }

            try (PreparedStatement insertPs = conn.prepareStatement(insertSql)) {
                insertPs.setInt(1, userId);
                insertPs.setInt(2, packageId);
                return insertPs.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean removeFromWishlist(int userId, int packageId) {
        String sql = "DELETE FROM wishlist WHERE user_id = ? AND package_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, packageId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<TourPackage> getWishlistByUser(int userId) {
        List<TourPackage> list = new ArrayList<>();
        String sql = "SELECT p.* FROM packages p JOIN wishlist w ON p.id = w.package_id WHERE w.user_id = ? AND p.status = 'ACTIVE'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TourPackage pkg = new TourPackage(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("duration_days"),
                        rs.getInt("duration_nights"),
                        rs.getString("start_location"),
                        rs.getString("difficulty"),
                        rs.getBoolean("is_featured"),
                        rs.getString("status")
                    );
                    list.add(pkg);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean isInWishlist(int userId, int packageId) {
        String sql = "SELECT id FROM wishlist WHERE user_id = ? AND package_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, packageId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

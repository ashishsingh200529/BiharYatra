package com.biharyatri.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.biharyatri.config.DBConnection;
import com.biharyatri.model.Review;

public class ReviewDAO {

    /**
     * Inserts a new user review for a package.
     */
    public boolean addReview(Review review) {
        String sql = "INSERT INTO reviews (user_id, package_id, rating, comment) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, review.getUserId());
            ps.setInt(2, review.getPackageId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lists all reviews for a specific tour package.
     */
    public List<Review> getReviewsByPackageId(int packageId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, u.name as user_name FROM reviews r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "WHERE r.package_id = ? ORDER BY r.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, packageId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review rev = new Review(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getInt("package_id"),
                        rs.getInt("rating"),
                        rs.getString("comment"),
                        rs.getTimestamp("created_at")
                    );
                    rev.setUserName(rs.getString("user_name"));
                    list.add(rev);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

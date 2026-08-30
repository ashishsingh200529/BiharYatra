package com.biharyatri.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.biharyatri.config.DBConnection;
import com.biharyatri.model.PartnerApplication;

public class PartnerDAO {

    public boolean saveApplication(PartnerApplication app) {
        String sql = "INSERT INTO partner_applications (full_name, mobile, partner_type, district, id_number, experience_details, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, app.getFullName());
            ps.setString(2, app.getMobile());
            ps.setString(3, app.getPartnerType());
            ps.setString(4, app.getDistrict());
            ps.setString(5, app.getIdNumber());
            ps.setString(6, app.getExperienceDetails());
            ps.setString(7, app.getStatus() != null ? app.getStatus() : "PENDING");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<PartnerApplication> getAllApplications() {
        List<PartnerApplication> list = new ArrayList<>();
        String sql = "SELECT * FROM partner_applications ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                PartnerApplication app = new PartnerApplication(
                    rs.getInt("id"),
                    rs.getString("full_name"),
                    rs.getString("mobile"),
                    rs.getString("partner_type"),
                    rs.getString("district"),
                    rs.getString("id_number"),
                    rs.getString("experience_details"),
                    rs.getString("status"),
                    rs.getTimestamp("created_at")
                );
                list.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE partner_applications SET status = ? WHERE id = ?";
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
}

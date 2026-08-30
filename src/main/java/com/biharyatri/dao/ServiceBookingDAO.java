package com.biharyatri.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.biharyatri.config.DBConnection;
import com.biharyatri.model.ServiceBooking;

public class ServiceBookingDAO {

    public boolean saveServiceBooking(ServiceBooking booking) {
        String sql = "INSERT INTO service_bookings (booking_type, user_name, user_phone, service_title, booking_details, total_amount, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, booking.getBookingType());
            ps.setString(2, booking.getUserName());
            ps.setString(3, booking.getUserPhone());
            ps.setString(4, booking.getServiceTitle());
            ps.setString(5, booking.getBookingDetails());
            ps.setBigDecimal(6, booking.getTotalAmount());
            ps.setString(7, booking.getStatus() != null ? booking.getStatus() : "PENDING");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<ServiceBooking> getAllServiceBookings() {
        List<ServiceBooking> list = new ArrayList<>();
        String sql = "SELECT * FROM service_bookings ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                ServiceBooking b = new ServiceBooking(
                    rs.getInt("id"),
                    rs.getString("booking_type"),
                    rs.getString("user_name"),
                    rs.getString("user_phone"),
                    rs.getString("service_title"),
                    rs.getString("booking_details"),
                    rs.getBigDecimal("total_amount"),
                    rs.getString("status"),
                    rs.getTimestamp("created_at")
                );
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE service_bookings SET status = ? WHERE id = ?";
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

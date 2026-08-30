package com.biharyatri.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.biharyatri.config.DBConnection;
import com.biharyatri.model.Payment;

public class PaymentDAO {

    public boolean recordPayment(Payment payment) {
        if (payment.getPaymentNo() == null || payment.getPaymentNo().trim().isEmpty()) {
            payment.setPaymentNo("PAY-" + (System.currentTimeMillis() % 1000000) + "-" + (int)(Math.random() * 900 + 100));
        }

        String sql = "INSERT INTO payments (payment_no, booking_id, razorpay_order_id, razorpay_payment_id, razorpay_signature, amount, payment_method, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, payment.getPaymentNo());
            ps.setInt(2, payment.getBookingId());
            ps.setString(3, payment.getRazorpayOrderId());
            ps.setString(4, payment.getRazorpayPaymentId());
            ps.setString(5, payment.getRazorpaySignature());
            ps.setDouble(6, payment.getAmount());
            ps.setString(7, payment.getPaymentMethod());
            ps.setString(8, payment.getStatus());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lists all payments (Admin View).
     */
    public List<Payment> getAllPayments() {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT p.*, b.booking_no, u.email as user_email " +
                     "FROM payments p " +
                     "JOIN bookings b ON p.booking_id = b.id " +
                     "JOIN users u ON b.user_id = u.id " +
                     "ORDER BY p.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Payment pay = new Payment(
                    rs.getInt("id"),
                    rs.getString("payment_no"),
                    rs.getInt("booking_id"),
                    rs.getString("razorpay_order_id"),
                    rs.getString("razorpay_payment_id"),
                    rs.getString("razorpay_signature"),
                    rs.getDouble("amount"),
                    rs.getString("payment_method"),
                    rs.getString("status"),
                    rs.getTimestamp("created_at")
                );
                pay.setBookingNo(rs.getString("booking_no"));
                pay.setUserEmail(rs.getString("user_email"));
                list.add(pay);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

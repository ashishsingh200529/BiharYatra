package com.biharyatri.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.biharyatri.config.DBConnection;
import com.biharyatri.model.Hotel;
import com.biharyatri.model.Room;

public class HotelDAO {

    /**
     * Lists hotels based on district filters.
     */
    public List<Hotel> getHotelsByDistrict(String district) {
        List<Hotel> list = new ArrayList<>();
        String sql = "SELECT * FROM hotels";
        if (district != null && !district.trim().isEmpty()) {
            sql += " WHERE district = ?";
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (district != null && !district.trim().isEmpty()) {
                ps.setString(1, district);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Hotel hotel = new Hotel(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("district"),
                        rs.getString("address"),
                        rs.getDouble("rating"),
                        rs.getString("description"),
                        rs.getString("image_url")
                    );
                    hotel.setRooms(getRoomsForHotel(conn, hotel.getId()));
                    list.add(hotel);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private List<Room> getRoomsForHotel(Connection conn, int hotelId) throws SQLException {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE hotel_id = ? AND is_available = TRUE";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, hotelId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Room(
                        rs.getInt("id"),
                        rs.getInt("hotel_id"),
                        rs.getString("room_type"),
                        rs.getDouble("price_per_night"),
                        rs.getInt("capacity"),
                        rs.getString("amenities"),
                        rs.getBoolean("is_available")
                    ));
                }
            }
        }
        return list;
    }
}

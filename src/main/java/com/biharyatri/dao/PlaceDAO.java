package com.biharyatri.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.biharyatri.config.DBConnection;
import com.biharyatri.model.Place;

public class PlaceDAO {

    /**
     * Lists all destinations in Bihar.
     */
    public List<Place> getAllPlaces() {
        List<Place> list = new ArrayList<>();
        String sql = "SELECT * FROM places ORDER BY district ASC, name ASC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                list.add(new Place(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getString("district"),
                    rs.getDouble("latitude"),
                    rs.getDouble("longitude"),
                    rs.getString("image_url"),
                    rs.getString("best_time_to_visit")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Finds a single place by its ID.
     */
    public Place getPlaceById(int id) {
        String sql = "SELECT * FROM places WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Place(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("district"),
                        rs.getDouble("latitude"),
                        rs.getDouble("longitude"),
                        rs.getString("image_url"),
                        rs.getString("best_time_to_visit")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

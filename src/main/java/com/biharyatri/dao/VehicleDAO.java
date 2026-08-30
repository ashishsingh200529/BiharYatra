package com.biharyatri.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.biharyatri.config.DBConnection;
import com.biharyatri.model.Vehicle;

public class VehicleDAO {

    /**
     * Lists all available vehicles.
     */
    public List<Vehicle> getAllAvailableVehicles() {
        List<Vehicle> list = new ArrayList<>();
        String sql = "SELECT * FROM vehicles WHERE is_available = TRUE";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                list.add(new Vehicle(
                    rs.getInt("id"),
                    rs.getString("type"),
                    rs.getString("model"),
                    rs.getInt("capacity"),
                    rs.getDouble("price_per_km"),
                    rs.getDouble("price_per_day"),
                    rs.getString("driver_name"),
                    rs.getString("driver_phone"),
                    rs.getBoolean("is_available")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

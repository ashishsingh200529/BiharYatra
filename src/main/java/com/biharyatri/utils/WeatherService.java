package com.biharyatri.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;
import com.biharyatri.config.DBConnection;

public class WeatherService {

    private static final long CACHE_EXPIRY_MS = 6 * 60 * 60 * 1000; // 6 hours cache

    public static class WeatherData {
        public String city;
        public double temp;
        public String condition;
        public int humidity;

        public WeatherData(String city, double temp, String condition, int humidity) {
            this.city = city;
            this.temp = temp;
            this.condition = condition;
            this.humidity = humidity;
        }
    }

    /**
     * Obtains the weather data for a particular Bihar district.
     * Uses DB caching or fallback calculations.
     */
    public static WeatherData getWeatherData(String district) {
        if (district == null || district.trim().isEmpty()) {
            district = "Patna";
        }
        
        district = district.substring(0, 1).toUpperCase() + district.substring(1).toLowerCase();

        // 1. Try to read from database cache
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT temp, condition_text, humidity, updated_at FROM weather_cache WHERE city = ?")) {
            
            ps.setString(1, district);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    double temp = rs.getDouble("temp");
                    String cond = rs.getString("condition_text");
                    int hum = rs.getInt("humidity");
                    Timestamp updatedAt = rs.getTimestamp("updated_at");

                    // Check if cache is still fresh
                    if (Instant.now().toEpochMilli() - updatedAt.getTime() < CACHE_EXPIRY_MS) {
                        return new WeatherData(district, temp, cond, hum);
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("[WeatherService Exception] Database cache read failed: " + e.getMessage());
        }

        // 2. Fetch/Simulate new weather details (Mock API generator)
        WeatherData freshData = fetchMockWeather(district);

        // 3. Update database cache
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO weather_cache (city, temp, condition_text, humidity, updated_at) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP) " +
                     "ON DUPLICATE KEY UPDATE temp = VALUES(temp), condition_text = VALUES(condition_text), humidity = VALUES(humidity), updated_at = CURRENT_TIMESTAMP")) {
            
            ps.setString(1, freshData.city);
            ps.setDouble(2, freshData.temp);
            ps.setString(3, freshData.condition);
            ps.setInt(4, freshData.humidity);
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("[WeatherService Exception] Database cache write failed: " + e.getMessage());
        }

        return freshData;
    }

    private static WeatherData fetchMockWeather(String district) {
        // Base temperatures for Bihar districts
        Map<String, Double> bases = new HashMap<>();
        bases.put("Patna", 32.0);
        bases.put("Gaya", 34.0);
        bases.put("Nalanda", 31.0);
        bases.put("Rajgir", 30.0);
        bases.put("Rohtas", 33.0);
        bases.put("West Champaran", 28.0);
        bases.put("Bhagalpur", 31.5);
        bases.put("Muzaffarpur", 30.5);

        double baseTemp = bases.getOrDefault(district, 30.0);
        // Add minor random fluctuation (-2 to +2 C)
        double offset = (Math.random() * 4) - 2;
        double temp = Math.round((baseTemp + offset) * 10.0) / 10.0;

        String[] conditions = {"Sunny", "Partly Cloudy", "Hazy", "Mostly Clear", "Humid"};
        int index = (int) (Math.random() * conditions.length);
        String cond = conditions[index];
        int humidity = 55 + (int) (Math.random() * 25); // 55% to 80%

        return new WeatherData(district, temp, cond, humidity);
    }
}

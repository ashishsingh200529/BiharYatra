package com.biharyatri.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.biharyatri.config.DBConnection;
import com.biharyatri.model.Itinerary;
import com.biharyatri.model.Place;
import com.biharyatri.model.TourPackage;

public class PackageDAO {

    /**
     * Lists all active tour packages.
     */
    public List<TourPackage> getActivePackages(String search, String startLoc, Double maxPrice) {
        List<TourPackage> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM packages WHERE status = 'ACTIVE'");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (title LIKE ? OR description LIKE ?)");
        }
        if (startLoc != null && !startLoc.trim().isEmpty()) {
            sql.append(" AND start_location = ?");
        }
        if (maxPrice != null && maxPrice > 0) {
            sql.append(" AND price <= ?");
        }
        
        sql.append(" ORDER BY id DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                String likePattern = "%" + search.trim() + "%";
                ps.setString(paramIndex++, likePattern);
                ps.setString(paramIndex++, likePattern);
            }
            if (startLoc != null && !startLoc.trim().isEmpty()) {
                ps.setString(paramIndex++, startLoc);
            }
            if (maxPrice != null && maxPrice > 0) {
                ps.setDouble(paramIndex++, maxPrice);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TourPackage pkg = mapRowToPackage(rs);
                    // Fetch primary image url
                    pkg.setImageUrls(getPackageImages(conn, pkg.getId()));
                    list.add(pkg);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Gets featured packages for the home screen slider.
     */
    public List<TourPackage> getFeaturedPackages() {
        List<TourPackage> list = new ArrayList<>();
        String sql = "SELECT * FROM packages WHERE status = 'ACTIVE' AND is_featured = TRUE LIMIT 4";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                TourPackage pkg = mapRowToPackage(rs);
                pkg.setImageUrls(getPackageImages(conn, pkg.getId()));
                list.add(pkg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Fetches detailed package information (itinerary, places, images).
     */
    public TourPackage getPackageById(int packageId) {
        String sql = "SELECT * FROM packages WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, packageId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    TourPackage pkg = mapRowToPackage(rs);
                    pkg.setImageUrls(getPackageImages(conn, packageId));
                    pkg.setPlaces(getPackagePlaces(conn, packageId));
                    pkg.setItineraries(getPackageItineraries(conn, packageId));
                    return pkg;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Adds a new package (Admin operation).
     */
    public boolean addPackage(TourPackage pkg, List<String> imageUrls) {
        String sql = "INSERT INTO packages (title, description, price, duration_days, duration_nights, start_location, difficulty, is_featured, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Begin Transaction
            
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, pkg.getTitle());
                ps.setString(2, pkg.getDescription());
                ps.setDouble(3, pkg.getPrice());
                ps.setInt(4, pkg.getDurationDays());
                ps.setInt(5, pkg.getDurationNights());
                ps.setString(6, pkg.getStartLocation());
                ps.setString(7, pkg.getDifficulty());
                ps.setBoolean(8, pkg.isFeatured());
                ps.setString(9, pkg.getStatus());

                int affected = ps.executeUpdate();
                if (affected == 0) {
                    conn.rollback();
                    return false;
                }

                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int packageId = generatedKeys.getInt(1);
                        pkg.setId(packageId);
                        // Add package images
                        if (imageUrls != null && !imageUrls.isEmpty()) {
                            String imgSql = "INSERT INTO package_images (package_id, image_url, is_primary) VALUES (?, ?, ?)";
                            try (PreparedStatement imgPs = conn.prepareStatement(imgSql)) {
                                boolean first = true;
                                for (String url : imageUrls) {
                                    imgPs.setInt(1, packageId);
                                    imgPs.setString(2, url);
                                    imgPs.setBoolean(3, first);
                                    imgPs.addBatch();
                                    first = false;
                                }
                                imgPs.executeBatch();
                            }
                        }
                    }
                }
            }
            conn.commit(); // Commit Transaction
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            return false;
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    /**
     * Updates an existing package.
     */
    public boolean updatePackage(TourPackage pkg) {
        String sql = "UPDATE packages SET title = ?, description = ?, price = ?, duration_days = ?, duration_nights = ?, start_location = ?, difficulty = ?, is_featured = ?, status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, pkg.getTitle());
            ps.setString(2, pkg.getDescription());
            ps.setDouble(3, pkg.getPrice());
            ps.setInt(4, pkg.getDurationDays());
            ps.setInt(5, pkg.getDurationNights());
            ps.setString(6, pkg.getStartLocation());
            ps.setString(7, pkg.getDifficulty());
            ps.setBoolean(8, pkg.isFeatured());
            ps.setString(9, pkg.getStatus());
            ps.setInt(10, pkg.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete/Toggle package status (Admin operation).
     */
    public boolean togglePackageStatus(int id, String status) {
        String sql = "UPDATE packages SET status = ? WHERE id = ?";
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
     * Saves or replaces day-wise itineraries for a package.
     */
    public boolean saveItineraries(int packageId, List<Itinerary> itineraries) {
        if (itineraries == null) return false;
        String deleteSql = "DELETE FROM itineraries WHERE package_id = ?";
        String insertSql = "INSERT INTO itineraries (package_id, day_number, title, activity_details, meals_included, accommodation) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement psDel = conn.prepareStatement(deleteSql)) {
                psDel.setInt(1, packageId);
                psDel.executeUpdate();
            }
            if (!itineraries.isEmpty()) {
                try (PreparedStatement psIns = conn.prepareStatement(insertSql)) {
                    for (Itinerary it : itineraries) {
                        psIns.setInt(1, packageId);
                        psIns.setInt(2, it.getDayNumber());
                        psIns.setString(3, it.getTitle() != null && !it.getTitle().trim().isEmpty() ? it.getTitle() : "Day " + it.getDayNumber());
                        psIns.setString(4, it.getActivityDetails() != null ? it.getActivityDetails() : "");
                        psIns.setString(5, it.getMealsIncluded() != null && !it.getMealsIncluded().trim().isEmpty() ? it.getMealsIncluded() : "Breakfast");
                        psIns.setString(6, it.getAccommodation() != null && !it.getAccommodation().trim().isEmpty() ? it.getAccommodation() : "Hotel Stay");
                        psIns.addBatch();
                    }
                    psIns.executeBatch();
                }
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Saves or replaces stops covered (places) for a package.
     */
    public boolean savePackagePlaces(int packageId, List<Integer> placeIds) {
        String deleteSql = "DELETE FROM package_places WHERE package_id = ?";
        String insertSql = "INSERT INTO package_places (package_id, place_id, sequence_order) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement psDel = conn.prepareStatement(deleteSql)) {
                psDel.setInt(1, packageId);
                psDel.executeUpdate();
            }
            if (placeIds != null && !placeIds.isEmpty()) {
                try (PreparedStatement psIns = conn.prepareStatement(insertSql)) {
                    int seq = 1;
                    for (Integer pId : placeIds) {
                        psIns.setInt(1, packageId);
                        psIns.setInt(2, pId);
                        psIns.setInt(3, seq++);
                        psIns.addBatch();
                    }
                    psIns.executeBatch();
                }
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ==========================================
    // HELPER METHODS (Private/Internal JDBC)
    // ==========================================

    private TourPackage mapRowToPackage(ResultSet rs) throws SQLException {
        return new TourPackage(
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
    }

    private List<String> getPackageImages(Connection conn, int packageId) throws SQLException {
        List<String> list = new ArrayList<>();
        String sql = "SELECT image_url FROM package_images WHERE package_id = ? ORDER BY is_primary DESC, id ASC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, packageId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getString("image_url"));
                }
            }
        }
        // Fallback placeholder image if none exists
        if (list.isEmpty()) {
            list.add("https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?auto=format&fit=crop&w=800&q=80");
        }
        return list;
    }

    private List<Place> getPackagePlaces(Connection conn, int packageId) throws SQLException {
        List<Place> list = new ArrayList<>();
        String sql = "SELECT p.* FROM places p JOIN package_places pp ON p.id = pp.place_id WHERE pp.package_id = ? ORDER BY pp.sequence_order ASC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, packageId);
            try (ResultSet rs = ps.executeQuery()) {
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
            }
        }
        return list;
    }

    private List<Itinerary> getPackageItineraries(Connection conn, int packageId) throws SQLException {
        List<Itinerary> list = new ArrayList<>();
        String sql = "SELECT * FROM itineraries WHERE package_id = ? ORDER BY day_number ASC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, packageId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Itinerary(
                        rs.getInt("id"),
                        rs.getInt("package_id"),
                        rs.getInt("day_number"),
                        rs.getString("title"),
                        rs.getString("activity_details"),
                        rs.getString("meals_included"),
                        rs.getString("accommodation")
                    ));
                }
            }
        }
        return list;
    }

    /**
     * Get total packages count.
     */
    public int getTotalPackagesCount() {
        String sql = "SELECT COUNT(*) FROM packages";
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

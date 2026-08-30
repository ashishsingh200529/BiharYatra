package com.biharyatri.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biharyatri.dao.PackageDAO;
import com.biharyatri.dao.PlaceDAO;
import com.biharyatri.model.Itinerary;
import com.biharyatri.model.Place;
import com.biharyatri.model.TourPackage;

@WebServlet("/admin/packages")
public class AdminManagePackagesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PackageDAO packageDAO;
    private PlaceDAO placeDAO;

    @Override
    public void init() throws ServletException {
        packageDAO = new PackageDAO();
        placeDAO = new PlaceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        List<Place> allPlaces = placeDAO.getAllPlaces();
        request.setAttribute("allPlaces", allPlaces);

        if ("edit".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            TourPackage pkg = packageDAO.getPackageById(id);
            request.setAttribute("pkg", pkg);
            request.getRequestDispatcher("/views/admin/edit-package.jsp").forward(request, response);
            return;
        }

        List<TourPackage> list = packageDAO.getActivePackages(null, null, null);
        request.setAttribute("packages", list);
        request.getRequestDispatcher("/views/admin/manage-packages.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int days = Integer.parseInt(request.getParameter("days"));
            int nights = Integer.parseInt(request.getParameter("nights"));
            String startLoc = request.getParameter("startLocation");
            String difficulty = request.getParameter("difficulty");
            boolean featured = request.getParameter("isFeatured") != null;
            String imageUrl = request.getParameter("imageUrl");

            TourPackage pkg = new TourPackage();
            pkg.setTitle(title);
            pkg.setDescription(description);
            pkg.setPrice(price);
            pkg.setDurationDays(days);
            pkg.setDurationNights(nights);
            pkg.setStartLocation(startLoc);
            pkg.setDifficulty(difficulty);
            pkg.setFeatured(featured);
            pkg.setStatus("ACTIVE");

            List<String> images = new ArrayList<>();
            if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                images.add(imageUrl);
            }

            boolean success = packageDAO.addPackage(pkg, images);
            if (success) {
                // Process Day-wise Itineraries & Stops Covered
                saveItineraryFromRequest(request, pkg.getId());
                savePlacesFromRequest(request, pkg.getId());

                String msg = java.net.URLEncoder.encode("Package added successfully with itineraries & stops!", java.nio.charset.StandardCharsets.UTF_8);
                response.sendRedirect(request.getContextPath() + "/admin/packages?success=" + msg);
            } else {
                String msg = java.net.URLEncoder.encode("Failed to add package.", java.nio.charset.StandardCharsets.UTF_8);
                response.sendRedirect(request.getContextPath() + "/admin/packages?error=" + msg);
            }
        } else if ("update".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int days = Integer.parseInt(request.getParameter("days"));
            int nights = Integer.parseInt(request.getParameter("nights"));
            String startLoc = request.getParameter("startLocation");
            String difficulty = request.getParameter("difficulty");
            boolean featured = request.getParameter("isFeatured") != null;
            String status = request.getParameter("status");

            TourPackage pkg = packageDAO.getPackageById(id);
            if (pkg != null) {
                pkg.setTitle(title);
                pkg.setDescription(description);
                pkg.setPrice(price);
                pkg.setDurationDays(days);
                pkg.setDurationNights(nights);
                pkg.setStartLocation(startLoc);
                pkg.setDifficulty(difficulty);
                pkg.setFeatured(featured);
                pkg.setStatus(status);

                boolean success = packageDAO.updatePackage(pkg);
                if (success) {
                    // Update Day-wise Itineraries & Stops Covered
                    saveItineraryFromRequest(request, pkg.getId());
                    savePlacesFromRequest(request, pkg.getId());

                    String msg = java.net.URLEncoder.encode("Package updated successfully!", java.nio.charset.StandardCharsets.UTF_8);
                    response.sendRedirect(request.getContextPath() + "/admin/packages?success=" + msg);
                } else {
                    String msg = java.net.URLEncoder.encode("Failed to update package.", java.nio.charset.StandardCharsets.UTF_8);
                    response.sendRedirect(request.getContextPath() + "/admin/packages?error=" + msg);
                }
            }
        } else if ("toggle".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            packageDAO.togglePackageStatus(id, status);
            String msg = java.net.URLEncoder.encode("Package status updated!", java.nio.charset.StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/admin/packages?success=" + msg);
        }
    }

    private void saveItineraryFromRequest(HttpServletRequest request, int packageId) {
        String[] dayTitles = request.getParameterValues("day_title[]");
        String[] dayActivities = request.getParameterValues("day_activity[]");
        String[] dayMeals = request.getParameterValues("day_meals[]");
        String[] dayStays = request.getParameterValues("day_stay[]");

        if (dayTitles != null && dayTitles.length > 0) {
            List<Itinerary> itineraries = new ArrayList<>();
            for (int i = 0; i < dayTitles.length; i++) {
                String title = dayTitles[i];
                if (title != null && !title.trim().isEmpty()) {
                    Itinerary it = new Itinerary();
                    it.setPackageId(packageId);
                    it.setDayNumber(i + 1);
                    it.setTitle(title.trim());
                    it.setActivityDetails(dayActivities != null && i < dayActivities.length ? dayActivities[i].trim() : "");
                    it.setMealsIncluded(dayMeals != null && i < dayMeals.length ? dayMeals[i].trim() : "Breakfast");
                    it.setAccommodation(dayStays != null && i < dayStays.length ? dayStays[i].trim() : "Hotel Stay");
                    itineraries.add(it);
                }
            }
            packageDAO.saveItineraries(packageId, itineraries);
        }
    }

    private void savePlacesFromRequest(HttpServletRequest request, int packageId) {
        String[] placeIdsStr = request.getParameterValues("place_ids[]");
        if (placeIdsStr != null && placeIdsStr.length > 0) {
            List<Integer> placeIds = new ArrayList<>();
            for (String pidStr : placeIdsStr) {
                try {
                    placeIds.add(Integer.parseInt(pidStr));
                } catch (NumberFormatException e) {
                    // skip invalid
                }
            }
            packageDAO.savePackagePlaces(packageId, placeIds);
        }
    }
}

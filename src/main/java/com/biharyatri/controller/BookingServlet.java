package com.biharyatri.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.biharyatri.dao.BookingDAO;
import com.biharyatri.dao.HotelDAO;
import com.biharyatri.dao.PackageDAO;
import com.biharyatri.dao.VehicleDAO;
import com.biharyatri.model.Booking;
import com.biharyatri.model.BookingDetail;
import com.biharyatri.model.Hotel;
import com.biharyatri.model.TourPackage;
import com.biharyatri.model.User;
import com.biharyatri.model.Vehicle;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PackageDAO packageDAO;
    private HotelDAO hotelDAO;
    private VehicleDAO vehicleDAO;
    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        packageDAO = new PackageDAO();
        hotelDAO = new HotelDAO();
        vehicleDAO = new VehicleDAO();
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String packageIdStr = request.getParameter("packageId");
        if (packageIdStr == null || packageIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/packages");
            return;
        }

        try {
            int packageId = Integer.parseInt(packageIdStr);
            TourPackage pkg = packageDAO.getPackageById(packageId);

            if (pkg == null) {
                response.sendRedirect(request.getContextPath() + "/packages");
                return;
            }

            // Load upgrades
            List<Hotel> hotels = hotelDAO.getHotelsByDistrict(null);
            List<Vehicle> vehicles = vehicleDAO.getAllAvailableVehicles();

            request.setAttribute("tourPackage", pkg);
            request.setAttribute("hotels", hotels);
            request.setAttribute("vehicles", vehicles);

            request.getRequestDispatcher("/views/user/booking.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/packages");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            int packageId = Integer.parseInt(request.getParameter("packageId"));
            String travelDateStr = request.getParameter("travelDate");
            String numTravelersStr = request.getParameter("numTravelers");

            if (travelDateStr == null || travelDateStr.trim().isEmpty()) {
                travelDateStr = new java.sql.Date(System.currentTimeMillis() + 86400000).toString();
            }

            int numTravelers = (numTravelersStr != null && !numTravelersStr.trim().isEmpty()) ? Integer.parseInt(numTravelersStr) : 1;
            
            // Upgrades
            String hotelUpgradePriceStr = request.getParameter("hotelUpgradePrice"); // Price per night
            String vehicleUpgradePriceStr = request.getParameter("vehicleUpgradePrice"); // Price per day
            String foodUpgradePriceStr = request.getParameter("foodUpgradePrice"); // Price per person

            double hotelPrice = (hotelUpgradePriceStr != null && !hotelUpgradePriceStr.trim().isEmpty()) ? Double.parseDouble(hotelUpgradePriceStr) : 0.0;
            double vehiclePrice = (vehicleUpgradePriceStr != null && !vehicleUpgradePriceStr.trim().isEmpty()) ? Double.parseDouble(vehicleUpgradePriceStr) : 0.0;
            double foodPrice = (foodUpgradePriceStr != null && !foodUpgradePriceStr.trim().isEmpty()) ? Double.parseDouble(foodUpgradePriceStr) : 0.0;

            TourPackage pkg = packageDAO.getPackageById(packageId);
            if (pkg == null) {
                response.sendRedirect(request.getContextPath() + "/packages");
                return;
            }

            // Calculate Pricing
            int nights = pkg.getDurationNights();
            int days = pkg.getDurationDays();
            double total = (pkg.getPrice() * numTravelers) 
                         + (hotelPrice * nights) 
                         + (vehiclePrice * days) 
                         + (foodPrice * numTravelers * days);

            // Map passenger list arrays
            String[] names = request.getParameterValues("traveler_name[]");
            String[] ages = request.getParameterValues("traveler_age[]");
            String[] genders = request.getParameterValues("traveler_gender[]");

            List<BookingDetail> details = new ArrayList<>();
            if (names != null) {
                for (int i = 0; i < names.length; i++) {
                    if (names[i] != null && !names[i].trim().isEmpty()) {
                        BookingDetail detail = new BookingDetail();
                        detail.setTravelerName(names[i]);
                        int age = 25;
                        if (ages != null && i < ages.length && ages[i] != null && !ages[i].trim().isEmpty()) {
                            try { age = Integer.parseInt(ages[i]); } catch (Exception ignored) {}
                        }
                        detail.setTravelerAge(age);
                        detail.setTravelerGender((genders != null && i < genders.length) ? genders[i] : "Male");
                        details.add(detail);
                    }
                }
            }

            // Fallback if passenger name was not populated
            if (details.isEmpty()) {
                BookingDetail defaultDetail = new BookingDetail();
                defaultDetail.setTravelerName(user.getName());
                defaultDetail.setTravelerAge(25);
                defaultDetail.setTravelerGender("Male");
                details.add(defaultDetail);
            }

            // Create Booking object
            Booking booking = new Booking();
            String bookingNo = "BY-" + (System.currentTimeMillis() % 1000000) + "-" + (int)(Math.random() * 900 + 100);
            booking.setBookingNo(bookingNo);
            booking.setUserId(user.getId());
            booking.setPackageId(packageId);
            
            Date travelDate;
            try {
                travelDate = Date.valueOf(travelDateStr);
            } catch (Exception ex) {
                travelDate = new Date(System.currentTimeMillis() + 86400000);
            }
            booking.setTravelDate(travelDate);
            booking.setNumTravelers(numTravelers);
            booking.setTotalPrice(total);
            booking.setStatus("PENDING");
            booking.setPaymentStatus("UNPAID");
            booking.setTravelers(details);

            boolean success = bookingDAO.createBooking(booking);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/payment?bookingNo=" + bookingNo);
            } else {
                String errorMsg = java.net.URLEncoder.encode("Booking generation failed. Try again.", java.nio.charset.StandardCharsets.UTF_8);
                response.sendRedirect(request.getContextPath() + "/booking?packageId=" + packageId + "&error=" + errorMsg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/packages");
        }
    }
}

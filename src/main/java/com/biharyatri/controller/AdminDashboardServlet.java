package com.biharyatri.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biharyatri.dao.BookingDAO;
import com.biharyatri.dao.PackageDAO;
import com.biharyatri.dao.PartnerDAO;
import com.biharyatri.dao.ServiceBookingDAO;
import com.biharyatri.dao.UserDAO;
import com.biharyatri.model.Booking;
import com.biharyatri.model.PartnerApplication;
import com.biharyatri.model.ServiceBooking;
import com.google.gson.Gson;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private PackageDAO packageDAO;
    private BookingDAO bookingDAO;
    private PartnerDAO partnerDAO;
    private ServiceBookingDAO serviceBookingDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        packageDAO = new PackageDAO();
        bookingDAO = new BookingDAO();
        partnerDAO = new PartnerDAO();
        serviceBookingDAO = new ServiceBookingDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action != null) {
            if ("approvePartner".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                partnerDAO.updateStatus(id, "APPROVED");
            } else if ("rejectPartner".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                partnerDAO.updateStatus(id, "REJECTED");
            } else if ("approveService".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                serviceBookingDAO.updateStatus(id, "CONFIRMED");
            } else if ("cancelService".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                serviceBookingDAO.updateStatus(id, "CANCELLED");
            }
        }

        int totalUsers = userDAO.getTotalUsersCount();
        int totalPackages = packageDAO.getTotalPackagesCount();
        int totalBookings = bookingDAO.getBookingsCount();
        double totalRevenue = bookingDAO.getTotalRevenue();

        Map<String, Object> monthlyData = bookingDAO.getMonthlyBookingAnalytics();
        Map<String, Integer> popularData = bookingDAO.getPopularPackageAnalytics();

        String monthlyJson = gson.toJson(monthlyData);
        String popularJson = gson.toJson(popularData);

        List<Booking> recentBookings = bookingDAO.getAllBookings();
        if (recentBookings.size() > 5) {
            recentBookings = recentBookings.subList(0, 5);
        }

        List<PartnerApplication> partnerApps = partnerDAO.getAllApplications();
        List<ServiceBooking> serviceBookings = serviceBookingDAO.getAllServiceBookings();

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalPackages", totalPackages);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("totalRevenue", totalRevenue);

        request.setAttribute("monthlyJson", monthlyJson);
        request.setAttribute("popularJson", popularJson);
        request.setAttribute("recentBookings", recentBookings);

        request.setAttribute("partnerApplications", partnerApps);
        request.setAttribute("serviceBookings", serviceBookings);

        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
    }
}

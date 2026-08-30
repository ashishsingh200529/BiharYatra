package com.biharyatri.controller;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biharyatri.dao.ServiceBookingDAO;
import com.biharyatri.model.ServiceBooking;

@WebServlet("/guides")
public class GuideServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ServiceBookingDAO serviceBookingDAO;

    @Override
    public void init() throws ServletException {
        serviceBookingDAO = new ServiceBookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/user/guides.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String guideName = request.getParameter("guideName");
        String userName = request.getParameter("userName");
        String userPhone = request.getParameter("userPhone");
        String hoursStr = request.getParameter("hours");
        String rateStr = request.getParameter("rate");

        int hours = hoursStr != null ? Integer.parseInt(hoursStr) : 4;
        double rate = rateStr != null ? Double.parseDouble(rateStr) : 500.0;
        double total = hours * rate;

        ServiceBooking booking = new ServiceBooking();
        booking.setBookingType("GUIDE");
        booking.setUserName(userName != null && !userName.trim().isEmpty() ? userName : "Tourist Customer");
        booking.setUserPhone(userPhone != null && !userPhone.trim().isEmpty() ? userPhone : "+91 98000 00000");
        booking.setServiceTitle("Private Guide: " + guideName);
        booking.setBookingDetails("Duration: " + hours + " Hours, Rate: Rs. " + (int)rate + "/hr");
        booking.setTotalAmount(new BigDecimal(total));
        booking.setStatus("PENDING");

        boolean success = serviceBookingDAO.saveServiceBooking(booking);
        if (success) {
            request.setAttribute("successMsg", "Guide Reservation Submitted! Admin will review and confirm your guide.");
        } else {
            request.setAttribute("errorMsg", "Failed to reserve guide. Please try again.");
        }
        request.getRequestDispatcher("/views/user/guides.jsp").forward(request, response);
    }
}

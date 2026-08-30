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

@WebServlet("/hotels")
public class HotelServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ServiceBookingDAO serviceBookingDAO;

    @Override
    public void init() throws ServletException {
        serviceBookingDAO = new ServiceBookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/user/hotels.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String hotelName = request.getParameter("hotelName");
        String userName = request.getParameter("userName");
        String userPhone = request.getParameter("userPhone");
        String nightsStr = request.getParameter("nights");
        String priceStr = request.getParameter("price");

        int nights = nightsStr != null ? Integer.parseInt(nightsStr) : 1;
        double price = priceStr != null ? Double.parseDouble(priceStr) : 2800.0;
        double total = nights * price;

        ServiceBooking booking = new ServiceBooking();
        booking.setBookingType("HOTEL");
        booking.setUserName(userName != null && !userName.trim().isEmpty() ? userName : "Hotel Guest");
        booking.setUserPhone(userPhone != null && !userPhone.trim().isEmpty() ? userPhone : "+91 98000 00000");
        booking.setServiceTitle("Hotel Stay: " + hotelName);
        booking.setBookingDetails("Stay Duration: " + nights + " Night(s), Rate: Rs. " + (int)price + "/night");
        booking.setTotalAmount(new BigDecimal(total));
        booking.setStatus("PENDING");

        boolean success = serviceBookingDAO.saveServiceBooking(booking);
        if (success) {
            request.setAttribute("successMsg", "Hotel Room Reserved! Admin will review and confirm your stay.");
        } else {
            request.setAttribute("errorMsg", "Failed to reserve room. Please try again.");
        }
        request.getRequestDispatcher("/views/user/hotels.jsp").forward(request, response);
    }
}

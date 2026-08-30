package com.biharyatri.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biharyatri.dao.PlaceDAO;
import com.biharyatri.dao.ServiceBookingDAO;
import com.biharyatri.model.Place;
import com.biharyatri.model.ServiceBooking;

@WebServlet("/cabs")
public class CabServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PlaceDAO placeDAO;
    private ServiceBookingDAO serviceBookingDAO;

    @Override
    public void init() throws ServletException {
        placeDAO = new PlaceDAO();
        serviceBookingDAO = new ServiceBookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Place> places = placeDAO.getAllPlaces();
        request.setAttribute("places", places);
        request.getRequestDispatcher("/views/user/cabs.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pickup = request.getParameter("pickup");
        String destination = request.getParameter("destination");
        String vehicle = request.getParameter("vehicle");
        String fareStr = request.getParameter("fare");
        String userName = request.getParameter("userName");
        String userPhone = request.getParameter("userPhone");

        double fare = fareStr != null ? Double.parseDouble(fareStr) : 1850.0;

        ServiceBooking booking = new ServiceBooking();
        booking.setBookingType("CAB");
        booking.setUserName(userName != null && !userName.trim().isEmpty() ? userName : "Cab Passenger");
        booking.setUserPhone(userPhone != null && !userPhone.trim().isEmpty() ? userPhone : "+91 98000 00000");
        booking.setServiceTitle("Cab: " + pickup + " ➔ " + destination);
        booking.setBookingDetails("Vehicle: " + (vehicle != null ? vehicle : "Sedan Dzire") + ", Fare: Rs. " + (int)fare);
        booking.setTotalAmount(new BigDecimal(fare));
        booking.setStatus("PENDING");

        boolean success = serviceBookingDAO.saveServiceBooking(booking);
        if (success) {
            request.setAttribute("successMsg", "Cab Booking Submitted! Admin will assign driver and confirm your ride.");
        } else {
            request.setAttribute("errorMsg", "Failed to book cab. Please try again.");
        }
        
        List<Place> places = placeDAO.getAllPlaces();
        request.setAttribute("places", places);
        request.getRequestDispatcher("/views/user/cabs.jsp").forward(request, response);
    }
}

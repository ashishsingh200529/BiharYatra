package com.biharyatri.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biharyatri.dao.BookingDAO;
import com.biharyatri.model.Booking;

@WebServlet("/admin/bookings")
public class AdminManageBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Booking> list = bookingDAO.getAllBookings();
        request.setAttribute("bookings", list);
        request.getRequestDispatcher("/views/admin/manage-bookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        if ("updateStatus".equalsIgnoreCase(action)) {
            String status = request.getParameter("status");
            bookingDAO.updateBookingStatus(bookingId, status);
            String msg = java.net.URLEncoder.encode("Booking status updated!", java.nio.charset.StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/admin/bookings?success=" + msg);
        } else if ("updatePayment".equalsIgnoreCase(action)) {
            String paymentStatus = request.getParameter("paymentStatus");
            bookingDAO.updatePaymentStatus(bookingId, paymentStatus);
            String msg = java.net.URLEncoder.encode("Payment status updated!", java.nio.charset.StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/admin/bookings?success=" + msg);
        }
    }
}

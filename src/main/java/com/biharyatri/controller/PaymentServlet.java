package com.biharyatri.controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biharyatri.dao.BookingDAO;
import com.biharyatri.dao.PaymentDAO;
import com.biharyatri.model.Booking;
import com.biharyatri.model.Payment;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO;
    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingNo = request.getParameter("bookingNo");
        if (bookingNo == null || bookingNo.trim().isEmpty()) {
            bookingNo = "BY-1001";
        }

        Booking booking = bookingDAO.getBookingByNo(bookingNo);
        if (booking == null) {
            booking = new Booking();
            booking.setBookingNo(bookingNo);
            booking.setPackageTitle("Bodh Gaya & Rajgir Heritage Tour");
            booking.setUserName("Rahul Kumar");
            booking.setUserEmail("rahul.kumar@gmail.com");
            booking.setNumTravelers(2);
            booking.setTotalPrice(10000.00);
            booking.setTravelDate(Date.valueOf(LocalDate.now().plusDays(3)));
            booking.setPaymentStatus("PENDING");
        }

        long amountInPaise = Math.round(booking.getTotalPrice() * 100);
        request.setAttribute("booking", booking);
        request.setAttribute("amountInPaise", amountInPaise);
        request.getRequestDispatcher("/views/user/payment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookingNo = request.getParameter("bookingNo");
        String razorpayPaymentId = request.getParameter("razorpay_payment_id");
        String razorpayOrderId = request.getParameter("razorpay_order_id");
        String razorpaySignature = request.getParameter("razorpay_signature");
        String paymentMethod = request.getParameter("payment_method");

        if (bookingNo == null || bookingNo.trim().isEmpty()) {
            bookingNo = "BY-" + (System.currentTimeMillis() % 1000000);
        }

        Booking booking = bookingDAO.getBookingByNo(bookingNo);
        if (booking != null) {
            bookingDAO.updatePaymentStatus(booking.getId(), "PAID");
            bookingDAO.updateBookingStatus(booking.getId(), "CONFIRMED");

            Payment payment = new Payment();
            String paymentNo = "PAY-" + System.currentTimeMillis() % 1000000;
            payment.setPaymentNo(paymentNo);
            payment.setBookingId(booking.getId());
            payment.setRazorpayOrderId(razorpayOrderId);
            payment.setRazorpayPaymentId(razorpayPaymentId);
            payment.setRazorpaySignature(razorpaySignature);
            payment.setAmount(booking.getTotalPrice());
            payment.setPaymentMethod(paymentMethod != null ? paymentMethod : "UPI / Card Gateway");
            payment.setStatus("CAPTURED");
            paymentDAO.recordPayment(payment);
        }

        String msg = java.net.URLEncoder.encode("Payment Completed Successfully!", java.nio.charset.StandardCharsets.UTF_8);
        response.sendRedirect(request.getContextPath() + "/ticket?bookingNo=" + bookingNo + "&success=" + msg);
    }
}

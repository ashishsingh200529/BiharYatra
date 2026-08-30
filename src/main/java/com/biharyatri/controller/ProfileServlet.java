package com.biharyatri.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.biharyatri.dao.BookingDAO;
import com.biharyatri.dao.UserDAO;
import com.biharyatri.dao.WishlistDAO;
import com.biharyatri.model.Booking;
import com.biharyatri.model.TourPackage;
import com.biharyatri.model.User;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private BookingDAO bookingDAO;
    private WishlistDAO wishlistDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        bookingDAO = new BookingDAO();
        wishlistDAO = new WishlistDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        
        // Fetch up-to-date user details, booking history, and wishlist
        User freshUser = userDAO.getUserByEmail(user.getEmail());
        List<Booking> bookings = bookingDAO.getBookingsByUserId(freshUser.getId());
        List<TourPackage> wishlist = wishlistDAO.getWishlistByUser(freshUser.getId());

        session.setAttribute("user", freshUser); // Update session
        request.setAttribute("bookings", bookings);
        request.setAttribute("wishlist", wishlist);

        request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
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
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");

        boolean success = userDAO.updateUserProfile(user.getId(), name, phone);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/profile?success=Profile updated successfully!");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?error=Failed to update profile details.");
        }
    }
}

package com.biharyatri.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.biharyatri.dao.WishlistDAO;
import com.biharyatri.model.User;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WishlistDAO wishlistDAO;

    @Override
    public void init() throws ServletException {
        wishlistDAO = new WishlistDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Please log in first.");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        String packageIdStr = request.getParameter("packageId");

        if (action == null || packageIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        try {
            int packageId = Integer.parseInt(packageIdStr);
            if ("add".equalsIgnoreCase(action)) {
                wishlistDAO.addToWishlist(user.getId(), packageId);
                response.sendRedirect(request.getContextPath() + "/package-details?id=" + packageId + "&success=Added to wishlist!");
            } else if ("remove".equalsIgnoreCase(action)) {
                wishlistDAO.removeFromWishlist(user.getId(), packageId);
                // Check if user came from profile wishlist tab
                String ref = request.getHeader("referer");
                if (ref != null && ref.contains("profile")) {
                    response.sendRedirect(request.getContextPath() + "/profile?success=Removed from wishlist!");
                } else {
                    response.sendRedirect(request.getContextPath() + "/package-details?id=" + packageId + "&success=Removed from wishlist!");
                }
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/packages");
        }
    }
}

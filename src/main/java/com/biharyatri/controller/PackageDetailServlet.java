package com.biharyatri.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.biharyatri.dao.PackageDAO;
import com.biharyatri.dao.ReviewDAO;
import com.biharyatri.dao.WishlistDAO;
import com.biharyatri.model.Review;
import com.biharyatri.model.TourPackage;
import com.biharyatri.model.User;

@WebServlet("/package-details")
public class PackageDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PackageDAO packageDAO;
    private ReviewDAO reviewDAO;
    private WishlistDAO wishlistDAO;

    @Override
    public void init() throws ServletException {
        packageDAO = new PackageDAO();
        reviewDAO = new ReviewDAO();
        wishlistDAO = new WishlistDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/packages");
            return;
        }

        try {
            int packageId = Integer.parseInt(idStr);
            TourPackage pkg = packageDAO.getPackageById(packageId);

            if (pkg == null) {
                response.sendRedirect(request.getContextPath() + "/packages");
                return;
            }

            List<Review> reviews = reviewDAO.getReviewsByPackageId(packageId);
            
            // Check wishlist status
            boolean inWishlist = false;
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                User user = (User) session.getAttribute("user");
                inWishlist = wishlistDAO.isInWishlist(user.getId(), packageId);
            }

            request.setAttribute("tourPackage", pkg);
            request.setAttribute("reviews", reviews);
            request.setAttribute("inWishlist", inWishlist);

            request.getRequestDispatcher("/views/user/package-details.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/packages");
        }
    }
}

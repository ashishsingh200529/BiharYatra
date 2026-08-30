package com.biharyatri.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biharyatri.dao.PackageDAO;
import com.biharyatri.model.TourPackage;

@WebServlet("/packages")
public class PackageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PackageDAO packageDAO;

    @Override
    public void init() throws ServletException {
        packageDAO = new PackageDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String search = request.getParameter("search");
        String startLocation = request.getParameter("startLocation");
        String maxPriceStr = request.getParameter("maxPrice");
        
        Double maxPrice = null;
        if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
            try {
                maxPrice = Double.parseDouble(maxPriceStr);
            } catch (NumberFormatException e) {
                // Ignore invalid numbers
            }
        }

        List<TourPackage> list = packageDAO.getActivePackages(search, startLocation, maxPrice);
        
        request.setAttribute("packagesList", list);
        request.setAttribute("searchVal", search);
        request.setAttribute("startLocationVal", startLocation);
        request.setAttribute("maxPriceVal", maxPriceStr);

        request.getRequestDispatcher("/views/user/packages.jsp").forward(request, response);
    }
}

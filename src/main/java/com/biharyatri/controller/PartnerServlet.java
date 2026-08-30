package com.biharyatri.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biharyatri.dao.PartnerDAO;
import com.biharyatri.model.PartnerApplication;

@WebServlet("/become-partner")
public class PartnerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PartnerDAO partnerDAO;

    @Override
    public void init() throws ServletException {
        partnerDAO = new PartnerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/user/become-partner.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String mobile = request.getParameter("mobile");
        String partnerType = request.getParameter("partnerType");
        String district = request.getParameter("district");
        String idNumber = request.getParameter("idNumber");
        String experienceDetails = request.getParameter("experienceDetails");

        PartnerApplication app = new PartnerApplication();
        app.setFullName(fullName);
        app.setMobile(mobile);
        app.setPartnerType(partnerType);
        app.setDistrict(district);
        app.setIdNumber(idNumber);
        app.setExperienceDetails(experienceDetails);
        app.setStatus("PENDING");

        boolean success = partnerDAO.saveApplication(app);
        if (success) {
            request.setAttribute("successMsg", "Partner Application Submitted Successfully! Admin will review and approve your application.");
        } else {
            request.setAttribute("errorMsg", "Failed to submit application. Please try again.");
        }
        request.getRequestDispatcher("/views/user/become-partner.jsp").forward(request, response);
    }
}

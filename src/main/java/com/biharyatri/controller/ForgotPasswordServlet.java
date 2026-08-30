package com.biharyatri.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biharyatri.dao.UserDAO;
import com.biharyatri.model.User;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/user/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("password");

        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("error", "No account registered with this email!");
            request.getRequestDispatcher("/views/user/forgot-password.jsp").forward(request, response);
            return;
        }

        boolean success = userDAO.updatePassword(email, newPassword);

        if (success) {
            String msg = java.net.URLEncoder.encode("Password reset successful! Please log in.", java.nio.charset.StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/login?success=" + msg);
        } else {
            request.setAttribute("error", "Failed to reset password. Try again later.");
            request.getRequestDispatcher("/views/user/forgot-password.jsp").forward(request, response);
        }
    }
}

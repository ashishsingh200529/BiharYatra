package com.biharyatri.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biharyatri.dao.UserDAO;
import com.biharyatri.model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/user/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        // Check if user already exists
        if (userDAO.getUserByEmail(email) != null) {
            request.setAttribute("error", "Email is already registered! Please log in.");
            request.getRequestDispatcher("/views/user/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);

        boolean success = userDAO.registerUser(user);

        if (success) {
            String msg = java.net.URLEncoder.encode("Registration successful! Please log in.", java.nio.charset.StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/login?success=" + msg);
        } else {
            request.setAttribute("error", "Registration failed! Please try again.");
            request.getRequestDispatcher("/views/user/register.jsp").forward(request, response);
        }
    }
}

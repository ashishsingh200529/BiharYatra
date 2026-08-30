package com.biharyatri.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.biharyatri.dao.UserDAO;
import com.biharyatri.model.User;

@WebServlet("/google-login")
public class GoogleLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String name = request.getParameter("name");

        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/views/user/login.jsp?error=Google authentication failed");
            return;
        }

        User user = userDAO.findOrCreateGoogleUser(email, name);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userName", user.getName());
            session.setAttribute("userRole", user.getRole());

            response.sendRedirect(request.getContextPath() + "/profile");
        } else {
            response.sendRedirect(request.getContextPath() + "/views/user/login.jsp?error=Unable to sign in with Google");
        }
    }
}

package com.biharyatri.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/views/user/profile.jsp", "/profile", "/booking", "/wishlist", "/payment", "/ticket"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            // Store target URI to redirect back after login
            String uri = httpRequest.getRequestURI();
            String query = httpRequest.getQueryString();
            String redirectUrl = uri + (query != null ? "?" + query : "");
            
            if (session == null) {
                session = httpRequest.getSession(true);
            }
            session.setAttribute("redirectAfterLogin", redirectUrl);
            
            String msg = java.net.URLEncoder.encode("Please login to access this page.", java.nio.charset.StandardCharsets.UTF_8);
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?error=" + msg);
        }
    }

    @Override
    public void destroy() {}
}

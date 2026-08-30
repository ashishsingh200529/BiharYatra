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

@WebFilter(filterName = "AdminFilter", urlPatterns = {"/views/admin/*", "/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String path = httpRequest.getRequestURI();
        boolean isLoginRequest = path.endsWith("/admin/login") || path.endsWith("/views/admin/login.jsp");
        boolean isAdminLoggedIn = (session != null && session.getAttribute("admin") != null);

        if (isAdminLoggedIn || isLoginRequest) {
            chain.doFilter(request, response);
        } else {
            String msg = java.net.URLEncoder.encode("Unauthorized Access! Please log in as admin.", java.nio.charset.StandardCharsets.UTF_8);
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin/login?error=" + msg);
        }
    }

    @Override
    public void destroy() {}
}

package com.biharyatri.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biharyatri.dao.PlaceDAO;
import com.biharyatri.model.Place;

@WebServlet("/ai-planner")
public class AIPlannerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PlaceDAO placeDAO;

    @Override
    public void init() throws ServletException {
        placeDAO = new PlaceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Place> places = placeDAO.getAllPlaces();
        request.setAttribute("places", places);
        request.getRequestDispatcher("/views/user/ai-planner.jsp").forward(request, response);
    }
}

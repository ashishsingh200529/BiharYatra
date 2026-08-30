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

@WebServlet("/map")
public class MapServlet extends HttpServlet {
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
        request.getRequestDispatcher("/views/user/map.jsp").forward(request, response);
    }
}

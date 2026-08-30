package com.biharyatri.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.biharyatri.utils.WeatherService;

@WebServlet("/api/weather")
public class WeatherServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String district = request.getParameter("district");
        WeatherService.WeatherData data = WeatherService.getWeatherData(district);

        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("city", data.city);
        jsonResponse.addProperty("temp", data.temp);
        jsonResponse.addProperty("condition", data.condition);
        jsonResponse.addProperty("humidity", data.humidity);

        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResponse.toString());
            out.flush();
        }
    }
}

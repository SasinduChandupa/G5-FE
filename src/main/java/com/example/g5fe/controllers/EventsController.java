package com.example.g5fe.controllers;

import com.example.g5fe.HttpClientHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.io.IOException;

@WebServlet("/students/events/search") // Matches the endpoint for searching events
public class EventsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Construct the URL with query parameters
            String query = request.getParameter("query");
            String eventType = request.getParameter("eventType");

            StringBuilder urlBuilder = new StringBuilder(
                    "https://virtserver.swaggerhub.com/MCHANUKA72/NibmEvex/1/students/events/search"
            );

            if (query != null || eventType != null) {
                urlBuilder.append("?");
                if (query != null) {
                    urlBuilder.append("query=").append(query);
                }
                if (eventType != null) {
                    if (query != null) {
                        urlBuilder.append("&");
                    }
                    urlBuilder.append("eventType=").append(eventType);
                }
            }

            // Fetch the response from the backend
            String backendResponse = HttpClientHelper.sendGetRequest(urlBuilder.toString());

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // Write the backend response to the HTTP response
            PrintWriter out = response.getWriter();
            out.print(backendResponse);
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching events");
        }
    }
}
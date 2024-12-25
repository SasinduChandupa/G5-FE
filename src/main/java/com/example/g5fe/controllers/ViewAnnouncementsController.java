package com.example.g5fe.controllers;

import com.example.g5fe.HttpClientHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.io.IOException;

@WebServlet("/announcements") // Matches the endpoint for the announcements view
public class ViewAnnouncementsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Call the backend API to fetch the list of announcements
            String backendResponse = HttpClientHelper.sendGetRequest(
                    "https://virtserver.swaggerhub.com/MCHANUKA72/NibmEvex/1/students/announcements"
            );

            // Set the content type to JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // Write the response back to the client
            PrintWriter out = response.getWriter();
            out.print(backendResponse);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching announcements");
        }
    }
}
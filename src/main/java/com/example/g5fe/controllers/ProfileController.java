package com.example.g5fe.controllers;

import com.example.g5fe.HttpClientHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/profile") // Ensure this endpoint matches the fetch call in your JSP
public class ProfileController extends HttpServlet {

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Read JSON input from request body
        StringBuilder jsonInput = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonInput.append(line);
            }
        }

        try {
            // Forward the JSON input to the backend API
            String backendResponse = HttpClientHelper.sendPutRequest(
                    "https://virtserver.swaggerhub.com/MCHANUKA72/NibmEvex/1/students/profile",
                    jsonInput.toString()
            );

            // Send the backend API response back to the client
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_OK);
            try (PrintWriter out = response.getWriter()) {
                out.write(backendResponse);
            }

        } catch (Exception e) {
            // Handle errors and respond with an error message
            e.printStackTrace(); // For debugging; replace with proper logging in production
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try (PrintWriter out = response.getWriter()) {
                out.write("{\"message\": \"Error updating profile. Please try again.\"}");
            }
        }
    }
}
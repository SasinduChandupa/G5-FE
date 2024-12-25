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

@WebServlet("/career portfolio")
public class CareerPortfolioController extends HttpServlet {

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
                    "https://virtserver.swaggerhub.com/MCHANUKA72/NibmEvex/1/students/portfolio",
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
            e.printStackTrace();
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try (PrintWriter out = response.getWriter()) {
                out.write("{\"error\": \"Error updating career portfolio. Please try again.\"}");
            }
        }
    }
}
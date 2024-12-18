package com.example.g5fe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/admin/login") // Ensure this endpoint matches the fetch call in your JSP
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Read JSON input from request body
        StringBuilder jsonInput = new StringBuilder();
        String line;
        BufferedReader reader = request.getReader();
        while ((line = reader.readLine()) != null) {
            jsonInput.append(line);
        }

        try {
            // Forward the JSON input to the backend API
            String backendResponse = HttpClientHelper.sendPostRequest(
                    "https://virtserver.swaggerhub.com/ChanukaDilshan-8ba/event-management_system_api/1.0.0/admin/login",
                    jsonInput.toString()
            );

            // Send the backend API response back to the client
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.write(backendResponse);
            out.flush();

        } catch (Exception e) {
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"message\": \"Error processing login. Please try again.\"}");
        }
    }
}

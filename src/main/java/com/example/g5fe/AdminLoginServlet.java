package com.example.g5fe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jsonInput = request.getReader().lines().reduce("", String::concat);
        // Forward JSON to backend API
        String backendResponse = com.example.g5fe.HttpClientHelper.sendPostRequest(
                "http://localhost:8080/api/v1/admin/login", jsonInput);

        response.setContentType("application/json");
        response.getWriter().write(backendResponse);
    }
}
package com.example.authinevex;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/student/login")
public class StudentLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jsonInput = request.getReader().lines().reduce("", String::concat);

        // Forward JSON to backend API
        String backendResponse = com.example.g5fe.HttpClientHelper.sendPostRequest(
                "http://localhost:8080/api/v1/student/login", jsonInput);

        response.setContentType("application/json");
        response.getWriter().write(backendResponse);
    }
}

package com.example.g5fe;

import com.example.g5fe.HttpClientHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/lecturer/register")
public class LecturerRegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jsonInput = request.getReader().lines().reduce("", String::concat);

        // Forward JSON to backend API
        String backendResponse = HttpClientHelper.sendPostRequest(
                "http://localhost:8080/api/v1/admin/lecturer/register", jsonInput);

        response.setContentType("application/json");
        response.getWriter().write(backendResponse);
    }
}

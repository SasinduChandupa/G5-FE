package com.example.g5fe;

import com.example.g5fe.HttpClientHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

@WebServlet("/lecturer/login")
public class LecturerLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jsonInput = request.getReader().lines().reduce("", String::concat);

        // Forward JSON to backend API
        String backendResponse = HttpClientHelper.sendPostRequest(
                "https://virtserver.swaggerhub.com/ChanukaDilshan-8ba/event-management_system_api/1.0.0/lecturer/login", jsonInput);

        response.setContentType("application/json");
        response.getWriter().write(backendResponse);
    }
}

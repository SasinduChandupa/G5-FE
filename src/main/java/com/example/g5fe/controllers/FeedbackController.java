package com.example.student.controllers;

import com.example.g5fe.HttpClientHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/feedback") // Matches the endpoint for feedback submission
public class FeedbackController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Read parameters from the request
            String eventId = request.getParameter("eventId");
            String description = request.getParameter("description");
            String sender = request.getParameter("sender");
            String receiver = request.getParameter("receiver");
            String lectureId = request.getParameter("lectureId");
            String studentId = request.getParameter("studentId");

            // Validate parameters (simple check for empty or null values)
            if (eventId == null || eventId.isEmpty() || description == null || description.isEmpty() || sender == null || sender.isEmpty() ||
                    receiver == null || receiver.isEmpty() || lectureId == null || lectureId.isEmpty() || studentId == null || studentId.isEmpty()) {

                // Respond with 400 Bad Request if validation fails
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.setContentType("application/json");
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"message\": \"All fields are required.\"}");
                    out.flush();
                }
                return;
            }

            // Format feedback data as JSON
            String feedbackJson = HttpClientHelper.formatFeedbackJson(eventId, description, sender, receiver, lectureId, studentId);

            // Send the feedback data as a POST request to the backend API
            String backendResponse = HttpClientHelper.sendPostRequest(
                    "https://virtserver.swaggerhub.com/MCHANUKA72/NibmEvex/1/students/feedback",
                    feedbackJson
            );

            // Check the backend response for success or failure
            if (backendResponse == null || backendResponse.isEmpty()) {
                // Respond with 500 Internal Server Error if the feedback submission fails
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.setContentType("application/json");
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"message\": \"Failed to submit feedback. Please try again.\"}");
                    out.flush();
                }
                return;
            }

            // Set response content type to JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // Write the backend response to the client
            try (PrintWriter out = response.getWriter()) {
                out.print(backendResponse);
                out.flush();
            }

        } catch (Exception e) {
            // Log the exception and send a generic error response
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
            response.setContentType("application/json");
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"message\": \"Error submitting feedback\"}");
                out.flush();
            }
        }
    }
}
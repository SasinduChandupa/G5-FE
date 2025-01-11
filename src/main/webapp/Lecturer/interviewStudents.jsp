<%@ page import="java.net.HttpURLConnection, java.net.URL, java.io.BufferedReader, java.io.InputStreamReader, org.json.JSONArray, org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="navbar.jsp" />
<%
    // Access the session and retrieve the userID
    String sessionId = (String) session.getAttribute("userID");
    if (sessionId == null || sessionId.isEmpty()) {
        response.sendRedirect("./logout.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interview Students and Feedback</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex flex-col min-h-screen">

<!-- Header -->
<header class="bg-blue-600 text-white py-4">
    <div class="container mx-auto flex justify-between items-center px-6">
        <h1 class="text-2xl font-bold">Interview Feedback</h1>
    </div>
</header>

<!-- Main Content -->
<main class="flex-grow container mx-auto py-8 px-6">
    <h2 class="text-xl font-semibold text-gray-800 mb-6">Interview Students and Feedback</h2>
    <div class="bg-white shadow rounded-lg p-6">
        <%
            String interviewId = request.getParameter("interviewId");
            String studentsApiUrl = "http://localhost:8080/api/v1/interview/" + interviewId + "/students";
            String feedbackApiUrl = "http://localhost:8080/api/v1/interview/" + interviewId + "/feedback";

            HttpURLConnection studentConnection = null;
            HttpURLConnection feedbackConnection = null;

            try {
                // Fetch students
                URL studentsUrl = new URL(studentsApiUrl);
                studentConnection = (HttpURLConnection) studentsUrl.openConnection();
                studentConnection.setRequestMethod("GET");
                studentConnection.setRequestProperty("Cookie", request.getHeader("Cookie"));
                studentConnection.setRequestProperty("Accept", "application/json");

                int studentStatus = studentConnection.getResponseCode();

                JSONArray students = new JSONArray();
                if (studentStatus == 200) {
                    BufferedReader studentReader = new BufferedReader(new InputStreamReader(studentConnection.getInputStream()));
                    StringBuilder studentResponse = new StringBuilder();
                    String line;
                    while ((line = studentReader.readLine()) != null) {
                        studentResponse.append(line);
                    }
                    studentReader.close();
                    students = new JSONArray(studentResponse.toString());
                }

                // Fetch feedback
                URL feedbackUrl = new URL(feedbackApiUrl);
                feedbackConnection = (HttpURLConnection) feedbackUrl.openConnection();
                feedbackConnection.setRequestMethod("GET");
                feedbackConnection.setRequestProperty("Cookie", request.getHeader("Cookie"));
                feedbackConnection.setRequestProperty("Accept", "application/json");

                int feedbackStatus = feedbackConnection.getResponseCode();

                JSONArray feedbacks = new JSONArray();
                if (feedbackStatus == 200) {
                    BufferedReader feedbackReader = new BufferedReader(new InputStreamReader(feedbackConnection.getInputStream()));
                    StringBuilder feedbackResponse = new StringBuilder();
                    String line;
                    while ((line = feedbackReader.readLine()) != null) {
                        feedbackResponse.append(line);
                    }
                    feedbackReader.close();
                    feedbacks = new JSONArray(feedbackResponse.toString());
                }
        %>
        <table class="table-auto w-full border-collapse border border-gray-300">
            <thead>
            <tr class="bg-gray-200">
                <th class="border border-gray-300 px-4 py-2">Student Name</th>
                <th class="border border-gray-300 px-4 py-2">Email</th>
                <th class="border border-gray-300 px-4 py-2">Feedback</th>
                <th class="border border-gray-300 px-4 py-2">Profile</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (int i = 0; i < students.length(); i++) {
                    JSONObject student = students.getJSONObject(i);
                    String studentId = student.getString("id");
                    String studentName = student.getString("name");
                    String studentEmail = student.getString("email");

                    // Match feedback for the student
                    String feedbackText = "No feedback provided";
                    for (int j = 0; j < feedbacks.length(); j++) {
                        JSONObject feedback = feedbacks.getJSONObject(j);
                        if (feedback.getString("studentId").equals(studentId)) {
                            feedbackText = feedback.getString("feedbackText");
                            break;
                        }
                    }
            %>
            <tr>
                <td class="border border-gray-300 px-4 py-2"><%= studentName %></td>
                <td class="border border-gray-300 px-4 py-2"><%= studentEmail %></td>
                <td class="border border-gray-300 px-4 py-2"><%= feedbackText %></td>
                <td class="border border-gray-300 px-4 py-2">
                    <a href="studentProfile.jsp?studentId=<%= studentId %>" class="text-blue-500 hover:underline">View Profile</a>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <%
        } catch (Exception e) {
        %>
        <p class="text-red-500">An error occurred: <%= e.getMessage() %></p>
        <%
            } finally {
                if (studentConnection != null) {
                    studentConnection.disconnect();
                }
                if (feedbackConnection != null) {
                    feedbackConnection.disconnect();
                }
            }
        %>
    </div>
</main>

<!-- Footer -->
<footer class="bg-gradient-to-r from-blue-800 to-blue-700 text-white text-center py-6 mt-auto shadow-inner">
    <p class="text-sm font-light">© 2025 Your Company. All Rights Reserved.</p>
</footer>

</body>
</html>

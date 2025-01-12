<%@ page import="org.json.JSONArray" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.OutputStreamWriter" %>
<%@ page import="org.json.JSONObject" %>
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
    <title>Lecturer Events</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex flex-col min-h-screen">

<!-- Header -->
<header class="bg-blue-800">
    <div class="container mx-auto py-4">
        <h1 class="text-center text-white text-3xl font-bold">Update and Delete</h1>
    </div>
</header>

<!-- Main Content -->
<main class="flex-grow">
    <div class="max-w-6xl mx-auto py-10 px-4">
        <h2 class="text-2xl font-bold mb-6 text-gray-800">Manage Events</h2>

        <%
            String apiUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/event/all";
            JSONArray allEvents = new JSONArray();
            String errorMessage = "";
            String successMessage = "";

            // Fetch all events
            try {
                URL url = new URL(apiUrl);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("GET");
                connection.setRequestProperty("Content-Type", "application/json");

                String cookie = request.getHeader("Cookie");
                if (cookie != null && !cookie.isEmpty()) {
                    connection.setRequestProperty("Cookie", cookie);
                } else {
                    throw new Exception("Authentication cookie is missing. Please log in.");
                }

                int responseCode = connection.getResponseCode();
                if (responseCode == 200) {
                    BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                    StringBuilder responseBody = new StringBuilder();
                    String line;

                    while ((line = reader.readLine()) != null) {
                        responseBody.append(line);
                    }
                    reader.close();

                    allEvents = new JSONArray(responseBody.toString());
                } else {
                    errorMessage = "Failed to fetch events. HTTP Response Code: " + responseCode;
                }
            } catch (Exception e) {
                errorMessage = "Error occurred while fetching events: " + e.getMessage();
            }

            // Update Event Status
            if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("status") != null) {
                String eid = request.getParameter("eid");
                String newStatus = request.getParameter("status");

                try {
                    String updateUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/lecturer/events/" + eid + "/status?status=" + newStatus;
                    URL url = new URL(updateUrl);
                    HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                    connection.setRequestMethod("PUT");
                    connection.setRequestProperty("Content-Type", "application/json");

                    String cookie = request.getHeader("Cookie");
                    if (cookie != null && !cookie.isEmpty()) {
                        connection.setRequestProperty("Cookie", cookie);
                    }

                    connection.setDoOutput(true);
                    OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream());
                    writer.write("{}");
                    writer.flush();
                    writer.close();

                    int responseCode = connection.getResponseCode();
                    if (responseCode == 200) {
                        successMessage = "Event status updated successfully.";
                    } else {
                        errorMessage = "Failed to update status. HTTP Response Code: " + responseCode;
                    }
                } catch (Exception e) {
                    errorMessage = "Error occurred while updating status: " + e.getMessage();
                }
            }

            // Delete Event
            if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("delete") != null) {
                String eid = request.getParameter("eid");

                try {
                    String deleteUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/event/delete/" + eid;
                    URL url = new URL(deleteUrl);
                    HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                    connection.setRequestMethod("DELETE");

                    String cookie = request.getHeader("Cookie");
                    if (cookie != null && !cookie.isEmpty()) {
                        connection.setRequestProperty("Cookie", cookie);
                    }

                    int responseCode = connection.getResponseCode();
                    if (responseCode == 200) {
                        successMessage = "Event deleted successfully.";
                    } else {
                        errorMessage = "Failed to delete event. HTTP Response Code: " + responseCode;
                    }
                } catch (Exception e) {
                    errorMessage = "Error occurred while deleting event: " + e.getMessage();
                }
            }
        %>

        <!-- Success and Error Messages -->
        <% if (!successMessage.isEmpty()) { %>
        <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6">
            <p><%= successMessage %></p>
        </div>
        <% } %>
        <% if (!errorMessage.isEmpty()) { %>
        <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6">
            <p><%= errorMessage %></p>
        </div>
        <% } %>

        <!-- Event Table -->
        <table class="table-auto w-full bg-white shadow-md rounded border border-gray-200">
            <thead>
            <tr class="bg-gray-200">
                <th class="px-4 py-2 text-left text-gray-700">Event ID</th>
                <th class="px-4 py-2 text-left text-gray-700">Date</th>
                <th class="px-4 py-2 text-left text-gray-700">Name</th>
                <th class="px-4 py-2 text-left text-gray-700">Status</th>
                <th class="px-4 py-2 text-left text-gray-700">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (allEvents.length() > 0) {
                    for (int i = 0; i < allEvents.length(); i++) {
                        JSONObject event = allEvents.getJSONObject(i);
                        String eid = event.optString("eid", "N/A");
                        String date = event.optString("date", "N/A");
                        String name = event.optString("name", "N/A");
                        String status = event.optString("status", "N/A");
            %>
            <tr>
                <td class="border px-4 py-2"><%= eid %></td>
                <td class="border px-4 py-2"><%= date %></td>
                <td class="border px-4 py-2"><%= name %></td>
                <td class="border px-4 py-2">
                    <!-- Update Event Status -->
                    <form method="POST" action="">
                        <input type="hidden" name="eid" value="<%= eid %>">
                        <div class="flex items-center space-x-2">
                            <select name="status" class="border rounded px-2 py-1">
                                <option value="Upcoming" <%= "Upcoming".equalsIgnoreCase(status) ? "selected" : "" %>>Upcoming</option>
                                <option value="Ongoing" <%= "Ongoing".equalsIgnoreCase(status) ? "selected" : "" %>>Ongoing</option>
                                <option value="Completed" <%= "Completed".equalsIgnoreCase(status) ? "selected" : "" %>>Completed</option>
                            </select>
                            <button type="submit" class="bg-blue-500 text-white px-3 py-1 rounded">Update</button>
                        </div>
                    </form>
                </td>
                <td class="border px-4 py-2">
                    <!-- Delete Event -->
                    <form method="POST" action="">
                        <input type="hidden" name="eid" value="<%= eid %>">
                        <input type="hidden" name="delete" value="true">
                        <button type="submit" class="bg-red-500 text-white px-3 py-1 rounded">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5" class="text-center text-gray-500 py-4">No events found.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</main>

<!-- Footer -->
<footer
        class="bg-gradient-to-r from-blue-800 to-blue-700 text-white text-center py-6 mt-auto shadow-inner">
    <p class="text-sm font-light">© 2025 NIBMEvex. All Rights Reserved.</p>
</footer>



</body>
</html>

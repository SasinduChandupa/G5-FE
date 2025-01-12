<%@ page import="java.io.*, java.net.*" %>
<%@ page import="java.util.*" %>
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
    <title>Create Announcement</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
</head>
<body class="bg-gray-100 h-screen flex flex-col">
<%
    String batchApiUrl = "http://ec2-13-60-79-77.eu-north-1.compute.amazonaws.com:8081/api/v1/lecturer/badges";
    String batchDataJson = "[]";

    try {
        URL url = new URL(batchApiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("Cookie", request.getHeader("Cookie"));

        if (conn.getResponseCode() == 200) {
            StringBuilder sb = new StringBuilder();
            try (Scanner scanner = new Scanner(conn.getInputStream())) {
                while (scanner.hasNext()) {
                    sb.append(scanner.nextLine());
                }
            }
            batchDataJson = sb.toString();
        }
        conn.disconnect();
    } catch (Exception e) {
        batchDataJson = "[]"; // Default to empty JSON array in case of error
    }

    List<Map<String, String>> batches = new ArrayList<>();
    try {
        org.json.JSONArray jsonArray = new org.json.JSONArray(batchDataJson);
        for (int i = 0; i < jsonArray.length(); i++) {
            org.json.JSONObject jsonObject = jsonArray.getJSONObject(i);
            Map<String, String> batch = new HashMap<>();
            batch.put("id", jsonObject.optString("bid")); // Use "bid" instead of "id"
            batch.put("name", jsonObject.optString("name"));
            batches.add(batch);
        }
    } catch (Exception e) {
        // Log and handle JSON parsing errors
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String date = request.getParameter("date");
        String name = request.getParameter("name");
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        String bid = request.getParameter("bid");

        String message = "";
        try {
            String announcementApiUrl = "http://ec2-13-60-79-77.eu-north-1.compute.amazonaws.com:8081/api/v1/lecturer/announcements";
            URL url = new URL(announcementApiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Cookie", request.getHeader("Cookie"));
            conn.setDoOutput(true);

            String jsonInput = String.format("{\"date\":\"%s\",\"name\":\"%s\",\"status\":\"%s\",\"description\":\"%s\",\"bid\":\"%s\"}",
                    date, name, status, description, bid);

            try (OutputStream os = conn.getOutputStream()) {
                os.write(jsonInput.getBytes("UTF-8"));
                os.flush();
            }

            if (conn.getResponseCode() == 200 || conn.getResponseCode() == 201) {
                message = "Announcement created successfully!";
            } else {
                StringBuilder errorResponse = new StringBuilder();
                try (Scanner errorScanner = new Scanner(conn.getErrorStream())) {
                    while (errorScanner.hasNext()) {
                        errorResponse.append(errorScanner.nextLine());
                    }
                }
                message = "Failed to create announcement. Error: " + conn.getResponseMessage() + ", Details: " + errorResponse.toString();
            }

            conn.disconnect();
        } catch (Exception e) {
            message = "Error while creating announcement: " + e.getMessage();
        }
        request.setAttribute("message", message);
    }
%>

<!-- Header -->
<header class="bg-blue-800 text-white p-4 shadow-md">
    <div class="container mx-auto flex justify-between items-center">
        <h1 class="text-lg font-bold">Announcements</h1>
    </div>
</header>

<!-- Main Content -->
<div class="container mx-auto mt-10 p-6 bg-white rounded shadow-md flex-grow">
    <h1 class="text-2xl font-bold mb-4">Create Announcement</h1>
    <form method="POST" class="space-y-4">
        <div>
            <label for="date" class="block text-gray-700">Date</label>
            <input type="date" id="date" name="date" class="w-full px-4 py-2 border rounded" required>
        </div>
        <div>
            <label for="name" class="block text-gray-700">Name</label>
            <input type="text" id="name" name="name" class="w-full px-4 py-2 border rounded" required>
        </div>
        <div>
            <label for="status" class="block text-gray-700">Status</label>
            <select id="status" name="status" class="w-full px-4 py-2 border rounded" required>
                <option value="Upcoming">Upcoming</option>
                <option value="Ongoing">Ongoing</option>
                <option value="Completed">Completed</option>
            </select>
        </div>
        <div>
            <label for="description" class="block text-gray-700">Description</label>
            <textarea id="description" name="description" class="w-full px-4 py-2 border rounded" required></textarea>
        </div>
        <div>
            <label for="bid" class="block text-gray-700">Batch</label>
            <select id="bid" name="bid" class="w-full px-4 py-2 border rounded" required>
                <option value="">Select a batch</option>
                <% for (Map<String, String> batch : batches) { %>
                <option value="<%= batch.get("id") %>"><%= batch.get("name") %></option>
                <% } %>
            </select>
        </div>
        <button type="submit" class="px-6 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
            Submit
        </button>
    </form>
    <% if (request.getAttribute("message") != null) { %>
    <p class="mt-4 text-green-500"><%= request.getAttribute("message") %></p>
    <% } %>
</div>

<!-- Footer -->
<footer class="bg-gradient-to-r from-blue-800 to-blue-700 text-white text-center py-6 mt-auto shadow-inner">
    <p class="text-sm font-light">© 2025 NIBMEvex. All Rights Reserved.</p>
</footer>
</body>
</html>

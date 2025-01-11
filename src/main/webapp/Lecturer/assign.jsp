<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.OutputStream" %>
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
    <title>Assign Students to Interviews</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<!-- Header -->
<header class="bg-blue-800 text-white text-center py-4">
    <h1 class="text-2xl font-bold">Assign Students to Interviews</h1>
</header>

<div class="container mx-auto my-8 p-4 bg-white shadow-md rounded-lg">
    <%
        // Fetch `eid` from request parameters
        String eid = request.getParameter("eid");
        if (eid == null || eid.isEmpty()) {
            //out.println("<div class='text-red-500 font-bold'>Error: Missing or invalid Event ID.</div>");
            return;
        }

        // API endpoints
        String apiUrlBatches = "http://localhost:8080/api/v1/lecturer/badges";
        String apiUrlStudents = "http://localhost:8080/api/v1/lecturer/students/";
        String apiUrlAssign = "http://localhost:8080/api/v1/lecturer/assign/interviews";
        JSONArray badges = new JSONArray();
        JSONArray students = new JSONArray();
        String selectedBatch = request.getParameter("batchId");
        String debugMessage = "";
        String successMessage = "";

        try {
            // Fetch batches
            URL urlBatches = new URL(apiUrlBatches);
            HttpURLConnection connectionBatches = (HttpURLConnection) urlBatches.openConnection();
            connectionBatches.setRequestMethod("GET");

            String cookie = request.getHeader("Cookie");
            if (cookie != null) {
                connectionBatches.setRequestProperty("Cookie", cookie);
            }

            if (connectionBatches.getResponseCode() == 200) {
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(connectionBatches.getInputStream()))) {
                    StringBuilder responseBody = new StringBuilder();
                    String line;
                    while ((line = reader.readLine()) != null) {
                        responseBody.append(line);
                    }
                    badges = new JSONArray(responseBody.toString());
                }
            } else {
                debugMessage += "Error: Unable to fetch batches. Response Code: " + connectionBatches.getResponseCode() + "<br>";
            }

            // Fetch students for selected batch
            if (selectedBatch != null && !selectedBatch.isEmpty()) {
                URL urlStudents = new URL(apiUrlStudents + selectedBatch);
                HttpURLConnection connectionStudents = (HttpURLConnection) urlStudents.openConnection();
                connectionStudents.setRequestMethod("GET");
                if (cookie != null) {
                    connectionStudents.setRequestProperty("Cookie", cookie);
                }

                if (connectionStudents.getResponseCode() == 200) {
                    try (BufferedReader reader = new BufferedReader(new InputStreamReader(connectionStudents.getInputStream()))) {
                        StringBuilder responseBody = new StringBuilder();
                        String line;
                        while ((line = reader.readLine()) != null) {
                            responseBody.append(line);
                        }
                        students = new JSONArray(responseBody.toString());
                    }
                } else {
                    debugMessage += "Error: Unable to fetch students. Response Code: " + connectionStudents.getResponseCode() + "<br>";
                }
            }

            // Assign students
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String[] studentIds = request.getParameterValues("studentIds");
                if (studentIds != null && studentIds.length > 0) {
                    JSONObject payload = new JSONObject();
                    payload.put("eid", eid);
                    payload.put("studentIds", studentIds);

                    URL urlAssign = new URL(apiUrlAssign);
                    HttpURLConnection connectionAssign = (HttpURLConnection) urlAssign.openConnection();
                    connectionAssign.setRequestMethod("POST");
                    connectionAssign.setRequestProperty("Content-Type", "application/json");
                    if (cookie != null) {
                        connectionAssign.setRequestProperty("Cookie", cookie);
                    }
                    connectionAssign.setDoOutput(true);

                    try (OutputStream os = connectionAssign.getOutputStream()) {
                        os.write(payload.toString().getBytes());
                        os.flush();
                    }

                    if (connectionAssign.getResponseCode() == 200) {
                        try (BufferedReader reader = new BufferedReader(new InputStreamReader(connectionAssign.getInputStream()))) {
                            successMessage = reader.readLine();
                        }
                    } else {
                        debugMessage += "Error: Unable to assign students. Response Code: " + connectionAssign.getResponseCode() + "<br>";
                    }
                } else {
                    debugMessage += "Error: No students selected.<br>";
                }
            }
        } catch (Exception e) {
            debugMessage += "Error: " + e.getMessage() + "<br>";
        }
    %>

    <!-- Batch Selection Form -->
    <form method="GET" action="assign.jsp" class="mb-6">
        <input type="hidden" name="eid" value="<%= eid %>">
        <label for="batchId" class="block mb-2 font-bold">Select Batch:</label>
        <select name="batchId" id="batchId" class="w-full border rounded px-3 py-2">
            <option value="">-- Select Batch --</option>
            <% for (int i = 0; i < badges.length(); i++) {
                JSONObject badge = badges.getJSONObject(i);
                String bid = badge.getString("bid");
                String name = badge.getString("name");
            %>
            <option value="<%= bid %>" <%= selectedBatch != null && selectedBatch.equals(bid) ? "selected" : "" %>>
                <%= name %>
            </option>
            <% } %>
        </select>
        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded mt-4">View Students</button>
    </form>

    <!-- Students List -->
    <% if (students.length() > 0) { %>
    <h2 class="text-xl font-bold mb-4">Students in Selected Batch:</h2>
    <form method="POST" action="assign.jsp">
        <input type="hidden" name="eid" value="<%= eid %>">
        <div class="overflow-x-auto">
            <table class="min-w-full table-auto border-collapse border border-gray-300">
                <thead>
                <tr class="bg-gray-200">
                    <th class="border border-gray-300 px-4 py-2">Select</th>
                    <th class="border border-gray-300 px-4 py-2">Student ID</th>
                    <th class="border border-gray-300 px-4 py-2">Name</th>
                    <th class="border border-gray-300 px-4 py-2">Email</th>
                </tr>
                </thead>
                <tbody>
                <% for (int i = 0; i < students.length(); i++) {
                    JSONObject student = students.getJSONObject(i);
                    String sid = student.getString("sid");
                    String name = student.getString("name");
                    String email = student.getString("email");
                %>
                <tr>
                    <td class="border border-gray-300 px-4 py-2 text-center">
                        <input type="checkbox" name="studentIds" value="<%= sid %>">
                    </td>
                    <td class="border border-gray-300 px-4 py-2"><%= sid %></td>
                    <td class="border border-gray-300 px-4 py-2"><%= name %></td>
                    <td class="border border-gray-300 px-4 py-2"><%= email %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded mt-4">Assign Selected Students</button>
    </form>
    <% } else if (selectedBatch != null && !selectedBatch.isEmpty()) { %>
    <p class="text-red-500">No students found for the selected batch.</p>
    <% } %>
</div>

<!-- Debugging Section -->
<div class="mt-8">
    <% if (!debugMessage.isEmpty()) { %>
    <div class="bg-yellow-100 text-yellow-800 p-4 rounded">
        <h3 class="font-bold">Debug Information:</h3>
        <p><%= debugMessage %></p>
    </div>
    <% } %>
    <% if (!successMessage.isEmpty()) { %>
    <div class="bg-green-100 text-green-800 p-4 rounded">
        <h3 class="font-bold">Success:</h3>
        <p><%= successMessage %></p>
    </div>
    <% } %>
</div>

<!-- Footer -->
<footer
        class="bg-gradient-to-r from-blue-800 to-blue-700 text-white text-center py-6 mt-auto shadow-inner">
    <p class="text-sm font-light">© 2025 NIBMEvex. All Rights Reserved.</p>
</footer>
</body>
</html>

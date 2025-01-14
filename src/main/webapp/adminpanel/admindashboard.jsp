<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.*, java.io.*, org.json.*" %>
<%@ include file="nav.jsp" %>
<%
    // Access the session and retrieve the userID
    String sessionId = (String) session.getAttribute("userID");
    if (sessionId == null || sessionId.isEmpty()) {
        response.sendRedirect("../logout.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #007bff;
            margin-bottom: 20px;
        }

        canvas {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Admin Dashboard</h1>
    <canvas id="adminChart" width="400" height="200"></canvas>
    <%
        // Retrieve the session cookie
        String sessionCookie = (String) session.getAttribute("sessionCookie");

        JSONObject adminData = null; // Corrected to org.json.JSONObject

        if (sessionCookie != null) {
            try {
                // Define the API URL
                URL url = new URL("http://51.20.114.214:8081/api/v1/admin/state");

                // Open the connection
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Accept", "application/json");
                conn.setRequestProperty("Cookie", sessionCookie); // Pass the session cookie

                // Check the response code
                int responseCode = conn.getResponseCode();
                if (responseCode == HttpURLConnection.HTTP_OK) {
                    // Read the response
                    BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                    StringBuilder jsonResponse = new StringBuilder(); // Changed variable name to avoid conflict
                    String line;
                    while ((line = reader.readLine()) != null) {
                        jsonResponse.append(line);
                    }
                    reader.close();

                    // Parse the JSON response
                    adminData = new JSONObject(jsonResponse.toString());
                } else {
                    out.println("<div class='error'>Failed to fetch admin data. Response Code: " + responseCode + "</div>");
                }
            } catch (Exception e) {
                out.println("<div class='error'>Error fetching admin data: " + e.getMessage() + "</div>");
            }
        } else {
            out.println("<div class='error'>Session not found. Please log in again.</div>");
        }
    %>
    <script>
        const adminData = <%= adminData != null ? adminData.toString() : "{}" %>;

        if (Object.keys(adminData).length > 0) {
            const ctx = document.getElementById('adminChart').getContext('2d');
            const chartData = {
                labels: ['Admins', 'Lecturers', 'Students', 'Events', 'Workshops', 'Announcements', 'Interviews', 'Feedback'],
                datasets: [{
                    label: 'Count',
                    data: [
                        adminData.totalAdmins || 0,
                        adminData.totalLecturers || 0,
                        adminData.totalStudents || 0,
                        adminData.totalEvents || 0,
                        adminData.totalWorkshops || 0,
                        adminData.totalAnnouncements || 0,
                        adminData.totalInterviews || 0,
                        adminData.totalFeedback || 0
                    ],
                    backgroundColor: [
                        '#007bff', '#28a745', '#ffc107', '#17a2b8',
                        '#fd7e14', '#6c757d', '#dc3545', '#6610f2'
                    ],
                    borderColor: [
                        '#0056b3', '#1e7e34', '#d39e00', '#117a8b',
                        '#e36209', '#545b62', '#c82333', '#520dc2'
                    ],
                    borderWidth: 1
                }]
            };

            new Chart(ctx, {
                type: 'bar',
                data: chartData,
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    plugins: {
                        legend: {
                            position: 'top'
                        }
                    }
                }
            });
        } else {
            document.querySelector('.container').innerHTML += '<p style="color: red; text-align: center;">Error loading chart data. Please try again later.</p>';
        }
    </script>
</div>
</body>
</html>

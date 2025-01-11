<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="nav.jsp" />
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
    <title>Student Portfolio</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-picture {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 4px solid #007bff;
            margin-bottom: 15px;
        }
        .profile-header h2 {
            margin: 0;
            font-size: 1.8rem;
            color: #007bff;
        }
        .profile-header p {
            margin: 5px 0;
            font-size: 1rem;
            color: #555;
        }
        .profile-content {
            margin-top: 20px;
        }

        .profile-content p {
            margin: 5px 0;
            font-size: 1rem;
        }
        .profile-content strong {
            color: #333;
        }
        .edit-button {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }
        .edit-button a {
            text-decoration: none;
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }
        .edit-button a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="edit-button">
        <a href="updateportfolio.jsp">✏ Edit Portfolio</a>
    </div>
    <%
        String portfolioData = null;

        try {
            // Connect to the backend API
            URL url = new URL("http://localhost:8080/api/v1/students/getportfolio");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Accept", "application/json");

            // Forward session cookies
            String cookies = request.getHeader("Cookie");
            if (cookies != null) {
                connection.setRequestProperty("Cookie", cookies);
            }

            int responseCode = connection.getResponseCode();
            if (responseCode == 200) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder jsonResponse = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonResponse.append(line);
                }
                reader.close();
                portfolioData = jsonResponse.toString();
            } else {
                portfolioData = "Failed to fetch portfolio. HTTP Code: " + responseCode;
            }
        } catch (Exception e) {
            portfolioData = "Error: " + e.getMessage();
        }

        if (portfolioData != null && portfolioData.startsWith("{")) {
            try {
                JSONObject portfolio = new JSONObject(portfolioData);

                String studentName = portfolio.optString("studentName", "Unknown");
                String studentEmail = portfolio.optString("studentEmail", "Unknown");
                int studentAge = portfolio.optInt("studentAge", 0);
                String portfolioGithubUsername = portfolio.optString("portfolioGithubUsername", "Unknown");
                String portfolioAchievements = portfolio.optString("portfolioAchievements", "None");
                String portfolioDescription = portfolio.optString("portfolioDescription", "No description provided");
                String portfolioEducation = portfolio.optString("portfolioEducation", "No education details");
                String profilePictureUrl = "https://github.com/" + portfolioGithubUsername + ".png";
    %>
    <div class="max-w-4xl mx-auto bg-white p-6 rounded-lg shadow-lg">
        <!-- Profile Header -->
        <div class="profile-header text-center border-b pb-6">
            <img
                    src="<%= profilePictureUrl %>"
                    alt="Profile Picture"
                    class="w-32 h-32 rounded-full mx-auto border-4 border-blue-500"
                    onerror="this.src='default-profile.png';"
            >
            <h2 class="text-2xl font-bold text-gray-800 mt-4"><%= studentName %></h2>
            <p class="text-gray-600 mt-2"><strong>Email:</strong> <%= studentEmail %></p>
            <p class="text-gray-600"><strong>Age:</strong> <%= studentAge %> years</p>
        </div>

        <!-- Profile Content -->
        <div class="profile-content mt-6">
            <h3 class="text-xl font-bold text-blue-600 mb-3  ">Achievements</h3>
            <p class="text-gray-700 mb-5 leading-relaxed font-bold"><%= portfolioAchievements %></p>

            <h3 class="text-xl font-bold text-blue-600 mb-3  ">Portfolio Description</h3>
            <p class="text-gray-700 mb-5 leading-relaxed font-bold"><%= portfolioDescription %></p>

            <h3 class="text-xl font-bold text-blue-600 mb-3  ">Education</h3>
            <p class="text-gray-700 mb-5 leading-relaxed font-bold"><%= portfolioEducation %></p>


        </div>
    </div>

    <%
    } catch (Exception e) {
    %>
    <div style="color: red; text-align: center;">Error parsing portfolio data: <%= e.getMessage() %></div>
    <%
        }
    } else {
    %>
    <div style="color: red; text-align: center;">Error: <%= portfolioData %></div>
    <%
        }
    %>
</div>
</body>
</html>
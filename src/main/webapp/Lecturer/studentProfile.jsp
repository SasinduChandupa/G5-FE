<%@ page import="java.net.HttpURLConnection, java.net.URL, java.io.BufferedReader, java.io.InputStreamReader, org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="navbar.jsp" />
<%
  // Access the session and retrieve the sessionCookie
  String sessionCookie = (String) session.getAttribute("sessionCookie");
  if (sessionCookie == null || sessionCookie.isEmpty()) {
    response.sendRedirect("./logout.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Profile</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex flex-col min-h-screen">
<!-- Header -->
<header class="bg-blue-800 text-white py-4">
  <div class="container mx-auto flex justify-between items-center px-6">
    <h1 class="text-2xl font-bold">Student Profile</h1>
  </div>
</header>

<!-- Main Content -->
<main class="flex-grow container mx-auto py-8 px-6">
  <%
    String studentId = request.getParameter("studentId");
    String apiUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/students/portfolio/" + studentId;

    HttpURLConnection connection = null;

    try {
      URL url = new URL(apiUrl);
      connection = (HttpURLConnection) url.openConnection();
      connection.setRequestMethod("GET");
      connection.setRequestProperty("Cookie", sessionCookie);
      connection.setRequestProperty("Accept", "application/json");

      int status = connection.getResponseCode();

      if (status == 200) {
        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        StringBuilder responseData = new StringBuilder();
        String line;

        while ((line = reader.readLine()) != null) {
          responseData.append(line);
        }
        reader.close();

        JSONObject studentProfile = new JSONObject(responseData.toString());
        String studentName = studentProfile.optString("studentName", "N/A");
        String studentEmail = studentProfile.optString("studentEmail", "N/A");
        int studentAge = studentProfile.optInt("studentAge", 0);
        String profilePicUrl = studentProfile.optString("studentProfilePic", "");
        String githubUsername = studentProfile.optString("portfolioGithubUsername", "N/A");
        String achievements = studentProfile.optString("portfolioAchievements", "N/A");
        String education = studentProfile.optString("portfolioEducation", "N/A");
        String portfolioDescription = studentProfile.optString("portfolioDescription", "N/A");
  %>
  <div class="bg-white shadow rounded-lg p-6">
    <div class="flex items-center">
      <% if (!githubUsername.equals("N/A")) { %>
      <img src="https://github.com/<%= githubUsername %>.png" alt="Profile Picture" class="w-24 h-24 rounded-full mr-6">
      <% } else { %>
      <img src="default-profile.png" alt="Default Profile Picture" class="w-24 h-24 rounded-full mr-6">
      <% } %>
      <div>
        <h2 class="text-2xl font-semibold text-gray-800"><%= studentName %></h2>
        <p class="text-gray-600"><%= studentEmail %></p>
        <p class="text-gray-600">Age: <%= studentAge %></p>
      </div>
    </div>
    <div class="mt-6">
      <h3 class="text-lg font-semibold text-gray-800">Portfolio Details</h3>
      <p class="text-gray-700"><strong>GitHub Username:</strong> <%= githubUsername %></p>
      <p class="text-gray-700"><strong>Achievements:</strong> <%= achievements %></p>
      <p class="text-gray-700"><strong>Education:</strong> <%= education %></p>
      <p class="text-gray-700"><strong>Description:</strong> <%= portfolioDescription %></p>
    </div>
  </div>
  <%
  } else {
  %>
  <p class="text-red-500">Failed to fetch the student profile. Status code: <%= status %></p>
  <%
    }
  } catch (Exception e) {
  %>
  <p class="text-red-500">An error occurred: <%= e.getMessage() %></p>
  <%
    } finally {
      if (connection != null) {
        connection.disconnect();
      }
    }
  %>
</main>

<!-- Footer -->
<footer
        class="bg-gradient-to-r from-blue-800 to-blue-700 text-white text-center py-6 mt-auto shadow-inner">
  <p class="text-sm font-light">© 2025 NIBMEvex. All Rights Reserved.</p>
</footer>
</body>
</html>

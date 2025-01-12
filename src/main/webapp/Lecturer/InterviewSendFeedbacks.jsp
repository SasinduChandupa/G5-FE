<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.*" %>
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
  <title>Assigned Students</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<header class="bg-blue-800 text-white text-center py-4">
  <h1 class="text-2xl font-bold">Assigned Students</h1>
</header>

<div class="container mx-auto my-8 p-4">
  <%
    String eid = request.getParameter("eid");
    JSONArray assignedStudents = new JSONArray();
    String feedbackResponse = null;

    if (eid != null && !eid.isEmpty()) {
      try {
        URL apiUrl = new URL("http://ec2-13-60-79-77.eu-north-1.compute.amazonaws.com:8081/api/v1/interview/" + eid + "/students");
        HttpURLConnection connection = (HttpURLConnection) apiUrl.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Content-Type", "application/json");

        String cookie = request.getHeader("Cookie");
        if (cookie != null) {
          connection.setRequestProperty("Cookie", cookie);
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
          assignedStudents = new JSONArray(responseBody.toString());
        } else {
          feedbackResponse = "Failed to fetch assigned students. HTTP Status: " + responseCode;
        }
      } catch (Exception e) {
        feedbackResponse = "Error while fetching students: " + e.getMessage();
      }
    } else {
      feedbackResponse = "Interview ID (eid) is required.";
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
      String description = request.getParameter("description");
      String sid = request.getParameter("sid");

      if (description != null && !description.isEmpty() && sid != null && !sid.isEmpty() && eid != null) {
        try {
          URL feedbackUrl = new URL("http://ec2-13-60-79-77.eu-north-1.compute.amazonaws.com:8081/api/v1/lecturer/send");
          HttpURLConnection feedbackConnection = (HttpURLConnection) feedbackUrl.openConnection();
          feedbackConnection.setRequestMethod("POST");
          feedbackConnection.setRequestProperty("Content-Type", "application/json");

          String cookie = request.getHeader("Cookie");
          if (cookie != null) {
            feedbackConnection.setRequestProperty("Cookie", cookie);
          }

          JSONObject feedbackPayload = new JSONObject();
          feedbackPayload.put("description", description);
          feedbackPayload.put("eid", eid);
          feedbackPayload.put("sid", sid);

          feedbackConnection.setDoOutput(true);
          try (OutputStream os = feedbackConnection.getOutputStream()) {
            byte[] input = feedbackPayload.toString().getBytes("utf-8");
            os.write(input, 0, input.length);
          }

          int feedbackResponseCode = feedbackConnection.getResponseCode();
          if (feedbackResponseCode == 200) {
            feedbackResponse = "Feedback sent successfully!";
          } else {
            BufferedReader errorReader = new BufferedReader(new InputStreamReader(feedbackConnection.getErrorStream()));
            StringBuilder errorResponse = new StringBuilder();
            String line;
            while ((line = errorReader.readLine()) != null) {
              errorResponse.append(line);
            }
            errorReader.close();
            feedbackResponse = "Failed to send feedback. HTTP Status: " + feedbackResponseCode + ". Error: " + errorResponse.toString();
          }
        } catch (Exception e) {
          feedbackResponse = "Error while sending feedback: " + e.getMessage();
        }
      } else {
        feedbackResponse = "All fields (description, sid) are required.";
      }
    }
  %>

  <% if (feedbackResponse != null) { %>
  <div class="bg-green-100 text-green-700 border border-green-400 px-4 py-2 rounded mb-4 text-center">
    <%= feedbackResponse %>
  </div>
  <% } %>

  <% if (assignedStudents.length() > 0) { %>
  <% for (int i = 0; i < assignedStudents.length(); i++) {
    JSONObject student = assignedStudents.getJSONObject(i);
    String sid = student.optString("id", "N/A");
    String name = student.optString("name", "N/A");
    String email = student.optString("email", "N/A");
  %>
  <div class="bg-white shadow-md p-4 rounded-lg mb-6">
    <p><strong>Student ID:</strong> <%= sid %></p>
    <p><strong>Name:</strong> <%= name %></p>
    <p><strong>Email:</strong> <%= email %></p>

    <form method="POST" action="InterviewSendFeedbacks.jsp?eid=<%= eid %>">
      <input type="hidden" name="sid" value="<%= sid %>">
      <textarea name="description" class="border rounded w-full p-2 mt-2" placeholder="Enter feedback"></textarea>
      <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded mt-2">
        Send Feedback
      </button>
    </form>

    <!-- View Profile Button -->
    <a href="studentProfile.jsp?studentId=<%= sid %>"
       class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded mt-2 inline-block text-center">
      View Profile
    </a>
  </div>
  <% } %>
  <% } else { %>
  <p class="text-center text-gray-500">No students are assigned to this interview.</p>
  <% } %>
</div>

<!-- Footer -->
<footer
        class="bg-gradient-to-r from-blue-800 to-blue-700 text-white text-center py-6 mt-auto shadow-inner">
  <p class="text-sm font-light">© 2025 NIBMEvex. All Rights Reserved.</p>
</footer>
</body>
</html>

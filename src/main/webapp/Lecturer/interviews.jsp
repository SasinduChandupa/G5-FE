<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
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
    <title>Interviews</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<!-- Header -->
<header class="bg-blue-800 text-white text-center py-4">
    <h1 class="text-2xl font-bold">Interviews</h1>
</header>

<!-- Interviews Section -->
<div class="container mx-auto my-8 p-4">

    <!-- Fetch Data from API -->
    <%
        String apiUrl = "http://localhost:8080/api/v1/lecturer/interviews";
        JSONArray upcomingInterviews = new JSONArray();
        JSONArray ongoingInterviews = new JSONArray();
        JSONArray completedInterviews = new JSONArray();

        try {
            // Set up the connection
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Content-Type", "application/json");

            // Add the cookie for authentication
            String cookie = request.getHeader("Cookie");
            connection.setRequestProperty("Cookie", cookie);

            int responseCode = connection.getResponseCode();

            if (responseCode == 200) {
                // Read the response
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder responseBody = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    responseBody.append(line);
                }
                reader.close();

                // Parse JSON response
                JSONArray interviews = new JSONArray(responseBody.toString());

                // Define current date
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(new Date());
                calendar.set(Calendar.HOUR_OF_DAY, 0);
                calendar.set(Calendar.MINUTE, 0);
                calendar.set(Calendar.SECOND, 0);
                calendar.set(Calendar.MILLISECOND, 0);
                Date currentDate = calendar.getTime();

                for (int i = 0; i < interviews.length(); i++) {
                    JSONObject interview = interviews.getJSONObject(i);
                    String date = interview.optString("date", "N/A");

                    // Parse interview date
                    Date interviewDate = sdf.parse(date);

                    // Reset time to midnight for comparison
                    calendar.setTime(interviewDate);
                    calendar.set(Calendar.HOUR_OF_DAY, 0);
                    calendar.set(Calendar.MINUTE, 0);
                    calendar.set(Calendar.SECOND, 0);
                    calendar.set(Calendar.MILLISECOND, 0);
                    interviewDate = calendar.getTime();

                    // Categorize interviews
                    if (interviewDate.after(currentDate)) {
                        upcomingInterviews.put(interview);  // Upcoming interviews
                    } else if (interviewDate.equals(currentDate)) {
                        ongoingInterviews.put(interview);  // Ongoing interviews
                    } else {
                        completedInterviews.put(interview);  // Completed interviews
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <!-- Display Interviews -->
    <% for (int i = 0; i < completedInterviews.length(); i++) {
        JSONObject interview = completedInterviews.getJSONObject(i);
        String eid = interview.optString("eid", "N/A");
        String interviewer = interview.optString("interviewer", "N/A");
        String location = interview.optString("location", "N/A");
        String date = interview.optString("date", "N/A");
    %>
    <div class="bg-white shadow-md p-4 rounded-lg mb-6">
        <p><strong>ID:</strong> <%= eid %></p>
        <p><strong>Interviewer:</strong> <%= interviewer %></p>
        <p><strong>Location:</strong> <%= location %></p>
        <p><strong>Date:</strong> <%= date %></p>

        <!-- Send feedback Button -->
        <form method="GET" action="InterviewSendFeedbacks.jsp" class="inline-block">
            <input type="hidden" name="eid" value="<%= eid %>">
            <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded mt-2">
                Send Feedbacks
            </button>
        </form>

        <!-- Assign Students Button -->
        <form method="GET" action="assign.jsp" class="inline-block ml-2">
            <input type="hidden" name="eid" value="<%= eid %>">
            <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded mt-2">
                Assign Students
            </button>
        </form>
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

<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<jsp:include page="navbar.jsp" />

<%
    // Access the session and retrieve the userID and sessionCookie
    String sessionId = (String) session.getAttribute("userID");
    String sessionCookie = (String) session.getAttribute("sessionCookie");

    if (sessionId == null || sessionId.isEmpty() || sessionCookie == null || sessionCookie.isEmpty()) {
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
        String apiUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/lecturer/interviews";
        JSONArray upcomingInterviews = new JSONArray();
        JSONArray ongoingInterviews = new JSONArray();
        JSONArray completedInterviews = new JSONArray();

        try {
            // Set up the connection
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Content-Type", "application/json");

            // Add session cookie for authentication
            connection.setRequestProperty("Cookie", sessionCookie);

            int responseCode = connection.getResponseCode();

            if (responseCode == HttpURLConnection.HTTP_OK) {
                // Read the response
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
                    StringBuilder responseBody = new StringBuilder();
                    String line;

                    while ((line = reader.readLine()) != null) {
                        responseBody.append(line);
                    }

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
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <!-- Completed Interviews -->
    <h2 class="text-lg font-bold mb-4">Completed Interviews</h2>
    <% for (int i = 0; i < completedInterviews.length(); i++) { %>
    <% JSONObject interview = completedInterviews.getJSONObject(i); %>
    <div class="bg-white shadow-md p-4 rounded-lg mb-6">
        <p><strong>ID:</strong> <%= interview.optString("eid", "N/A") %></p>
        <p><strong>Interviewer:</strong> <%= interview.optString("interviewer", "N/A") %></p>
        <p><strong>Location:</strong> <%= interview.optString("location", "N/A") %></p>
        <p><strong>Date:</strong> <%= interview.optString("date", "N/A") %></p>

        <!-- Send Feedback Button -->
        <form method="GET" action="InterviewSendFeedbacks.jsp" class="inline-block">
            <input type="hidden" name="eid" value="<%= interview.optString("eid", "N/A") %>">
            <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded mt-2">
                Send Feedbacks
            </button>
        </form>

        <!-- Assign Students Button -->
        <form method="GET" action="assign.jsp" class="inline-block ml-2">
            <input type="hidden" name="eid" value="<%= interview.optString("eid", "N/A") %>">
            <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded mt-2">
                Assign Students
            </button>
        </form>
    </div>
    <% } %>

    <!-- Ongoing Interviews -->
    <h2 class="text-lg font-bold mb-4">Ongoing Interviews</h2>
    <% for (int i = 0; i < ongoingInterviews.length(); i++) { %>
    <% JSONObject interview = ongoingInterviews.getJSONObject(i); %>
    <div class="bg-white shadow-md p-4 rounded-lg mb-6">
        <p><strong>ID:</strong> <%= interview.optString("eid", "N/A") %></p>
        <p><strong>Interviewer:</strong> <%= interview.optString("interviewer", "N/A") %></p>
        <p><strong>Location:</strong> <%= interview.optString("location", "N/A") %></p>
        <p><strong>Date:</strong> <%= interview.optString("date", "N/A") %></p>

        <!-- Send Feedback Button -->
        <form method="GET" action="InterviewSendFeedbacks.jsp" class="inline-block">
            <input type="hidden" name="eid" value="<%= interview.optString("eid", "N/A") %>">
            <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded mt-2">
                Send Feedbacks
            </button>
        </form>

        <!-- Assign Students Button -->
        <form method="GET" action="assign.jsp" class="inline-block ml-2">
            <input type="hidden" name="eid" value="<%= interview.optString("eid", "N/A") %>">
            <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded mt-2">
                Assign Students
            </button>
        </form>
    </div>
    <% } %>

    <!-- Upcoming Interviews -->
    <h2 class="text-lg font-bold mb-4">Upcoming Interviews</h2>
    <% for (int i = 0; i < upcomingInterviews.length(); i++) { %>
    <% JSONObject interview = upcomingInterviews.getJSONObject(i); %>
    <div class="bg-white shadow-md p-4 rounded-lg mb-6">
        <p><strong>ID:</strong> <%= interview.optString("eid", "N/A") %></p>
        <p><strong>Interviewer:</strong> <%= interview.optString("interviewer", "N/A") %></p>
        <p><strong>Location:</strong> <%= interview.optString("location", "N/A") %></p>
        <p><strong>Date:</strong> <%= interview.optString("date", "N/A") %></p>

        <!-- Send Feedback Button -->
        <form method="GET" action="InterviewSendFeedbacks.jsp" class="inline-block">
            <input type="hidden" name="eid" value="<%= interview.optString("eid", "N/A") %>">
            <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded mt-2">
                Send Feedbacks
            </button>
        </form>

        <!-- Assign Students Button -->
        <form method="GET" action="assign.jsp" class="inline-block ml-2">
            <input type="hidden" name="eid" value="<%= interview.optString("eid", "N/A") %>">
            <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded mt-2">
                Assign Students
            </button>
        </form>
    </div>
    <% } %>
</div>

<!-- Footer -->
<footer class="bg-gradient-to-r from-blue-800 to-blue-700 text-white text-center py-6 mt-auto shadow-inner">
    <p class="text-sm font-light">&copy; 2025 NIBMEvex. All Rights Reserved.</p>
</footer>

</body>
</html>

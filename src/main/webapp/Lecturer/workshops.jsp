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
    <title>Workshops</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<!-- Header -->
<header class="bg-blue-800 text-white text-center py-4">
    <h1 class="text-2xl font-bold">Workshops</h1>
</header>

<!-- Workshops Section -->
<div class="container mx-auto my-8 p-4">

    <!-- Fetch Data from API -->
    <%
        String apiUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/lecturer/workshops";
        JSONArray upcomingWorkshops = new JSONArray();
        JSONArray ongoingWorkshops = new JSONArray();
        JSONArray completedWorkshops = new JSONArray();

        try {
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Content-Type", "application/json");

            String cookie = request.getHeader("Cookie");
            connection.setRequestProperty("Cookie", cookie);

            int responseCode = connection.getResponseCode();

            if (responseCode == 200) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder responseBody = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    responseBody.append(line);
                }
                reader.close();

                JSONArray workshops = new JSONArray(responseBody.toString());
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(new Date());
                calendar.set(Calendar.HOUR_OF_DAY, 0);
                calendar.set(Calendar.MINUTE, 0);
                calendar.set(Calendar.SECOND, 0);
                calendar.set(Calendar.MILLISECOND, 0);
                Date currentDate = calendar.getTime();

                for (int i = 0; i < workshops.length(); i++) {
                    JSONObject workshop = workshops.getJSONObject(i);
                    String date = workshop.optString("date", "N/A");

                    Date workshopDate = sdf.parse(date);
                    calendar.setTime(workshopDate);
                    calendar.set(Calendar.HOUR_OF_DAY, 0);
                    calendar.set(Calendar.MINUTE, 0);
                    calendar.set(Calendar.SECOND, 0);
                    calendar.set(Calendar.MILLISECOND, 0);
                    workshopDate = calendar.getTime();

                    if (workshopDate.after(currentDate)) {
                        upcomingWorkshops.put(workshop);
                    } else if (workshopDate.equals(currentDate)) {
                        ongoingWorkshops.put(workshop);
                    } else {
                        completedWorkshops.put(workshop);
                    }
                }
            } else {
                System.out.println("Error: Received response code " + responseCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <!-- Upcoming Workshops -->
    <h2 class="text-xl font-bold text-blue-700 mb-4">Upcoming Workshops</h2>
    <div class="bg-white shadow-md p-4 rounded-lg mb-6">
        <%
            for (int i = 0; i < upcomingWorkshops.length(); i++) {
                JSONObject workshop = upcomingWorkshops.getJSONObject(i);
                String eid = workshop.optString("eid", "N/A");
                String name = workshop.optString("name", "N/A");
                String speaker = workshop.optString("speaker", "N/A");
                String location = workshop.optString("location", "N/A");
                String date = workshop.optString("date", "N/A");
        %>
        <div class="p-4 border-b border-gray-300">
            <p><strong>ID:</strong> <%= eid %></p>
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Speaker:</strong> <%= speaker %></p>
            <p><strong>Location:</strong> <%= location %></p>
            <p><strong>Date:</strong> <%= date %></p>
            <form action="WorkshopSendFeedbacks.jsp" method="GET">
                <input type="hidden" name="workshopID" value="<%= eid %>">
                <button type="submit" class="mt-2 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">
                    Send Feedback
                </button>
            </form>
        </div>
        <%
            }
        %>
    </div>

    <!-- Ongoing Workshops -->
    <h2 class="text-xl font-bold text-blue-700 mb-4">Ongoing Workshops</h2>
    <div class="bg-white shadow-md p-4 rounded-lg mb-6">
        <%
            for (int i = 0; i < ongoingWorkshops.length(); i++) {
                JSONObject workshop = ongoingWorkshops.getJSONObject(i);
                String eid = workshop.optString("eid", "N/A");
                String name = workshop.optString("name", "N/A");
                String speaker = workshop.optString("speaker", "N/A");
                String location = workshop.optString("location", "N/A");
                String date = workshop.optString("date", "N/A");
        %>
        <div class="p-4 border-b border-gray-300">
            <p><strong>ID:</strong> <%= eid %></p>
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Speaker:</strong> <%= speaker %></p>
            <p><strong>Location:</strong> <%= location %></p>
            <p><strong>Date:</strong> <%= date %></p>
            <form action="WorkshopSendFeedbacks.jsp" method="GET">
                <input type="hidden" name="workshopID" value="<%= eid %>">
                <button type="submit" class="mt-2 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">
                    Send Feedback
                </button>
            </form>
        </div>
        <%
            }
        %>
    </div>

    <!-- Completed Workshops -->
    <h2 class="text-xl font-bold text-blue-700 mb-4">Completed Workshops</h2>
    <div class="bg-white shadow-md p-4 rounded-lg mb-6">
        <%
            for (int i = 0; i < completedWorkshops.length(); i++) {
                JSONObject workshop = completedWorkshops.getJSONObject(i);
                String eid = workshop.optString("eid", "N/A");
                String name = workshop.optString("name", "N/A");
                String speaker = workshop.optString("speaker", "N/A");
                String location = workshop.optString("location", "N/A");
                String date = workshop.optString("date", "N/A");
        %>
        <div class="p-4 border-b border-gray-300">
            <p><strong>ID:</strong> <%= eid %></p>
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Speaker:</strong> <%= speaker %></p>
            <p><strong>Location:</strong> <%= location %></p>
            <p><strong>Date:</strong> <%= date %></p>
            <form action="WorkshopSendFeedbacks.jsp" method="GET">
                <input type="hidden" name="workshopID" value="<%= eid %>">
                <button type="submit" class="mt-2 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">
                    Send Feedback
                </button>
            </form>
        </div>
        <%
            }
        %>
    </div>
</div>

<!-- Footer -->
<footer
        class="bg-gradient-to-r from-blue-800 to-blue-700 text-white text-center py-6 mt-auto shadow-inner">
    <p class="text-sm font-light">© 2025 NIBMEvex. All Rights Reserved.</p>
</footer>

</body>
</html>

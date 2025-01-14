<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.*, java.io.*, org.json.*" %>
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
    <title>View Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #e9ecef;
            margin: 0;
            padding: 0;
        }

        .profile-header {
            margin-bottom: 20px;
            position: relative;
        }

        .edit-button {
            position: absolute;
            top: 10px;
            right: 10px;
        }

        .edit-button a {
            text-decoration: none;
            background-color: #007bff;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.9rem;
            transition: background-color 0.3s ease;
        }

        .edit-button a:hover {
            background-color: #0056b3;
        }

        .profile-picture {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 4px solid #007bff;
            margin-bottom: 15px;
        }

        .profile-details {
            text-align: left;
            margin-top: 20px;
        }

        .profile-details h3 {
            border-bottom: 2px solid #007bff;
            padding-bottom: 5px;
            margin-bottom: 15px;
            color: #007bff;
        }

        .profile-details p {
            margin: 10px 0;
            font-size: 1rem;
        }

        .badge {
            display: inline-block;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border-radius: 5px;
            margin-top: 10px;
            font-size: 1rem;
        }
    </style>
</head>
<body>
<div class="container">
    <%
        String profileData = null;

        try {
            URL url = new URL("http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/student/profile");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Content-Type", "application/json");

            // Pass cookies correctly
            String sessionCookie = (String) session.getAttribute("sessionCookie");
            if (sessionCookie != null) {
                connection.setRequestProperty("Cookie", sessionCookie);
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
                profileData = jsonResponse.toString();
            } else {
                profileData = "Failed to fetch profile. HTTP Code: " + responseCode;
            }
        } catch (Exception e) {
            profileData = "Error: " + e.getMessage();
        }

        if (profileData != null && profileData.startsWith("{")) {
            JSONObject profile = new JSONObject(profileData);
            String sid = profile.optString("sid", "Unknown");
            String name = profile.optString("name", "Unknown");
            String email = profile.optString("email", "Unknown");
            String username = profile.optString("username", "Unknown");
            int age = profile.optInt("age", 0);
            String profilePic = profile.optString("profilePic", "null");
            String badgeId = profile.getJSONObject("badge").optString("bid", "");
            String badgeName = profile.getJSONObject("badge").optString("name", "No Badge");

            if (profilePic == null || profilePic.equalsIgnoreCase("null") || profilePic.isEmpty()) {
                profilePic = "https://ui-avatars.com/api/?name=" + name.replace(" ", "+") + "&background=random&color=fff";
            }
    %>
    <div class="max-w-4xl mx-auto bg-white shadow-lg rounded-lg overflow-hidden">
        <div class="p-6 bg-gray-100">
            <div class="flex items-center">
                <img src="<%= profilePic %>" alt="Profile Picture" class="w-24 h-24 rounded-full border-4 border-blue-500 object-cover">
                <div class="ml-6">
                    <h2 class="text-2xl font-semibold text-gray-800"><%= name %></h2>
                    <a href="editprofile.jsp?name=<%= name %>&email=<%= email %>&username=<%= username %>&age=<%= age %>&profilePic=<%= profilePic %>&badgeId=<%= badgeId %>"
                       class="mt-2 inline-block px-4 py-2 bg-blue-500 text-white font-medium text-sm rounded-lg shadow hover:bg-blue-600 transition">
                        Edit Profile
                    </a>
                </div>
            </div>
        </div>
        <div class="p-6">
            <h3 class="text-lg font-semibold text-blue-500 border-b-2 border-blue-500 pb-2">Details</h3>
            <div class="mt-4 space-y-4">
                <p class="text-gray-700"><strong>Email:</strong> <%= email %></p>
                <p class="text-gray-700"><strong>Username:</strong> <%= username %></p>
                <p class="text-gray-700"><strong>Age:</strong> <%= age %> years</p>
            </div>
            <div class="mt-4">
            <span class="inline-block px-4 py-2 bg-green-500 text-white font-medium rounded-lg">
                Badge: <%= badgeName %>
            </span>
            </div>
        </div>
    </div>

    <%
    } else {
    %>
    <div style="color: red; text-align: center;">Error: <%= profileData %></div>
    <%
        }
    %>
</div>
</body>
</html>

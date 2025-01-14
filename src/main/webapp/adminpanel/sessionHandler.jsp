<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, org.json.JSONObject" %>
<%
    // Retrieve the session cookie
    String sessionCookie = (String) session.getAttribute("sessionCookie");

    if (sessionCookie != null) {
        try {
            // Define the API URL
            URL url = new URL("http://51.20.114.214:8081/api/v1/session/details");

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
                StringBuilder jsonResponse = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonResponse.append(line);
                }
                reader.close();

                // Parse the JSON response
                JSONObject sessionDetails = new JSONObject(jsonResponse.toString());
                String userId = sessionDetails.optString("id", null);
                String userRole = sessionDetails.optString("role", null);

                // Validate the session details
                if (userId != null && !userId.matches(".*[A-Za-z].*")) {
                    // Create FE session attributes
                    session.setAttribute("userID", userId);
                    session.setAttribute("userRole", userRole);

                    // Redirect to the admin dashboard
                    response.sendRedirect("./admindashboard.jsp");
                } else {
                    // Redirect to logout if session details are invalid
                    response.sendRedirect("logout.jsp");
                }
            } else {
                // Redirect to logout if the API call fails
                response.sendRedirect("logout.jsp");
            }
        } catch (Exception e) {
            // Redirect to logout if an error occurs
            response.sendRedirect("logout.jsp");
        }
    } else {
        // Redirect to logout if session cookie is missing
        response.sendRedirect("logout.jsp");
    }
%>

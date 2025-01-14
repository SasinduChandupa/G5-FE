<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.net.*, org.json.JSONObject" %>
<%
    // Retrieve the session cookie
    String sessionCookie = (String) session.getAttribute("sessionCookie");

    if (sessionCookie != null) {
        try {
            // Define the API URL
            URL url = new URL("http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/session/details");

            // Open the connection
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Accept", "application/json");
            connection.setRequestProperty("Cookie", sessionCookie); // Pass the session cookie

            // Check the response code
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // Read the response
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder jsonResponse = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonResponse.append(line);
                }
                reader.close();

                // Parse the JSON response
                JSONObject sessionDetails = new JSONObject(jsonResponse.toString());
                String id = sessionDetails.optString("id", null);

                // Validate the session details
                if (id != null && id.startsWith("S")) {
                    // Create FE session attributes
                    session.setAttribute("userID", id);

                    // Redirect to the lecturer dashboard
                    response.sendRedirect("./studentdashboard.jsp");
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

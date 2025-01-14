<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URL, java.net.HttpURLConnection" %>
<%@ page import="java.net.URLEncoder" %>
<%
  // Backend logout API URL
  String apiUrl = "http://ec2-51-20-114-214.eu-north-1.compute.amazonaws.com:8081/api/v1/logout";

  try {
    // Create URL and connection
    URL url = new URL(apiUrl);
    HttpURLConnection connection = (HttpURLConnection) url.openConnection();
    connection.setRequestMethod("POST");
    connection.setRequestProperty("Accept", "application/json");

    // Pass session cookies if available
    String sessionCookie = (String) session.getAttribute("sessionCookie");
    if (sessionCookie != null) {
      connection.setRequestProperty("Cookie", sessionCookie);
    }

    // Get the response code
    int responseCode = connection.getResponseCode();

    if (responseCode == 200) {
      // Invalidate the session to clear the frontend session data
      session.invalidate();

      // Redirect to login page after successful logout
      response.sendRedirect("./index.jsp");
    } else {
      // Redirect to error page with the HTTP response code
      response.sendRedirect("./error.jsp?message=" + URLEncoder.encode("Failed to logout. HTTP Code: " + responseCode, "UTF-8"));
    }

    connection.disconnect();
  } catch (Exception e) {
    // Handle exceptions and redirect to an error page with the exception message
    response.sendRedirect("./error.jsp?message=" + URLEncoder.encode("Error: " + e.getMessage(), "UTF-8"));
  }
%>

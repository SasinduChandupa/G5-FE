<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URLEncoder" %>
<%
  // Backend logout
  String apiUrl = "http://ec2-13-60-79-77.eu-north-1.compute.amazonaws.com:8081/api/v1/logout";
  try {
    URL url = new URL(apiUrl);
    HttpURLConnection connection = (HttpURLConnection) url.openConnection();
    connection.setRequestMethod("POST");
    connection.setRequestProperty("Accept", "application/json");

    // Pass cookies if any
    String cookies = request.getHeader("Cookie");
    if (cookies != null) {
      connection.setRequestProperty("Cookie", cookies);
    }

    int responseCode = connection.getResponseCode();

    if (responseCode == 200) {
      // Clear frontend session
      session.invalidate();

      // Logout successful, redirect to login page
      response.sendRedirect("./index.jsp");
    } else {
      // Redirect to an error page or handle as needed
      response.sendRedirect("./error.jsp?message=Failed to logout. HTTP Code: " + responseCode);
    }

    connection.disconnect();
  } catch (Exception e) {
    // Redirect to an error page with the exception message
    response.sendRedirect("./error.jsp?message=" + URLEncoder.encode("Error: " + e.getMessage(), "UTF-8"));
  }
%>
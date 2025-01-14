<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lecturer Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }
        .login-container h2 {
            margin-bottom: 20px;
            font-size: 1.5rem;
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn:hover {
            background: #0056b3;
        }
        .result {
            margin-top: 15px;
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Lecturer Login</h2>
    <form method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="btn">Login</button>
    </form>
    <div class="result">
        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                try {
                    // Define the login API URL
                    URL url = new URL("http://51.20.114.214:8081/api/v1/lecturer/login");

                    // Open a connection
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setRequestMethod("POST");
                    conn.setRequestProperty("Content-Type", "application/json");
                    conn.setDoOutput(true);

                    // Prepare JSON payload
                    String payload = "{\"username\":\"" + username + "\",\"password\":\"" + password + "\"}";

                    // Send request
                    try (OutputStream os = conn.getOutputStream()) {
                        os.write(payload.getBytes("UTF-8"));
                    }

                    // Read response
                    int responseCode = conn.getResponseCode();
                    if (responseCode == HttpURLConnection.HTTP_OK) {
                        // Forward session cookies from the response
                        String cookieHeader = conn.getHeaderField("Set-Cookie");
                        if (cookieHeader != null) {
                            session.setAttribute("sessionCookie", cookieHeader);
                        }

                        out.println("<p style='color: green;'>Login successful! Redirecting...</p>");
                        response.sendRedirect("Lecturer/sessionhandler.jsp");
                    } else {
                        out.println("<p>Login failed: Invalid credentials</p>");
                    }
                } catch (Exception e) {
                    out.println("<p>Error during login: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</div>
</body>
</html>

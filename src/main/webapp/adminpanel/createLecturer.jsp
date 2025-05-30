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
    <title>Create Lecturer</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            padding: 20px;
        }
        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
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
            border-radius: 5px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 1rem;
            border: none;
            border-radius: 4px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .alert {
            margin-top: 20px;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <h3>Create Lecturer</h3>
        <form method="post" action="./createLecturer.jsp">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="contact">Contact</label>
                <input type="text" id="contact" name="contact" required>
            </div>
            <button type="submit" class="btn">Create Lecturer</button>
        </form>
        <%
            String username = request.getParameter("username");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String contact = request.getParameter("contact");

            if (username != null && name != null && email != null && password != null && contact != null) {
                try {
                    URL url = new URL("http://51.20.114.214:8081/api/v1/admin/lecturer/register");
                    HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                    connection.setRequestMethod("POST");
                    connection.setRequestProperty("Content-Type", "application/json");

                    // Retrieve session cookie and add it to the request
                    String sessionCookie = (String) session.getAttribute("sessionCookie");
                    if (sessionCookie != null) {
                        connection.setRequestProperty("Cookie", sessionCookie);
                    }

                    connection.setDoOutput(true);

                    JSONObject payload = new JSONObject();
                    payload.put("username", username);
                    payload.put("name", name);
                    payload.put("email", email);
                    payload.put("password", password);
                    payload.put("contact", contact);

                    OutputStream os = connection.getOutputStream();
                    os.write(payload.toString().getBytes("UTF-8"));
                    os.close();

                    int responseCode = connection.getResponseCode();
                    if (responseCode == 200) {
                        request.setAttribute("message", "<div class='alert alert-success'>Lecturer registered successfully!</div>");
                    } else {
                        request.setAttribute("message", "<div class='alert alert-danger'>Failed to register lecturer. HTTP Code: " + responseCode + "</div>");
                    }
                } catch (Exception e) {
                    request.setAttribute("message", "<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                }
            }
        %>
        <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
    </div>
</div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login</title>
    <style>
        /* Body Styling */
        body {
            font-family: 'Arial', sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        /* Login Container Styling */
        .login-container {
            background: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }

        .login-container h2 {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 20px;
        }

        /* Form Styling */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-bottom: 8px;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            outline: none;
            transition: border 0.3s ease;
        }

        .form-group input:focus {
            border-color: #ff7e5f;
        }

        /* Button Styling */
        .btn {
            width: 100%;
            padding: 12px;
            background: #ff7e5f;
            color: white;
            font-size: 1.1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background: #feb47b;
        }

        /* Result Message Styling */
        .result {
            margin-top: 20px;
            font-size: 1rem;
            color: #e74c3c;
        }

        /* Responsive Design */
        @media (max-width: 400px) {
            .login-container {
                width: 90%;
                padding: 30px;
            }
        }
    </style>
</head>
<body class="relative" style="background-image: url('auth/images/lecturer.jpg'); background-size: cover; background-position: center; height: 100vh; margin: 0; background-attachment: fixed;">

<div class="login-container">
    <h2>Lecturer Login</h2>
    <form id="lecturerLoginForm">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="button" class="btn" id="lecturerLoginButton">Login</button>
        <div class="result" id="result"></div>
    </form>
</div>

<script>
    const studentLoginEndpoint = "http://localhost:8080/api/v1/lecturer/login";

    // Student Login Function
    async function studentLogin() {
        const username = document.getElementById("username").value;
        const password = document.getElementById("password").value;

        try {
            const response = await fetch(studentLoginEndpoint, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({ username, password }),
                credentials: "include" // Include cookies in the request
            });

            if (response.ok) {
                document.getElementById("result").innerText = "Login successful! Redirecting...";
                setTimeout(() => {
                    window.location.href = "Lecturer/sessionhandler.jsp"; // Redirect after successful login
                }, 2000);
            } else {
                const error = await response.text();
                document.getElementById("result").innerText = "Login failed: " + error;
            }
        } catch (error) {
            document.getElementById("result").innerText = "Error during login: " + error.message;
        }
    }

    // Attach event listener to student login button
    document.getElementById("lecturerLoginForm").addEventListener("click", studentLogin);
</script>
</body>
</html>
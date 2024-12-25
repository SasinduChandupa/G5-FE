<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Feedback</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
<div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-lg">
    <h1 class="text-2xl font-bold text-gray-800 mb-6 text-center">Submit Feedback</h1>
    <form id="feedbackForm" class="space-y-4">
        <!-- Event ID -->
        <div>
            <label for="eventId" class="block text-sm font-medium text-gray-700">Event ID</label>
            <input
                    type="text"
                    name="eventId"
                    id="eventId"
                    required
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                    placeholder="Enter Event ID"
            >
        </div>

        <!-- Description (Feedback) -->
        <div>
            <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
            <textarea
                    name="description"
                    id="description"
                    required
                    rows="4"
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                    placeholder="Enter your feedback here..."
            ></textarea>
        </div>

        <!-- Sender (Student ID) -->
        <div>
            <label for="sender" class="block text-sm font-medium text-gray-700">Sender (Student ID)</label>
            <input
                    type="text"
                    name="sender"
                    id="sender"
                    required
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                    placeholder="Enter Your Student ID"
            >
        </div>

        <!-- Receiver (Lecturer Name) -->
        <div>
            <label for="receiver" class="block text-sm font-medium text-gray-700">Receiver (Lecturer Name)</label>
            <input
                    type="text"
                    name="receiver"
                    id="receiver"
                    required
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                    placeholder="Enter Lecturer Name"
            >
        </div>

        <!-- Lecture ID -->
        <div>
            <label for="lectureId" class="block text-sm font-medium text-gray-700">Lecture ID</label>
            <input
                    type="text"
                    name="lectureId"
                    id="lectureId"
                    required
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                    placeholder="Enter Lecture ID"
            >
        </div>

        <!-- Student ID -->
        <div>
            <label for="studentId" class="block text-sm font-medium text-gray-700">Student ID</label>
            <input
                    type="text"
                    name="studentId"
                    id="studentId"
                    required
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                    placeholder="Enter Student ID"
            >
        </div>

        <!-- Submit Button -->
        <div>
            <button
                    type="submit"
                    class="w-full bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 px-4 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
            >
                Submit
            </button>
        </div>
    </form>
</div>


<script>
    document.getElementById("feedbackForm").addEventListener("submit", async (e) => {
        e.preventDefault();

        // Collect form data
        const feedbackData = {
            eventId: document.getElementById("eventId").value,
            description: document.getElementById("description").value,
            sender: document.getElementById("sender").value,
            receiver: document.getElementById("receiver").value,
            lectureId: document.getElementById("lectureId").value,
            studentId: document.getElementById("studentId").value
        };

        try {
            // Send a POST request to the backend
            const response = await fetch("https://virtserver.swaggerhub.com/MCHANUKA72/NibmEvex/1/students/feedback", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(feedbackData)
            });

            // Handle response
            if (response.ok) {
                const data = await response.json();
                alert(data.message || "Feedback submitted .");
                window.location.href = "student.jsp";
            } else {
                const data = await response.json();
                alert(data.message || "Failed to submit feedback. Please try again.");
            }
        } catch (error) {
            console.error("Error:", error);
            alert("An unexpected error occurred. Please try again.");
        }
    });
</script>


</body>
</html>
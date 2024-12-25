<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Feedback</title>
    <script>
        // Function to fetch feedback from the server and display them in the table
        async function fetchFeedback() {
            try {
                const response = await fetch('https://virtserver.swaggerhub.com/MCHANUKA72/NibmEvex/1/students/feedbacks', {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json'
                    }
                });

                if (!response.ok) {
                    throw new Error('Failed to fetch feedback');
                }

                const feedbacks = await response.json();
                const tableBody = document.getElementById('feedbackTableBody');
                tableBody.innerHTML = ''; // Clear previous rows

                if (Array.isArray(feedbacks)) {
                    feedbacks.forEach(feedback => {
                        const row = document.createElement('tr');

                        const eventIdCell = document.createElement('td');
                        eventIdCell.textContent = feedback.eventId; // Event ID from response
                        row.appendChild(eventIdCell);

                        const feedbackCell = document.createElement('td');
                        feedbackCell.textContent = feedback.feedback; // Feedback text
                        row.appendChild(feedbackCell);

                        tableBody.appendChild(row);
                    });
                } else {
                    console.error('Unexpected response structure:', feedbacks);
                }

            } catch (error) {
                console.error('Error fetching feedback:', error);
            }
        }

        // Call the fetchFeedback function when the page loads
        window.onload = fetchFeedback;
    </script>
</head>
<body>
<header>
    <h1>Feedback from Lecturers</h1>
</header>

<main>
    <h2>Feedback List</h2>
    <table border="1">
        <thead>
        <tr>
            <th>Event ID</th>
            <th>Feedback</th>
        </tr>
        </thead>
        <tbody id="feedbackTableBody">
        <!-- Feedback data will be populated here by JavaScript -->
        </tbody>
    </table>
</main>

</body>
</html>
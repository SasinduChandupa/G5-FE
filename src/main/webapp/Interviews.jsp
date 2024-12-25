<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assigned Interviews</title>
    <script>
        // Function to fetch interviews from the server and display them in the table
        async function fetchInterviews() {
            try {
                const response = await fetch('https://virtserver.swaggerhub.com/MCHANUKA72/NibmEvex/1/students/interviews', {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json'
                    }
                });

                if (response.ok) {
                    const interviews = await response.json();
                    const tableBody = document.getElementById('interviewTableBody');
                    tableBody.innerHTML = '';

                    if (Array.isArray(interviews) && interviews.length > 0) {
                        interviews.forEach(interview => {
                            const row = document.createElement('tr');

                            const eventNameCell = document.createElement('td');
                            eventNameCell.textContent = interview.eventName;
                            row.appendChild(eventNameCell);

                            const dateCell = document.createElement('td');
                            dateCell.textContent = interview.date;
                            row.appendChild(dateCell);

                            const statusCell = document.createElement('td');
                            statusCell.textContent = interview.status;
                            row.appendChild(statusCell);

                            const locationCell = document.createElement('td');
                            locationCell.textContent = interview.location;
                            row.appendChild(locationCell);

                            const interviewerCell = document.createElement('td');
                            interviewerCell.textContent = interview.interviewer;
                            row.appendChild(interviewerCell);

                            tableBody.appendChild(row);
                        });
                    } else {
                        tableBody.innerHTML = '<tr><td colspan="5">No interviews assigned.</td></tr>';
                    }
                } else {
                    console.error('Failed to fetch interviews:', response.statusText);
                    alert('Error fetching interviews. Please try again later.');
                }
            } catch (error) {
                console.error('Error fetching interviews:', error);
            }
        }

        window.onload = fetchInterviews;
    </script>
</head>
<body>
<header>
    <h1>Assigned Interviews</h1>
</header>

<main>
    <table border="1">
        <thead>
        <tr>
            <th>Event Name</th>
            <th>Date</th>
            <th>Status</th>
            <th>Location</th>
            <th>Interviewer</th>
        </tr>
        </thead>
        <tbody id="interviewTableBody">
        <!-- Interview data will be populated here by JavaScript -->
        </tbody>
    </table>
</main>
</body>
</html>
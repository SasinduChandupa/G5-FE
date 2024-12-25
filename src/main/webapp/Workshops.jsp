<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Workshops</title>
    <script>
        // Function to fetch workshops from the server and display them in the table
        async function fetchWorkshops() {
            try {
                const response = await fetch('https://virtserver.swaggerhub.com/MCHANUKA72/NibmEvex/1/students/workshops', {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json'
                    }
                });

                if (!response.ok) {
                    throw new Error('Failed to fetch workshops');
                }

                const workshops = await response.json();
                const tableBody = document.getElementById('workshopTableBody');
                tableBody.innerHTML = ''; // Clear previous rows

                // Populate table with workshops
                workshops.forEach(workshop => {
                    const row = document.createElement('tr');

                    const nameCell = document.createElement('td');
                    nameCell.textContent = workshop.eventName;
                    row.appendChild(nameCell);

                    const dateCell = document.createElement('td');
                    dateCell.textContent = workshop.date;
                    row.appendChild(dateCell);

                    const statusCell = document.createElement('td');
                    statusCell.textContent = workshop.status;
                    row.appendChild(statusCell);

                    const locationCell = document.createElement('td');
                    locationCell.textContent = workshop.location;
                    row.appendChild(locationCell);

                    const topicCell = document.createElement('td');
                    topicCell.textContent = workshop.topic.join(', ');
                    row.appendChild(topicCell);

                    const speakerCell = document.createElement('td');
                    speakerCell.textContent = workshop.speaker;
                    row.appendChild(speakerCell);

                    const durationCell = document.createElement('td');
                    durationCell.textContent = workshop.duration;
                    row.appendChild(durationCell);

                    const batchIdCell = document.createElement('td');
                    batchIdCell.textContent = workshop.batchId;
                    row.appendChild(batchIdCell);

                    tableBody.appendChild(row);
                });
            } catch (error) {
                console.error('Error fetching workshops:', error);
            }
        }

        // Fetch workshops on page load
        window.onload = fetchWorkshops;
    </script>
</head>
<body>
<header>
    <h1>Workshops</h1>
</header>
<main>
    <h2>Assigned Workshops</h2>
    <table border="1">
        <thead>
        <tr>
            <th>Name</th>
            <th>Date</th>
            <th>Status</th>
            <th>Location</th>
            <th>Topics</th>
            <th>Speaker</th>
            <th>Duration</th>
            <th>Batch ID</th>
        </tr>
        </thead>
        <tbody id="workshopTableBody">
        <!-- Workshop data will be dynamically inserted here -->
        </tbody>
    </table>
</main>
</body>
</html>
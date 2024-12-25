<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Announcements</title>
    <script>
        // Function to fetch announcements from the server and display them in the table
        async function fetchAnnouncements() {
            try {
                const response = await fetch('https://virtserver.swaggerhub.com/MCHANUKA72/NibmEvex/1/students/announcements', {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json'
                    }
                });

                if (!response.ok) {
                    throw new Error('Failed to fetch announcements');
                }

                const announcements = await response.json();
                const tableBody = document.getElementById('announcementTableBody');
                tableBody.innerHTML = ''; // Clear previous rows

                if (Array.isArray(announcements)) {
                    announcements.forEach(announcement => {
                        const row = document.createElement('tr');

                        const idCell = document.createElement('td');
                        idCell.textContent = announcement.id; // Announcement ID
                        row.appendChild(idCell);

                        const batchIdCell = document.createElement('td');
                        batchIdCell.textContent = announcement.batchId; // Batch ID
                        row.appendChild(batchIdCell);

                        const messageCell = document.createElement('td');
                        messageCell.textContent = announcement.message; // Announcement message
                        row.appendChild(messageCell);

                        tableBody.appendChild(row);
                    });
                } else {
                    console.error('Unexpected response structure:', announcements);
                }

            } catch (error) {
                console.error('Error fetching announcements:', error);
            }
        }

        // Call the fetchAnnouncements function when the page loads
        window.onload = fetchAnnouncements;
    </script>
</head>
<body>
<header>
    <h1>Announcements</h1>
</header>

<main>
    <h2>Announcements List</h2>
    <table border="1">
        <thead>
        <tr>
            <th>ID</th>
            <th>Batch ID</th>
            <th>Message</th>
        </tr>
        </thead>
        <tbody id="announcementTableBody">
        <!-- Announcement data will be populated here by JavaScript -->
        </tbody>
    </table>
</main>

</body>
</html>
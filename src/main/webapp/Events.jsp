<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Events</title>
    <script>
        // Function to search events and populate the table
        async function searchEvents() {
            const query = document.getElementById('query').value;
            const eventType = document.getElementById('eventType').value;

            const url = new URL('https://virtserver.swaggerhub.com/MCHANUKA72/NibmEvex/1/students/events/search');
            if (query) {
                url.searchParams.append('query', query);
            }
            if (eventType) {
                url.searchParams.append('eventType', eventType);
            }

            try {
                const response = await fetch(url, {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json'
                    }
                });

                const resultsTable = document.getElementById('resultsTableBody');
                resultsTable.innerHTML = ''; // Clear previous results

                if (response.ok) {
                    const events = await response.json();
                    events.forEach(event => {
                        const row = document.createElement('tr');

                        const idCell = document.createElement('td');
                        idCell.textContent = event.id;
                        row.appendChild(idCell);

                        const nameCell = document.createElement('td');
                        nameCell.textContent = event.eventName;
                        row.appendChild(nameCell);

                        const dateCell = document.createElement('td');
                        dateCell.textContent = event.date;
                        row.appendChild(dateCell);

                        const typeCell = document.createElement('td');
                        typeCell.textContent = event.eventType;
                        row.appendChild(typeCell);

                        resultsTable.appendChild(row);
                    });
                } else {
                    const error = await response.json();
                    alert(Error: ${error.error});
                }
            } catch (err) {
                console.error('Error searching events:', err);
                alert('An error occurred while searching for events.');
            }
        }
    </script>
</head>
<body>
<header>
    <h1>Search Events</h1>
</header>
<main>
    <h2>Find Events</h2>
    <form onsubmit="event.preventDefault(); searchEvents();">
        <label for="query">Search Query:</label>
        <input type="text" id="query" name="query" placeholder="Enter event name or date">
        <label for="eventType">Event Type:</label>
        <select id="eventType" name="eventType">
            <option value="">All</option>
            <option value="workshop">Workshop</option>
            <option value="interview">Interview</option>
        </select>
        <button type="submit">Search</button>
    </form>

    <h2>Search Results</h2>
    <table border="1">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Date</th>
            <th>Type</th>
        </tr>
        </thead>
        <tbody id="resultsTableBody">
        <!-- Results will be dynamically populated here -->
        </tbody>
    </table>
</main>
</body>
</html>
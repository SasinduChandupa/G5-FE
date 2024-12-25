<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maintain Career Portfolio</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
<div class="w-full max-w-md bg-white p-8 rounded-lg shadow-lg">
    <h1 class="text-2xl font-bold text-gray-800 mb-6 text-center">Maintain Career Portfolio</h1>
    <form id="portfolioForm" class="space-y-4">
        <div>
            <label for="description" class="block text-gray-700 font-medium mb-2">Description</label>
            <textarea id="description" name="description" required
                      class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"></textarea>
        </div>
        <div>
            <label for="education" class="block text-gray-700 font-medium mb-2">Education</label>
            <input type="text" id="education" name="education" required
                   class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
        </div>
        <div>
            <label for="achievement" class="block text-gray-700 font-medium mb-2">Achievement</label>
            <input type="text" id="achievement" name="achievement" required
                   class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
        </div>
        <button type="submit"
                class="w-full bg-blue-500 text-white py-2 px-4 rounded-md hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
            Save Portfolio
        </button>
    </form>
</div>

<script>
    document.getElementById("portfolioForm").addEventListener("submit", async (e) => {
        e.preventDefault();

        // Collect form data
        const formData = {
            description: document.getElementById("description").value,
            education: document.getElementById("education").value,
            achievement: document.getElementById("achievement").value
        };

        try {
            // Send a PUT request to the backend
            const response = await fetch("https://virtserver.swaggerhub.com/MCHANUKA72/NibmEvex/1/students/portfolio", {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(formData)
            });

            // Parse the JSON response
            const data = await response.json();

            if (response.ok) {
                alert(data.message || "updated successfully.");
                window.location.href = "/index.jsp";
            } else {
                alert(data.error || "Failed to update portfolio. Please try again.");
            }
        } catch (error) {
            console.error("Error:", error);
            alert("An unexpected error occurred. Please try again.");
        }
    });
</script>

</body>
</html>
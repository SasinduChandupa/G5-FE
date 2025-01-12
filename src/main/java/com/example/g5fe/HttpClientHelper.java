package com.example.g5fe;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class HttpClientHelper {

    // Method to send a GET request
    public static String sendGetRequest(String urlString) throws IOException {
        HttpURLConnection conn = createConnection(urlString, "GET");
        return getResponse(conn);
    }

    // Method to send a POST request
    public static String sendPostRequest(String urlString, String jsonInput) throws IOException {
        HttpURLConnection conn = createConnection(urlString, "POST");
        return sendRequestWithBody(conn, jsonInput);
    }

    // Method to send a PUT request
    public static String sendPutRequest(String urlString, String jsonInput) throws IOException {
        HttpURLConnection conn = createConnection(urlString, "PUT");
        return sendRequestWithBody(conn, jsonInput);
    }

    // Method to send a DELETE request
    public static String sendDeleteRequest(String urlString) throws IOException {
        HttpURLConnection conn = createConnection(urlString, "DELETE");
        return getResponse(conn);
    }

    // Helper method to create an HTTP connection
    private static HttpURLConnection createConnection(String urlString, String method) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod(method);
        conn.setRequestProperty("Content-Type", "application/json");

        // Enable output for methods requiring a body (POST, PUT)
        if (method.equals("POST") || method.equals("PUT")) {
            conn.setDoOutput(true);
        }
        return conn;
    }

    // Helper method to send the request with a body (used for POST and PUT)
    private static String sendRequestWithBody(HttpURLConnection conn, String jsonInput) throws IOException {
        try (OutputStream os = conn.getOutputStream()) {
            os.write(jsonInput.getBytes());
            os.flush();
        }
        return getResponse(conn);
    }



    // Helper method to retrieve the response
    private static String getResponse(HttpURLConnection conn) throws IOException {
        int responseCode = conn.getResponseCode();
        StringBuilder response = new StringBuilder();

        // Use BufferedReader for better performance
        try (BufferedReader in = new BufferedReader(new InputStreamReader(
                (responseCode >= 200 && responseCode < 300) ? conn.getInputStream() : conn.getErrorStream()))) {
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
        }

        if (responseCode >= 200 && responseCode < 300) {
            return response.toString();
        } else {
            throw new IOException("HTTP Error Code: " + responseCode + " Response: " + response.toString());
        }
    }

    // Method to format feedback data into JSON format for sending in POST request
    public static String formatFeedbackJson(String eventId, String description, String sender,
                                            String receiver, String lectureId, String studentId) {
        return "{"
                + "\"eventId\": \"" + eventId + "\","
                + "\"description\": \"" + description + "\","
                + "\"sender\": \"" + sender + "\","
                + "\"receiver\": \"" + receiver + "\","
                + "\"lectureId\": \"" + lectureId + "\","
                + "\"studentId\": \"" + studentId + "\""
                + "}";
    }
}
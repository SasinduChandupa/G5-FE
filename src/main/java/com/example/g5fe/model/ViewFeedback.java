package com.example.eventmanagement.models;

public class ViewFeedback {
    private String eventId;
    private String feedback;

    public ViewFeedback() {
        // Default constructor
    }

    public ViewFeedback(String eventId, String feedback) {
        this.eventId = eventId;
        this.feedback = feedback;
    }

    public String getEventId() {
        return eventId;
    }

    public void setEventId(String eventId) {
        this.eventId = eventId;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }
}
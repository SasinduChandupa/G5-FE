package com.example.eventmanagement.models;

public class Events {
    private String id;
    private String eventName;
    private String date;
    private String eventType;

    public Events() {
        // Default constructor
    }

    public Events(String id, String eventName, String date, String eventType) {
        this.id = id;
        this.eventName = eventName;
        this.date = date;
        this.eventType = eventType;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getEventType() {
        return eventType;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
    }
}
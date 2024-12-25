package com.example.eventmanagement.models;

public class Interviews {
    private String eventName;
    private String date;
    private String status;
    private String location;
    private String interviewer;

    public Interviews() {
        // Default constructor
    }

    public Interviews(String eventName, String date, String status, String location, String interviewer) {
        this.eventName = eventName;
        this.date = date;
        this.status = status;
        this.location = location;
        this.interviewer = interviewer;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getInterviewer() {
        return interviewer;
    }

    public void setInterviewer(String interviewer) {
        this.interviewer = interviewer;
    }
}
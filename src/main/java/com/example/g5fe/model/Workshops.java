package com.example.eventmanagement.models;

import java.util.List;

public class Workshops {
    private String eventName;
    private String date;
    private String status;
    private String location;
    private List<String> topic;
    private String speaker;
    private String duration;
    private String batchId; // Added Batch ID field

    public Workshops() {
        // Default constructor
    }

    public Workshops(String eventName, String date, String status, String location, List<String> topic, String speaker, String duration, String batchId) {
        this.eventName = eventName;
        this.date = date;
        this.status = status;
        this.location = location;
        this.topic = topic;
        this.speaker = speaker;
        this.duration = duration;
        this.batchId = batchId;
    }

    // Getters and Setters
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

    public List<String> getTopic() {
        return topic;
    }

    public void setTopic(List<String> topic) {
        this.topic = topic;
    }

    public String getSpeaker() {
        return speaker;
    }

    public void setSpeaker(String speaker) {
        this.speaker = speaker;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getBatchId() {
        return batchId;
    }

    public void setBatchId(String batchId) {
        this.batchId = batchId;
    }
}
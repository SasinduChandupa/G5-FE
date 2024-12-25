package com.example.eventmanagement.models;

public class ViewAnnouncements {
    private String id;
    private String batchId;
    private String message;

    public ViewAnnouncements() {
        // Default constructor
    }

    public ViewAnnouncements(String id, String batchId, String message) {
        this.id = id;
        this.batchId = batchId;
        this.message = message;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBatchId() {
        return batchId;
    }

    public void setBatchId(String batchId) {
        this.batchId = batchId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
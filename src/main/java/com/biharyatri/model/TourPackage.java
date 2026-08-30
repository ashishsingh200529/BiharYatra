package com.biharyatri.model;

import java.util.ArrayList;
import java.util.List;

public class TourPackage {
    private int id;
    private String title;
    private String description;
    private double price;
    private int durationDays;
    private int durationNights;
    private String startLocation;
    private String difficulty;
    private boolean isFeatured;
    private String status;

    // Helper mappings
    private List<String> imageUrls = new ArrayList<>();
    private List<Place> places = new ArrayList<>();
    private List<Itinerary> itineraries = new ArrayList<>();

    public TourPackage() {}

    public TourPackage(int id, String title, String description, double price, int durationDays, int durationNights, String startLocation, String difficulty, boolean isFeatured, String status) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.price = price;
        this.durationDays = durationDays;
        this.durationNights = durationNights;
        this.startLocation = startLocation;
        this.difficulty = difficulty;
        this.isFeatured = isFeatured;
        this.status = status;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getDurationDays() { return durationDays; }
    public void setDurationDays(int durationDays) { this.durationDays = durationDays; }

    public int getDurationNights() { return durationNights; }
    public void setDurationNights(int durationNights) { this.durationNights = durationNights; }

    public String getStartLocation() { return startLocation; }
    public void setStartLocation(String startLocation) { this.startLocation = startLocation; }

    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String difficulty) { this.difficulty = difficulty; }

    public boolean isFeatured() { return isFeatured; }
    public void setFeatured(boolean featured) { isFeatured = featured; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public List<String> getImageUrls() { return imageUrls; }
    public void setImageUrls(List<String> imageUrls) { this.imageUrls = imageUrls; }

    public List<Place> getPlaces() { return places; }
    public void setPlaces(List<Place> places) { this.places = places; }

    public List<Itinerary> getItineraries() { return itineraries; }
    public void setItineraries(List<Itinerary> itineraries) { this.itineraries = itineraries; }
}

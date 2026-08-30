package com.biharyatri.model;

public class Place {
    private int id;
    private String name;
    private String description;
    private String district;
    private double latitude;
    private double longitude;
    private String imageUrl;
    private String bestTimeToVisit;

    public Place() {}

    public Place(int id, String name, String description, String district, double latitude, double longitude, String imageUrl, String bestTimeToVisit) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.district = district;
        this.latitude = latitude;
        this.longitude = longitude;
        this.imageUrl = imageUrl;
        this.bestTimeToVisit = bestTimeToVisit;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public double getLatitude() { return latitude; }
    public void setLatitude(double latitude) { this.latitude = latitude; }

    public double getLongitude() { return longitude; }
    public void setLongitude(double longitude) { this.longitude = longitude; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getBestTimeToVisit() { return bestTimeToVisit; }
    public void setBestTimeToVisit(String bestTimeToVisit) { this.bestTimeToVisit = bestTimeToVisit; }
}

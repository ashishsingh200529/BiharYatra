package com.biharyatri.model;

import java.util.ArrayList;
import java.util.List;

public class Hotel {
    private int id;
    private String name;
    private String district;
    private String address;
    private double rating;
    private String description;
    private String imageUrl;
    private List<Room> rooms = new ArrayList<>();

    public Hotel() {}

    public Hotel(int id, String name, String district, String address, double rating, String description, String imageUrl) {
        this.id = id;
        this.name = name;
        this.district = district;
        this.address = address;
        this.rating = rating;
        this.description = description;
        this.imageUrl = imageUrl;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public List<Room> getRooms() { return rooms; }
    public void setRooms(List<Room> rooms) { this.rooms = rooms; }
}

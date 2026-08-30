package com.biharyatri.model;

public class Room {
    private int id;
    private int hotelId;
    private String roomType;
    private double pricePerNight;
    private int capacity;
    private String amenities;
    private boolean isAvailable;

    public Room() {}

    public Room(int id, int hotelId, String roomType, double pricePerNight, int capacity, String amenities, boolean isAvailable) {
        this.id = id;
        this.hotelId = hotelId;
        this.roomType = roomType;
        this.pricePerNight = pricePerNight;
        this.capacity = capacity;
        this.amenities = amenities;
        this.isAvailable = isAvailable;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getHotelId() { return hotelId; }
    public void setHotelId(int hotelId) { this.hotelId = hotelId; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public double getPricePerNight() { return pricePerNight; }
    public void setPricePerNight(double pricePerNight) { this.pricePerNight = pricePerNight; }

    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }

    public String getAmenities() { return amenities; }
    public void setAmenities(String amenities) { this.amenities = amenities; }

    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean available) { isAvailable = available; }
}

package com.biharyatri.model;

public class Vehicle {
    private int id;
    private String type;
    private String model;
    private int capacity;
    private double pricePerKm;
    private double pricePerDay;
    private String driverName;
    private String driverPhone;
    private boolean isAvailable;

    public Vehicle() {}

    public Vehicle(int id, String type, String model, int capacity, double pricePerKm, double pricePerDay, String driverName, String driverPhone, boolean isAvailable) {
        this.id = id;
        this.type = type;
        this.model = model;
        this.capacity = capacity;
        this.pricePerKm = pricePerKm;
        this.pricePerDay = pricePerDay;
        this.driverName = driverName;
        this.driverPhone = driverPhone;
        this.isAvailable = isAvailable;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }

    public double getPricePerKm() { return pricePerKm; }
    public void setPricePerKm(double pricePerKm) { this.pricePerKm = pricePerKm; }

    public double getPricePerDay() { return pricePerDay; }
    public void setPricePerDay(double pricePerDay) { this.pricePerDay = pricePerDay; }

    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }

    public String getDriverPhone() { return driverPhone; }
    public void setDriverPhone(String driverPhone) { this.driverPhone = driverPhone; }

    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean available) { isAvailable = available; }
}

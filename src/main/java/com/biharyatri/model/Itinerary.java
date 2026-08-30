package com.biharyatri.model;

public class Itinerary {
    private int id;
    private int packageId;
    private int dayNumber;
    private String title;
    private String activityDetails;
    private String mealsIncluded;
    private String accommodation;

    public Itinerary() {}

    public Itinerary(int id, int packageId, int dayNumber, String title, String activityDetails, String mealsIncluded, String accommodation) {
        this.id = id;
        this.packageId = packageId;
        this.dayNumber = dayNumber;
        this.title = title;
        this.activityDetails = activityDetails;
        this.mealsIncluded = mealsIncluded;
        this.accommodation = accommodation;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPackageId() { return packageId; }
    public void setPackageId(int packageId) { this.packageId = packageId; }

    public int getDayNumber() { return dayNumber; }
    public void setDayNumber(int dayNumber) { this.dayNumber = dayNumber; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getActivityDetails() { return activityDetails; }
    public void setActivityDetails(String activityDetails) { this.activityDetails = activityDetails; }

    public String getMealsIncluded() { return mealsIncluded; }
    public void setMealsIncluded(String mealsIncluded) { this.mealsIncluded = mealsIncluded; }

    public String getAccommodation() { return accommodation; }
    public void setAccommodation(String accommodation) { this.accommodation = accommodation; }
}

package com.biharyatri.model;

public class BookingDetail {
    private int id;
    private int bookingId;
    private String travelerName;
    private int travelerAge;
    private String travelerGender;

    public BookingDetail() {}

    public BookingDetail(int id, int bookingId, String travelerName, int travelerAge, String travelerGender) {
        this.id = id;
        this.bookingId = bookingId;
        this.travelerName = travelerName;
        this.travelerAge = travelerAge;
        this.travelerGender = travelerGender;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public String getTravelerName() { return travelerName; }
    public void setTravelerName(String travelerName) { this.travelerName = travelerName; }

    public int getTravelerAge() { return travelerAge; }
    public void setTravelerAge(int travelerAge) { this.travelerAge = travelerAge; }

    public String getTravelerGender() { return travelerGender; }
    public void setTravelerGender(String travelerGender) { this.travelerGender = travelerGender; }
}

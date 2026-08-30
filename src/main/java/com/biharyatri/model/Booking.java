package com.biharyatri.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Booking {
    private int id;
    private String bookingNo;
    private int userId;
    private int packageId;
    private Timestamp bookingDate;
    private Date travelDate;
    private int numTravelers;
    private double totalPrice;
    private String status;
    private String paymentStatus;
    private Timestamp createdAt;

    // Join / Helper Fields
    private String userEmail;
    private String userName;
    private String packageTitle;
    private String packageImageUrl;
    private List<BookingDetail> travelers = new ArrayList<>();

    public Booking() {}

    public Booking(int id, String bookingNo, int userId, int packageId, Timestamp bookingDate, Date travelDate, int numTravelers, double totalPrice, String status, String paymentStatus, Timestamp createdAt) {
        this.id = id;
        this.bookingNo = bookingNo;
        this.userId = userId;
        this.packageId = packageId;
        this.bookingDate = bookingDate;
        this.travelDate = travelDate;
        this.numTravelers = numTravelers;
        this.totalPrice = totalPrice;
        this.status = status;
        this.paymentStatus = paymentStatus;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getBookingNo() { return bookingNo; }
    public void setBookingNo(String bookingNo) { this.bookingNo = bookingNo; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getPackageId() { return packageId; }
    public void setPackageId(int packageId) { this.packageId = packageId; }

    public Timestamp getBookingDate() { return bookingDate; }
    public void setBookingDate(Timestamp bookingDate) { this.bookingDate = bookingDate; }

    public Date getTravelDate() { return travelDate; }
    public void setTravelDate(Date travelDate) { this.travelDate = travelDate; }

    public int getNumTravelers() { return numTravelers; }
    public void setNumTravelers(int numTravelers) { this.numTravelers = numTravelers; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getPackageTitle() { return packageTitle; }
    public void setPackageTitle(String packageTitle) { this.packageTitle = packageTitle; }

    public String getPackageImageUrl() { return packageImageUrl; }
    public void setPackageImageUrl(String packageImageUrl) { this.packageImageUrl = packageImageUrl; }

    public List<BookingDetail> getTravelers() { return travelers; }
    public void setTravelers(List<BookingDetail> travelers) { this.travelers = travelers; }
}

package com.biharyatri.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ServiceBooking {
    private int id;
    private String bookingType;
    private String userName;
    private String userPhone;
    private String serviceTitle;
    private String bookingDetails;
    private BigDecimal totalAmount;
    private String status;
    private Timestamp createdAt;

    public ServiceBooking() {}

    public ServiceBooking(int id, String bookingType, String userName, String userPhone, String serviceTitle, String bookingDetails, BigDecimal totalAmount, String status, Timestamp createdAt) {
        this.id = id;
        this.bookingType = bookingType;
        this.userName = userName;
        this.userPhone = userPhone;
        this.serviceTitle = serviceTitle;
        this.bookingDetails = bookingDetails;
        this.totalAmount = totalAmount;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getBookingType() { return bookingType; }
    public void setBookingType(String bookingType) { this.bookingType = bookingType; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getUserPhone() { return userPhone; }
    public void setUserPhone(String userPhone) { this.userPhone = userPhone; }

    public String getServiceTitle() { return serviceTitle; }
    public void setServiceTitle(String serviceTitle) { this.serviceTitle = serviceTitle; }

    public String getBookingDetails() { return bookingDetails; }
    public void setBookingDetails(String bookingDetails) { this.bookingDetails = bookingDetails; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}

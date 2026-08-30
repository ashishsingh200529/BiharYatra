package com.biharyatri.model;

import java.sql.Timestamp;

public class PartnerApplication {
    private int id;
    private String fullName;
    private String mobile;
    private String partnerType;
    private String district;
    private String idNumber;
    private String experienceDetails;
    private String status;
    private Timestamp createdAt;

    public PartnerApplication() {}

    public PartnerApplication(int id, String fullName, String mobile, String partnerType, String district, String idNumber, String experienceDetails, String status, Timestamp createdAt) {
        this.id = id;
        this.fullName = fullName;
        this.mobile = mobile;
        this.partnerType = partnerType;
        this.district = district;
        this.idNumber = idNumber;
        this.experienceDetails = experienceDetails;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }

    public String getPartnerType() { return partnerType; }
    public void setPartnerType(String partnerType) { this.partnerType = partnerType; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public String getIdNumber() { return idNumber; }
    public void setIdNumber(String idNumber) { this.idNumber = idNumber; }

    public String getExperienceDetails() { return experienceDetails; }
    public void setExperienceDetails(String experienceDetails) { this.experienceDetails = experienceDetails; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}

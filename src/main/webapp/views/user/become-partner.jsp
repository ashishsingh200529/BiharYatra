<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-dark text-white py-5">
    <div class="container text-center py-4">
        <span class="badge bg-warning text-dark px-3 py-2 rounded-pill mb-3 font-semibold">Earn with BiharYatra</span>
        <h1 class="fw-bold display-4 mb-3">Become an Official BiharYatra Partner</h1>
        <p class="lead text-white-50 max-w-2xl mx-auto mb-0">Join Bihar's #1 tourism platform. Register your Taxi, Homestay, or Tour Guide service and earn up to ₹50,000+ per month!</p>
    </div>
</div>

<div class="container my-5">
    <div class="row g-4 justify-content-center">
        <div class="col-lg-8">
            <c:if test="${not empty successMsg}">
                <div class="alert alert-success border-0 rounded-4 shadow-sm mb-4 d-flex align-items-center">
                    <i class="bi bi-check-circle-fill fs-3 me-3 text-success"></i>
                    <div>
                        <strong class="d-block font-semibold">Application Received!</strong>
                        <span>${successMsg}</span>
                    </div>
                </div>
            </c:if>
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger border-0 rounded-4 shadow-sm mb-4">
                    ${errorMsg}
                </div>
            </c:if>

            <div class="glass-card p-5 border bg-white rounded-4 shadow-sm">
                <h4 class="fw-bold text-dark mb-4 text-center"><i class="bi bi-person-badge-fill text-danger me-2"></i> Partner Registration Form</h4>
                
                <form action="${pageContext.request.contextPath}/become-partner" method="POST">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label font-semibold text-dark small">Full Name</label>
                            <input type="text" name="fullName" class="form-control" placeholder="Ramesh Singh" required />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label font-semibold text-dark small">Mobile Phone (WhatsApp)</label>
                            <input type="tel" name="mobile" class="form-control" placeholder="+91 98350 00000" required />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label font-semibold text-dark small">Partner Type</label>
                            <select name="partnerType" class="form-select" required>
                                <option value="Cab Driver / Taxi Fleet Operator">Cab Driver / Taxi Fleet Operator</option>
                                <option value="Certified Tour Guide">Certified Tour Guide</option>
                                <option value="Homestay / Hotel Host">Homestay / Hotel Host</option>
                                <option value="Local Culinary Partner">Local Food / Handicrafts Partner</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label font-semibold text-dark small">Primary District</label>
                            <select name="district" class="form-select" required>
                                <option value="Patna">Patna</option>
                                <option value="Gaya">Gaya / Bodh Gaya</option>
                                <option value="Nalanda">Nalanda / Rajgir</option>
                                <option value="West Champaran">West Champaran (Valmiki)</option>
                                <option value="Rohtas">Rohtas / Sasaram</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label font-semibold text-dark small">Aadhaar Card / Driving License Number</label>
                            <input type="text" name="idNumber" class="form-control" placeholder="XXXX-XXXX-XXXX" required />
                        </div>
                        <div class="col-12">
                            <label class="form-label font-semibold text-dark small">Tell Us About Your Fleet / Experience</label>
                            <textarea name="experienceDetails" class="form-control" rows="3" placeholder="I own 2 Innova Crystas and 1 Dzire based near Patna Airport..."></textarea>
                        </div>
                        <div class="col-12 mt-4">
                            <button type="submit" class="btn btn-brand w-100 py-3 font-semibold text-white shadow-sm">Submit Partner Application</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

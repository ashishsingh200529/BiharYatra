<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-gradient-to-r from-danger to-warning text-white py-5">
    <div class="container text-center py-4">
        <span class="badge bg-white text-danger px-3 py-2 rounded-pill mb-3 font-semibold">Festive Gifting</span>
        <h1 class="fw-bold display-4 mb-2">Gift a Bihar Travel Experience</h1>
        <p class="lead mb-0 opacity-90">Send digital travel gift vouchers to family and friends for Chhath Puja, Weddings, and Festivals.</p>
    </div>
</div>

<div class="container my-5">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card border rounded-4 shadow-sm p-4 text-center h-100 bg-light">
                <i class="bi bi-gift-fill display-3 text-danger mb-3 d-inline-block"></i>
                <h4 class="fw-bold text-dark">Chhath Puja Special</h4>
                <p class="text-muted small">Ideal for family visits to Bihar ghats & local sightseeing.</p>
                <h2 class="fw-bold text-danger my-3">Rs. 2,000</h2>
                <button class="btn btn-brand w-100 py-2.5 font-semibold" onclick="alert('Gift Card Purchased! Voucher Code: BYGIFT-CHHATH-2000 sent via SMS.');">Purchase Voucher</button>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card border border-warning rounded-4 shadow p-4 text-center h-100 bg-white" style="border-width: 2px !important;">
                <span class="badge bg-danger position-absolute top-0 end-0 m-3">Best Seller</span>
                <i class="bi bi-award-fill display-3 text-warning mb-3 d-inline-block"></i>
                <h4 class="fw-bold text-dark">Heritage Discovery Pass</h4>
                <p class="text-muted small">Valid for all 3-day Bodh Gaya, Rajgir, and Nalanda tour circuits.</p>
                <h2 class="fw-bold text-danger my-3">Rs. 5,000</h2>
                <button class="btn btn-brand w-100 py-2.5 font-semibold" onclick="alert('Gift Card Purchased! Voucher Code: BYGIFT-HERITAGE-5000 sent via SMS.');">Purchase Voucher</button>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card border rounded-4 shadow-sm p-4 text-center h-100 bg-light">
                <i class="bi bi-gem display-3 text-primary mb-3 d-inline-block"></i>
                <h4 class="fw-bold text-dark">Royal Yatri Luxury Pass</h4>
                <p class="text-muted small">Includes 4-Star hotels, AC Innova cab transfers, and private guide.</p>
                <h2 class="fw-bold text-danger my-3">Rs. 10,000</h2>
                <button class="btn btn-brand w-100 py-2.5 font-semibold" onclick="alert('Gift Card Purchased! Voucher Code: BYGIFT-ROYAL-10000 sent via SMS.');">Purchase Voucher</button>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

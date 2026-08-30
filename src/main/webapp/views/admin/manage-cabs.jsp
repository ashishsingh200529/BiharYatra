<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <span class="badge bg-danger mb-1">Admin Console</span>
            <h2 class="fw-bold text-dark mb-0"><i class="bi bi-taxi-front-fill text-primary me-2"></i> Manage Tourist Cabs & Routes</h2>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-dark btn-sm rounded-pill font-semibold">Back to Dashboard</a>
        </div>
    </div>

    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <h5 class="fw-bold text-dark mb-3">Cab Vehicle Fleet & Per-KM Rates</h5>
        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Vehicle Category</th>
                        <th>Seating Capacity</th>
                        <th>Per KM Fare Rate</th>
                        <th>Driver Allowance</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-bold text-dark">Sedan (Dzire / Etios)</td>
                        <td>4 Seats (AC)</td>
                        <td class="fw-bold text-danger">Rs. 14 / km</td>
                        <td>Included</td>
                        <td><span class="badge bg-success-subtle text-success border">Active Fleet</span></td>
                    </tr>
                    <tr>
                        <td class="fw-bold text-dark">SUV (Innova Crysta)</td>
                        <td>7 Seats (AC)</td>
                        <td class="fw-bold text-danger">Rs. 19 / km</td>
                        <td>Included</td>
                        <td><span class="badge bg-success-subtle text-success border">Active Fleet</span></td>
                    </tr>
                    <tr>
                        <td class="fw-bold text-dark">Tempo Traveller</td>
                        <td>17 Seats (AC)</td>
                        <td class="fw-bold text-danger">Rs. 28 / km</td>
                        <td>Included</td>
                        <td><span class="badge bg-success-subtle text-success border">Active Fleet</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

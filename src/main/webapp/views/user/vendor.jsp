<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-dark text-white py-4 border-bottom border-warning">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <span class="badge bg-warning text-dark px-3 py-1 rounded-pill mb-2 font-semibold">Vendor Portal</span>
            <h2 class="fw-bold mb-0">Partner Earnings & Payout Dashboard</h2>
        </div>
        <button class="btn btn-outline-light btn-sm rounded-pill font-semibold" onclick="alert('Instant Bank Payout of Rs. 1,20,700 initiated to registered HDFC Bank A/c!');"><i class="bi bi-wallet-fill text-warning me-1"></i> Withdraw Net Payout</button>
    </div>
</div>

<div class="container my-5">
    <!-- Stat Cards Row -->
    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                <small class="text-muted d-block font-semibold mb-1">Total Completed Bookings</small>
                <h2 class="fw-bold text-dark mb-0">48</h2>
            </div>
        </div>
        <div class="col-md-3">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                <small class="text-muted d-block font-semibold mb-1">Gross Booking Revenue</small>
                <h2 class="fw-bold text-primary mb-0">Rs. 1,42,000</h2>
            </div>
        </div>
        <div class="col-md-3">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                <small class="text-muted d-block font-semibold mb-1">Platform Commission (15%)</small>
                <h2 class="fw-bold text-danger mb-0">Rs. 21,300</h2>
            </div>
        </div>
        <div class="col-md-3">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                <small class="text-muted d-block font-semibold mb-1">Net Bank Payout</small>
                <h2 class="fw-bold text-success mb-0">Rs. 1,20,700</h2>
            </div>
        </div>
    </div>

    <!-- Recent Vendor Bookings Table -->
    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <h5 class="fw-bold text-dark mb-3"><i class="bi bi-receipt me-2 text-danger"></i> Recent Partner Bookings</h5>
        <div class="table-responsive">
            <table class="table align-middle table-hover small">
                <thead class="table-light">
                    <tr>
                        <th>Booking ID</th>
                        <th>Customer</th>
                        <th>Service Type</th>
                        <th>Gross Fare</th>
                        <th>Net Share</th>
                        <th>Payout Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-semibold">#BY-8812</td>
                        <td>Rahul Verma</td>
                        <td>Patna Airport ➔ Bodh Gaya Cab</td>
                        <td>Rs. 1,850</td>
                        <td class="fw-bold text-success">Rs. 1,572.50</td>
                        <td><span class="badge bg-success-subtle text-success border border-success-subtle">Paid to Bank</span></td>
                    </tr>
                    <tr>
                        <td class="fw-semibold">#BY-8834</td>
                        <td>Priya Sharma</td>
                        <td>Nalanda Private Guide (4 hrs)</td>
                        <td>Rs. 2,000</td>
                        <td class="fw-bold text-success">Rs. 1,700.00</td>
                        <td><span class="badge bg-success-subtle text-success border border-success-subtle">Paid to Bank</span></td>
                    </tr>
                    <tr>
                        <td class="fw-semibold">#BY-8890</td>
                        <td>Amitabh Roy</td>
                        <td>Bodh Gaya Homestay (2 Nights)</td>
                        <td>Rs. 5,600</td>
                        <td class="fw-bold text-success">Rs. 4,760.00</td>
                        <td><span class="badge bg-warning-subtle text-dark border border-warning-subtle">Processing</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

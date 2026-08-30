<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <span class="badge bg-danger mb-1">Admin Console</span>
            <h2 class="fw-bold text-dark mb-0"><i class="bi bi-wallet-fill text-warning me-2"></i> Manage Partner Payouts & 15% Platform Commissions</h2>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-dark btn-sm rounded-pill font-semibold">Back to Dashboard</a>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                <small class="text-muted font-semibold d-block">Gross Partner Revenue</small>
                <h3 class="fw-bold text-dark mb-0">Rs. 1,42,000</h3>
            </div>
        </div>
        <div class="col-md-4">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                <small class="text-muted font-semibold d-block">Platform Fee Revenue (15%)</small>
                <h3 class="fw-bold text-danger mb-0">Rs. 21,300</h3>
            </div>
        </div>
        <div class="col-md-4">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                <small class="text-muted font-semibold d-block">Net Disbursed Payouts</small>
                <h3 class="fw-bold text-success mb-0">Rs. 1,20,700</h3>
            </div>
        </div>
    </div>

    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Partner Name</th>
                        <th>Partner Type</th>
                        <th>Gross Earnings</th>
                        <th>15% Platform Cut</th>
                        <th>Net Payable</th>
                        <th>Payout Status</th>
                        <th class="text-center">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-bold text-dark">Ramesh Singh (Taxi Operator)</td>
                        <td>Cab Operator</td>
                        <td>Rs. 45,000</td>
                        <td class="text-danger font-semibold">Rs. 6,750</td>
                        <td class="fw-bold text-success">Rs. 38,250</td>
                        <td><span class="badge bg-warning-subtle text-dark border">Pending Payout</span></td>
                        <td class="text-center">
                            <button class="btn btn-success btn-sm rounded-pill px-3" onclick="alert('Bank Transfer of Rs. 38,250 approved to Ramesh Singh HDFC Bank!');">Approve Payout</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

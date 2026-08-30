<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <span class="badge bg-danger mb-1">Admin Console</span>
            <h2 class="fw-bold text-dark mb-0"><i class="bi bi-gift-fill text-danger me-2"></i> Manage Gift Cards & Promo Codes</h2>
        </div>
        <div>
            <button class="btn btn-brand btn-sm rounded-pill font-semibold px-3 me-2" onclick="var c = 'BYGIFT-' + Math.floor(1000 + Math.random()*9000); alert('New Promo Code Issued: ' + c);"><i class="bi bi-plus-lg me-1"></i> Issue Custom Promo Code</button>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-dark btn-sm rounded-pill font-semibold">Back to Dashboard</a>
        </div>
    </div>

    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Voucher Code</th>
                        <th>Voucher Type</th>
                        <th>Discount Value</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>BIHAR500</code></td>
                        <td>Tourism Trivia Reward</td>
                        <td class="fw-bold text-danger">Rs. 500 OFF</td>
                        <td><span class="badge bg-success-subtle text-success border">Active</span></td>
                    </tr>
                    <tr>
                        <td><code>BYGIFT-CHHATH-2000</code></td>
                        <td>Chhath Festival Pass</td>
                        <td class="fw-bold text-danger">Rs. 2,000 Voucher</td>
                        <td><span class="badge bg-success-subtle text-success border">Active</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

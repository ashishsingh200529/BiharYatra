<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <span class="badge bg-danger mb-1">Admin Console</span>
            <h2 class="fw-bold text-dark mb-0"><i class="bi bi-building text-success me-2"></i> Manage B2B School & Corporate Inquiries</h2>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-dark btn-sm rounded-pill font-semibold">Back to Dashboard</a>
    </div>

    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Institution / Company</th>
                        <th>Contact Person</th>
                        <th>Group Size</th>
                        <th>Applied Discount</th>
                        <th>Status</th>
                        <th class="text-center">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-bold text-dark">St. Xavier's High School</td>
                        <td>Mr. Sharma (Principal)</td>
                        <td>50 Students</td>
                        <td><span class="badge bg-success-subtle text-success border">25% OFF</span></td>
                        <td><span class="badge bg-warning-subtle text-dark border">Quote Sent</span></td>
                        <td class="text-center">
                            <button class="btn btn-success btn-sm rounded-pill px-3" onclick="alert('B2B Quote Approved!');">Confirm Deal</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

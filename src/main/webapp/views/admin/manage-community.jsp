<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <span class="badge bg-danger mb-1">Admin Console</span>
            <h2 class="fw-bold text-dark mb-0"><i class="bi bi-camera-fill text-info me-2"></i> Moderate Travelers Community Feed</h2>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-dark btn-sm rounded-pill font-semibold">Back to Dashboard</a>
    </div>

    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Traveler</th>
                        <th>Story Highlight</th>
                        <th>Likes</th>
                        <th>Status</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-bold text-dark">Vikram Sharma</td>
                        <td>"Evening chanting under the Bodhi Tree was a spiritual awakening..."</td>
                        <td>142 Likes</td>
                        <td><span class="badge bg-success-subtle text-success border">Featured</span></td>
                        <td class="text-center">
                            <button class="btn btn-outline-danger btn-sm rounded-circle" title="Delete" onclick="alert('Post removed.');"><i class="bi bi-trash-fill"></i></button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

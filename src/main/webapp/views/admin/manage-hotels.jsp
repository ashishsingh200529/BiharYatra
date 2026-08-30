<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <span class="badge bg-danger mb-1">Admin Console</span>
            <h2 class="fw-bold text-dark mb-0"><i class="bi bi-house-door-fill text-warning me-2"></i> Manage Hotels & Homestays</h2>
        </div>
        <div>
            <button class="btn btn-brand btn-sm rounded-pill font-semibold px-3 me-2" data-bs-toggle="modal" data-bs-target="#addHotelModal"><i class="bi bi-plus-lg me-1"></i> Add New Property</button>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-dark btn-sm rounded-pill font-semibold">Back to Dashboard</a>
        </div>
    </div>

    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Property Name</th>
                        <th>Category</th>
                        <th>Location</th>
                        <th>Per Night Tariff</th>
                        <th>Status</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-bold text-dark">Bodh Gaya Zen Retreat</td>
                        <td><span class="badge bg-success-subtle text-success border">Meditation Resort</span></td>
                        <td class="text-danger font-semibold"><i class="bi bi-geo-alt-fill"></i> Bodh Gaya</td>
                        <td class="fw-bold">Rs. 2,800</td>
                        <td><span class="badge bg-success-subtle text-success border">Available</span></td>
                        <td class="text-center">
                            <button class="btn btn-outline-primary btn-sm rounded-circle me-1" title="Edit"><i class="bi bi-pencil-fill"></i></button>
                            <button class="btn btn-outline-danger btn-sm rounded-circle" title="Delete" onclick="alert('Property deleted.');"><i class="bi bi-trash-fill"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td class="fw-bold text-dark">Rajgir Heritage Homestay</td>
                        <td><span class="badge bg-primary-subtle text-primary border">Homestay</span></td>
                        <td class="text-danger font-semibold"><i class="bi bi-geo-alt-fill"></i> Rajgir</td>
                        <td class="fw-bold">Rs. 1,800</td>
                        <td><span class="badge bg-success-subtle text-success border">Available</span></td>
                        <td class="text-center">
                            <button class="btn btn-outline-primary btn-sm rounded-circle me-1" title="Edit"><i class="bi bi-pencil-fill"></i></button>
                            <button class="btn btn-outline-danger btn-sm rounded-circle" title="Delete" onclick="alert('Property deleted.');"><i class="bi bi-trash-fill"></i></button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add Hotel Modal -->
<div class="modal fade" id="addHotelModal" tabindex="-1" aria-labelledby="addHotelModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header bg-danger text-white border-0 py-3">
                <h5 class="modal-title fw-bold" id="addHotelModalLabel"><i class="bi bi-house-plus-fill me-2"></i> Add New Hotel / Homestay</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form onsubmit="event.preventDefault(); alert('New Property Added Successfully!'); bootstrap.Modal.getInstance(document.getElementById('addHotelModal')).hide();">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark small">Property Name</label>
                        <input type="text" class="form-control" placeholder="Patna Royal Heritage Hotel" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark small">Category</label>
                        <select class="form-select">
                            <option value="Resort">Resort & Spa</option>
                            <option value="Homestay">Heritage Homestay</option>
                            <option value="Hotel">4-Star Hotel</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark small">City / Location</label>
                        <input type="text" class="form-control" placeholder="Patna Gandhi Maidan" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark small">Per Night Tariff (Rs.)</label>
                        <input type="number" class="form-control" placeholder="3500" required />
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-light border" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-brand">Save Property</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

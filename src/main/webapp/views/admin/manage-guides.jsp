<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <span class="badge bg-danger mb-1">Admin Console</span>
            <h2 class="fw-bold text-dark mb-0"><i class="bi bi-patch-check-fill text-danger me-2"></i> Manage Certified Tour Guides</h2>
        </div>
        <div>
            <button class="btn btn-brand btn-sm rounded-pill font-semibold px-3 me-2" data-bs-toggle="modal" data-bs-target="#addGuideModal"><i class="bi bi-plus-lg me-1"></i> Add New Certified Guide</button>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-dark btn-sm rounded-pill font-semibold">Back to Dashboard</a>
        </div>
    </div>

    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Guide Name</th>
                        <th>District / Circuit</th>
                        <th>Languages Spoken</th>
                        <th>Hourly Rate</th>
                        <th>Rating</th>
                        <th>Status</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-bold text-dark">Anand Varma</td>
                        <td class="text-danger font-semibold"><i class="bi bi-geo-alt-fill"></i> Bodh Gaya & Gaya</td>
                        <td>Hindi, English, Japanese</td>
                        <td class="fw-bold">Rs. 500/hr</td>
                        <td><span class="badge bg-warning text-dark"><i class="bi bi-star-fill"></i> 4.9</span></td>
                        <td><span class="badge bg-success-subtle text-success border">Active</span></td>
                        <td class="text-center">
                            <button class="btn btn-outline-primary btn-sm rounded-circle me-1" title="Edit"><i class="bi bi-pencil-fill"></i></button>
                            <button class="btn btn-outline-danger btn-sm rounded-circle" title="Delete" onclick="alert('Guide deleted successfully.');"><i class="bi bi-trash-fill"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td class="fw-bold text-dark">Dr. Priya Sinha</td>
                        <td class="text-danger font-semibold"><i class="bi bi-geo-alt-fill"></i> Nalanda & Rajgir</td>
                        <td>Hindi, English, French</td>
                        <td class="fw-bold">Rs. 700/hr</td>
                        <td><span class="badge bg-warning text-dark"><i class="bi bi-star-fill"></i> 5.0</span></td>
                        <td><span class="badge bg-success-subtle text-success border">Active</span></td>
                        <td class="text-center">
                            <button class="btn btn-outline-primary btn-sm rounded-circle me-1" title="Edit"><i class="bi bi-pencil-fill"></i></button>
                            <button class="btn btn-outline-danger btn-sm rounded-circle" title="Delete" onclick="alert('Guide deleted successfully.');"><i class="bi bi-trash-fill"></i></button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add Guide Modal -->
<div class="modal fade" id="addGuideModal" tabindex="-1" aria-labelledby="addGuideModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header bg-danger text-white border-0 py-3">
                <h5 class="modal-title fw-bold" id="addGuideModalLabel"><i class="bi bi-person-plus-fill me-2"></i> Add New Certified Guide</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form onsubmit="event.preventDefault(); alert('New Guide Added Successfully!'); bootstrap.Modal.getInstance(document.getElementById('addGuideModal')).hide();">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark small">Guide Full Name</label>
                        <input type="text" class="form-control" placeholder="Rohan Sharma" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark small">Primary District / Circuit</label>
                        <input type="text" class="form-control" placeholder="Patna & Vaishali Circuit" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark small">Languages Spoken</label>
                        <input type="text" class="form-control" placeholder="Hindi, English, Maithili" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark small">Hourly Rate (Rs.)</label>
                        <input type="number" class="form-control" placeholder="600" required />
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-light border" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-brand">Save Guide</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

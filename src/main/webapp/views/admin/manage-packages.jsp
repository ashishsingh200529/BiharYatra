<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
        <div>
            <h2 class="fw-bold text-dark mb-0"><i class="bi bi-airplane text-danger me-1"></i> Manage Tour Packages</h2>
            <small class="text-muted">Create, edit, or toggle the availability of packages</small>
        </div>
        <div class="mt-2 mt-md-0">
            <button type="button" class="btn btn-brand" data-bs-toggle="modal" data-bs-target="#addPackageModal">
                <i class="bi bi-plus-circle me-1"></i> Add Tour Package
            </button>
        </div>
    </div>

    <!-- Alert Displays -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success border-0 small mb-4">
            <i class="bi bi-check-circle-fill"></i> ${param.success}
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger border-0 small mb-4">
            <i class="bi bi-exclamation-triangle-fill"></i> ${param.error}
        </div>
    </c:if>

    <!-- Packages List Table -->
    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <div class="table-responsive">
            <table class="table align-middle table-hover small">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Tour Package</th>
                        <th>Start Point</th>
                        <th>Duration</th>
                        <th>Cost</th>
                        <th>Status</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${packages}">
                        <tr>
                            <td>${p.id}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="${p.imageUrls[0]}" class="rounded me-2.5" style="width: 50px; height: 35px; object-fit: cover;" />
                                    <div>
                                        <h6 class="fw-bold text-dark mb-0">${p.title}</h6>
                                        <small class="text-muted">Difficulty: ${p.difficulty}</small>
                                    </div>
                                </div>
                            </td>
                            <td>${p.startLocation}</td>
                            <td>${p.durationDays} Days / ${p.durationNights} Nights</td>
                            <td class="fw-semibold text-danger">Rs. ${p.price}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.status == 'ACTIVE'}">
                                        <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill">Disabled</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end">
                                <div class="d-flex gap-1.5 justify-content-end">
                                    <a href="${pageContext.request.contextPath}/admin/packages?action=edit&id=${p.id}" class="btn btn-light btn-sm border"><i class="bi bi-pencil"></i></a>
                                    
                                    <form action="${pageContext.request.contextPath}/admin/packages" method="POST" class="d-inline">
                                        <input type="hidden" name="action" value="toggle" />
                                        <input type="hidden" name="id" value="${p.id}" />
                                        <c:choose>
                                            <c:when test="${p.status == 'ACTIVE'}">
                                                <input type="hidden" name="status" value="DISABLED" />
                                                <button type="submit" class="btn btn-outline-danger btn-sm" title="Disable Package"><i class="bi bi-eye-slash"></i></button>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="hidden" name="status" value="ACTIVE" />
                                                <button type="submit" class="btn btn-outline-success btn-sm" title="Activate Package"><i class="bi bi-eye"></i></button>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add Package Modal Popup -->
<div class="modal fade" id="addPackageModal" tabindex="-1" aria-labelledby="addPackageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header bg-danger text-white border-0 py-3">
                <h5 class="modal-title fw-bold" id="addPackageModalLabel"><i class="bi bi-plus-circle me-1"></i> Add New Tour Package</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <form action="${pageContext.request.contextPath}/admin/packages" method="POST">
                <input type="hidden" name="action" value="add" />
                <div class="modal-body p-4 small">
                    
                    <div class="row g-3 mb-3">
                        <div class="col-md-8">
                            <label class="form-label font-semibold text-dark">Package Title</label>
                            <input type="text" name="title" class="form-control" placeholder="e.g. Nalanda Heritage Tour" required />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label font-semibold text-dark">Base Price (Rs.)</label>
                            <input type="number" name="price" class="form-control" placeholder="Price" min="500" required />
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark">Description</label>
                        <textarea name="description" class="form-control" rows="4" placeholder="Brief tour overview description..." required></textarea>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-3">
                            <label class="form-label font-semibold text-dark">Duration Days</label>
                            <input type="number" name="days" class="form-control" min="1" required />
                        </div>
                        <div class="col-md-3">
                            <label class="form-label font-semibold text-dark">Duration Nights</label>
                            <input type="number" name="nights" class="form-control" min="0" required />
                        </div>
                        <div class="col-md-3">
                            <label class="form-label font-semibold text-dark">Start Point</label>
                            <input type="text" name="startLocation" class="form-control" placeholder="Patna" required />
                        </div>
                        <div class="col-md-3">
                            <label class="form-label font-semibold text-dark">Difficulty</label>
                            <select name="difficulty" class="form-select">
                                <option value="Easy">Easy</option>
                                <option value="Medium">Medium</option>
                                <option value="Hard">Hard</option>
                            </select>
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-9">
                            <label class="form-label font-semibold text-dark">Featured Cover Image URL</label>
                            <input type="url" name="imageUrl" class="form-control" placeholder="https://images.unsplash.com/..." />
                        </div>
                        <div class="col-md-3 d-flex align-items-end">
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" name="isFeatured" id="isFeatured" />
                                <label class="form-check-label font-semibold text-dark animate-pulse" for="isFeatured">Feature Tour</label>
                            </div>
                        </div>
                    </div>

                    <!-- Stops Covered Places Checkboxes (Grouped by District Circuit) -->
                    <hr class="my-4">
                    <h6 class="fw-bold text-dark mb-3"><i class="bi bi-geo-alt-fill text-danger me-1"></i> Stops Covered (Select Places Included in Tour)</h6>
                    <div class="p-3 bg-light rounded-3 border mb-4" style="max-height: 280px; overflow-y: auto;">
                        <c:set var="lastDistrict" value="" />
                        <div class="row g-2">
                            <c:forEach var="place" items="${allPlaces}">
                                <c:if test="${place.district != lastDistrict}">
                                    <c:set var="lastDistrict" value="${place.district}" />
                                    <div class="col-12 mt-2">
                                        <div class="fw-bold text-danger small border-bottom pb-1">
                                            <i class="bi bi-pin-map-fill me-1"></i> ${place.district} District Circuit
                                        </div>
                                    </div>
                                </c:if>
                                <div class="col-md-6">
                                    <div class="form-check ms-1">
                                        <input class="form-check-input" type="checkbox" name="place_ids[]" value="${place.id}" id="add_place_${place.id}">
                                        <label class="form-check-label small font-semibold text-dark" for="add_place_${place.id}">
                                            ${place.name}
                                        </label>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Day-wise Itinerary Builder Section -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="fw-bold text-dark mb-0"><i class="bi bi-calendar3-event text-danger me-1"></i> Day-wise Itinerary Schedule</h6>
                        <button type="button" id="add-day-btn" class="btn btn-outline-danger btn-sm"><i class="bi bi-plus-lg me-1"></i> Add Another Day</button>
                    </div>

                    <div id="itinerary-container">
                        <div class="card p-3 border rounded-3 mb-3 bg-light itinerary-item">
                            <div class="fw-bold text-danger mb-2 small d-flex justify-content-between align-items-center">
                                <span><i class="bi bi-pin-map-fill me-1"></i> Day 1 Inclusions</span>
                            </div>
                            <div class="row g-2">
                                <div class="col-md-6">
                                    <input type="text" name="day_title[]" class="form-control form-control-sm" placeholder="Day Title (e.g. Arrival & Local Sightseeing)" required />
                                </div>
                                <div class="col-md-3">
                                    <input type="text" name="day_meals[]" class="form-control form-control-sm" placeholder="Meals (e.g. Dinner / Breakfast & Dinner)" value="Breakfast & Dinner" />
                                </div>
                                <div class="col-md-3">
                                    <input type="text" name="day_stay[]" class="form-control form-control-sm" placeholder="Hotel Stay (e.g. Heritage Resort)" value="3-Star Hotel Stay" />
                                </div>
                                <div class="col-12 mt-2">
                                    <textarea name="day_activity[]" class="form-control form-control-sm" rows="2" placeholder="Activities details (e.g. Pick up from station, check-in, visit local monuments...)"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-light border" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-brand">Create Package</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var dayCount = 1;
        var addBtn = document.getElementById("add-day-btn");
        var container = document.getElementById("itinerary-container");

        if (addBtn && container) {
            addBtn.addEventListener("click", function() {
                dayCount++;
                var div = document.createElement("div");
                div.className = "card p-3 border rounded-3 mb-3 bg-light itinerary-item";
                div.innerHTML = `
                    <div class="fw-bold text-danger mb-2 small d-flex justify-content-between align-items-center">
                        <span><i class="bi bi-pin-map-fill me-1"></i> Day ` + dayCount + ` Inclusions</span>
                        <button type="button" class="btn-close remove-day-btn" style="font-size: 10px;" aria-label="Remove Day"></button>
                    </div>
                    <div class="row g-2">
                        <div class="col-md-6">
                            <input type="text" name="day_title[]" class="form-control form-control-sm" placeholder="Day Title (e.g. Monument Visits & Guided Tour)" required />
                        </div>
                        <div class="col-md-3">
                            <input type="text" name="day_meals[]" class="form-control form-control-sm" placeholder="Meals" value="Breakfast & Dinner" />
                        </div>
                        <div class="col-md-3">
                            <input type="text" name="day_stay[]" class="form-control form-control-sm" placeholder="Hotel Stay" value="3-Star Hotel Stay" />
                        </div>
                        <div class="col-12 mt-2">
                            <textarea name="day_activity[]" class="form-control form-control-sm" rows="2" placeholder="Activities details for Day ` + dayCount + `..."></textarea>
                        </div>
                    </div>
                `;
                container.appendChild(div);

                div.querySelector(".remove-day-btn").addEventListener("click", function() {
                    div.remove();
                });
            });
        }
    });
</script>

<%@ include file="/views/common/footer.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="glass-card p-5 border bg-white rounded-4 shadow-sm">
                
                <h3 class="fw-bold text-dark mb-4"><i class="bi bi-pencil-square text-danger me-1"></i> Edit Tour Package</h3>
                <hr class="my-4">
                
                <form action="${pageContext.request.contextPath}/admin/packages" method="POST" class="small">
                    <input type="hidden" name="action" value="update" />
                    <input type="hidden" name="id" value="${pkg.id}" />
                    
                    <div class="row g-3 mb-3">
                        <div class="col-md-8">
                            <label class="form-label font-semibold text-dark">Package Title</label>
                            <input type="text" name="title" class="form-control" value="${pkg.title}" required />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label font-semibold text-dark">Base Price (Rs.)</label>
                            <input type="number" name="price" class="form-control" value="${pkg.price}" min="500" required />
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark">Description</label>
                        <textarea name="description" class="form-control" rows="5" required>${pkg.description}</textarea>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-3">
                            <label class="form-label font-semibold text-dark">Duration Days</label>
                            <input type="number" name="days" class="form-control" value="${pkg.durationDays}" min="1" required />
                        </div>
                        <div class="col-md-3">
                            <label class="form-label font-semibold text-dark">Duration Nights</label>
                            <input type="number" name="nights" class="form-control" value="${pkg.durationNights}" min="0" required />
                        </div>
                        <div class="col-md-3">
                            <label class="form-label font-semibold text-dark">Start Point</label>
                            <input type="text" name="startLocation" class="form-control" value="${pkg.startLocation}" required />
                        </div>
                        <div class="col-md-3">
                            <label class="form-label font-semibold text-dark">Difficulty</label>
                            <select name="difficulty" class="form-select">
                                <option value="Easy" ${pkg.difficulty == 'Easy' ? 'selected' : ''}>Easy</option>
                                <option value="Medium" ${pkg.difficulty == 'Medium' ? 'selected' : ''}>Medium</option>
                                <option value="Hard" ${pkg.difficulty == 'Hard' ? 'selected' : ''}>Hard</option>
                            </select>
                        </div>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label font-semibold text-dark">Current Status</label>
                            <select name="status" class="form-select">
                                <option value="ACTIVE" ${pkg.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                                <option value="DISABLED" ${pkg.status == 'DISABLED' ? 'selected' : ''}>Disabled</option>
                            </select>
                        </div>
                        <div class="col-md-6 d-flex align-items-end">
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" name="isFeatured" id="editIsFeatured" ${pkg.featured ? 'checked' : ''} />
                                <label class="form-check-label font-semibold text-dark" for="editIsFeatured">Feature Tour on Slider</label>
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
                                <c:set var="isPlaceSelected" value="false" />
                                <c:forEach var="pPlace" items="${pkg.places}">
                                    <c:if test="${pPlace.id == place.id}">
                                        <c:set var="isPlaceSelected" value="true" />
                                    </c:if>
                                </c:forEach>
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
                                        <input class="form-check-input" type="checkbox" name="place_ids[]" value="${place.id}" id="edit_place_${place.id}" ${isPlaceSelected ? 'checked' : ''}>
                                        <label class="form-check-label small font-semibold text-dark" for="edit_place_${place.id}">
                                            ${place.name}
                                        </label>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Day-wise Itinerary Edit Section -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="fw-bold text-dark mb-0"><i class="bi bi-calendar3-event text-danger me-1"></i> Day-wise Itinerary Schedule</h6>
                        <button type="button" id="add-edit-day-btn" class="btn btn-outline-danger btn-sm"><i class="bi bi-plus-lg me-1"></i> Add Another Day</button>
                    </div>

                    <div id="edit-itinerary-container">
                        <c:choose>
                            <c:when test="${not empty pkg.itineraries}">
                                <c:forEach var="it" items="${pkg.itineraries}" varStatus="loop">
                                    <div class="card p-3 border rounded-3 mb-3 bg-light itinerary-item">
                                        <div class="fw-bold text-danger mb-2 small d-flex justify-content-between align-items-center">
                                            <span><i class="bi bi-pin-map-fill me-1"></i> Day ${it.dayNumber} Inclusions</span>
                                            <c:if test="${loop.index > 0}">
                                                <button type="button" class="btn-close remove-day-btn" style="font-size: 10px;" aria-label="Remove Day"></button>
                                            </c:if>
                                        </div>
                                        <div class="row g-2">
                                            <div class="col-md-6">
                                                <input type="text" name="day_title[]" class="form-control form-control-sm" value="${it.title}" placeholder="Day Title" required />
                                            </div>
                                            <div class="col-md-3">
                                                <input type="text" name="day_meals[]" class="form-control form-control-sm" value="${it.mealsIncluded}" placeholder="Meals" />
                                            </div>
                                            <div class="col-md-3">
                                                <input type="text" name="day_stay[]" class="form-control form-control-sm" value="${it.accommodation}" placeholder="Hotel Stay" />
                                            </div>
                                            <div class="col-12 mt-2">
                                                <textarea name="day_activity[]" class="form-control form-control-sm" rows="2" placeholder="Activities details...">${it.activityDetails}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="card p-3 border rounded-3 mb-3 bg-light itinerary-item">
                                    <div class="fw-bold text-danger mb-2 small d-flex justify-content-between align-items-center">
                                        <span><i class="bi bi-pin-map-fill me-1"></i> Day 1 Inclusions</span>
                                    </div>
                                    <div class="row g-2">
                                        <div class="col-md-6">
                                            <input type="text" name="day_title[]" class="form-control form-control-sm" placeholder="Day Title (e.g. Arrival & Local Sightseeing)" required />
                                        </div>
                                        <div class="col-md-3">
                                            <input type="text" name="day_meals[]" class="form-control form-control-sm" placeholder="Meals" value="Breakfast & Dinner" />
                                        </div>
                                        <div class="col-md-3">
                                            <input type="text" name="day_stay[]" class="form-control form-control-sm" placeholder="Hotel Stay" value="3-Star Hotel Stay" />
                                        </div>
                                        <div class="col-12 mt-2">
                                            <textarea name="day_activity[]" class="form-control form-control-sm" rows="2" placeholder="Activities details..."></textarea>
                                        </div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="d-flex gap-2.5 pt-3 border-top mt-4 justify-content-end">
                        <a href="${pageContext.request.contextPath}/admin/packages" class="btn btn-light border">Cancel</a>
                        <button type="submit" class="btn btn-brand">Save Package Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var container = document.getElementById("edit-itinerary-container");
        var dayCount = container ? container.querySelectorAll(".itinerary-item").length : 1;
        var addBtn = document.getElementById("add-edit-day-btn");

        if (container) {
            container.querySelectorAll(".remove-day-btn").forEach(function(btn) {
                btn.addEventListener("click", function() {
                    btn.closest(".itinerary-item").remove();
                });
            });
        }

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
                            <input type="text" name="day_title[]" class="form-control form-control-sm" placeholder="Day Title" required />
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

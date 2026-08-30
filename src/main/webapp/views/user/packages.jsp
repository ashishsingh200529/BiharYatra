<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="row">
        <!-- Filters Sidebar (Left Column) -->
        <div class="col-lg-3 mb-4">
            <div class="glass-card p-4 border bg-white rounded-4 sticky-top" style="top: 90px; z-index: 10;">
                <h5 class="fw-bold mb-3"><i class="bi bi-funnel text-danger me-1"></i> Filter Packages</h5>
                <hr class="my-3">
                
                <form action="${pageContext.request.contextPath}/packages" method="GET">
                    <!-- Text Search -->
                    <div class="mb-3">
                        <label for="search" class="form-label small font-semibold">Search Destination</label>
                        <input type="text" name="search" id="search" class="form-control form-control-sm" placeholder="e.g. Nalanda, Bodh Gaya" value="${searchVal}" />
                    </div>

                    <!-- Start Location -->
                    <div class="mb-3">
                        <label for="startLocation" class="form-label small font-semibold">Start Location</label>
                        <select name="startLocation" id="startLocation" class="form-select form-select-sm">
                            <option value="">Any Location</option>
                            <option value="Patna" ${startLocationVal == 'Patna' ? 'selected' : ''}>Patna</option>
                            <option value="Gorakhpur" ${startLocationVal == 'Gorakhpur' ? 'selected' : ''}>Gorakhpur</option>
                        </select>
                    </div>

                    <!-- Max Price Slider -->
                    <div class="mb-4">
                        <label for="maxPrice" class="form-label small font-semibold d-flex justify-content-between">
                            <span>Max Budget</span>
                            <span class="text-danger" id="priceDisplay">Rs. ${empty maxPriceVal ? '10,000' : maxPriceVal}</span>
                        </label>
                        <input type="range" name="maxPrice" id="maxPrice" class="form-range" min="1000" max="15000" step="500" value="${empty maxPriceVal ? '10000' : maxPriceVal}" oninput="document.getElementById('priceDisplay').textContent = 'Rs. ' + this.value" />
                    </div>

                    <button type="submit" class="btn btn-brand btn-sm w-100 py-2">Apply Filters</button>
                    <a href="${pageContext.request.contextPath}/packages" class="btn btn-light btn-sm w-100 py-2 mt-2">Clear Filters</a>
                </form>

                <!-- Smart Trip Cost Estimator Widget -->
                <hr class="my-4">
                <h6 class="fw-bold text-dark mb-3"><i class="bi bi-calculator-fill text-danger me-1"></i> Custom Trip Estimator</h6>
                <div class="p-3 bg-light rounded-3 border small">
                    <div class="mb-2">
                        <label class="form-label mb-1 text-muted" style="font-size: 11px;">Travelers (Adults)</label>
                        <input type="number" id="est-adults" class="form-control form-control-sm" value="2" min="1" max="20" />
                    </div>
                    <div class="mb-2">
                        <label class="form-label mb-1 text-muted" style="font-size: 11px;">Duration (Days)</label>
                        <input type="number" id="est-days" class="form-control form-control-sm" value="3" min="1" max="10" />
                    </div>
                    <div class="mb-2">
                        <label class="form-label mb-1 text-muted" style="font-size: 11px;">Transport Mode</label>
                        <select id="est-transport" class="form-select form-select-sm">
                            <option value="1200">Sedan (AC Car)</option>
                            <option value="2000">SUV (Innova)</option>
                            <option value="500">Tourist Bus</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label mb-1 text-muted" style="font-size: 11px;">Stay Rating</label>
                        <select id="est-hotel" class="form-select form-select-sm">
                            <option value="1500">3-Star Hotel (Rs 1500/night)</option>
                            <option value="3500">5-Star Luxury Resort (Rs 3500/night)</option>
                            <option value="800">Heritage Homestay (Rs 800/night)</option>
                        </select>
                    </div>

                    <div class="d-flex justify-content-between font-semibold border-top pt-2 text-dark">
                        <span>Est. Total Cost:</span>
                        <strong class="text-danger" id="est-total">Rs. 8,100</strong>
                    </div>
                </div>
            </div>
        </div>

        <!-- Packages Grid (Right Column) -->
        <div class="col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold mb-0">Tour Packages Catalog</h3>
                    <small class="text-muted">Explore tailored packages with custom itineraries</small>
                </div>
                <span class="badge bg-danger rounded-pill px-3 py-2 fs-7">${packagesList.size()} Packages Found</span>
            </div>

            <div class="row g-4">
                <c:choose>
                    <c:when test="${not empty packagesList}">
                        <c:forEach var="pkg" items="${packagesList}">
                            <div class="col-md-6 col-lg-4">
                                <div class="card h-100 border-0 shadow-sm glass-card overflow-hidden">
                                    <div style="height: 180px; overflow: hidden; position: relative;">
                                        <img src="${pkg.imageUrls[0]}" class="w-100 h-100" style="object-fit: cover;" alt="${pkg.title}">
                                        <span class="badge bg-warning text-dark position-absolute shadow-sm" style="right: 15px; top: 15px;">
                                            ${pkg.difficulty}
                                        </span>
                                    </div>
                                    <div class="card-body d-flex flex-column p-4">
                                        <span class="text-muted small mb-2"><i class="bi bi-clock me-1"></i> ${pkg.durationDays} Days / ${pkg.durationNights} Nights</span>
                                        <h5 class="card-title fw-bold text-dark mb-3">${pkg.title}</h5>
                                        <p class="card-text text-muted small flex-grow-1" style="display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;">
                                            ${pkg.description}
                                        </p>
                                        <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                                            <div>
                                                <small class="text-muted block" style="font-size: 10px;">Starting From</small>
                                                <span class="fw-bold text-danger fs-5">Rs. ${pkg.price}</span>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/package-details?id=${pkg.id}" class="btn btn-brand btn-sm">Details</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12">
                            <div class="alert alert-warning text-center py-5 border-dashed">
                                <i class="bi bi-search display-3 d-block mb-3 text-muted"></i>
                                <h4 class="fw-bold text-dark">No Packages Match Your Search!</h4>
                                <p class="text-muted">Try clearing your filters or testing other search terms.</p>
                                <a href="${pageContext.request.contextPath}/packages" class="btn btn-brand btn-sm mt-3 px-4">Browse All Packages</a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var adults = document.getElementById("est-adults");
        var days = document.getElementById("est-days");
        var transport = document.getElementById("est-transport");
        var hotel = document.getElementById("est-hotel");
        var totalEl = document.getElementById("est-total");

        function calculateCost() {
            if (!adults || !totalEl) return;
            var numAdults = parseInt(adults.value) || 1;
            var numDays = parseInt(days.value) || 1;
            var transCost = parseInt(transport.value) || 1200;
            var hotelCost = parseInt(hotel.value) || 1500;

            var total = (numAdults * hotelCost * numDays) + (transCost * numDays) + (numAdults * 300 * numDays);
            totalEl.innerText = "Rs. " + total.toLocaleString('en-IN');
        }

        [adults, days, transport, hotel].forEach(function(input) {
            if (input) input.addEventListener("change", calculateCost);
            if (input) input.addEventListener("keyup", calculateCost);
        });
    });
</script>

<%@ include file="/views/common/footer.jsp" %>

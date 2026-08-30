<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="row">
        <!-- Main Form (Left Column) -->
        <div class="col-lg-8 mb-4">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                <span class="text-uppercase text-danger fw-bold tracking-wider" style="font-size: 13px;">Secure Checkout</span>
                <h2 class="fw-bold text-dark mt-1 mb-3">Booking Information</h2>
                <p class="text-muted small">Enter passenger list details and configure your optional logistics upgrades.</p>
                
                <form action="${pageContext.request.contextPath}/booking" method="POST" class="mt-4">
                    <!-- Hidden inputs for math helper values in main.js -->
                    <input type="hidden" name="packageId" value="${tourPackage.id}" />
                    <input type="hidden" id="basePriceVal" value="${tourPackage.price}" />
                    <input type="hidden" id="durationDaysVal" value="${tourPackage.durationDays}" />
                    <input type="hidden" id="durationNightsVal" value="${tourPackage.durationNights}" />
                    
                    <input type="hidden" name="hotelUpgradePrice" id="hotelUpgradePriceHidden" value="0" />
                    <input type="hidden" name="vehicleUpgradePrice" id="vehicleUpgradePriceHidden" value="0" />
                    <input type="hidden" name="foodUpgradePrice" id="foodUpgradePriceHidden" value="0" />

                    <!-- Travel Date and Number of travelers -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label for="travelDate" class="form-label font-semibold text-dark">Travel Start Date</label>
                            <input type="date" name="travelDate" id="travelDate" class="form-control" min="<%= new java.sql.Date(System.currentTimeMillis() + 86400000) %>" required />
                        </div>
                        <div class="col-md-6">
                            <label for="numTravelersInput" class="form-label font-semibold text-dark">Number of Travelers</label>
                            <input type="number" name="numTravelers" id="numTravelersInput" class="form-control" value="1" min="1" max="15" required />
                        </div>
                    </div>

                    <!-- Traveler details rows (Dynamically populated by main.js) -->
                    <h5 class="fw-bold text-dark mb-3 mt-4"><i class="bi bi-people-fill text-danger me-1"></i> Traveler Personal Details</h5>
                    <div id="travelerDetailsContainer" class="mb-4">
                        <!-- Dynamic content loaded via main.js -->
                    </div>

                    <!-- Logistics Upgrades -->
                    <h5 class="fw-bold text-dark mb-3 mt-5"><i class="bi bi-patch-plus-fill text-danger me-1"></i> Optional Upgrades</h5>
                    
                    <!-- Hotel Upgrade -->
                    <div class="mb-3">
                        <label for="hotelSelect" class="form-label font-semibold text-dark">Accommodation Upgrade (Per Night)</label>
                        <select id="hotelSelect" class="form-select bg-light border-0 py-2.5">
                            <option value="" data-price="0">Standard Package Accommodation (Included)</option>
                            <c:forEach var="h" items="${hotels}">
                                <c:forEach var="r" items="${h.rooms}">
                                    <option value="${r.id}" data-price="${r.pricePerNight}">${h.name} – ${r.roomType} (Add Rs. ${r.pricePerNight}/night)</option>
                                </c:forEach>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Vehicle Upgrade -->
                    <div class="mb-3">
                        <label for="vehicleSelect" class="form-label font-semibold text-dark">Private Transport Upgrade (Per Day)</label>
                        <select id="vehicleSelect" class="form-select bg-light border-0 py-2.5">
                            <option value="" data-price="0">Standard Shared Tourist Bus/Cab (Included)</option>
                            <c:forEach var="v" items="${vehicles}">
                                <option value="${v.id}" data-price="${v.pricePerDay}">Private ${v.type}: ${v.model} (Add Rs. ${v.pricePerDay}/day)</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Food Plan Upgrade -->
                    <div class="mb-4">
                        <label for="foodSelect" class="form-label font-semibold text-dark">Traditional Meal Upgrades (Per Person/Day)</label>
                        <select id="foodSelect" class="form-select bg-light border-0 py-2.5">
                            <option value="" data-price="0">Basic Hotel breakfast/dinners (Included)</option>
                            <option value="1" data-price="200">Standard Veg Thali (Add Rs. 200/person/day)</option>
                            <option value="2" data-price="350">Traditional Bihar Sattu &amp; Litti thali (Add Rs. 350/person/day)</option>
                            <option value="3" data-price="800">All-Inclusive Gourmet Board (Add Rs. 800/person/day)</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-brand w-100 py-3 mt-4 font-semibold"><i class="bi bi-credit-card-2-front me-1"></i> Proceed to Payment Gateway</button>
                </form>
            </div>
        </div>

        <!-- Checkout Summaries Sidebar (Right Column) -->
        <div class="col-lg-4">
            <div class="glass-card p-4 border bg-white rounded-4 sticky-top" style="top: 90px; z-index: 10;">
                <h4 class="fw-bold text-dark mb-3">Fare Summary</h4>
                <p class="text-muted small">${tourPackage.title}</p>
                
                <hr class="my-3">
                
                <div class="d-flex justify-content-between small mb-2 text-muted">
                    <span>Base Package cost</span>
                    <span>Rs. ${tourPackage.price} / person</span>
                </div>
                <div class="d-flex justify-content-between small mb-2 text-muted">
                    <span>Duration</span>
                    <span>${tourPackage.durationDays} Days / ${tourPackage.durationNights} Nights</span>
                </div>
                <div class="d-flex justify-content-between small mb-2 text-muted">
                    <span>Selected Travelers</span>
                    <span id="summary-travelers">1</span>
                </div>

                <hr class="my-3">

                <div class="d-flex justify-content-between small mb-2 text-dark font-medium">
                    <span>Base Subtotal</span>
                    <span id="summary-base-cost">Rs. ${tourPackage.price}</span>
                </div>
                <div class="d-flex justify-content-between small mb-2 text-dark font-medium">
                    <span>Logistics Upgrades</span>
                    <span id="summary-upgrade-cost">Rs. 0.00</span>
                </div>

                <hr class="my-3">

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <span class="fw-bold text-dark fs-5">Grand Total</span>
                    <span class="fw-bold text-danger fs-4" id="summary-total-cost">Rs. ${tourPackage.price}</span>
                </div>

                <div class="alert alert-info border-0 small mb-0 mt-3 text-center">
                    <i class="bi bi-shield-fill-check text-success"></i> Secure 256-bit SSL encrypted checkout connection.
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-dark text-white py-5 position-relative overflow-hidden">
    <div class="container position-relative" style="z-index: 2;">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <span class="badge bg-danger px-3 py-2 rounded-pill mb-3 font-semibold"><i class="bi bi-taxi-front-fill me-1"></i> Official Tourist Cab Service</span>
                <h1 class="fw-bold display-5 mb-2">Bihar Tourist Cabs & Airport Transfers</h1>
                <p class="lead text-white-50 mb-0">Hassle-free AC Cabs, SUVs, and Tempo Travellers from Patna Airport / Station to all Bihar destinations.</p>
            </div>
        </div>
    </div>
</div>

<div class="container my-5">
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success border-0 rounded-4 shadow-sm mb-4 d-flex align-items-center">
            <i class="bi bi-check-circle-fill fs-3 me-3 text-success"></i>
            <div>
                <strong class="d-block font-semibold">Cab Reserved!</strong>
                <span>${successMsg}</span>
            </div>
        </div>
    </c:if>

    <div class="row g-4">
        <!-- Booking Form Column -->
        <div class="col-lg-5">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                <h4 class="fw-bold text-dark mb-4"><i class="bi bi-geo-fill text-danger me-2"></i> Book Your Cab</h4>

                <div class="mb-3">
                    <label class="form-label font-semibold text-dark small">Pick-up Location</label>
                    <select id="cab-pickup" class="form-select">
                        <option value="Patna Airport (PAT)">Patna Jay Prakash Narayan Airport (PAT)</option>
                        <option value="Patna Junction (PNBE)">Patna Junction Railway Station (PNBE)</option>
                        <option value="Gaya Airport (GAY)">Gaya International Airport (GAY)</option>
                        <option value="Deen Dayal Upadhyaya (DDU)">DDU Junction (Mughalsarai)</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label font-semibold text-dark small">Destination</label>
                    <select id="cab-dest" class="form-select">
                        <c:forEach var="place" items="${places}">
                            <option value="${place.name}" data-km="${place.district == 'Patna' ? '15' : place.district == 'Nalanda' ? '90' : place.district == 'Gaya' ? '110' : '150'}">${place.name} (${place.district})</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label font-semibold text-dark small">Vehicle Choice</label>
                    <div class="d-grid gap-2" id="veh-selector">
                        <div class="border rounded-3 p-2.5 d-flex align-items-center justify-content-between veh-opt active border-danger bg-danger-subtle cursor-pointer" data-rate="14" data-vname="Sedan (Dzire / Etios)">
                            <div>
                                <strong class="d-block text-dark small">Sedan (Swift Dzire / Etios)</strong>
                                <small class="text-muted" style="font-size: 11px;">4 Seats • AC • 2 Luggage</small>
                            </div>
                            <span class="fw-bold text-danger">Rs. 14/km</span>
                        </div>
                        <div class="border rounded-3 p-2.5 d-flex align-items-center justify-content-between veh-opt cursor-pointer" data-rate="19" data-vname="SUV (Innova Crysta)">
                            <div>
                                <strong class="d-block text-dark small">SUV (Innova Crysta)</strong>
                                <small class="text-muted" style="font-size: 11px;">7 Seats • AC • 4 Luggage</small>
                            </div>
                            <span class="fw-bold text-danger">Rs. 19/km</span>
                        </div>
                        <div class="border rounded-3 p-2.5 d-flex align-items-center justify-content-between veh-opt cursor-pointer" data-rate="28" data-vname="Tempo Traveller (17 Seater)">
                            <div>
                                <strong class="d-block text-dark small">Tempo Traveller</strong>
                                <small class="text-muted" style="font-size: 11px;">17 Seats • AC • Group Luxury</small>
                            </div>
                            <span class="fw-bold text-danger">Rs. 28/km</span>
                        </div>
                    </div>
                </div>

                <div class="p-3 bg-light rounded-3 border mb-4">
                    <div class="d-flex justify-content-between small mb-1">
                        <span class="text-muted">Est. Distance:</span>
                        <strong class="text-dark" id="cab-dist-val">90 km</strong>
                    </div>
                    <div class="d-flex justify-content-between small mb-1">
                        <span class="text-muted">Driver Allowance & Tolls:</span>
                        <strong class="text-dark">Included</strong>
                    </div>
                    <div class="d-flex justify-content-between border-top pt-2 font-semibold">
                        <span class="text-dark">Estimated Total Fare:</span>
                        <strong class="text-danger fs-5" id="cab-fare-val">Rs. 1,260</strong>
                    </div>
                </div>

                <button type="button" class="btn btn-brand w-100 py-3 font-semibold shadow-sm" data-bs-toggle="modal" data-bs-target="#cabConfirmModal">
                    <i class="bi bi-check-circle-fill me-1"></i> Proceed to Cab Confirmation
                </button>
            </div>
        </div>

        <!-- Benefits & Guarantee Column -->
        <div class="col-lg-7">
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm h-100">
                        <div class="bg-danger-subtle text-danger rounded-circle p-3 d-inline-block mb-3">
                            <i class="bi bi-shield-check fs-3"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-1">Verified Police Drivers</h5>
                        <p class="text-muted small mb-0">All drivers are police-verified with expert knowledge of Bihar highways and heritage spots.</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm h-100">
                        <div class="bg-warning-subtle text-dark rounded-circle p-3 d-inline-block mb-3">
                            <i class="bi bi-clock-history fs-3 text-warning"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-1">Zero Flight-Delay Penalty</h5>
                        <p class="text-muted small mb-0">Free 90 minutes waiting time at Patna Airport in case of flight or train delays.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Cab Confirmation Modal Form -->
<div class="modal fade" id="cabConfirmModal" tabindex="-1" aria-labelledby="cabConfirmModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header bg-danger text-white border-0 py-3">
                <h5 class="modal-title fw-bold" id="cabConfirmModalLabel"><i class="bi bi-taxi-front-fill me-2"></i> Cab Booking Confirmation</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/cabs" method="POST">
                <input type="hidden" name="pickup" id="input-c-pickup" value="Patna Airport" />
                <input type="hidden" name="destination" id="input-c-dest" value="Bodh Gaya" />
                <input type="hidden" name="vehicle" id="input-c-veh" value="Sedan (Dzire / Etios)" />
                <input type="hidden" name="fare" id="input-c-fare" value="1260" />

                <div class="modal-body p-4 text-center">
                    <i class="bi bi-taxi-front display-1 text-danger mb-3 d-inline-block"></i>
                    <h4 class="fw-bold text-dark">Confirm Cab Ride</h4>
                    <p class="text-muted small mb-3">Enter passenger contact details.</p>

                    <div class="text-start mb-3">
                        <label class="form-label font-semibold text-dark small">Passenger Name</label>
                        <input type="text" name="userName" class="form-control form-control-sm" placeholder="Rahul Kumar" required />
                    </div>

                    <div class="text-start mb-3">
                        <label class="form-label font-semibold text-dark small">Mobile Phone (WhatsApp)</label>
                        <input type="tel" name="userPhone" class="form-control form-control-sm" placeholder="+91 98000 00000" required />
                    </div>

                    <div class="p-3 bg-light rounded-3 border text-start small mb-3">
                        <div><strong>Pick-up:</strong> <span id="mod-pickup">Patna Airport</span></div>
                        <div><strong>Destination:</strong> <span id="mod-dest">Bodh Gaya</span></div>
                        <div><strong>Est. Fare:</strong> <strong class="text-danger" id="mod-fare">Rs. 1,260</strong></div>
                    </div>
                    <button type="submit" class="btn btn-brand w-100 py-3 font-semibold rounded-3 shadow-sm">Confirm & Submit Cab Booking</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var selectedRate = 14;
        var selectedVehicle = "Sedan (Dzire / Etios)";

        document.querySelectorAll(".veh-opt").forEach(function(opt) {
            opt.addEventListener("click", function() {
                document.querySelectorAll(".veh-opt").forEach(o => o.className = "border rounded-3 p-2.5 d-flex align-items-center justify-content-between veh-opt cursor-pointer");
                opt.className = "border rounded-3 p-2.5 d-flex align-items-center justify-content-between veh-opt active border-danger bg-danger-subtle cursor-pointer";
                selectedRate = parseInt(opt.getAttribute("data-rate"));
                selectedVehicle = opt.getAttribute("data-vname");
                recalc();
            });
        });

        var destSelect = document.getElementById("cab-dest");
        if (destSelect) {
            destSelect.addEventListener("change", recalc);
        }

        function recalc() {
            var opt = destSelect.options[destSelect.selectedIndex];
            var km = parseInt(opt.getAttribute("data-km")) || 90;
            var fare = km * selectedRate;
            var pickupVal = document.getElementById("cab-pickup").value;
            var destVal = opt.value;

            document.getElementById("cab-dist-val").innerText = km + " km";
            document.getElementById("cab-fare-val").innerText = "Rs. " + fare.toLocaleString('en-IN');
            document.getElementById("mod-fare").innerText = "Rs. " + fare.toLocaleString('en-IN');
            document.getElementById("mod-pickup").innerText = pickupVal;
            document.getElementById("mod-dest").innerText = destVal;

            document.getElementById("input-c-pickup").value = pickupVal;
            document.getElementById("input-c-dest").value = destVal;
            document.getElementById("input-c-veh").value = selectedVehicle;
            document.getElementById("input-c-fare").value = fare;
        }
    });
</script>

<%@ include file="/views/common/footer.jsp" %>

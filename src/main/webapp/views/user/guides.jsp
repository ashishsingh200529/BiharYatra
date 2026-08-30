<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-dark text-white py-5 position-relative overflow-hidden">
    <div class="container position-relative" style="z-index: 2;">
        <span class="badge bg-danger px-3 py-2 rounded-pill mb-3 font-semibold"><i class="bi bi-patch-check-fill me-1"></i> Certified Bihar Tour Guides</span>
        <h1 class="fw-bold display-5 mb-2">Hire Local Expert Tour Guides</h1>
        <p class="lead text-white-50 mb-0">Book verified local historians, Buddhist scholars, and art curators for personalized private tours.</p>
    </div>
</div>

<div class="container my-5">
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success border-0 rounded-4 shadow-sm mb-4 d-flex align-items-center">
            <i class="bi bi-check-circle-fill fs-3 me-3 text-success"></i>
            <div>
                <strong class="d-block font-semibold">Guide Reserved!</strong>
                <span>${successMsg}</span>
            </div>
        </div>
    </c:if>

    <div class="row g-4">
        <!-- Guide 1 -->
        <div class="col-md-6 col-lg-3">
            <div class="card border rounded-4 overflow-hidden shadow-sm h-100">
                <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=600&q=80" style="height: 220px; object-fit: cover;" class="card-img-top" alt="Anand Varma" />
                <div class="card-body">
                    <span class="badge bg-warning text-dark mb-2"><i class="bi bi-star-fill"></i> 4.9 (124 Reviews)</span>
                    <h5 class="fw-bold text-dark mb-1">Anand Varma</h5>
                    <p class="text-danger small font-semibold mb-2"><i class="bi bi-geo-alt-fill"></i> Bodh Gaya & Gaya Circuit</p>
                    <p class="text-muted small mb-3">Specialist in Mahabodhi Temple history, Pali scripture sermons, and Theravada Buddhist lore. Spoken: Hindi, English, Japanese.</p>
                    <div class="d-flex justify-content-between align-items-center border-top pt-3">
                        <span class="fw-bold text-dark">Rs. 500/hr</span>
                        <button class="btn btn-brand btn-sm font-semibold rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#hireGuideModal" data-name="Anand Varma" data-rate="500">Hire Guide</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Guide 2 -->
        <div class="col-md-6 col-lg-3">
            <div class="card border rounded-4 overflow-hidden shadow-sm h-100">
                <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=600&q=80" style="height: 220px; object-fit: cover;" class="card-img-top" alt="Dr. Priya Sinha" />
                <div class="card-body">
                    <span class="badge bg-warning text-dark mb-2"><i class="bi bi-star-fill"></i> 5.0 (98 Reviews)</span>
                    <h5 class="fw-bold text-dark mb-1">Dr. Priya Sinha</h5>
                    <p class="text-danger small font-semibold mb-2"><i class="bi bi-geo-alt-fill"></i> Nalanda & Rajgir Ruins</p>
                    <p class="text-muted small mb-3">PhD Archeologist specializing in 5th-century CE Ancient Nalanda University excavated seals, stupas, and monastery relics.</p>
                    <div class="d-flex justify-content-between align-items-center border-top pt-3">
                        <span class="fw-bold text-dark">Rs. 700/hr</span>
                        <button class="btn btn-brand btn-sm font-semibold rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#hireGuideModal" data-name="Dr. Priya Sinha" data-rate="700">Hire Guide</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Guide 3 -->
        <div class="col-md-6 col-lg-3">
            <div class="card border rounded-4 overflow-hidden shadow-sm h-100">
                <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=600&q=80" style="height: 220px; object-fit: cover;" class="card-img-top" alt="Rajesh Kumar" />
                <div class="card-body">
                    <span class="badge bg-warning text-dark mb-2"><i class="bi bi-star-fill"></i> 4.8 (86 Reviews)</span>
                    <h5 class="fw-bold text-dark mb-1">Rajesh Kumar</h5>
                    <p class="text-danger small font-semibold mb-2"><i class="bi bi-geo-alt-fill"></i> Patna Heritage & Bihar Museum</p>
                    <p class="text-muted small mb-3">Curator guide for Bihar Museum galleries, Didarganj Yakshi, Golghar, and Patna Sahib Gurudwara.</p>
                    <div class="d-flex justify-content-between align-items-center border-top pt-3">
                        <span class="fw-bold text-dark">Rs. 450/hr</span>
                        <button class="btn btn-brand btn-sm font-semibold rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#hireGuideModal" data-name="Rajesh Kumar" data-rate="450">Hire Guide</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Guide 4 -->
        <div class="col-md-6 col-lg-3">
            <div class="card border rounded-4 overflow-hidden shadow-sm h-100">
                <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=600&q=80" style="height: 220px; object-fit: cover;" class="card-img-top" alt="Sunita Mishra" />
                <div class="card-body">
                    <span class="badge bg-warning text-dark mb-2"><i class="bi bi-star-fill"></i> 4.9 (112 Reviews)</span>
                    <h5 class="fw-bold text-dark mb-1">Sunita Mishra</h5>
                    <p class="text-danger small font-semibold mb-2"><i class="bi bi-geo-alt-fill"></i> Valmiki Tiger Reserve Tracker</p>
                    <p class="text-muted small mb-3">Certified forest ranger guide for wildlife jungle safaris, birdwatching canopy trails, and Gandak river boating.</p>
                    <div class="d-flex justify-content-between align-items-center border-top pt-3">
                        <span class="fw-bold text-dark">Rs. 800/hr</span>
                        <button class="btn btn-brand btn-sm font-semibold rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#hireGuideModal" data-name="Sunita Mishra" data-rate="800">Hire Guide</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Hire Guide Modal Form -->
<div class="modal fade" id="hireGuideModal" tabindex="-1" aria-labelledby="hireGuideModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header bg-danger text-white border-0 py-3">
                <h5 class="modal-title fw-bold" id="hireGuideModalLabel"><i class="bi bi-patch-check-fill me-2"></i> Book Private Tour Guide</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/guides" method="POST">
                <input type="hidden" name="guideName" id="input-g-name" value="Anand Varma" />
                <input type="hidden" name="rate" id="input-g-rate" value="500" />
                <div class="modal-body p-4 text-center">
                    <i class="bi bi-person-badge-fill display-1 text-danger mb-3 d-inline-block"></i>
                    <h4 class="fw-bold text-dark" id="modal-g-name">Anand Varma</h4>
                    <p class="text-muted small mb-3">Enter your details to confirm guide reservation.</p>

                    <div class="text-start mb-3">
                        <label class="form-label font-semibold text-dark small">Your Name</label>
                        <input type="text" name="userName" class="form-control form-control-sm" placeholder="Rahul Kumar" required />
                    </div>

                    <div class="text-start mb-3">
                        <label class="form-label font-semibold text-dark small">Mobile Phone (WhatsApp)</label>
                        <input type="tel" name="userPhone" class="form-control form-control-sm" placeholder="+91 98000 00000" required />
                    </div>

                    <div class="p-3 bg-light rounded-3 border mb-3 text-start">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Hourly Rate:</span>
                            <strong class="text-dark" id="modal-g-rate">Rs. 500/hr</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2 align-items-center">
                            <span class="text-muted">Selected Hours:</span>
                            <select name="hours" id="guide-hours" class="form-select form-select-sm w-auto" onchange="var r = parseInt(document.getElementById('input-g-rate').value); document.getElementById('modal-g-total').innerText = 'Rs. ' + (r * parseInt(this.value)).toLocaleString('en-IN');">
                                <option value="2">2 Hours (Half Day Spot)</option>
                                <option value="4" selected>4 Hours (Full Spot Tour)</option>
                                <option value="8">8 Hours (Full Day Circuit)</option>
                            </select>
                        </div>
                        <div class="d-flex justify-content-between border-top pt-2 font-semibold">
                            <span class="text-dark">Total Fee:</span>
                            <strong class="text-danger fs-5" id="modal-g-total">Rs. 2,000</strong>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-brand w-100 py-3 font-semibold rounded-3 shadow-sm">Confirm Guide Reservation</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var hireModal = document.getElementById('hireGuideModal');
        if (hireModal) {
            hireModal.addEventListener('show.bs.modal', function(e) {
                var btn = e.relatedTarget;
                var name = btn.getAttribute('data-name');
                var rate = parseInt(btn.getAttribute('data-rate'));
                document.getElementById('modal-g-name').innerText = name;
                document.getElementById('input-g-name').value = name;
                document.getElementById('input-g-rate').value = rate;
                document.getElementById('modal-g-rate').innerText = 'Rs. ' + rate + '/hr';
                document.getElementById('modal-g-total').innerText = 'Rs. ' + (rate * 4).toLocaleString('en-IN');
            });
        }
    });
</script>

<%@ include file="/views/common/footer.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-dark text-white py-5">
    <div class="container py-3">
        <span class="badge bg-warning text-dark px-3 py-2 rounded-pill mb-3 font-semibold"><i class="bi bi-building me-1"></i> B2B Group Travel Desk</span>
        <h1 class="fw-bold display-5 mb-2">School Educational & Corporate Tours</h1>
        <p class="lead text-white-50 mb-0">Customized heritage study tours for schools, colleges, and corporate retreats with up to 35% bulk discount.</p>
    </div>
</div>

<div class="container my-5">
    <div class="row g-4">
        <!-- Inquiry Form Column -->
        <div class="col-lg-5">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                <h4 class="fw-bold text-dark mb-4"><i class="bi bi-calculator-fill text-danger me-2"></i> Bulk Group Fare Estimator</h4>
                
                <form onsubmit="event.preventDefault(); alert('B2B Inquiry Received! Our group travel manager will call your institution within 2 hours.');">
                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark small">Institution / Company Name</label>
                        <input type="text" class="form-control" placeholder="St. Xavier's High School" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark small">Contact Person Name & Designation</label>
                        <input type="text" class="form-control" placeholder="Principal / HR Head" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark small">Group Size (Students / Employees)</label>
                        <select id="b2b-group-size" class="form-select" onchange="var sz = parseInt(this.value); var disc = sz >= 100 ? 35 : sz >= 50 ? 25 : 15; document.getElementById('b2b-disc-val').innerText = disc + '% OFF';">
                            <option value="30">30 - 49 Travelers (15% Bulk Discount)</option>
                            <option value="50" selected>50 - 99 Travelers (25% Bulk Discount)</option>
                            <option value="100">100+ Travelers (35% Bulk Discount)</option>
                        </select>
                    </div>
                    <div class="p-3 bg-light rounded-3 border mb-4">
                        <div class="d-flex justify-content-between small mb-1">
                            <span class="text-muted">Applied Group Benefit:</span>
                            <strong class="text-success" id="b2b-disc-val">25% OFF</strong>
                        </div>
                        <div class="d-flex justify-content-between small mb-1">
                            <span class="text-muted">Luxury Buses & Escort Guides:</span>
                            <strong class="text-dark">Included</strong>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-brand w-100 py-3 font-semibold text-white shadow-sm">Request Official B2B Quote</button>
                </form>
            </div>
        </div>

        <!-- Tour Features Column -->
        <div class="col-lg-7">
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm h-100">
                        <div class="bg-primary-subtle text-primary rounded-circle p-3 d-inline-block mb-3">
                            <i class="bi bi-journal-bookmark-fill fs-3"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-1">School Heritage Circuit</h5>
                        <p class="text-muted small mb-0">Guided historical visits to Nalanda Ruins, Patna Museum, and Ashokan Pillar with educational workbooks.</p>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm h-100">
                        <div class="bg-danger-subtle text-danger rounded-circle p-3 d-inline-block mb-3">
                            <i class="bi bi-briefcase-fill fs-3"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-1">Corporate Eco Retreat</h5>
                        <p class="text-muted small mb-0">Team building retreats at Valmiki Tiger Reserve Eco-Lodge and Rajgir Glass Skywalk nature trails.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

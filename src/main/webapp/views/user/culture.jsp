<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-gradient-to-r from-danger to-warning text-white py-5 position-relative">
    <div class="container py-3">
        <span class="badge bg-white text-danger px-3 py-2 rounded-pill mb-3 font-semibold">Bihari Heritage & Cuisine</span>
        <h1 class="fw-bold display-5 mb-2">Flavors & Folk Art of Bihar</h1>
        <p class="lead mb-0 text-white-50">Explore GI-tagged delicacies, 2500-year-old Madhubani paintings, and iconic traditional crafts.</p>
    </div>
</div>

<div class="container my-5">
    <!-- Cuisine Section -->
    <div class="mb-5">
        <h3 class="fw-bold text-dark mb-4 border-start border-4 border-danger ps-3">🍲 Authentic Bihari Delicacies</h3>
        
        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 border rounded-4 overflow-hidden shadow-sm">
                    <img src="https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=600&q=80" style="height: 180px; object-fit: cover;" class="card-img-top" alt="Litti Chokha">
                    <div class="card-body">
                        <span class="badge bg-danger mb-2">State Dish</span>
                        <h5 class="fw-bold text-dark mb-1">Litti Chokha</h5>
                        <p class="text-muted small mb-0">Roasted wheat balls stuffed with spiced roasted gram flour (Sattu), served with ghee, brinjal & tomato chokha.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 border rounded-4 overflow-hidden shadow-sm">
                    <img src="https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?auto=format&fit=crop&w=600&q=80" style="height: 180px; object-fit: cover;" class="card-img-top" alt="Silao Khaja">
                    <div class="card-body">
                        <span class="badge bg-warning text-dark mb-2">GI-Tagged Sweet</span>
                        <h5 class="fw-bold text-dark mb-1">Silao Khaja</h5>
                        <p class="text-muted small mb-0">Multi-layered crispy, flaky pastry sweet from Silao (Nalanda) with origins tracing back to King Bimbisara's era.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 border rounded-4 overflow-hidden shadow-sm">
                    <img src="https://images.unsplash.com/photo-1541781774459-bb2af2f05b55?auto=format&fit=crop&w=600&q=80" style="height: 180px; object-fit: cover;" class="card-img-top" alt="Gaya Tilkut">
                    <div class="card-body">
                        <span class="badge bg-danger mb-2">Gaya Specialty</span>
                        <h5 class="fw-bold text-dark mb-1">Gaya Tilkut</h5>
                        <p class="text-muted small mb-0">Traditional winter delicacy made from pounded sesame seeds and refined jaggery/sugar, famously made in Gaya.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 border rounded-4 overflow-hidden shadow-sm">
                    <img src="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=600&q=80" style="height: 180px; object-fit: cover;" class="card-img-top" alt="Mithila Makhana">
                    <div class="card-body">
                        <span class="badge bg-success mb-2">Superfood</span>
                        <h5 class="fw-bold text-dark mb-1">Mithila Makhana</h5>
                        <p class="text-muted small mb-0">GI-tagged popped gorgon nuts harvested from lotus ponds of Mithilanchal (Darbhanga & Madhubani).</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Folk Art & Handicrafts -->
    <div class="mb-5">
        <h3 class="fw-bold text-dark mb-4 border-start border-4 border-danger ps-3">🎨 World-Famous Bihar Folk Art</h3>
        
        <div class="row g-4">
            <div class="col-md-4">
                <div class="glass-card p-4 border bg-white rounded-4 shadow-sm h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-danger-subtle text-danger rounded-circle p-3 me-3">
                            <i class="bi bi-palette-fill fs-4"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold text-dark mb-0">Madhubani Painting</h5>
                            <small class="text-muted">Mithila Region</small>
                        </div>
                    </div>
                    <p class="text-muted small mb-0">Characterized by eye-catching geometrical patterns, natural dyes (turmeric, indigo), twigs, and fingers depicting mythology and nature.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="glass-card p-4 border bg-white rounded-4 shadow-sm h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-warning-subtle text-dark rounded-circle p-3 me-3">
                            <i class="bi bi-brush-fill fs-4 text-warning"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold text-dark mb-0">Manjusha Art</h5>
                            <small class="text-muted">Anga Region (Bhagalpur)</small>
                        </div>
                    </div>
                    <p class="text-muted small mb-0">Ancient scroll painting style depicting the folklore of Bihula-Vishahari using pink, green, and yellow borders.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="glass-card p-4 border bg-white rounded-4 shadow-sm h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-success-subtle text-success rounded-circle p-3 me-3">
                            <i class="bi bi-scissors fs-4"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold text-dark mb-0">Bhagalpuri Tussar Silk</h5>
                            <small class="text-muted">Silk City Bhagalpur</small>
                        </div>
                    </div>
                    <p class="text-muted small mb-0">Famous eco-friendly natural silk weaving tradition over a century old, globally exported as Bhagalpuri Silk.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Call to action -->
    <div class="p-5 bg-dark text-white rounded-4 shadow text-center">
        <h3 class="fw-bold mb-2">Experience Bihar's Rich Living Culture</h3>
        <p class="text-white-50 mb-4">Book a guided heritage & culinary circuit with BiharYatra today.</p>
        <a href="${pageContext.request.contextPath}/packages" class="btn btn-brand btn-lg px-5 py-2.5 font-semibold">Explore Tour Packages</a>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

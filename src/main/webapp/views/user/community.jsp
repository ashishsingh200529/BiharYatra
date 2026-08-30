<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-dark text-white py-5">
    <div class="container py-3">
        <span class="badge bg-danger px-3 py-2 rounded-pill mb-3 font-semibold"><i class="bi bi-camera-fill me-1"></i> Travelers Feed</span>
        <h1 class="fw-bold display-5 mb-2">BiharYatra Community & Photo Wall</h1>
        <p class="lead text-white-50 mb-0">See verified trip photos, hidden travel tips, and stories shared by fellow travelers.</p>
    </div>
</div>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold text-dark mb-0">Recent Travel Stories</h3>
        <button class="btn btn-brand rounded-pill px-4 font-semibold" onclick="alert('Photo submission opened! Upload your travel memories.');"><i class="bi bi-plus-circle-fill me-1"></i> Share Your Story</button>
    </div>

    <div class="row g-4">
        <div class="col-md-6 col-lg-4">
            <div class="card border rounded-4 overflow-hidden shadow-sm h-100">
                <img src="https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=600&q=80" style="height: 240px; object-fit: cover;" class="card-img-top" alt="Bodh Gaya Sunset" />
                <div class="card-body">
                    <div class="d-flex align-items-center mb-2">
                        <i class="bi bi-person-circle fs-4 me-2 text-danger"></i>
                        <div>
                            <strong class="d-block text-dark small">Vikram Sharma</strong>
                            <small class="text-muted" style="font-size: 11px;">Visited Bodh Gaya • 2 days ago</small>
                        </div>
                    </div>
                    <p class="text-dark small mb-3">"Evening chanting under the Bodhi Tree was a spiritual awakening. Do visit around 5:30 PM for sunset prayers!"</p>
                    <div class="d-flex justify-content-between align-items-center border-top pt-2 text-muted small">
                        <span><i class="bi bi-heart-fill text-danger me-1"></i> 142 Likes</span>
                        <span><i class="bi bi-chat-left-text me-1"></i> 18 Comments</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-4">
            <div class="card border rounded-4 overflow-hidden shadow-sm h-100">
                <img src="https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=600&q=80" style="height: 240px; object-fit: cover;" class="card-img-top" alt="Nalanda Ruins Walk" />
                <div class="card-body">
                    <div class="d-flex align-items-center mb-2">
                        <i class="bi bi-person-circle fs-4 me-2 text-danger"></i>
                        <div>
                            <strong class="d-block text-dark small">Sneha Kapoor</strong>
                            <small class="text-muted" style="font-size: 11px;">Visited Nalanda • 4 days ago</small>
                        </div>
                    </div>
                    <p class="text-dark small mb-3">"Walking through the 1500-year-old Nalanda University monastery walls left me speechless. Make sure to hire a licensed guide!"</p>
                    <div class="d-flex justify-content-between align-items-center border-top pt-2 text-muted small">
                        <span><i class="bi bi-heart-fill text-danger me-1"></i> 218 Likes</span>
                        <span><i class="bi bi-chat-left-text me-1"></i> 32 Comments</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-4">
            <div class="card border rounded-4 overflow-hidden shadow-sm h-100">
                <img src="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=600&q=80" style="height: 240px; object-fit: cover;" class="card-img-top" alt="Kakolat Waterfall" />
                <div class="card-body">
                    <div class="d-flex align-items-center mb-2">
                        <i class="bi bi-person-circle fs-4 me-2 text-danger"></i>
                        <div>
                            <strong class="d-block text-dark small">Amitabh Roy</strong>
                            <small class="text-muted" style="font-size: 11px;">Visited Kakolat • 1 week ago</small>
                        </div>
                    </div>
                    <p class="text-dark small mb-3">"The 160-foot Kakolat waterfall is Bihar's natural paradise! Water is ice-cold and crystal clear. Perfect weekend trip."</p>
                    <div class="d-flex justify-content-between align-items-center border-top pt-2 text-muted small">
                        <span><i class="bi bi-heart-fill text-danger me-1"></i> 189 Likes</span>
                        <span><i class="bi bi-chat-left-text me-1"></i> 24 Comments</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

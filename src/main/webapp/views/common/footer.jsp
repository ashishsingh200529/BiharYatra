<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- FOOTER SECTION -->
<footer class="footer-section">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <h5 class="fw-bold text-white"><i class="bi bi-compass-fill me-2 text-warning"></i>BIHAR YATRA</h5>
                <p class="small text-muted mt-3">
                    BiharYatra is a digital solution targeting easy travel exploration and online booking systems. Learn, plan, customize, and navigate your way through Bihar's historical and spiritual centers.
                </p>
                <div class="mt-4">
                    <a href="#" class="text-white me-3"><i class="bi bi-facebook fs-5"></i></a>
                    <a href="#" class="text-white me-3"><i class="bi bi-instagram fs-5"></i></a>
                    <a href="#" class="text-white me-3"><i class="bi bi-twitter fs-5"></i></a>
                    <a href="#" class="text-white"><i class="bi bi-youtube fs-5"></i></a>
                </div>
            </div>
            
            <div class="col-lg-2 col-md-6">
                <h5 class="fw-bold">Explore</h5>
                <a href="${pageContext.request.contextPath}/packages" class="footer-link">Tour Packages</a>
                <a href="${pageContext.request.contextPath}/reviews" class="footer-link">Verified Reviews</a>
                <a href="${pageContext.request.contextPath}/invoice?bookingNo=BY-1001" class="footer-link">Sample GST Invoice</a>
                <a href="${pageContext.request.contextPath}/views/user/contact.jsp" class="footer-link">Helpdesk Support</a>
                <a href="${pageContext.request.contextPath}/admin/login" class="footer-link text-warning fw-bold"><i class="bi bi-shield-lock me-1"></i> Admin Console</a>
            </div>
            
            <div class="col-lg-2 col-md-6">
                <h5 class="fw-bold">Top Destinations</h5>
                <a href="${pageContext.request.contextPath}/package-details?id=2" class="footer-link">Bodh Gaya Temple</a>
                <a href="${pageContext.request.contextPath}/package-details?id=1" class="footer-link">Rajgir Peace Pagoda</a>
                <a href="${pageContext.request.contextPath}/package-details?id=1" class="footer-link">Nalanda Ruins</a>
                <a href="${pageContext.request.contextPath}/package-details?id=4" class="footer-link">Valmiki Safari</a>
            </div>
            
            <div class="col-lg-4 col-md-6">
                <h5 class="fw-bold">Accreditations & Office</h5>
                <p class="small text-muted mb-2">
                    <i class="bi bi-geo-alt-fill text-warning me-2"></i>Bihar Tourism Development Corp, Gandhi Maidan, Patna, Bihar, 800001
                </p>
                <div class="mt-3 p-2.5 bg-dark bg-opacity-50 rounded-3 border border-secondary d-flex align-items-center gap-3">
                    <span class="badge bg-warning text-dark font-semibold py-2 px-2.5"><i class="bi bi-patch-check-fill me-1"></i> ISO 9001:2026</span>
                    <span class="small text-white-50" style="font-size: 11px;">Government Recognized Smart Tourism Platform</span>
                </div>
            </div>
        </div>
        
        <hr class="mt-5 border-secondary">
        
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center pt-3 small text-muted">
            <p class="mb-0">&copy; 2026 BiharYatra Smart Tourism Project. Built for 7th Semester Major Project.</p>
            <div class="mt-2 mt-md-0">
                <a href="#" class="text-muted text-decoration-none me-3">Privacy Policy</a>
                <a href="#" class="text-muted text-decoration-none">Terms of Service</a>
            </div>
        </div>
    </div>
</footer>

<!-- Live Social Proof Floating Activity Ticker -->
<div id="live-social-ticker" class="position-fixed bottom-0 start-0 m-3 p-3 bg-white border border-danger rounded-4 shadow-lg d-flex align-items-center gap-3 animate-pulse-glow" style="z-index: 1050; max-width: 360px; display: none;">
    <div class="bg-danger text-white rounded-circle p-2.5 d-flex align-items-center justify-content-center">
        <i class="bi bi-bag-check-fill fs-5"></i>
    </div>
    <div>
        <strong class="d-block text-dark small" id="ticker-msg">Rahul from Delhi just booked Bodh Gaya Tour!</strong>
        <small class="text-muted" style="font-size: 10px;" id="ticker-time">2 minutes ago • Verified Booking</small>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var ticker = document.getElementById("live-social-ticker");
        var msg = document.getElementById("ticker-msg");
        var time = document.getElementById("ticker-time");

        var activities = [
            "Rahul from Delhi just booked Bodh Gaya Heritage Tour!",
            "Priya from Patna reserved a Tourist Cab for Rajgir!",
            "Vikram from Mumbai hired a Certified Tour Guide!",
            "Sneha from Kolkata booked Bodh Gaya Zen Resort!",
            "Amit from Bengaluru claimed ₹500 Discount Coupon!"
        ];

        var index = 0;
        if (ticker) {
            setInterval(function() {
                msg.innerText = activities[index];
                time.innerText = Math.floor(1 + Math.random()*4) + " minutes ago • Verified Booking";
                ticker.style.display = "flex";
                setTimeout(function() {
                    ticker.style.display = "none";
                }, 4000);
                index = (index + 1) % activities.length;
            }, 10000);
        }
    });
</script>

<!-- FLOATING AI CHATBOT WIDGET -->
<button class="chatbot-toggler shadow-lg" aria-label="Open Chatbot">
    <i class="bi bi-chat-dots-fill fs-4"></i>
</button>

<div class="chatbot-box">
    <div class="chatbot-header">
        <div class="d-flex align-items-center">
            <i class="bi bi-robot fs-4 me-2 text-warning"></i>
            <div>
                <h6 class="mb-0 fw-bold">Yatra Mitra</h6>
                <small style="font-size: 11px; opacity: 0.8;">Bihar Tourism AI Guide</small>
            </div>
        </div>
        <button class="btn btn-close btn-close-white close-chat-btn" aria-label="Close Chat"></button>
    </div>
    
    <div class="chatbot-messages d-flex flex-column">
        <div class="chat-bubble bot">
            Namaste! I am <strong>Yatra Mitra</strong>, your smart Bihar tourism guide. 
            Ask me about places like Bodh Gaya, Nalanda, Rajgir glass bridge, litti chokha, or packages booking!
        </div>
    </div>
    
    <div class="chatbot-input-container">
        <input type="text" id="chat-input" placeholder="Ask Yatra Mitra..." maxlength="120" />
        <button id="send-chat-btn" aria-label="Send message">
            <i class="bi bi-send-fill"></i>
        </button>
    </div>
</div>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Leaflet.js Map script (for interactive maps) -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>

<!-- Custom main JS module -->
<script src="${pageContext.request.contextPath}/static/js/main.js"></script>

</body>
</html>

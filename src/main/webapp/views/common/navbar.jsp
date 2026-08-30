<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg custom-navbar sticky-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/index.jsp">
            <i class="bi bi-compass-fill me-2"></i> BIHAR YATRA
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-3">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp" data-i18n="nav_home">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/packages" data-i18n="nav_packages">Packages</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger font-semibold" href="${pageContext.request.contextPath}/ai-planner"><i class="bi bi-robot me-1"></i> AI Planner</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger font-semibold" href="${pageContext.request.contextPath}/map"><i class="bi bi-map-fill me-1"></i> Map</a>
                </li>

                <!-- More Experiences Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle font-semibold text-dark" href="#" id="moreNavDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Explore ▾
                    </a>
                    <ul class="dropdown-menu shadow border-0 mt-2" aria-labelledby="moreNavDropdown">
                        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/vr-gallery"><i class="bi bi-badge-3d-fill me-2 text-danger"></i> 360° VR Virtual Tours</a></li>
                        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/transit"><i class="bi bi-bus-front-fill me-2 text-warning"></i> Bus & Train Routes</a></li>
                        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/leaderboard"><i class="bi bi-trophy-fill me-2 text-warning"></i> Tourism Leaderboard</a></li>
                        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/guides"><i class="bi bi-patch-check-fill me-2 text-danger"></i> Certified Tour Guides</a></li>
                        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/hotels"><i class="bi bi-house-door-fill me-2 text-warning"></i> Hotels & Homestays</a></li>
                        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/cabs"><i class="bi bi-taxi-front-fill me-2 text-primary"></i> Tourist Cabs</a></li>
                        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/culture"><i class="bi bi-egg-fried me-2 text-warning"></i> Cuisine & Art</a></li>
                        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/gift-cards"><i class="bi bi-gift-fill me-2 text-danger"></i> Travel Gift Cards</a></li>
                        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/community"><i class="bi bi-camera-fill me-2 text-info"></i> Travelers Community</a></li>
                        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/b2b"><i class="bi bi-building me-2 text-success"></i> B2B Group & Schools</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item py-2 font-semibold text-danger" href="${pageContext.request.contextPath}/become-partner"><i class="bi bi-handbag-fill me-2"></i> Become a Partner</a></li>
                        <li><a class="dropdown-item py-2 font-semibold text-dark" href="${pageContext.request.contextPath}/vendor"><i class="bi bi-wallet-fill me-2 text-warning"></i> Partner Payout Portal</a></li>
                    </ul>
                </li>
            </ul>

            <!-- Right Controls Utility Bar -->
            <div class="d-flex align-items-center gap-2">
                <!-- Voice Mic Search Button -->
                <button type="button" id="voice-mic-btn" class="btn btn-outline-danger btn-sm rounded-circle p-2 shadow-sm" style="width: 36px; height: 36px;" title="Voice Search">
                    <i class="bi bi-mic-fill" id="mic-icon"></i>
                </button>

                <!-- Settings Dropdown (Currency & Language) -->
                <div class="dropdown">
                    <button class="btn btn-outline-secondary btn-sm dropdown-toggle rounded-pill px-3 font-semibold" type="button" id="settingsDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-globe me-1 text-danger"></i> <span id="current-lang-label">ENG</span> • <span id="curr-label">₹</span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2" aria-labelledby="settingsDropdown">
                        <li><h6 class="dropdown-header text-muted small">Select Language</h6></li>
                        <li><button class="dropdown-item lang-opt py-1.5" data-lang="en">🇬🇧 English</button></li>
                        <li><button class="dropdown-item lang-opt py-1.5" data-lang="hi">🇮🇳 हिन्दी (Hindi)</button></li>
                        <li><button class="dropdown-item lang-opt py-1.5" data-lang="bho">🌾 भोजपुरी (Bhojpuri)</button></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><h6 class="dropdown-header text-muted small">Select Currency</h6></li>
                        <li><button class="dropdown-item curr-opt py-1.5" data-curr="INR" data-symbol="₹" data-rate="1">🇮🇳 INR (₹)</button></li>
                        <li><button class="dropdown-item curr-opt py-1.5" data-curr="USD" data-symbol="$" data-rate="0.012">🇺🇸 USD ($)</button></li>
                        <li><button class="dropdown-item curr-opt py-1.5" data-curr="EUR" data-symbol="€" data-rate="0.011">🇪🇺 EUR (€)</button></li>
                    </ul>
                </div>

                <!-- Dark Mode Toggle -->
                <button type="button" id="theme-toggle-btn" class="btn btn-light btn-sm rounded-circle p-2 border shadow-sm" style="width: 36px; height: 36px;" title="Toggle Theme">
                    <i class="bi bi-moon-stars-fill text-dark" id="theme-icon"></i>
                </button>

                <!-- Admin Console Button (Always Highlighted) -->
                <a href="${pageContext.request.contextPath}/admin/login" class="btn btn-warning text-dark font-bold btn-sm rounded-pill px-3 shadow-sm" title="Staff & Admin Console">
                    <i class="bi bi-shield-lock-fill me-1 text-danger"></i> Admin
                </a>

                <!-- User Session -->
                <c:choose>
                    <c:when test="${not empty sessionScope.admin}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-danger btn-sm rounded-pill px-3">Dashboard</a>
                    </c:when>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="dropdown">
                            <button class="btn btn-outline-dark btn-sm rounded-pill dropdown-toggle font-semibold" type="button" id="userMenuDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-circle me-1 text-danger"></i> ${sessionScope.user.name}
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2" aria-labelledby="userMenuDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="bi bi-grid-fill me-2 text-muted"></i>My Profile</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile#bookings-tab"><i class="bi bi-ticket-detailed-fill me-2 text-muted"></i>My Bookings</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Log Out</a></li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary-brand btn-sm rounded-pill px-3">Log In</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-brand btn-sm rounded-pill px-3">Sign Up</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<!-- Floating Tourist Emergency SOS Button -->
<div class="position-fixed bottom-0 start-0 m-4" style="z-index: 1050;">
    <button type="button" class="btn btn-danger rounded-circle p-3 shadow-lg animate-bounce" data-bs-toggle="modal" data-bs-target="#sosModal" title="Tourist Emergency Helpline SOS">
        <i class="bi bi-shield-fill-exclamation fs-3"></i>
    </button>
</div>

<!-- Tourist Emergency SOS Modal -->
<div class="modal fade" id="sosModal" tabindex="-1" aria-labelledby="sosModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header bg-danger text-white border-0 py-3">
                <h5 class="modal-title fw-bold" id="sosModalLabel"><i class="bi bi-shield-fill-exclamation me-2"></i> Bihar Tourist Safety & Emergency Desk</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4 text-center">
                <div class="bg-danger-subtle text-danger rounded-circle p-3 d-inline-block mb-3">
                    <i class="bi bi-telephone-outbound-fill display-4"></i>
                </div>
                <h4 class="fw-bold text-dark mb-1">Emergency Help Desks</h4>
                <p class="text-muted small mb-4">Direct 24/7 emergency hotlines for tourists traveling in Bihar.</p>

                <div class="row g-2">
                    <div class="col-6">
                        <a href="tel:112" class="btn btn-outline-danger w-100 py-3 rounded-3 text-start small font-semibold">
                            <i class="bi bi-shield-lock-fill fs-5 d-block text-danger"></i> Tourist Police: <strong>112</strong>
                        </a>
                    </div>
                    <div class="col-6">
                        <a href="tel:108" class="btn btn-outline-danger w-100 py-3 rounded-3 text-start small font-semibold">
                            <i class="bi bi-hospital-fill fs-5 d-block text-danger"></i> Ambulance: <strong>108</strong>
                        </a>
                    </div>
                    <div class="col-6 mt-2">
                        <a href="tel:1091" class="btn btn-outline-danger w-100 py-3 rounded-3 text-start small font-semibold">
                            <i class="bi bi-person-fill-exclamation fs-5 d-block text-danger"></i> Women Helpline: <strong>1091</strong>
                        </a>
                    </div>
                    <div class="col-6 mt-2">
                        <a href="tel:18003456789" class="btn btn-outline-danger w-100 py-3 rounded-3 text-start small font-semibold">
                            <i class="bi bi-headset fs-5 d-block text-danger"></i> Bihar Tourism: <strong>1800-345-6789</strong>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bihar Tourism Quiz Modal -->
<div class="modal fade" id="quizModal" tabindex="-1" aria-labelledby="quizModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header bg-warning text-dark border-0 py-3">
                <h5 class="modal-title fw-bold" id="quizModalLabel"><i class="bi bi-trophy-fill me-2 text-danger"></i> Bihar Tourism Trivia - Win ₹500 Off!</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <div id="quiz-question-box">
                    <span class="badge bg-danger mb-2">Question 1 of 3</span>
                    <h5 class="fw-bold text-dark mb-3" id="quiz-q">Where did Lord Buddha achieve Enlightenment under the Bodhi tree?</h5>
                    <div class="d-grid gap-2" id="quiz-opts">
                        <button class="btn btn-light border text-start quiz-ans-btn" data-correct="true">A) Bodh Gaya</button>
                        <button class="btn btn-light border text-start quiz-ans-btn" data-correct="false">B) Patna</button>
                        <button class="btn btn-light border text-start quiz-ans-btn" data-correct="false">C) Nalanda</button>
                    </div>
                </div>

                <div id="quiz-win-box" class="d-none text-center py-4">
                    <i class="bi bi-gift-fill display-2 text-danger mb-3 d-inline-block"></i>
                    <h3 class="fw-bold text-dark">Congratulations! 🎉</h3>
                    <p class="text-muted small">You answered correctly and won a <strong>₹500 Discount Promo Code</strong>!</p>
                    <div class="p-3 bg-light border border-dashed rounded-3 mb-3">
                        <span class="fs-4 fw-bold text-danger letter-spacing-2">BIHAR500</span>
                    </div>
                    <small class="text-muted d-block">Use code <strong>BIHAR500</strong> during booking for flat ₹500 discount.</small>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 1. Multi-language translation engine
        var translations = {
            en: { nav_home: "Home", nav_packages: "Tour Packages", nav_map: "Interactive Map", nav_contact: "Contact Us" },
            hi: { nav_home: "मुख्य पृष्ठ", nav_packages: "टूर पैकेज", nav_map: "नक्शा & रूट", nav_contact: "संपर्क करें" },
            bho: { nav_home: "घर", nav_packages: "घूमे वाला पैकेज", nav_map: "बिहार नक्शा", nav_contact: "सम्पर्क करीं" }
        };

        var savedLang = localStorage.getItem("biharYatraLang") || "en";
        applyLang(savedLang);

        document.querySelectorAll(".lang-opt").forEach(function(btn) {
            btn.addEventListener("click", function() {
                var lang = btn.getAttribute("data-lang");
                localStorage.setItem("biharYatraLang", lang);
                applyLang(lang);
            });
        });

        function applyLang(lang) {
            var labels = { en: "English", hi: "हिन्दी", bho: "भोजपुरी" };
            var lblEl = document.getElementById("current-lang-label");
            if (lblEl) lblEl.innerText = labels[lang] || "English";

            var dict = translations[lang] || translations["en"];
            document.querySelectorAll("[data-i18n]").forEach(function(el) {
                var key = el.getAttribute("data-i18n");
                if (dict[key]) el.innerText = dict[key];
            });
        }

        // 2. Dark Mode / Night Mode Engine
        var themeBtn = document.getElementById("theme-toggle-btn");
        var themeIcon = document.getElementById("theme-icon");
        var currentTheme = localStorage.getItem("biharYatraTheme") || "light";

        if (currentTheme === "dark") {
            document.body.classList.add("bg-dark", "text-white");
            if (themeIcon) themeIcon.className = "bi bi-sun-fill text-warning";
        }

        if (themeBtn) {
            themeBtn.addEventListener("click", function() {
                if (document.body.classList.contains("bg-dark")) {
                    document.body.classList.remove("bg-dark", "text-white");
                    localStorage.setItem("biharYatraTheme", "light");
                    if (themeIcon) themeIcon.className = "bi bi-moon-stars-fill text-dark";
                } else {
                    document.body.classList.add("bg-dark", "text-white");
                    localStorage.setItem("biharYatraTheme", "dark");
                    if (themeIcon) themeIcon.className = "bi bi-sun-fill text-warning";
                }
            });
        }

        // 3. Voice Search Engine (Speech Recognition)
        var micBtn = document.getElementById("voice-mic-btn");
        var micIcon = document.getElementById("mic-icon");

        if (micBtn) {
            micBtn.addEventListener("click", function() {
                if ('webkitSpeechRecognition' in window || 'SpeechRecognition' in window) {
                    var SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
                    var recognition = new SpeechRecognition();
                    recognition.lang = 'hi-IN';

                    recognition.onstart = function() {
                        if (micIcon) micIcon.className = "bi bi-mic-fill text-danger animate-pulse";
                    };

                    recognition.onresult = function(event) {
                        var transcript = event.results[0][0].transcript;
                        if (micIcon) micIcon.className = "bi bi-mic-fill";
                        window.location.href = "${pageContext.request.contextPath}/packages?search=" + encodeURIComponent(transcript);
                    };

                    recognition.onerror = function() {
                        if (micIcon) micIcon.className = "bi bi-mic-fill";
                    };

                    recognition.start();
                } else {
                    var input = prompt("Voice search is not supported on this browser. Type your search term below:");
                    if (input && input.trim() !== "") {
                        window.location.href = "${pageContext.request.contextPath}/packages?search=" + encodeURIComponent(input);
                    }
                }
            });
        }

        // 4. Multi-Currency Engine
        document.querySelectorAll(".curr-opt").forEach(function(btn) {
            btn.addEventListener("click", function() {
                var curr = btn.getAttribute("data-curr");
                var symbol = btn.getAttribute("data-symbol");
                var rate = parseFloat(btn.getAttribute("data-rate"));

                var label = document.getElementById("curr-label");
                if (label) label.innerText = symbol;

                localStorage.setItem("biharYatraCurr", JSON.stringify({ curr: curr, symbol: symbol, rate: rate }));
            });
        });

        // 5. Quiz Logic
        document.querySelectorAll(".quiz-ans-btn").forEach(function(btn) {
            btn.addEventListener("click", function() {
                var isCorrect = btn.getAttribute("data-correct") === "true";
                if (isCorrect) {
                    document.getElementById("quiz-question-box").classList.add("d-none");
                    document.getElementById("quiz-win-box").classList.remove("d-none");
                } else {
                    alert("Incorrect answer! Try again!");
                }
            });
        });
    });
</script>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-dark text-white py-5 position-relative overflow-hidden">
    <div class="container position-relative" style="z-index: 2;">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <span class="badge bg-danger px-3 py-2 rounded-pill mb-3 font-semibold"><i class="bi bi-robot me-1"></i> Yatra Mitra AI Engine 2.0</span>
                <h1 class="fw-bold display-5 mb-3">AI Custom Trip Planner</h1>
                <p class="lead text-white-50 mb-0">Generate a personalized, day-by-day Bihar travel itinerary tailored precisely to your budget, travel style, and duration.</p>
            </div>
            <div class="col-lg-4 text-center d-none d-lg-block">
                <i class="bi bi-magic display-1 text-danger animate-pulse"></i>
            </div>
        </div>
    </div>
</div>

<div class="container my-5">
    <div class="row g-4">
        <!-- Planner Form Column -->
        <div class="col-lg-5">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                <h4 class="fw-bold text-dark mb-4"><i class="bi bi-sliders text-danger me-2"></i> Trip Preferences</h4>
                
                <div class="mb-4">
                    <label class="form-label font-semibold text-dark small">1. Choose Travel Theme / Vibe</label>
                    <div class="row g-2" id="vibe-selector">
                        <div class="col-6">
                            <div class="border rounded-3 p-3 text-center cursor-pointer vibe-card active border-danger bg-danger-subtle" data-vibe="Spiritual">
                                <i class="bi bi-flower1 fs-3 text-danger mb-1 d-block"></i>
                                <span class="fw-bold small text-dark">Spiritual</span>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="border rounded-3 p-3 text-center cursor-pointer vibe-card" data-vibe="Heritage">
                                <i class="bi bi-bank fs-3 text-danger mb-1 d-block"></i>
                                <span class="fw-bold small text-dark">Heritage</span>
                            </div>
                        </div>
                        <div class="col-6 mt-2">
                            <div class="border rounded-3 p-3 text-center cursor-pointer vibe-card" data-vibe="Nature">
                                <i class="bi bi-tree fs-3 text-danger mb-1 d-block"></i>
                                <span class="fw-bold small text-dark">Eco-Safari</span>
                            </div>
                        </div>
                        <div class="col-6 mt-2">
                            <div class="border rounded-3 p-3 text-center cursor-pointer vibe-card" data-vibe="Culinary">
                                <i class="bi bi-cup-hot fs-3 text-danger mb-1 d-block"></i>
                                <span class="fw-bold small text-dark">Culinary & Art</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label font-semibold text-dark small d-flex justify-content-between">
                        <span>2. Trip Duration</span>
                        <strong class="text-danger" id="days-val">3 Days</strong>
                    </label>
                    <input type="range" id="days-slider" class="form-range" min="1" max="7" value="3" oninput="document.getElementById('days-val').innerText = this.value + ' Days'" />
                </div>

                <div class="mb-4">
                    <label class="form-label font-semibold text-dark small d-flex justify-content-between">
                        <span>3. Target Budget (per person)</span>
                        <strong class="text-danger" id="budget-val">Rs. 6,000</strong>
                    </label>
                    <input type="range" id="budget-slider" class="form-range" min="2000" max="25000" step="1000" value="6000" oninput="document.getElementById('budget-val').innerText = 'Rs. ' + parseInt(this.value).toLocaleString('en-IN')" />
                </div>

                <div class="mb-4">
                    <label class="form-label font-semibold text-dark small">4. Traveler Count</label>
                    <select id="pax-select" class="form-select">
                        <option value="1">Solo Traveler (1 Adult)</option>
                        <option value="2" selected>Couple / Pair (2 Adults)</option>
                        <option value="4">Family & Friends (4 Adults)</option>
                        <option value="8">Group Tour (8+ Travelers)</option>
                    </select>
                </div>

                <button type="button" id="btn-generate-ai" class="btn btn-brand w-100 py-3 font-semibold fs-6 shadow-sm">
                    <i class="bi bi-magic me-2"></i> Generate AI Itinerary
                </button>
            </div>
        </div>

        <!-- AI Output Column -->
        <div class="col-lg-7">
            <div id="ai-placeholder" class="glass-card p-5 border bg-white rounded-4 shadow-sm text-center py-5">
                <i class="bi bi-robot display-1 text-muted mb-3 d-inline-block opacity-50"></i>
                <h4 class="fw-bold text-dark">Ready to Build Your Dream Bihar Tour!</h4>
                <p class="text-muted small">Select your preferences on the left and click <strong>"Generate AI Itinerary"</strong> to produce a customized travel plan.</p>
            </div>

            <div id="ai-results" class="d-none">
                <div class="glass-card p-4 border bg-white rounded-4 shadow-sm mb-4">
                    <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
                        <div>
                            <span class="badge bg-danger mb-1" id="res-theme-badge">Spiritual Tour</span>
                            <h3 class="fw-bold text-dark mb-0" id="res-title">Customized Bihar Experience</h3>
                        </div>
                        <div class="text-end">
                            <small class="text-muted d-block">Est. Total Package</small>
                            <span class="fw-bold text-danger fs-4" id="res-price">Rs. 6,000</span>
                        </div>
                    </div>

                    <h5 class="fw-bold text-dark mb-3"><i class="bi bi-calendar-range text-danger me-2"></i> Generated Day-by-Day Schedule</h5>
                    
                    <div id="itinerary-days-container"></div>

                    <div class="d-flex gap-3 pt-3 border-top mt-4">
                        <a href="${pageContext.request.contextPath}/packages" class="btn btn-brand w-100 py-2.5 font-semibold"><i class="bi bi-check-circle me-1"></i> Book Matching Tour Package</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var selectedVibe = "Spiritual";
        
        document.querySelectorAll(".vibe-card").forEach(function(card) {
            card.addEventListener("click", function() {
                document.querySelectorAll(".vibe-card").forEach(c => c.className = "border rounded-3 p-3 text-center cursor-pointer vibe-card");
                card.className = "border rounded-3 p-3 text-center cursor-pointer vibe-card active border-danger bg-danger-subtle";
                selectedVibe = card.getAttribute("data-vibe");
            });
        });

        document.getElementById("btn-generate-ai").addEventListener("click", function() {
            var days = parseInt(document.getElementById("days-slider").value);
            var budget = parseInt(document.getElementById("budget-slider").value);
            var pax = parseInt(document.getElementById("pax-select").value);

            document.getElementById("ai-placeholder").classList.add("d-none");
            document.getElementById("ai-results").classList.remove("d-none");

            document.getElementById("res-theme-badge").innerText = selectedVibe + " Expedition";
            document.getElementById("res-title").innerText = days + "-Day " + selectedVibe + " Discovery Circuit";
            document.getElementById("res-price").innerText = "Rs. " + (budget * pax).toLocaleString('en-IN') + " (" + pax + " Pax)";

            var container = document.getElementById("itinerary-days-container");
            container.innerHTML = "";

            var itineraryPlans = {
                Spiritual: [
                    { title: "Arrival in Gaya & Mahabodhi Temple", desc: "Check-in at hotel, evening meditation at Bodhi Tree, and visit Great Buddha Statue.", meals: "Breakfast & Dinner", stay: "Gaya Resort" },
                    { title: "Rajgir Peace Pagoda & Vishwa Shanti Stupa", desc: "Ropeway ride to Vulture Peak, explore Griddhakuta Hill sermons site.", meals: "Breakfast & Lunch", stay: "Rajgir Heritage Hotel" },
                    { title: "Pawapuri Jal Mandir & Return", desc: "Visit marble Jal Mandir in lotus tank where Lord Mahavira attained liberation.", meals: "Breakfast", stay: "Departure" },
                    { title: "Patna Sahib Gurudwara Darshan", desc: "Visit Takht Sri Patna Sahib, historical museum galleries, and Ganga Ghat.", meals: "Breakfast & Lunch", stay: "Patna Hotel" }
                ],
                Heritage: [
                    { title: "Patna Heritage & Bihar Museum", desc: "Explore Bihar Museum's 2500-year artifacts, Didarganj Yakshi, and Golghar.", meals: "Breakfast & Dinner", stay: "Patna Grand Hotel" },
                    { title: "Nalanda Ruins & Ancient University", desc: "Guided exploration of 5th century CE Nalanda University excavated monastery ruins.", meals: "Breakfast & Lunch", stay: "Rajgir Residency" },
                    { title: "Sasaram Tomb of Sher Shah Suri", desc: "Drive to Sasaram to view the 3-storied red sandstone lake mausoleum.", meals: "Breakfast & Dinner", stay: "Sasaram Tourist Complex" },
                    { title: "Vikramshila University & Bhagalpur", desc: "Visit Pala dynasty ruins of Vikramshila and Bhagalpur silk weaving centers.", meals: "Breakfast", stay: "Bhagalpur Hotel" }
                ],
                Nature: [
                    { title: "Valmiki Tiger Reserve Jungle Safari", desc: "Arrival at Valmiki Nagar, Gandak river boat ride, and jungle canopy watchtower.", meals: "All Meals Included", stay: "Jungle Eco-Lodge" },
                    { title: "Kakolat Natural Waterfall Eco-Bath", desc: "Excursion to 160-foot Kakolat Falls in Nawada valley with guided nature walk.", meals: "Breakfast & Lunch", stay: "Nawada Nature Resort" },
                    { title: "Rajgir Glass Skywalk & Nature Trail", desc: "Walk on the 85-ft transparent glass suspension bridge over deep green gorges.", meals: "Breakfast & Dinner", stay: "Rajgir Safari Resort" },
                    { title: "Kaimur Hills & Rohtasgarh Fort Trek", desc: "Scenic mountain drive to Rohtasgarh Fort and Elephant Gate vantage point.", meals: "Breakfast & Lunch", stay: "Kaimur Eco Retreat" }
                ],
                Culinary: [
                    { title: "Patna Street Food & Authentic Litti Chokha", desc: "Traditional Litti Chokha tasting tour, Sattu Sharbat, and Bihar Museum visit.", meals: "All Local Delicacies", stay: "Patna City Hotel" },
                    { title: "Silao Khaja & Gaya Tilkut Culinary Trail", desc: "Visit GI-tagged Silao Khaja confectioners and authentic Gaya Tilkut artisans.", meals: "Tasting Menu Included", stay: "Gaya Heritage Hotel" },
                    { title: "Madhubani Art Village & Mithila Cuisine", desc: "Live Madhubani painting workshop with local artists and traditional Mithila thali.", meals: "Authentic Mithila Feast", stay: "Madhubani Art Homestay" }
                ]
            };

            var selectedList = itineraryPlans[selectedVibe] || itineraryPlans["Spiritual"];

            for (var i = 1; i <= days; i++) {
                var plan = selectedList[(i - 1) % selectedList.length];
                var div = document.createElement("div");
                div.className = "card p-3 border rounded-3 mb-3 bg-light";
                div.innerHTML = `
                    <div class="fw-bold text-danger mb-1">Day ` + i + `: ` + plan.title + `</div>
                    <p class="text-muted small mb-2">` + plan.desc + `</p>
                    <div class="d-flex gap-3 small text-secondary">
                        <span><i class="bi bi-egg-fried text-warning me-1"></i> ` + plan.meals + `</span>
                        <span><i class="bi bi-house-door-fill text-primary me-1"></i> ` + plan.stay + `</span>
                    </div>
                `;
                container.appendChild(div);
            }
        });
    });
</script>

<%@ include file="/views/common/footer.jsp" %>

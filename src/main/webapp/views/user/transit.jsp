<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-gradient-to-r from-dark to-danger text-white py-5">
    <div class="container text-center py-3">
        <span class="badge bg-warning text-dark px-3 py-2 rounded-pill mb-3 font-semibold"><i class="bi bi-train-front-fill me-1"></i> Indian Railways & BSRTC Transit Finder</span>
        <h1 class="fw-bold display-4 mb-2">Bihar Train & Bus Timetable</h1>
        <p class="lead text-white-50 max-w-2xl mx-auto mb-0">Check departure times, arrival times, train numbers, fares, and routes connecting all major stations across Bihar.</p>
    </div>
</div>

<div class="container my-5">
    
    <!-- Train Route Filter & Search Bar -->
    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm mb-4">
        <h5 class="fw-bold text-dark mb-3"><i class="bi bi-search text-danger me-1"></i> Find Trains Between Stations</h5>
        <div class="row g-3 align-items-center">
            <div class="col-md-4">
                <label class="form-label font-semibold text-dark small">From Station</label>
                <select id="fromStation" class="form-select" onchange="filterTrains()">
                    <option value="">All Origin Stations</option>
                    <option value="PNBE">Patna Junction (PNBE)</option>
                    <option value="GAY">Gaya Junction (GAY)</option>
                    <option value="RGD">Rajgir (RGD)</option>
                    <option value="MFP">Muzaffarpur (MFP)</option>
                    <option value="BGP">Bhagalpur (BGP)</option>
                    <option value="DBG">Darbhanga (DBG)</option>
                </select>
            </div>
            <div class="col-md-4">
                <label class="form-label font-semibold text-dark small">To Station</label>
                <select id="toStation" class="form-select" onchange="filterTrains()">
                    <option value="">All Destination Stations</option>
                    <option value="GAY">Gaya Junction (GAY)</option>
                    <option value="RGD">Rajgir (RGD)</option>
                    <option value="PNBE">Patna Junction (PNBE)</option>
                    <option value="NDLS">New Delhi (NDLS)</option>
                    <option value="HWH">Howrah / Kolkata (HWH)</option>
                </select>
            </div>
            <div class="col-md-4">
                <label class="form-label font-semibold text-dark small">Quick Search</label>
                <input type="text" id="trainSearch" class="form-control" placeholder="Search train name or no..." onkeyup="filterTrains()" />
            </div>
        </div>
    </div>

    <!-- Complete Bihar Train Timetable Table -->
    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <span class="badge bg-danger mb-1">Live Timetable</span>
                <h4 class="fw-bold text-dark mb-0"><i class="bi bi-train-front-fill text-danger me-2"></i> Indian Railways Schedule for Bihar</h4>
            </div>
            <a href="https://www.irctc.co.in" target="_blank" class="btn btn-outline-danger btn-sm rounded-pill font-semibold px-3"><i class="bi bi-box-arrow-up-right me-1"></i> Book Ticket on IRCTC</a>
        </div>

        <div class="table-responsive">
            <table class="table align-middle table-hover small" id="trainTable">
                <thead class="table-dark">
                    <tr>
                        <th>Train Name & No</th>
                        <th>Origin ➔ Destination</th>
                        <th>Dep. Time</th>
                        <th>Arr. Time</th>
                        <th>Duration</th>
                        <th>Runs On</th>
                        <th>Classes</th>
                        <th>Starting Fare</th>
                        <th class="text-end">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Train 1 -->
                    <tr class="train-row" data-from="PNBE" data-to="HWH">
                        <td>
                            <strong class="d-block text-dark">Patna - Howrah Vande Bharat Express</strong>
                            <small class="badge bg-danger">22348</small>
                        </td>
                        <td>Patna (PNBE) ➔ Howrah (HWH)</td>
                        <td><span class="fw-bold text-success">08:00 AM</span></td>
                        <td><span class="fw-bold text-danger">02:35 PM</span></td>
                        <td>6 hrs 35 min</td>
                        <td><span class="badge bg-light text-dark border">Daily (Except Wed)</span></td>
                        <td><span class="badge bg-secondary">CC, EC</span></td>
                        <td class="fw-bold text-danger">Rs. 1,450</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book</a></td>
                    </tr>
                    <!-- Train 2 -->
                    <tr class="train-row" data-from="PNBE" data-to="GAY">
                        <td>
                            <strong class="d-block text-dark">Patna - Ranchi Jan Shatabdi Express</strong>
                            <small class="badge bg-danger">12365</small>
                        </td>
                        <td>Patna (PNBE) ➔ Gaya Junction (GAY)</td>
                        <td><span class="fw-bold text-success">06:10 AM</span></td>
                        <td><span class="fw-bold text-danger">07:55 AM</span></td>
                        <td>1 hr 45 min</td>
                        <td><span class="badge bg-light text-dark border">Daily</span></td>
                        <td><span class="badge bg-secondary">2S, CC</span></td>
                        <td class="fw-bold text-danger">Rs. 320</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book</a></td>
                    </tr>
                    <!-- Train 3 -->
                    <tr class="train-row" data-from="PNBE" data-to="NDLS">
                        <td>
                            <strong class="d-block text-dark">Patna Tejas Rajdhani Express</strong>
                            <small class="badge bg-danger">12309</small>
                        </td>
                        <td>Patna (PNBE) ➔ New Delhi (NDLS)</td>
                        <td><span class="fw-bold text-success">07:10 PM</span></td>
                        <td><span class="fw-bold text-danger">07:40 AM</span></td>
                        <td>12 hrs 30 min</td>
                        <td><span class="badge bg-light text-dark border">Daily</span></td>
                        <td><span class="badge bg-secondary">1A, 2A, 3A</span></td>
                        <td class="fw-bold text-danger">Rs. 2,150</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book</a></td>
                    </tr>
                    <!-- Train 4 -->
                    <tr class="train-row" data-from="RGD" data-to="NDLS">
                        <td>
                            <strong class="d-block text-dark">Shramjeevi Express</strong>
                            <small class="badge bg-danger">12391</small>
                        </td>
                        <td>Rajgir (RGD) ➔ New Delhi (NDLS) via Patna</td>
                        <td><span class="fw-bold text-success">08:05 AM</span></td>
                        <td><span class="fw-bold text-danger">04:40 AM</span></td>
                        <td>20 hrs 35 min</td>
                        <td><span class="badge bg-light text-dark border">Daily</span></td>
                        <td><span class="badge bg-secondary">1A, 2A, 3A, SL</span></td>
                        <td class="fw-bold text-danger">Rs. 510</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book</a></td>
                    </tr>
                    <!-- Train 5 -->
                    <tr class="train-row" data-from="GAY" data-to="NDLS">
                        <td>
                            <strong class="d-block text-dark">Mahabodhi Express</strong>
                            <small class="badge bg-danger">12397</small>
                        </td>
                        <td>Gaya Junction (GAY) ➔ New Delhi (NDLS)</td>
                        <td><span class="fw-bold text-success">02:00 PM</span></td>
                        <td><span class="fw-bold text-danger">04:10 AM</span></td>
                        <td>14 hrs 10 min</td>
                        <td><span class="badge bg-light text-dark border">Daily</span></td>
                        <td><span class="badge bg-secondary">1A, 2A, 3A, SL</span></td>
                        <td class="fw-bold text-danger">Rs. 495</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book</a></td>
                    </tr>
                    <!-- Train 6 -->
                    <tr class="train-row" data-from="MFP" data-to="HWH">
                        <td>
                            <strong class="d-block text-dark">Mithila Express</strong>
                            <small class="badge bg-danger">13022</small>
                        </td>
                        <td>Muzaffarpur (MFP) ➔ Howrah (HWH)</td>
                        <td><span class="fw-bold text-success">01:45 PM</span></td>
                        <td><span class="fw-bold text-danger">04:00 AM</span></td>
                        <td>14 hrs 15 min</td>
                        <td><span class="badge bg-light text-dark border">Daily</span></td>
                        <td><span class="badge bg-secondary">2A, 3A, SL</span></td>
                        <td class="fw-bold text-danger">Rs. 385</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book</a></td>
                    </tr>
                    <!-- Train 7 -->
                    <tr class="train-row" data-from="BGP" data-to="NDLS">
                        <td>
                            <strong class="d-block text-dark">Vikramshila Express</strong>
                            <small class="badge bg-danger">12367</small>
                        </td>
                        <td>Bhagalpur (BGP) ➔ New Delhi (NDLS)</td>
                        <td><span class="fw-bold text-success">12:00 PM</span></td>
                        <td><span class="fw-bold text-danger">07:20 AM</span></td>
                        <td>19 hrs 20 min</td>
                        <td><span class="badge bg-light text-dark border">Daily</span></td>
                        <td><span class="badge bg-secondary">1A, 2A, 3A, SL</span></td>
                        <td class="fw-bold text-danger">Rs. 575</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- BSRTC Volvo AC Bus Routes Table -->
    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <h4 class="fw-bold text-dark mb-4"><i class="bi bi-bus-front-fill text-primary me-2"></i> BSRTC AC Volvo Express Bus Routes</h4>
        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Bus Service</th>
                        <th>Route</th>
                        <th>Departure Frequency</th>
                        <th>Fare</th>
                        <th class="text-end">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-bold text-dark">BSRTC Volvo AC Luxury Express</td>
                        <td>Patna Bankipur ➔ Bodh Gaya Bus Stand</td>
                        <td>Every 30 Minutes (06:00 AM - 09:00 PM)</td>
                        <td class="fw-bold text-danger">Rs. 220</td>
                        <td class="text-end"><a href="${pageContext.request.contextPath}/cabs" class="btn btn-outline-primary btn-sm font-semibold py-1 px-2.5">Book Seat</a></td>
                    </tr>
                    <tr>
                        <td class="fw-bold text-dark">BSRTC Rajdhani Express Bus</td>
                        <td>Patna ➔ Rajgir Bus Stand</td>
                        <td>Every 45 Minutes (06:30 AM - 08:00 PM)</td>
                        <td class="fw-bold text-danger">Rs. 180</td>
                        <td class="text-end"><a href="${pageContext.request.contextPath}/cabs" class="btn btn-outline-primary btn-sm font-semibold py-1 px-2.5">Book Seat</a></td>
                    </tr>
                    <tr>
                        <td class="fw-bold text-dark">BSRTC Eco Safari Superfast</td>
                        <td>Patna ➔ Valmiki Nagar Safari Stand</td>
                        <td>Daily 06:00 AM & 08:00 PM</td>
                        <td class="fw-bold text-danger">Rs. 450</td>
                        <td class="text-end"><a href="${pageContext.request.contextPath}/cabs" class="btn btn-outline-primary btn-sm font-semibold py-1 px-2.5">Book Seat</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    function filterTrains() {
        var from = document.getElementById("fromStation").value.toUpperCase();
        var to = document.getElementById("toStation").value.toUpperCase();
        var query = document.getElementById("trainSearch").value.toLowerCase();
        
        var rows = document.querySelectorAll(".train-row");
        rows.forEach(function(row) {
            var rowFrom = row.getAttribute("data-from") || "";
            var rowTo = row.getAttribute("data-to") || "";
            var text = row.innerText.toLowerCase();
            
            var matchFrom = !from || rowFrom.includes(from);
            var matchTo = !to || rowTo.includes(to);
            var matchQuery = !query || text.includes(query);
            
            if (matchFrom && matchTo && matchQuery) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    }
</script>

<%@ include file="/views/common/footer.jsp" %>

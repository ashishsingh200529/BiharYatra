<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-gradient-to-r from-dark to-danger text-white py-5">
    <div class="container text-center py-3">
        <span class="badge bg-warning text-dark px-3 py-2 rounded-pill mb-3 font-semibold"><i class="bi bi-train-front-fill me-1"></i> Indian Railways & BSRTC Transit Finder</span>
        <h1 class="fw-bold display-4 mb-2">Bihar IRCTC Train & Bus Timetable</h1>
        <p class="lead text-white-50 max-w-2xl mx-auto mb-0">Search all Vande Bharat, Rajdhani, Shatabdi, Amrit Bharat, Jan Shatabdi, Garib Rath, and Intercity trains connecting Bihar hubs.</p>
    </div>
</div>

<div class="container my-5">
    
    <!-- IRCTC Live PNR & Seat Availability Widget -->
    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm mb-4">
        <h5 class="fw-bold text-dark mb-3"><i class="bi bi-ticket-perforated-fill text-danger me-1"></i> IRCTC PNR Status & Seat Availability Quick Check</h5>
        <form action="https://www.irctc.co.in/nget/booking/pnr-enquiry" target="_blank" method="GET" class="row g-3 align-items-center">
            <div class="col-md-5">
                <label class="form-label font-semibold text-dark small">Enter 10-Digit PNR Number</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="bi bi-card-text"></i></span>
                    <input type="text" class="form-control" name="pnr" placeholder="e.g. 2415678901" maxlength="10" />
                </div>
            </div>
            <div class="col-md-4">
                <label class="form-label font-semibold text-dark small">Check Service</label>
                <select class="form-select">
                    <option>Live PNR Status</option>
                    <option>Seat Availability & Fare</option>
                    <option>Live Running Status (NTES)</option>
                </select>
            </div>
            <div class="col-md-3 mt-md-4">
                <button type="submit" class="btn btn-brand w-100 py-2.5 font-semibold"><i class="bi bi-box-arrow-up-right me-1"></i> Check on IRCTC</button>
            </div>
        </form>
    </div>

    <!-- Train Route Filter & Search Bar -->
    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm mb-4">
        <h5 class="fw-bold text-dark mb-3"><i class="bi bi-search text-danger me-1"></i> Search Bihar Trains Between Stations</h5>
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
                    <option value="RJPB">Rajendra Nagar (RJPB)</option>
                </select>
            </div>
            <div class="col-md-4">
                <label class="form-label font-semibold text-dark small">To Station</label>
                <select id="toStation" class="form-select" onchange="filterTrains()">
                    <option value="">All Destination Stations</option>
                    <option value="NDLS">New Delhi / ANVT (NDLS)</option>
                    <option value="HWH">Howrah / Kolkata (HWH)</option>
                    <option value="GAY">Gaya Junction (GAY)</option>
                    <option value="RGD">Rajgir (RGD)</option>
                    <option value="PNBE">Patna Junction (PNBE)</option>
                    <option value="LKO">Lucknow Charbagh (LKO)</option>
                    <option value="RNC">Ranchi (RNC)</option>
                    <option value="JAT">Jammu Tawi (JAT)</option>
                </select>
            </div>
            <div class="col-md-4">
                <label class="form-label font-semibold text-dark small">Filter by Category / Name</label>
                <input type="text" id="trainSearch" class="form-control" placeholder="e.g. Vande Bharat, Rajdhani, 12309..." onkeyup="filterTrains()" />
            </div>
        </div>
    </div>

    <!-- Complete Bihar IRCTC Train Timetable Table -->
    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <span class="badge bg-danger mb-1">Official IRCTC Schedule</span>
                <h4 class="fw-bold text-dark mb-0"><i class="bi bi-train-front-fill text-danger me-2"></i> All IRCTC Bihar Trains (Vande Bharat, Rajdhani, Express)</h4>
            </div>
            <a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm rounded-pill font-semibold px-3"><i class="bi bi-box-arrow-up-right me-1"></i> IRCTC Ticket Booking</a>
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
                        <th>Fare</th>
                        <th class="text-end">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Train 1 -->
                    <tr class="train-row" data-from="PNBE" data-to="HWH">
                        <td>
                            <strong class="d-block text-dark">Patna - Howrah Vande Bharat Express</strong>
                            <span class="badge bg-danger">22348</span> <span class="badge bg-warning text-dark">Vande Bharat</span>
                        </td>
                        <td>Patna (PNBE) ➔ Howrah (HWH)</td>
                        <td><span class="fw-bold text-success">08:00 AM</span></td>
                        <td><span class="fw-bold text-danger">02:35 PM</span></td>
                        <td>6 hrs 35 min</td>
                        <td><span class="badge bg-light text-dark border">Daily (Ex. Wed)</span></td>
                        <td><span class="badge bg-secondary">CC, EC</span></td>
                        <td class="fw-bold text-danger">Rs. 1,450</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book IRCTC</a></td>
                    </tr>
                    <!-- Train 2 -->
                    <tr class="train-row" data-from="PNBE" data-to="RNC">
                        <td>
                            <strong class="d-block text-dark">Patna - Ranchi Vande Bharat Express</strong>
                            <span class="badge bg-danger">22349</span> <span class="badge bg-warning text-dark">Vande Bharat</span>
                        </td>
                        <td>Patna (PNBE) ➔ Gaya ➔ Ranchi (RNC)</td>
                        <td><span class="fw-bold text-success">07:00 AM</span></td>
                        <td><span class="fw-bold text-danger">01:00 PM</span></td>
                        <td>6 hrs 00 min</td>
                        <td><span class="badge bg-light text-dark border">Daily (Ex. Tue)</span></td>
                        <td><span class="badge bg-secondary">CC, EC</span></td>
                        <td class="fw-bold text-danger">Rs. 1,245</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book IRCTC</a></td>
                    </tr>
                    <!-- Train 3 -->
                    <tr class="train-row" data-from="PNBE" data-to="LKO">
                        <td>
                            <strong class="d-block text-dark">Patna - Lucknow Vande Bharat Express</strong>
                            <span class="badge bg-danger">22345</span> <span class="badge bg-warning text-dark">Vande Bharat</span>
                        </td>
                        <td>Patna (PNBE) ➔ Ayodhya ➔ Lucknow (LKO)</td>
                        <td><span class="fw-bold text-success">06:05 AM</span></td>
                        <td><span class="fw-bold text-danger">02:30 PM</span></td>
                        <td>8 hrs 25 min</td>
                        <td><span class="badge bg-light text-dark border">Daily (Ex. Fri)</span></td>
                        <td><span class="badge bg-secondary">CC, EC</span></td>
                        <td class="fw-bold text-danger">Rs. 1,540</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book IRCTC</a></td>
                    </tr>
                    <!-- Train 4 -->
                    <tr class="train-row" data-from="PNBE" data-to="NDLS">
                        <td>
                            <strong class="d-block text-dark">Patna Tejas Rajdhani Express</strong>
                            <span class="badge bg-danger">12309</span> <span class="badge bg-dark text-white">Rajdhani</span>
                        </td>
                        <td>Patna (PNBE) ➔ New Delhi (NDLS)</td>
                        <td><span class="fw-bold text-success">07:10 PM</span></td>
                        <td><span class="fw-bold text-danger">07:40 AM</span></td>
                        <td>12 hrs 30 min</td>
                        <td><span class="badge bg-light text-dark border">Daily</span></td>
                        <td><span class="badge bg-secondary">1A, 2A, 3A</span></td>
                        <td class="fw-bold text-danger">Rs. 2,150</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book IRCTC</a></td>
                    </tr>
                    <!-- Train 5 -->
                    <tr class="train-row" data-from="RJPB" data-to="NDLS">
                        <td>
                            <strong class="d-block text-dark">Sampoorna Kranti Express</strong>
                            <span class="badge bg-danger">12393</span> <span class="badge bg-primary">Superfast</span>
                        </td>
                        <td>Rajendra Nagar (RJPB) ➔ Patna ➔ New Delhi (NDLS)</td>
                        <td><span class="fw-bold text-success">07:25 PM</span></td>
                        <td><span class="fw-bold text-danger">07:55 AM</span></td>
                        <td>12 hrs 30 min</td>
                        <td><span class="badge bg-light text-dark border">Daily</span></td>
                        <td><span class="badge bg-secondary">1A, 2A, 3A, SL</span></td>
                        <td class="fw-bold text-danger">Rs. 515</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book IRCTC</a></td>
                    </tr>
                    <!-- Train 6 -->
                    <tr class="train-row" data-from="PNBE" data-to="GAY">
                        <td>
                            <strong class="d-block text-dark">Patna - Ranchi Jan Shatabdi Express</strong>
                            <span class="badge bg-danger">12365</span> <span class="badge bg-info text-dark">Jan Shatabdi</span>
                        </td>
                        <td>Patna (PNBE) ➔ Gaya Junction (GAY)</td>
                        <td><span class="fw-bold text-success">06:10 AM</span></td>
                        <td><span class="fw-bold text-danger">07:55 AM</span></td>
                        <td>1 hr 45 min</td>
                        <td><span class="badge bg-light text-dark border">Daily</span></td>
                        <td><span class="badge bg-secondary">2S, CC</span></td>
                        <td class="fw-bold text-danger">Rs. 320</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book IRCTC</a></td>
                    </tr>
                    <!-- Train 7 -->
                    <tr class="train-row" data-from="RGD" data-to="NDLS">
                        <td>
                            <strong class="d-block text-dark">Shramjeevi Express</strong>
                            <span class="badge bg-danger">12391</span> <span class="badge bg-primary">Express</span>
                        </td>
                        <td>Rajgir (RGD) ➔ Patna ➔ New Delhi (NDLS)</td>
                        <td><span class="fw-bold text-success">08:05 AM</span></td>
                        <td><span class="fw-bold text-danger">04:40 AM</span></td>
                        <td>20 hrs 35 min</td>
                        <td><span class="badge bg-light text-dark border">Daily</span></td>
                        <td><span class="badge bg-secondary">1A, 2A, 3A, SL</span></td>
                        <td class="fw-bold text-danger">Rs. 510</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book IRCTC</a></td>
                    </tr>
                    <!-- Train 8 -->
                    <tr class="train-row" data-from="GAY" data-to="NDLS">
                        <td>
                            <strong class="d-block text-dark">Mahabodhi Express</strong>
                            <span class="badge bg-danger">12397</span> <span class="badge bg-primary">Superfast</span>
                        </td>
                        <td>Gaya Junction (GAY) ➔ New Delhi (NDLS)</td>
                        <td><span class="fw-bold text-success">02:00 PM</span></td>
                        <td><span class="fw-bold text-danger">04:10 AM</span></td>
                        <td>14 hrs 10 min</td>
                        <td><span class="badge bg-light text-dark border">Daily</span></td>
                        <td><span class="badge bg-secondary">1A, 2A, 3A, SL</span></td>
                        <td class="fw-bold text-danger">Rs. 495</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book IRCTC</a></td>
                    </tr>
                    <!-- Train 9 -->
                    <tr class="train-row" data-from="DBG" data-to="NDLS">
                        <td>
                            <strong class="d-block text-dark">Bihar Sampark Kranti Express</strong>
                            <span class="badge bg-danger">12565</span> <span class="badge bg-primary">Superfast</span>
                        </td>
                        <td>Darbhanga (DBG) ➔ Muzaffarpur ➔ New Delhi (NDLS)</td>
                        <td><span class="fw-bold text-success">08:25 AM</span></td>
                        <td><span class="fw-bold text-danger">05:15 AM</span></td>
                        <td>20 hrs 50 min</td>
                        <td><span class="badge bg-light text-dark border">Daily</span></td>
                        <td><span class="badge bg-secondary">1A, 2A, 3A, SL</span></td>
                        <td class="fw-bold text-danger">Rs. 545</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book IRCTC</a></td>
                    </tr>
                    <!-- Train 10 -->
                    <tr class="train-row" data-from="DBG" data-to="NDLS">
                        <td>
                            <strong class="d-block text-dark">Darbhanga - Anand Vihar Amrit Bharat</strong>
                            <span class="badge bg-danger">15557</span> <span class="badge bg-success">Amrit Bharat</span>
                        </td>
                        <td>Darbhanga (DBG) ➔ Ayodhya ➔ Anand Vihar (NDLS)</td>
                        <td><span class="fw-bold text-success">03:00 PM</span></td>
                        <td><span class="fw-bold text-danger">12:35 PM</span></td>
                        <td>21 hrs 35 min</td>
                        <td><span class="badge bg-light text-dark border">Mon, Thu</span></td>
                        <td><span class="badge bg-secondary">SL, 2S</span></td>
                        <td class="fw-bold text-danger">Rs. 460</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book IRCTC</a></td>
                    </tr>
                    <!-- Train 11 -->
                    <tr class="train-row" data-from="RJPB" data-to="NDLS">
                        <td>
                            <strong class="d-block text-dark">Garib Rath Express</strong>
                            <span class="badge bg-danger">12353</span> <span class="badge bg-info text-dark">Garib Rath</span>
                        </td>
                        <td>Rajendra Nagar (RJPB) ➔ Anand Vihar (NDLS)</td>
                        <td><span class="fw-bold text-success">07:45 PM</span></td>
                        <td><span class="fw-bold text-danger">09:50 AM</span></td>
                        <td>14 hrs 05 min</td>
                        <td><span class="badge bg-light text-dark border">Tue, Sat</span></td>
                        <td><span class="badge bg-secondary">3A AC</span></td>
                        <td class="fw-bold text-danger">Rs. 895</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book IRCTC</a></td>
                    </tr>
                    <!-- Train 12 -->
                    <tr class="train-row" data-from="PNBE" data-to="JAT">
                        <td>
                            <strong class="d-block text-dark">Archana Express</strong>
                            <span class="badge bg-danger">12355</span> <span class="badge bg-primary">Express</span>
                        </td>
                        <td>Patna (PNBE) ➔ Jammu Tawi (JAT)</td>
                        <td><span class="fw-bold text-success">07:30 PM</span></td>
                        <td><span class="fw-bold text-danger">10:20 PM</span></td>
                        <td>26 hrs 50 min</td>
                        <td><span class="badge bg-light text-dark border">Tue, Sat</span></td>
                        <td><span class="badge bg-secondary">1A, 2A, 3A, SL</span></td>
                        <td class="fw-bold text-danger">Rs. 690</td>
                        <td class="text-end"><a href="https://www.irctc.co.in" target="_blank" class="btn btn-brand btn-sm font-semibold py-1 px-2">Book IRCTC</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- BSRTC Volvo AC Bus Routes Table -->
    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <span class="badge bg-primary mb-1">State Transport & Online Partners</span>
                <h4 class="fw-bold text-dark mb-0"><i class="bi bi-bus-front-fill text-primary me-2"></i> BSRTC AC Volvo Express & Online Bus Booking</h4>
            </div>
            <div class="d-flex gap-2">
                <a href="https://www.redbus.in" target="_blank" class="btn btn-danger btn-sm rounded-pill font-semibold px-3"><i class="bi bi-box-arrow-up-right me-1"></i> Book on RedBus</a>
                <a href="https://www.makemytrip.com/bus-tickets/" target="_blank" class="btn btn-primary btn-sm rounded-pill font-semibold px-3"><i class="bi bi-box-arrow-up-right me-1"></i> Book on MakeMyTrip</a>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Bus Service</th>
                        <th>Route</th>
                        <th>Departure Frequency</th>
                        <th>Fare</th>
                        <th class="text-end">Online Booking Partners</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-bold text-dark">BSRTC Volvo AC Luxury Express</td>
                        <td>Patna Bankipur ➔ Bodh Gaya Bus Stand</td>
                        <td>Every 30 Minutes (06:00 AM - 09:00 PM)</td>
                        <td class="fw-bold text-danger">Rs. 220</td>
                        <td class="text-end">
                            <div class="d-flex gap-1 justify-content-end">
                                <a href="https://www.redbus.in/bus-tickets/patna-to-bodhgaya" target="_blank" class="btn btn-danger btn-sm font-semibold py-1 px-2">RedBus</a>
                                <a href="https://www.makemytrip.com/bus-tickets/patna-bodh-gaya-bus-booking.html" target="_blank" class="btn btn-primary btn-sm font-semibold py-1 px-2">MakeMyTrip</a>
                                <a href="${pageContext.request.contextPath}/cabs" class="btn btn-outline-dark btn-sm font-semibold py-1 px-2">BiharYatra</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="fw-bold text-dark">BSRTC Rajdhani Express Bus</td>
                        <td>Patna ➔ Rajgir Bus Stand</td>
                        <td>Every 45 Minutes (06:30 AM - 08:00 PM)</td>
                        <td class="fw-bold text-danger">Rs. 180</td>
                        <td class="text-end">
                            <div class="d-flex gap-1 justify-content-end">
                                <a href="https://www.redbus.in/bus-tickets/patna-to-rajgir" target="_blank" class="btn btn-danger btn-sm font-semibold py-1 px-2">RedBus</a>
                                <a href="https://www.makemytrip.com/bus-tickets/patna-rajgir-bus-booking.html" target="_blank" class="btn btn-primary btn-sm font-semibold py-1 px-2">MakeMyTrip</a>
                                <a href="${pageContext.request.contextPath}/cabs" class="btn btn-outline-dark btn-sm font-semibold py-1 px-2">BiharYatra</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="fw-bold text-dark">BSRTC Eco Safari Superfast</td>
                        <td>Patna ➔ Valmiki Nagar Safari Stand</td>
                        <td>Daily 06:00 AM & 08:00 PM</td>
                        <td class="fw-bold text-danger">Rs. 450</td>
                        <td class="text-end">
                            <div class="d-flex gap-1 justify-content-end">
                                <a href="https://www.redbus.in" target="_blank" class="btn btn-danger btn-sm font-semibold py-1 px-2">RedBus</a>
                                <a href="https://www.makemytrip.com/bus-tickets/" target="_blank" class="btn btn-primary btn-sm font-semibold py-1 px-2">MakeMyTrip</a>
                                <a href="${pageContext.request.contextPath}/cabs" class="btn btn-outline-dark btn-sm font-semibold py-1 px-2">BiharYatra</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="fw-bold text-dark">BSRTC Intercity Deluxe Sleeper</td>
                        <td>Muzaffarpur ➔ Gaya ➔ Ranchi</td>
                        <td>Daily 07:30 PM & 09:30 PM</td>
                        <td class="fw-bold text-danger">Rs. 550</td>
                        <td class="text-end">
                            <div class="d-flex gap-1 justify-content-end">
                                <a href="https://www.redbus.in" target="_blank" class="btn btn-danger btn-sm font-semibold py-1 px-2">RedBus</a>
                                <a href="https://www.makemytrip.com/bus-tickets/" target="_blank" class="btn btn-primary btn-sm font-semibold py-1 px-2">MakeMyTrip</a>
                                <a href="${pageContext.request.contextPath}/cabs" class="btn btn-outline-dark btn-sm font-semibold py-1 px-2">BiharYatra</a>
                            </div>
                        </td>
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

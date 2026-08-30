<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-dark text-white py-5">
    <div class="container text-center py-3">
        <span class="badge bg-warning text-dark px-3 py-2 rounded-pill mb-3 font-semibold"><i class="bi bi-bus-front-fill me-1"></i> Transit Route Finder</span>
        <h1 class="fw-bold display-4 mb-2">Bihar Bus & Train Schedules</h1>
        <p class="lead text-white-50 max-w-2xl mx-auto mb-0">Check schedules for BSRTC AC Buses, Vande Bharat Express, and Intercity trains connecting Bihar hubs.</p>
    </div>
</div>

<div class="container my-5">
    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm mb-5">
        <h4 class="fw-bold text-dark mb-4"><i class="bi bi-train-front-fill text-danger me-2"></i> High-Speed Train Connections</h4>
        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Train Name & No</th>
                        <th>Origin ➔ Destination</th>
                        <th>Departure</th>
                        <th>Duration</th>
                        <th>Fare (Chair Car)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-bold text-dark">Patna - Howrah Vande Bharat (22348)</td>
                        <td>Patna (PNBE) ➔ Gaya (GAY)</td>
                        <td>08:00 AM</td>
                        <td>1 hr 25 min</td>
                        <td class="fw-bold text-danger">Rs. 650</td>
                    </tr>
                    <tr>
                        <td class="fw-bold text-dark">Patna - Ranchi Jan Shatabdi (12365)</td>
                        <td>Patna (PNBE) ➔ Gaya (GAY)</td>
                        <td>06:10 AM</td>
                        <td>1 hr 45 min</td>
                        <td class="fw-bold text-danger">Rs. 320</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <h4 class="fw-bold text-dark mb-4"><i class="bi bi-bus-front-fill text-primary me-2"></i> BSRTC AC Volvo Express Bus Routes</h4>
        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Bus Service</th>
                        <th>Route</th>
                        <th>Frequency</th>
                        <th>Fare</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-bold text-dark">BSRTC Volvo AC Express</td>
                        <td>Patna Bankipur ➔ Bodh Gaya Bus Stand</td>
                        <td>Every 30 Minutes</td>
                        <td class="fw-bold text-danger">Rs. 220</td>
                    </tr>
                    <tr>
                        <td class="fw-bold text-dark">BSRTC Rajdhani Express Bus</td>
                        <td>Patna ➔ Rajgir Bus Stand</td>
                        <td>Every 45 Minutes</td>
                        <td class="fw-bold text-danger">Rs. 180</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

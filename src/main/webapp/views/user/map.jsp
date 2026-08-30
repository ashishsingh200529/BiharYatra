<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<!-- Leaflet CSS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />

<div class="bg-light py-4 border-bottom">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h2 class="fw-bold text-dark mb-1"><i class="bi bi-map-fill text-danger me-2"></i> Bihar Tourism Interactive Map</h2>
                <p class="text-muted mb-0 small">Explore 18+ heritage monuments, Buddhist stupas, national parks, and waterfalls across Bihar.</p>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/packages" class="btn btn-brand btn-sm"><i class="bi bi-bag-check me-1"></i> View All Packages</a>
            </div>
        </div>
    </div>
</div>

<div class="container my-4">
    <div class="row g-4">
        <!-- Sidebar Controls & Distance Calculator -->
        <div class="col-lg-4">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm mb-4">
                <h5 class="fw-bold text-dark mb-3"><i class="bi bi-funnel-fill text-danger me-1"></i> Filter by District</h5>
                <div class="d-flex flex-wrap gap-1.5 mb-4" id="district-filters">
                    <button class="btn btn-sm btn-danger active-filter px-3 rounded-pill" data-district="ALL">All Bihar</button>
                    <button class="btn btn-sm btn-outline-secondary px-3 rounded-pill" data-district="Patna">Patna</button>
                    <button class="btn btn-sm btn-outline-secondary px-3 rounded-pill" data-district="Nalanda">Nalanda</button>
                    <button class="btn btn-sm btn-outline-secondary px-3 rounded-pill" data-district="Gaya">Gaya</button>
                    <button class="btn btn-sm btn-outline-secondary px-3 rounded-pill" data-district="Rohtas">Rohtas</button>
                    <button class="btn btn-sm btn-outline-secondary px-3 rounded-pill" data-district="Kaimur">Kaimur</button>
                    <button class="btn btn-sm btn-outline-secondary px-3 rounded-pill" data-district="Bhagalpur">Bhagalpur</button>
                    <button class="btn btn-sm btn-outline-secondary px-3 rounded-pill" data-district="Nawada">Nawada</button>
                </div>

                <hr>

                <h5 class="fw-bold text-dark mb-3"><i class="bi bi-signpost-2-fill text-danger me-1"></i> Distance & Travel Time Estimator</h5>
                <div class="mb-3">
                    <label class="form-label small font-semibold text-muted">Starting Point</label>
                    <input type="text" class="form-control form-control-sm bg-light" value="Patna Junction / Airport" readonly />
                </div>
                <div class="mb-3">
                    <label class="form-label small font-semibold text-dark">Select Destination</label>
                    <select class="form-select form-select-sm" id="calc-destination">
                        <c:forEach var="place" items="${places}">
                            <option value="${place.latitude},${place.longitude}">${place.name} (${place.district})</option>
                        </c:forEach>
                    </select>
                </div>
                <button class="btn btn-danger w-100 btn-sm font-semibold" id="btn-calc-distance"><i class="bi bi-calculator me-1"></i> Calculate Distance</button>

                <div id="calc-result" class="mt-3 p-3 bg-light rounded-3 border d-none">
                    <div class="d-flex justify-content-between small mb-1">
                        <span class="text-muted">Est. Distance:</span>
                        <strong class="text-danger" id="res-distance">-- km</strong>
                    </div>
                    <div class="d-flex justify-content-between small">
                        <span class="text-muted">Est. Drive Time:</span>
                        <strong class="text-dark" id="res-time">-- hrs</strong>
                    </div>
                </div>
            </div>
        </div>

        <!-- Map Container -->
        <div class="col-lg-8">
            <div class="glass-card border bg-white rounded-4 shadow-sm overflow-hidden">
                <div id="bihar-map" style="height: 580px; width: 100%;"></div>
            </div>
        </div>
    </div>
</div>

<!-- Leaflet JS -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Initialize Map centered on Bihar
        var map = L.map('bihar-map').setView([25.3, 85.3], 8);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 18,
            attribution: '© BiharYatra Tourism Portal | OpenStreetMap'
        }).addTo(map);

        var markers = [];
        var placesData = [
            <c:forEach var="place" items="${places}" varStatus="loop">
                {
                    id: ${place.id},
                    name: "${place.name}",
                    district: "${place.district}",
                    desc: "${place.description}",
                    lat: ${place.latitude},
                    lng: ${place.longitude},
                    img: "${place.imageUrl}",
                    bestTime: "${place.bestTimeToVisit}"
                }<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];

        // Red Custom Marker Icon
        var redIcon = L.icon({
            iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
            shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
            iconSize: [25, 41],
            iconAnchor: [12, 41],
            popupAnchor: [1, -34],
            shadowSize: [41, 41]
        });

        // Add markers to map
        placesData.forEach(function(p) {
            var popupContent = `
                <div style="width: 220px;" class="p-1">
                    <img src="` + p.img + `" style="width: 100%; height: 110px; object-fit: cover; border-radius: 8px;" class="mb-2" />
                    <span class="badge bg-danger mb-1">` + p.district + `</span>
                    <h6 style="font-weight: bold; margin-bottom: 4px; font-size: 14px;">` + p.name + `</h6>
                    <p style="font-size: 11px; color: #555; margin-bottom: 8px; line-height: 1.3;">` + p.desc.substring(0, 75) + `...</p>
                    <div style="font-size: 10px; color: #888;" class="mb-2">Best Visit: ` + p.bestTime + `</div>
                    <a href="${pageContext.request.contextPath}/packages" class="btn btn-danger btn-sm text-white w-100 py-1" style="font-size: 11px;">View Tour Packages</a>
                </div>
            `;

            var marker = L.marker([p.lat, p.lng], {icon: redIcon}).addTo(map)
                .bindPopup(popupContent);
            marker.district = p.district;
            markers.push(marker);
        });

        // District filter clicks
        document.querySelectorAll("#district-filters button").forEach(function(btn) {
            btn.addEventListener("click", function() {
                document.querySelectorAll("#district-filters button").forEach(b => {
                    b.classList.remove("btn-danger");
                    b.classList.add("btn-outline-secondary");
                });
                btn.classList.remove("btn-outline-secondary");
                btn.classList.add("btn-danger");

                var dist = btn.getAttribute("data-district");
                markers.forEach(function(m) {
                    if (dist === "ALL" || m.district.toLowerCase() === dist.toLowerCase()) {
                        m.addTo(map);
                    } else {
                        map.removeLayer(m);
                    }
                });
            });
        });

        // Distance Estimator logic
        var patnaLat = 25.6092, patnaLng = 85.1235; // Patna Junction
        document.getElementById("btn-calc-distance").addEventListener("click", function() {
            var val = document.getElementById("calc-destination").value.split(",");
            var destLat = parseFloat(val[0]);
            var destLng = parseFloat(val[1]);

            // Haversine formula distance
            var R = 6371; // km
            var dLat = (destLat - patnaLat) * Math.PI / 180;
            var dLon = (destLng - patnaLng) * Math.PI / 180;
            var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                    Math.cos(patnaLat * Math.PI / 180) * Math.cos(destLat * Math.PI / 180) *
                    Math.sin(dLon/2) * Math.sin(dLon/2);
            var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
            var directKm = R * c;
            var roadKm = Math.round(directKm * 1.25); // Approximate road factor
            var hours = (roadKm / 45).toFixed(1); // Avg 45 km/h speed

            document.getElementById("res-distance").innerText = roadKm + " km";
            document.getElementById("res-time").innerText = hours + " hrs";
            document.getElementById("calc-result").classList.remove("d-none");
        });
    });
</script>

<%@ include file="/views/common/footer.jsp" %>

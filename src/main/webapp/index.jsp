<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.biharyatri.dao.PackageDAO" %>
<%@ page import="com.biharyatri.dao.PlaceDAO" %>
<%@ page import="com.biharyatri.model.TourPackage" %>
<%@ page import="com.biharyatri.model.Place" %>
<%@ page import="java.util.List" %>

<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<%
    // Instantiate DAOs directly for homepage dynamic loading
    PackageDAO packageDAO = new PackageDAO();
    PlaceDAO placeDAO = new PlaceDAO();
    
    List<TourPackage> featuredPkgs = packageDAO.getFeaturedPackages();
    List<Place> placesList = placeDAO.getAllPlaces();
%>

<!-- HERO BANNER -->
<section class="hero-section text-center">
    <div class="container">
        <h1 class="hero-title mb-3">Explore the Historic Majesty of Bihar</h1>
        <p class="lead mb-5 text-light" style="max-width: 700px; margin: 0 auto;">
            From the roots of ancient wisdom in Nalanda and spiritual enlightenment in Bodh Gaya, to eco-safaris in Valmiki. Start your journey today!
        </p>
        
        <!-- Search bar widget -->
        <div class="row justify-content-center">
            <div class="col-md-8">
                <form action="${pageContext.request.contextPath}/packages" method="GET" class="glass-card p-3 d-flex flex-column flex-md-row gap-2">
                    <input type="text" name="search" class="form-control border-0 bg-transparent py-2" placeholder="Search destinations (e.g. Gaya, Nalanda, Rajgir...)" />
                    <select name="startLocation" class="form-select border-0 bg-transparent py-2">
                        <option value="">Start Point</option>
                        <option value="Patna">From Patna</option>
                        <option value="Gorakhpur">From Gorakhpur</option>
                    </select>
                    <button type="submit" class="btn btn-brand px-4 py-2 text-nowrap"><i class="bi bi-search me-1"></i> Find Tours</button>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- MAIN CONTENT WRAPPER -->
<div class="container my-5">
    
    <!-- FEATURED TOUR PACKAGES SECTION -->
    <section class="mb-5">
        <div class="d-flex justify-content-between align-items-end mb-4">
            <div>
                <span class="text-uppercase text-danger fw-bold tracking-wider" style="font-size: 13px;">Handpicked Experiences</span>
                <h2 class="fw-bold mb-0">Popular Tour Packages</h2>
            </div>
            <a href="${pageContext.request.contextPath}/packages" class="text-decoration-none fw-bold text-danger">View All Packages <i class="bi bi-arrow-right"></i></a>
        </div>
        
        <div class="row g-4">
            <%
                if (featuredPkgs != null && !featuredPkgs.isEmpty()) {
                    for (TourPackage pkg : featuredPkgs) {
                        String primaryImage = pkg.getImageUrls().isEmpty() ? "https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?auto=format&fit=crop&w=800&q=80" : pkg.getImageUrls().get(0);
            %>
            <div class="col-lg-3 col-md-6">
                <div class="card h-100 border-0 shadow-sm glass-card overflow-hidden">
                    <div style="height: 180px; overflow: hidden; position: relative;">
                        <img src="<%= primaryImage %>" class="w-100 h-100" style="object-fit: cover;" alt="<%= pkg.getTitle() %>">
                        <span class="badge bg-warning text-dark position-absolute top-3 right-3 shadow-sm" style="right: 15px; top: 15px;">
                            <%= pkg.getDifficulty() %>
                        </span>
                    </div>
                    <div class="card-body d-flex flex-column p-4">
                        <span class="text-muted small mb-2"><i class="bi bi-clock me-1"></i> <%= pkg.getDurationDays() %> Days / <%= pkg.getDurationNights() %> Nights</span>
                        <h5 class="card-title fw-bold text-dark mb-3"><%= pkg.getTitle() %></h5>
                        <p class="card-text text-muted small flex-grow-1" style="display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;">
                            <%= pkg.getDescription() %>
                        </p>
                        <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                            <div>
                                <small class="text-muted block" style="font-size: 10px;">Starting From</small>
                                <span class="fw-bold text-danger fs-5">Rs. <%= String.format("%.2f", pkg.getPrice()) %></span>
                            </div>
                            <a href="${pageContext.request.contextPath}/package-details?id=<%= pkg.getId() %>" class="btn btn-brand btn-sm">Details</a>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="col-12">
                <div class="alert alert-info text-center">No packages are currently featured. Check out the <a href="${pageContext.request.contextPath}/packages">Packages Catalog</a>.</div>
            </div>
            <%
                }
            %>
        </div>
    </section>

    <!-- INTERACTIVE MAP & WEATHER SIDE-BY-SIDE SECTION -->
    <section class="row g-4 my-5 pt-3" id="interactive-map-section">
        <!-- Interactive Bihar Map (Left Column) -->
        <div class="col-lg-8">
            <div class="glass-card p-4 h-100">
                <span class="text-uppercase text-danger fw-bold tracking-wider" style="font-size: 13px;">Geo Exploration</span>
                <h3 class="fw-bold mb-3">Interactive Bihar Travel Map</h3>
                <p class="text-muted small mb-4">Click on any marker pin to explore the destinations, read summary reviews, and look up guided packages.</p>
                <div id="bihar-map"></div>
            </div>
        </div>
        
        <!-- Live District Weather (Right Column) -->
        <div class="col-lg-4">
            <div class="glass-card p-4 h-100 d-flex flex-column justify-content-between">
                <div>
                    <span class="text-uppercase text-danger fw-bold tracking-wider" style="font-size: 13px;">Real-Time Weather</span>
                    <h3 class="fw-bold mb-3">District Climate Monitor</h3>
                    <p class="text-muted small mb-4">Get real-time updates on weather condition, humidity, and temperature for planning your trip.</p>
                    
                    <!-- Dropdown selection of districts -->
                    <div class="mb-4">
                        <label class="form-label font-semibold text-dark">Select District Hub</label>
                        <select id="weather-district-select" class="form-select bg-light border-0 py-2.5">
                            <option value="Patna" selected>Patna (Capital)</option>
                            <option value="Gaya">Gaya (Spiritual)</option>
                            <option value="Nalanda">Nalanda (Heritage)</option>
                            <option value="Rajgir">Rajgir (Nature/Wellness)</option>
                            <option value="West Champaran">West Champaran (Eco-Safari)</option>
                            <option value="Rohtas">Rohtas (Forts/Waterfalls)</option>
                        </select>
                    </div>
                </div>
                
                <!-- Weather Details Display Card -->
                <div class="bg-light p-4 rounded-4 text-center my-3 border shadow-sm">
                    <i class="bi bi-cloud-sun-fill text-warning display-4 mb-2"></i>
                    <h2 id="weather-temp" class="fw-bold text-dark mb-1">--°C</h2>
                    <h5 id="weather-condition" class="text-muted text-capitalize mb-2">Loading...</h5>
                    <span id="weather-city" class="badge bg-danger px-3 py-2 rounded-pill fs-6">Patna</span>
                    <hr class="my-3">
                    <span id="weather-humidity" class="small text-muted font-medium">Humidity: --%</span>
                </div>
                
                <div class="alert alert-warning border-0 small mb-0 mt-2">
                    <i class="bi bi-info-circle-fill me-1"></i> Best season to travel across most hubs is between <strong>October and March</strong>.
                </div>
            </div>
        </div>
    </section>
</div>

<!-- LEAFLET MAP DYNAMIC MARKERS LOADER -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Initialize Map centered on Bihar
        var map = L.map('bihar-map').setView([25.0961, 85.3131], 8);
        
        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);

        // Custom Terracotta marker color
        var greenIcon = new L.Icon({
          iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-orange.png',
          shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
          iconSize: [25, 41],
          iconAnchor: [12, 41],
          popupAnchor: [1, -34],
          shadowSize: [41, 41]
        });

        // Parse places list from JSP DB collection
        <%
            if (placesList != null) {
                for (Place place : placesList) {
        %>
            var marker = L.marker([<%= place.getLatitude() %>, <%= place.getLongitude() %>], {icon: greenIcon}).addTo(map);
            var popupContent = `
                <div style="width: 180px;">
                    <img src="<%= place.getImageUrl() %>" class="w-100 rounded mb-2" style="height: 90px; object-fit: cover;" />
                    <h6 class="fw-bold mb-0 text-dark"><%= place.getName() %></h6>
                    <small class="text-danger block mb-2"><i class="bi bi-geo-alt-fill"></i> <%= place.getDistrict() %></small>
                    <p class="text-muted mb-2" style="font-size: 11px; line-height: 1.3;"><%= place.getDescription().replace("'", "\\'") %></p>
                    <a href="${pageContext.request.contextPath}/packages?search=<%= place.getDistrict() %>" class="btn btn-brand btn-sm text-white w-100 py-1" style="font-size: 11px;">Search Packages</a>
                </div>
            `;
            marker.bindPopup(popupContent);
        <%
                }
            }
        %>
    });
</script>

<%@ include file="/views/common/footer.jsp" %>

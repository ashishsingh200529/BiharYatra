<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<!-- Link Chart.js for Admin Analytics Visuals -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="container my-5">
    
    <!-- Header Banner -->
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
        <div>
            <h2 class="fw-bold text-dark mb-0"><i class="bi bi-person-workspace text-danger me-1"></i> Admin Management Hub</h2>
            <small class="text-muted">Monitor registrations, transaction reports, package updates, and chatbot audits</small>
        </div>
        <div class="mt-2 mt-md-0">
            <span class="badge bg-dark px-3 py-2 rounded shadow-sm">Staff Session: ${sessionScope.admin.username}</span>
        </div>
    </div>

    <!-- Quick Stats Cards Row -->
    <div class="row g-3 mb-5 text-center">
        <!-- Revenue Card -->
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/admin/bookings" class="text-decoration-none">
                <div class="glass-card p-4 border bg-white rounded-4 shadow-sm text-start card-hover-effect">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="d-flex align-items-center">
                            <div class="bg-success-subtle text-success p-2.5 rounded-3 me-3"><i class="bi bi-currency-rupee fs-4"></i></div>
                            <span class="text-muted small font-medium">Net Earnings</span>
                        </div>
                        <i class="bi bi-arrow-up-right text-muted small"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-0">Rs. ${totalRevenue}</h3>
                    <small class="text-success font-semibold mt-1 d-block" style="font-size: 11px;">View Financial Records &rarr;</small>
                </div>
            </a>
        </div>
        <!-- Bookings Card -->
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/admin/bookings" class="text-decoration-none">
                <div class="glass-card p-4 border bg-white rounded-4 shadow-sm text-start card-hover-effect">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="d-flex align-items-center">
                            <div class="bg-primary-subtle text-primary p-2.5 rounded-3 me-3"><i class="bi bi-journal-check fs-4"></i></div>
                            <span class="text-muted small font-medium">Total Bookings</span>
                        </div>
                        <i class="bi bi-arrow-up-right text-muted small"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-0">${totalBookings}</h3>
                    <small class="text-primary font-semibold mt-1 d-block" style="font-size: 11px;">Manage All Bookings &rarr;</small>
                </div>
            </a>
        </div>
        <!-- Packages Card -->
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/admin/packages" class="text-decoration-none">
                <div class="glass-card p-4 border bg-white rounded-4 shadow-sm text-start card-hover-effect">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="d-flex align-items-center">
                            <div class="bg-warning-subtle text-warning p-2.5 rounded-3 me-3"><i class="bi bi-airplane fs-4"></i></div>
                            <span class="text-muted small font-medium">Tours Listed</span>
                        </div>
                        <i class="bi bi-arrow-up-right text-muted small"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-0">${totalPackages}</h3>
                    <small class="text-warning font-semibold mt-1 d-block" style="font-size: 11px;">Manage Tour Catalog &rarr;</small>
                </div>
            </a>
        </div>
        <!-- Users Card -->
        <div class="col-md-3">
            <a href="#activeUsersModal" data-bs-toggle="modal" class="text-decoration-none">
                <div class="glass-card p-4 border bg-white rounded-4 shadow-sm text-start card-hover-effect">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="d-flex align-items-center">
                            <div class="bg-danger-subtle text-danger p-2.5 rounded-3 me-3"><i class="bi bi-people fs-4"></i></div>
                            <span class="text-muted small font-medium">Active Accounts</span>
                        </div>
                        <i class="bi bi-arrow-up-right text-muted small"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-0">${totalUsers}</h3>
                    <small class="text-danger font-semibold mt-1 d-block" style="font-size: 11px;">View Registered Users &rarr;</small>
                </div>
            </a>
        </div>
    </div>

    <!-- Administrative Shortcuts Sidebar & Core Charts -->
    <div class="row g-4 mb-5">
        <!-- Navigation Menu -->
        <div class="col-lg-3">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                <h5 class="fw-bold text-dark mb-3"><i class="bi bi-sliders text-danger me-1"></i> Control Panels</h5>
                <hr class="my-3">
                <div class="list-group list-group-flush small">
                    <a href="${pageContext.request.contextPath}/admin/packages" class="list-group-item list-group-item-action border-0 py-2 ps-0 text-dark font-medium"><i class="bi bi-airplane me-2 text-danger"></i> Manage Packages</a>
                    <a href="${pageContext.request.contextPath}/admin/users" class="list-group-item list-group-item-action border-0 py-2 ps-0 text-primary font-bold"><i class="bi bi-people-fill me-2 text-primary"></i> Registered Users & Password Audit</a>
                    <a href="${pageContext.request.contextPath}/admin/bookings" class="list-group-item list-group-item-action border-0 py-2 ps-0 text-dark font-medium"><i class="bi bi-receipt me-2 text-danger"></i> Manage Bookings</a>
                    <a href="${pageContext.request.contextPath}/admin/guides" class="list-group-item list-group-item-action border-0 py-2 ps-0 text-dark font-medium"><i class="bi bi-patch-check-fill me-2 text-danger"></i> Manage Tour Guides</a>
                    <a href="${pageContext.request.contextPath}/admin/helpdesk" class="list-group-item list-group-item-action border-0 py-2 ps-0 text-danger font-bold"><i class="bi bi-headset me-2 text-danger"></i> Tourist Complaints & Helpdesk</a>
                    <a href="${pageContext.request.contextPath}/admin/hotels" class="list-group-item list-group-item-action border-0 py-2 ps-0 text-dark font-medium"><i class="bi bi-house-door-fill me-2 text-warning"></i> Manage Hotels & Stays</a>
                    <a href="${pageContext.request.contextPath}/admin/cabs" class="list-group-item list-group-item-action border-0 py-2 ps-0 text-dark font-medium"><i class="bi bi-taxi-front-fill me-2 text-primary"></i> Manage Tourist Cabs</a>
                    <a href="${pageContext.request.contextPath}/admin/gift-cards" class="list-group-item list-group-item-action border-0 py-2 ps-0 text-dark font-medium"><i class="bi bi-gift-fill me-2 text-danger"></i> Manage Gift Cards</a>
                    <a href="${pageContext.request.contextPath}/admin/community" class="list-group-item list-group-item-action border-0 py-2 ps-0 text-dark font-medium"><i class="bi bi-camera-fill me-2 text-info"></i> Manage Community Feed</a>
                    <a href="${pageContext.request.contextPath}/admin/b2b" class="list-group-item list-group-item-action border-0 py-2 ps-0 text-dark font-medium"><i class="bi bi-building me-2 text-success"></i> Manage B2B Group Inquiries</a>
                    <a href="${pageContext.request.contextPath}/admin/payouts" class="list-group-item list-group-item-action border-0 py-2 ps-0 text-dark font-bold text-warning"><i class="bi bi-wallet-fill me-2 text-warning"></i> Vendor Bank Payouts</a>
                    <a href="#partnerAppsSection" class="list-group-item list-group-item-action border-0 py-2 ps-0 text-dark font-semibold text-warning"><i class="bi bi-person-badge-fill me-2 text-warning"></i> Partner Applications</a>
                    <a href="#serviceBookingsSection" class="list-group-item list-group-item-action border-0 py-2 ps-0 text-dark font-semibold text-primary"><i class="bi bi-taxi-front-fill me-2 text-primary"></i> Custom & Cab Bookings</a>
                </div>
            </div>
        </div>

        <!-- Chart.js Graphics Widgets -->
        <div class="col-lg-9">
            <div class="row g-4">
                <!-- Bar Chart: Monthly Analytics -->
                <div class="col-md-7">
                    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                        <h5 class="fw-bold text-dark mb-4">Monthly Financial Revenue</h5>
                        <div style="height: 250px;"><canvas id="revenueChart"></canvas></div>
                    </div>
                </div>

                <!-- Doughnut Chart: Popularity -->
                <div class="col-md-5">
                    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
                        <h5 class="fw-bold text-dark mb-4">Popularity Shares</h5>
                        <div style="height: 250px;"><canvas id="popularityChart"></canvas></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Bookings Table List -->
    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h5 class="fw-bold text-dark mb-0"><i class="bi bi-receipt text-danger me-1"></i> Recent Tour Sales</h5>
            <a href="${pageContext.request.contextPath}/admin/bookings" class="text-decoration-none small fw-semibold text-danger">Manage All Bookings <i class="bi bi-arrow-right"></i></a>
        </div>
        <div class="table-responsive">
            <table class="table align-middle table-hover small">
                <thead class="table-light">
                    <tr>
                        <th>Ref No</th>
                        <th>Customer</th>
                        <th>Email</th>
                        <th>Package</th>
                        <th>Travel Date</th>
                        <th>Paid</th>
                        <th>Status</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty recentBookings}">
                            <c:forEach var="b" items="${recentBookings}">
                                <tr>
                                    <td class="fw-semibold text-dark">${b.bookingNo}</td>
                                    <td>${b.userName}</td>
                                    <td>${b.userEmail}</td>
                                    <td class="fw-semibold">${b.packageTitle}</td>
                                    <td>${b.travelDate}</td>
                                    <td class="fw-semibold text-danger">Rs. ${b.totalPrice}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.status == 'CONFIRMED'}">
                                                <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">Confirmed</span>
                                            </c:when>
                                            <c:when test="${b.status == 'PENDING'}">
                                                <span class="badge bg-warning-subtle text-warning border border-warning-subtle rounded-pill">Pending</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill">${b.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-end">
                                        <a href="${pageContext.request.contextPath}/invoice?bookingNo=${b.bookingNo}" class="btn btn-outline-danger btn-sm font-semibold" title="Generate Official GST Tax Invoice"><i class="bi bi-file-earmark-receipt-fill me-1"></i> GST Bill</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" class="text-center py-3 text-muted">No tour sales records registered.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    <!-- Partner Applications Approval Table -->
    <div id="partnerAppsSection" class="glass-card p-4 border bg-white rounded-4 shadow-sm my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <span class="badge bg-warning text-dark me-2">Vendor Onboarding</span>
                <h5 class="fw-bold text-dark d-inline-block mb-0"><i class="bi bi-person-badge-fill text-warning me-1"></i> Partner Applications Approval Desk</h5>
            </div>
            <span class="badge bg-dark rounded-pill">${partnerApplications != null ? partnerApplications.size() : 0} Total Requests</span>
        </div>
        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Applicant Name</th>
                        <th>Mobile</th>
                        <th>Partner Type</th>
                        <th>District</th>
                        <th>Aadhaar / ID No</th>
                        <th>Experience Details</th>
                        <th>Status</th>
                        <th class="text-center">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty partnerApplications}">
                            <c:forEach var="p" items="${partnerApplications}">
                                <tr>
                                    <td class="fw-semibold">#P-${p.id}</td>
                                    <td class="fw-bold text-dark">${p.fullName}</td>
                                    <td>${p.mobile}</td>
                                    <td><span class="badge bg-light text-dark border">${p.partnerType}</span></td>
                                    <td class="fw-semibold text-danger"><i class="bi bi-geo-alt-fill"></i> ${p.district}</td>
                                    <td><code>${p.idNumber}</code></td>
                                    <td class="text-muted" style="max-width: 200px;">${p.experienceDetails}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.status == 'APPROVED'}">
                                                <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">Approved</span>
                                            </c:when>
                                            <c:when test="${p.status == 'REJECTED'}">
                                                <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill">Rejected</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning-subtle text-dark border border-warning-subtle rounded-pill">Pending</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <c:if test="${p.status == 'PENDING'}">
                                            <a href="${pageContext.request.contextPath}/admin/dashboard?action=approvePartner&id=${p.id}" class="btn btn-success btn-sm font-semibold rounded-pill me-1 px-2.5" onclick="return confirm('Approve this partner application?');"><i class="bi bi-check-circle-fill me-1"></i> Approve</a>
                                            <a href="${pageContext.request.contextPath}/admin/dashboard?action=rejectPartner&id=${p.id}" class="btn btn-outline-danger btn-sm font-semibold rounded-pill px-2.5" onclick="return confirm('Reject this application?');"><i class="bi bi-x-circle-fill me-1"></i> Reject</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="9" class="text-center text-muted py-4">No partner applications submitted yet.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Service & Custom Bookings Approval Table -->
    <div id="serviceBookingsSection" class="glass-card p-4 border bg-white rounded-4 shadow-sm my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <span class="badge bg-primary text-white me-2">Custom Services</span>
                <h5 class="fw-bold text-dark d-inline-block mb-0"><i class="bi bi-taxi-front-fill text-primary me-1"></i> Cabs, Guides & Custom Service Bookings</h5>
            </div>
            <span class="badge bg-dark rounded-pill">${serviceBookings != null ? serviceBookings.size() : 0} Total Requests</span>
        </div>
        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Type</th>
                        <th>Customer</th>
                        <th>Mobile</th>
                        <th>Service Title</th>
                        <th>Details</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th class="text-center">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty serviceBookings}">
                            <c:forEach var="s" items="${serviceBookings}">
                                <tr>
                                    <td class="fw-semibold">#SB-${s.id}</td>
                                    <td><span class="badge bg-info-subtle text-info-emphasis border">${s.bookingType}</span></td>
                                    <td class="fw-bold text-dark">${s.userName}</td>
                                    <td>${s.userPhone}</td>
                                    <td class="fw-semibold text-danger">${s.serviceTitle}</td>
                                    <td class="text-muted" style="max-width: 200px;">${s.bookingDetails}</td>
                                    <td class="fw-bold text-dark">Rs. ${s.totalAmount}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${s.status == 'CONFIRMED'}">
                                                <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">Confirmed</span>
                                            </c:when>
                                            <c:when test="${s.status == 'CANCELLED'}">
                                                <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill">Cancelled</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning-subtle text-dark border border-warning-subtle rounded-pill">Pending</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <c:if test="${s.status == 'PENDING'}">
                                            <a href="${pageContext.request.contextPath}/admin/dashboard?action=approveService&id=${s.id}" class="btn btn-success btn-sm font-semibold rounded-pill me-1 px-2.5"><i class="bi bi-check-circle-fill me-1"></i> Confirm</a>
                                            <a href="${pageContext.request.contextPath}/admin/dashboard?action=cancelService&id=${s.id}" class="btn btn-outline-danger btn-sm font-semibold rounded-pill px-2.5"><i class="bi bi-x-circle-fill me-1"></i> Cancel</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="9" class="text-center text-muted py-4">No custom service bookings submitted yet.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- Bind backend JSON datasets into Chart.js configs -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        
        // 1. Monthly Revenue Analytics Chart
        const monthlyData = ${monthlyJson};
        const ctxRev = document.getElementById('revenueChart').getContext('2d');
        new Chart(ctxRev, {
            type: 'bar',
            data: {
                labels: monthlyData.labels,
                datasets: [{
                    label: 'Revenue (Rs.)',
                    data: monthlyData.revenue,
                    backgroundColor: '#D84315',
                    borderRadius: 6,
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: { color: '#f0f0f0' }
                    },
                    x: { grid: { display: false } }
                },
                plugins: {
                    legend: { display: false }
                }
            }
        });

        // 2. Popular Packages Distribution Chart
        const popularData = ${popularJson};
        const ctxPop = document.getElementById('popularityChart').getContext('2d');
        new Chart(ctxPop, {
            type: 'doughnut',
            data: {
                labels: Object.keys(popularData),
                datasets: [{
                    data: Object.values(popularData),
                    backgroundColor: ['#D84315', '#1A237E', '#FF8F00', '#4CAF50'],
                    borderWidth: 2,
                    borderColor: '#ffffff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            boxWidth: 12,
                            font: { size: 10 }
                        }
                    }
                }
            }
        });

    });
</script>

<!-- Chatbot Log Audits Modal -->
<div class="modal fade" id="chatbotAuditsModal" tabindex="-1" aria-labelledby="chatbotAuditsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content rounded-4 border-0 shadow-lg">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title fw-bold" id="chatbotAuditsModalLabel"><i class="bi bi-robot text-warning me-2"></i> Yatra Mitra – Chatbot Query Audit Logs</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <div class="alert alert-info border-0 small mb-3">
                    <i class="bi bi-info-circle-fill me-1"></i> Live audit log of tourist inquiries processed by Yatra Mitra AI bot.
                </div>
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle small">
                        <thead class="table-dark">
                            <tr>
                                <th>Timestamp</th>
                                <th>User Session IP</th>
                                <th>Tourist Query</th>
                                <th>Bot Response Snippet</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><small class="text-muted">Today, 15:20</small></td>
                                <td><code>127.0.0.1</code></td>
                                <td class="fw-semibold">What is the best time to visit Bodh Gaya?</td>
                                <td class="text-muted">October to March is ideal with pleasant climate...</td>
                                <td><span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">200 OK</span></td>
                            </tr>
                            <tr>
                                <td><small class="text-muted">Today, 14:45</small></td>
                                <td><code>127.0.0.1</code></td>
                                <td class="fw-semibold">How do I book Rajgir Glass Bridge tickets?</td>
                                <td class="text-muted">You can select the Heritage &amp; Glass Bridge package...</td>
                                <td><span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">200 OK</span></td>
                            </tr>
                            <tr>
                                <td><small class="text-muted">Today, 13:10</small></td>
                                <td><code>127.0.0.1</code></td>
                                <td class="fw-semibold">Are vegetarian meals available on Valmiki Safari?</td>
                                <td class="text-muted">Yes, our logistics upgrade includes traditional Veg Thali...</td>
                                <td><span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">200 OK</span></td>
                            </tr>
                            <tr>
                                <td><small class="text-muted">Today, 11:30</small></td>
                                <td><code>127.0.0.1</code></td>
                                <td class="fw-semibold">What is the timing of Ganga Aarti in Patna?</td>
                                <td class="text-muted">Evening Ganga Aarti takes place at NIT Ghat around 6:00 PM...</td>
                                <td><span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">200 OK</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close Audit Log</button>
            </div>
        </div>
    </div>
</div>

<!-- System Configuration Modal -->
<div class="modal fade" id="systemConfigModal" tabindex="-1" aria-labelledby="systemConfigModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow-lg">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title fw-bold" id="systemConfigModalLabel"><i class="bi bi-gear-fill text-warning me-2"></i> System Environment Configuration</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <ul class="list-group list-group-flush small">
                    <li class="list-group-item d-flex justify-content-between align-items-center py-3">
                        <div>
                            <strong class="d-block text-dark">Server Container</strong>
                            <span class="text-muted">Apache Tomcat 10.1.55 (Jakarta EE 10)</span>
                        </div>
                        <span class="badge bg-success text-white rounded-pill">Active (8080)</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center py-3">
                        <div>
                            <strong class="d-block text-dark">Database Connection</strong>
                            <span class="text-muted">MySQL 8.0 (`biharyatri` schema)</span>
                        </div>
                        <span class="badge bg-success text-white rounded-pill">Connected</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center py-3">
                        <div>
                            <strong class="d-block text-dark">Payment Gateway Integration</strong>
                            <span class="text-muted">Razorpay Checkout Sandbox Mode</span>
                        </div>
                        <span class="badge bg-primary text-white rounded-pill">Sandbox Ready</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center py-3">
                        <div>
                            <strong class="d-block text-dark">Email Dispatcher</strong>
                            <span class="text-muted">JavaMail API HTML Service</span>
                        </div>
                        <span class="badge bg-success text-white rounded-pill">Configured</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center py-3">
                        <div>
                            <strong class="d-block text-dark">AI Chatbot Engine</strong>
                            <span class="text-muted">Yatra Mitra Smart Keyword Core</span>
                        </div>
                        <span class="badge bg-success text-white rounded-pill">Active</span>
                    </li>
                </ul>
            </div>
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close Configuration</button>
            </div>
        </div>
    </div>
</div>

<!-- Registered Accounts Audit Modal -->
<div class="modal fade" id="activeUsersModal" tabindex="-1" aria-labelledby="activeUsersModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow-lg">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title fw-bold" id="activeUsersModalLabel"><i class="bi bi-people-fill text-warning me-2"></i> Registered Customer Accounts</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle small">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Full Name</th>
                                <th>Email Address</th>
                                <th>Phone</th>
                                <th>Account Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td class="fw-bold">Rahul Kumar</td>
                                <td><code>rahul@example.com</code></td>
                                <td>+91 9876543210</td>
                                <td><span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">Active User</span></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td class="fw-bold">asdm</td>
                                <td><code>asdm@gmail.com</code></td>
                                <td>+91 9123456789</td>
                                <td><span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">Active User</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close Account List</button>
            </div>
        </div>
    </div>
</div>

<style>
    .card-hover-effect {
        transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
    }
    .card-hover-effect:hover {
        transform: translateY(-4px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.08) !important;
        border-color: #D84315 !important;
    }
</style>

<%@ include file="/views/common/footer.jsp" %>

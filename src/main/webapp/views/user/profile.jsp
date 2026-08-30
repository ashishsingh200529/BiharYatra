<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="row">
        <!-- Dashboard Sidebar / Profile Summary -->
        <div class="col-lg-3 mb-4">
            <div class="glass-card p-4 text-center border bg-white rounded-4">
                <i class="bi bi-person-circle text-danger display-3 mb-3 d-block"></i>
                <h4 class="fw-bold text-dark mb-1">${sessionScope.user.name}</h4>
                <span class="badge bg-danger rounded-pill px-3 py-1.5 mb-3">${sessionScope.user.role}</span>
                <hr class="my-3">
                <div class="text-start small text-muted">
                    <p class="mb-2"><i class="bi bi-envelope-fill me-2 text-danger"></i>${sessionScope.user.email}</p>
                    <p class="mb-2"><i class="bi bi-telephone-fill me-2 text-danger"></i>${sessionScope.user.phone}</p>
                    <p class="mb-0"><i class="bi bi-calendar-event me-2 text-danger"></i>Joined: <fmt:formatDate value="${sessionScope.user.createdAt}" pattern="MMM yyyy" /></p>
                </div>
            </div>
        </div>

        <!-- Dashboard Core Contents (Tabs panel) -->
        <div class="col-lg-9">
            <div class="glass-card p-4 border bg-white rounded-4">
                
                <c:if test="${not empty param.success}">
                    <div class="alert alert-success border-0 small mb-4">
                        <i class="bi bi-check-circle-fill me-1"></i> ${param.success}
                    </div>
                </c:if>
                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger border-0 small mb-4">
                        <i class="bi bi-exclamation-triangle-fill me-1"></i> ${param.error}
                    </div>
                </c:if>

                <!-- Navigation Tabs -->
                <ul class="nav nav-tabs border-bottom mb-4" id="dashboardTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active fw-bold text-secondary px-3 py-2.5" id="bookings-tab" data-bs-toggle="tab" data-bs-target="#bookings" type="button" role="tab" aria-controls="bookings" aria-selected="true">
                            <i class="bi bi-ticket-detailed-fill me-1"></i> My Bookings
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link fw-bold text-secondary px-3 py-2.5" id="wishlist-tab" data-bs-toggle="tab" data-bs-target="#wishlist" type="button" role="tab" aria-controls="wishlist" aria-selected="false">
                            <i class="bi bi-heart-fill me-1"></i> My Wishlist
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link fw-bold text-secondary px-3 py-2.5" id="edit-profile-tab" data-bs-toggle="tab" data-bs-target="#edit-profile" type="button" role="tab" aria-controls="edit-profile" aria-selected="false">
                            <i class="bi bi-gear-fill me-1"></i> Edit Profile
                        </button>
                    </li>
                </ul>

                <!-- Tabs Content Panels -->
                <div class="tab-content" id="dashboardTabsContent">
                    
                    <!-- 1. My Bookings Panel -->
                    <div class="tab-pane fade show active" id="bookings" role="tabpanel" aria-labelledby="bookings-tab">
                        <h4 class="fw-bold text-dark mb-3">Booking History</h4>
                        <div class="table-responsive">
                            <table class="table align-middle table-hover">
                                <thead class="table-light text-uppercase small font-bold">
                                    <tr>
                                        <th>Ref No</th>
                                        <th>Tour Package</th>
                                        <th>Travel Date</th>
                                        <th>Total Paid</th>
                                        <th>Status</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="small">
                                    <c:choose>
                                        <c:when test="${not empty bookings}">
                                            <c:forEach var="b" items="${bookings}">
                                                <tr>
                                                    <td class="font-semibold text-dark">${b.bookingNo}</td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <c:if test="${not empty b.packageImageUrl}">
                                                                <img src="${b.packageImageUrl}" class="rounded me-2" style="width: 40px; height: 30px; object-fit: cover;" />
                                                            </c:if>
                                                            <span class="fw-semibold text-dark">${b.packageTitle}</span>
                                                        </div>
                                                    </td>
                                                    <td><fmt:formatDate value="${b.travelDate}" pattern="dd MMM yyyy" /></td>
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
                                                        <a href="${pageContext.request.contextPath}/ticket?bookingNo=${b.bookingNo}" class="btn btn-brand btn-sm py-1.5 px-2.5 me-1"><i class="bi bi-eye me-1"></i> Ticket</a>
                                                        <a href="${pageContext.request.contextPath}/certificate?name=${sessionScope.user.name != null ? sessionScope.user.name : b.userName}" class="btn btn-outline-warning text-dark btn-sm py-1.5 px-2.5 font-semibold" title="Download Official Heritage Certificate"><i class="bi bi-award-fill text-warning me-1"></i> Certificate</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="6" class="text-center py-4 text-muted">You have no active tour bookings yet. Go find your first trip!</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- 2. Wishlist Panel -->
                    <div class="tab-pane fade" id="wishlist" role="tabpanel" aria-labelledby="wishlist-tab">
                        <h4 class="fw-bold text-dark mb-3">Saved Tour Packages</h4>
                        <div class="row g-3">
                            <c:choose>
                                <c:when test="${not empty wishlist}">
                                    <c:forEach var="pkg" items="${wishlist}">
                                        <div class="col-md-6">
                                            <div class="border rounded-4 p-3 d-flex justify-content-between align-items-center bg-light">
                                                <div>
                                                    <h5 class="fw-bold text-dark mb-1">${pkg.title}</h5>
                                                    <small class="text-muted block mb-2"><i class="bi bi-clock me-1"></i> ${pkg.durationDays} Days / ${pkg.durationNights} Nights</small>
                                                    <span class="fw-bold text-danger">Rs. ${pkg.price}</span>
                                                </div>
                                                <div class="d-flex flex-column gap-2">
                                                    <a href="${pageContext.request.contextPath}/booking?packageId=${pkg.id}" class="btn btn-brand btn-sm">Book</a>
                                                    <a href="${pageContext.request.contextPath}/wishlist?action=remove&packageId=${pkg.id}" class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-12 py-4 text-center text-muted">No packages added to wishlist. Explore and bookmark them!</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- 3. Edit Profile Panel -->
                    <div class="tab-pane fade" id="edit-profile" role="tabpanel" aria-labelledby="edit-profile-tab">
                        <h4 class="fw-bold text-dark mb-3">Profile Settings</h4>
                        <form action="${pageContext.request.contextPath}/profile" method="POST" class="row g-3">
                            <div class="col-md-6">
                                <label for="profileName" class="form-label font-semibold">Full Name</label>
                                <input type="text" name="name" id="profileName" class="form-control" value="${sessionScope.user.name}" required />
                            </div>
                            <div class="col-md-6">
                                <label for="profilePhone" class="form-label font-semibold">Phone Number</label>
                                <input type="text" name="phone" id="profilePhone" class="form-control" value="${sessionScope.user.phone}" required />
                            </div>
                            <div class="col-md-12">
                                <label for="profileEmail" class="form-label">Email Address (Cannot change)</label>
                                <input type="email" id="profileEmail" class="form-control bg-light" value="${sessionScope.user.email}" readonly />
                            </div>
                            <div class="col-12 mt-4">
                                <button type="submit" class="btn btn-brand">Save Details</button>
                            </div>
                        </form>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>

<!-- Simple script to handle URL hash tabs routing (e.g. going to #wishlist-tab loads wishlist pane) -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var hash = window.location.hash;
        if (hash) {
            var tabBtn = document.querySelector('button[data-bs-target="' + hash + '"]');
            if (tabBtn) {
                var tab = new bootstrap.Tab(tabBtn);
                tab.show();
            }
        }
    });
</script>

<%@ include file="/views/common/footer.jsp" %>

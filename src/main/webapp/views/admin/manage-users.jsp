<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>

<div class="d-flex" id="wrapper">
    <!-- Admin Sidebar -->
    <div class="bg-dark text-white border-end" id="sidebar-wrapper" style="width: 250px; min-height: 100vh;">
        <div class="sidebar-heading p-3 fs-5 fw-bold border-bottom text-warning">
            <i class="bi bi-shield-lock-fill me-2"></i>Admin Console
        </div>
        <div class="list-group list-group-flush">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item list-group-item-action bg-dark text-white p-3"><i class="bi bi-speedometer2 me-2"></i> Dashboard Overview</a>
            <a href="${pageContext.request.contextPath}/admin/users" class="list-group-item list-group-item-action bg-primary text-white p-3 active"><i class="bi bi-people-fill me-2"></i> Registered Users & Audit</a>
            <a href="${pageContext.request.contextPath}/admin/bookings" class="list-group-item list-group-item-action bg-dark text-white p-3"><i class="bi bi-ticket-detailed me-2"></i> Package Bookings</a>
            <a href="${pageContext.request.contextPath}/admin/helpdesk" class="list-group-item list-group-item-action bg-dark text-white p-3"><i class="bi bi-headset me-2"></i> Tourist Complaints</a>
            <a href="${pageContext.request.contextPath}/admin/guides" class="list-group-item list-group-item-action bg-dark text-white p-3"><i class="bi bi-patch-check me-2"></i> Tour Guides</a>
            <a href="${pageContext.request.contextPath}/admin/hotels" class="list-group-item list-group-item-action bg-dark text-white p-3"><i class="bi bi-house-door me-2"></i> Hotels & Stay</a>
            <a href="${pageContext.request.contextPath}/admin/cabs" class="list-group-item list-group-item-action bg-dark text-white p-3"><i class="bi bi-taxi-front me-2"></i> Cabs Transfers</a>
            <a href="${pageContext.request.contextPath}/admin/gift-cards" class="list-group-item list-group-item-action bg-dark text-white p-3"><i class="bi bi-gift me-2"></i> Gift Cards</a>
            <a href="${pageContext.request.contextPath}/admin/community" class="list-group-item list-group-item-action bg-dark text-white p-3"><i class="bi bi-camera me-2"></i> Community Posts</a>
            <a href="${pageContext.request.contextPath}/admin/b2b" class="list-group-item list-group-item-action bg-dark text-white p-3"><i class="bi bi-building me-2"></i> B2B Group Leads</a>
            <a href="${pageContext.request.contextPath}/admin/payouts" class="list-group-item list-group-item-action bg-dark text-white p-3"><i class="bi bi-cash-stack me-2"></i> Partner Payouts</a>
            <a href="${pageContext.request.contextPath}/logout" class="list-group-item list-group-item-action bg-dark text-danger p-3 mt-4 border-top"><i class="bi bi-box-arrow-right me-2"></i> Log Out</a>
        </div>
    </div>

    <!-- Page Content -->
    <div id="page-content-wrapper" class="flex-grow-1 p-4 bg-light">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-dark mb-0"><i class="bi bi-people-fill text-primary me-2"></i> Registered User Audit & Access Control</h2>
                <p class="text-muted small">View all registered tourist accounts, login authentication methods, and security hashes.</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-dark btn-sm rounded-pill"><i class="bi bi-arrow-left me-1"></i> Back to Dashboard</a>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success border-0 small mb-4">
                <i class="bi bi-check-circle-fill me-1"></i> ${param.success}
            </div>
        </c:if>

        <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
            <div class="table-responsive">
                <table class="table align-middle table-hover small">
                    <thead class="table-dark">
                        <tr>
                            <th>User ID</th>
                            <th>Full Name</th>
                            <th>Email Address</th>
                            <th>Phone Number</th>
                            <th>Auth Method</th>
                            <th>Password Security Hash</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty userList}">
                                <c:forEach var="u" items="${userList}">
                                    <tr>
                                        <td><strong>#USR-${u.id}</strong></td>
                                        <td class="fw-bold text-dark">${u.name}</td>
                                        <td><span class="text-muted">${u.email}</span></td>
                                        <td><span>${u.phone != null ? u.phone : 'N/A'}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.authMethod == 'Google 1-Click SSO'}">
                                                    <span class="badge bg-primary-subtle text-primary border"><i class="bi bi-google me-1"></i> Google SSO</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary-subtle text-secondary border"><i class="bi bi-key-fill me-1"></i> Password Account</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><code class="text-muted" style="font-size: 11px;">${u.passHash}</code></td>
                                        <td><span class="badge bg-dark">${u.role}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.status == 'ACTIVE'}">
                                                    <span class="badge bg-success">ACTIVE</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">BLOCKED</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/admin/users" method="POST" class="d-inline-block">
                                                <input type="hidden" name="userId" value="${u.id}" />
                                                <c:choose>
                                                    <c:when test="${u.status == 'ACTIVE'}">
                                                        <input type="hidden" name="status" value="BLOCKED" />
                                                        <button type="submit" class="btn btn-outline-danger btn-sm font-semibold py-1 px-2">Block User</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="hidden" name="status" value="ACTIVE" />
                                                        <button type="submit" class="btn btn-success btn-sm font-semibold py-1 px-2">Unblock</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="9" class="text-center py-4 text-muted">No registered users found in database.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

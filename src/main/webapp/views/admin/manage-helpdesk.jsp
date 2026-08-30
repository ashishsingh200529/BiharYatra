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
            <a href="${pageContext.request.contextPath}/admin/bookings" class="list-group-item list-group-item-action bg-dark text-white p-3"><i class="bi bi-ticket-detailed me-2"></i> Package Bookings</a>
            <a href="${pageContext.request.contextPath}/admin/helpdesk" class="list-group-item list-group-item-action bg-danger text-white p-3 active"><i class="bi bi-headset me-2"></i> Tourist Complaints</a>
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
                <h2 class="fw-bold text-dark mb-0"><i class="bi bi-headset text-danger me-2"></i> Tourist Helpdesk & Complaints</h2>
                <p class="text-muted small">Review, track, and resolve query tickets submitted by travelers.</p>
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
                            <th>ID</th>
                            <th>Tourist Name</th>
                            <th>Contact Info</th>
                            <th>Subject / Category</th>
                            <th>Elaborated Message</th>
                            <th>Status</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty tickets}">
                                <c:forEach var="t" items="${tickets}">
                                    <tr>
                                        <td><strong>#HD-${t.id}</strong></td>
                                        <td class="fw-semibold text-dark">${t.name}</td>
                                        <td><span class="text-muted">${t.contact}</span></td>
                                        <td><span class="badge bg-danger-subtle text-danger border">${t.subject}</span></td>
                                        <td><p class="mb-0 text-dark small" style="max-width: 280px;">${t.message}</p></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${t.status == 'RESOLVED'}">
                                                    <span class="badge bg-success">RESOLVED</span>
                                                </c:when>
                                                <c:when test="${t.status == 'IN_PROGRESS'}">
                                                    <span class="badge bg-warning text-dark">IN PROGRESS</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">PENDING</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/admin/helpdesk" method="POST" class="d-inline-block">
                                                <input type="hidden" name="id" value="${t.id}" />
                                                <c:choose>
                                                    <c:when test="${t.status == 'PENDING'}">
                                                        <input type="hidden" name="status" value="RESOLVED" />
                                                        <button type="submit" class="btn btn-success btn-sm font-semibold py-1 px-2.5">Mark Resolved</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="hidden" name="status" value="PENDING" />
                                                        <button type="submit" class="btn btn-outline-secondary btn-sm py-1 px-2.5">Reopen</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="text-center py-4 text-muted">No complaint tickets logged yet.</td>
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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
        <div>
            <h2 class="fw-bold text-dark mb-0"><i class="bi bi-receipt text-danger me-1"></i> Manage Bookings &amp; Payments</h2>
            <small class="text-muted">Review client orders, update travel statuses, and process payment logs</small>
        </div>
        <div class="mt-2 mt-md-0">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary-brand"><i class="bi bi-arrow-left"></i> Dashboard</a>
        </div>
    </div>

    <!-- Alert Displays -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success border-0 small mb-4">
            <i class="bi bi-check-circle-fill"></i> ${param.success}
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger border-0 small mb-4">
            <i class="bi bi-exclamation-triangle-fill"></i> ${param.error}
        </div>
    </c:if>

    <!-- Bookings Management Table -->
    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <div class="table-responsive">
            <table class="table align-middle table-hover small">
                <thead class="table-light">
                    <tr>
                        <th>Booking Ref</th>
                        <th>Customer</th>
                        <th>Tour Package</th>
                        <th>Travel Date</th>
                        <th>Price</th>
                        <th>Travel Status</th>
                        <th>Payment Status</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty bookings}">
                            <c:forEach var="b" items="${bookings}">
                                <tr>
                                    <td class="fw-bold text-dark">${b.bookingNo}</td>
                                    <td>
                                        <div>
                                            <div class="fw-semibold text-dark">${b.userName}</div>
                                            <small class="text-muted">${b.userEmail}</small>
                                        </div>
                                    </td>
                                    <td><span class="fw-semibold">${b.packageTitle}</span></td>
                                    <td><fmt:formatDate value="${b.travelDate}" pattern="dd MMM yyyy" /></td>
                                    <td class="fw-bold text-danger">Rs. ${b.totalPrice}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.status == 'CONFIRMED'}">
                                                <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">Confirmed</span>
                                            </c:when>
                                            <c:when test="${b.status == 'PENDING'}">
                                                <span class="badge bg-warning-subtle text-warning border border-warning-subtle rounded-pill">Pending</span>
                                            </c:when>
                                            <c:when test="${b.status == 'COMPLETED'}">
                                                <span class="badge bg-info-subtle text-info border border-info-subtle rounded-pill">Completed</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill">${b.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.paymentStatus == 'PAID'}">
                                                <span class="badge bg-success text-white rounded-pill">Paid</span>
                                            </c:when>
                                            <c:when test="${b.paymentStatus == 'UNPAID'}">
                                                <span class="badge bg-warning text-dark rounded-pill">Unpaid</span>
                                            </c:when>
                                            <c:when test="${b.paymentStatus == 'REFUNDED'}">
                                                <span class="badge bg-secondary text-white rounded-pill">Refunded</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-dark text-white rounded-pill">${b.paymentStatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-end">
                                        <div class="d-flex gap-2 justify-content-end align-items-center">
                                            <!-- Update Travel Status Dropdown Form -->
                                            <form action="${pageContext.request.contextPath}/admin/bookings" method="POST" class="d-inline-block">
                                                <input type="hidden" name="action" value="updateStatus" />
                                                <input type="hidden" name="bookingId" value="${b.id}" />
                                                <select name="status" class="form-select form-select-sm" onchange="this.form.submit()" style="width: 120px;">
                                                    <option value="" disabled selected>Travel Status</option>
                                                    <option value="PENDING">Pending</option>
                                                    <option value="CONFIRMED">Confirmed</option>
                                                    <option value="COMPLETED">Completed</option>
                                                    <option value="CANCELLED">Cancelled</option>
                                                </select>
                                            </form>
                                            
                                            <!-- Update Payment Status Dropdown Form -->
                                            <form action="${pageContext.request.contextPath}/admin/bookings" method="POST" class="d-inline-block">
                                                <input type="hidden" name="action" value="updatePayment" />
                                                <input type="hidden" name="bookingId" value="${b.id}" />
                                                <select name="paymentStatus" class="form-select form-select-sm" onchange="this.form.submit()" style="width: 125px;">
                                                    <option value="" disabled selected>Payment Status</option>
                                                    <option value="UNPAID">Unpaid</option>
                                                    <option value="PAID">Paid</option>
                                                    <option value="REFUNDED">Refunded</option>
                                                </select>
                                            </form>
                                            
                                            <!-- View details/ticket -->
                                            <a href="${pageContext.request.contextPath}/ticket?bookingNo=${b.bookingNo}" class="btn btn-brand btn-sm" title="View Ticket"><i class="bi bi-eye"></i></a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" class="text-center py-4 text-muted">No tour bookings are currently registered.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5 py-3">
    <div class="row g-4">
        <!-- Details Card (Left Column) -->
        <div class="col-lg-5">
            <div class="glass-card p-5 border bg-white rounded-4 shadow-sm h-100 d-flex flex-column justify-content-between">
                <div>
                    <span class="text-uppercase text-danger fw-bold tracking-wider" style="font-size: 13px;">Get In Touch</span>
                    <h2 class="fw-bold text-dark mt-1 mb-3">Tourist Helpdesk</h2>
                    <p class="text-muted small">We are available 24/7 to resolve issues regarding package reservations, payment disputes, or customized itinerary requests.</p>
                    
                    <hr class="my-4">

                    <div class="d-flex align-items-center mb-4">
                        <i class="bi bi-geo-alt-fill text-danger fs-3 me-3"></i>
                        <div>
                            <h6 class="fw-bold mb-1 text-dark">Office Headquarters</h6>
                            <small class="text-muted">BSTDC Corp, Gandhi Maidan, Patna, Bihar, 800001</small>
                        </div>
                    </div>

                    <div class="d-flex align-items-center mb-4">
                        <i class="bi bi-telephone-fill text-danger fs-3 me-3"></i>
                        <div>
                            <h6 class="fw-bold mb-1 text-dark">Telephone Support</h6>
                            <small class="text-muted">+91-612-YATRA (92872) / +91-9988776655</small>
                        </div>
                    </div>

                    <div class="d-flex align-items-center">
                        <i class="bi bi-envelope-fill text-danger fs-3 me-3"></i>
                        <div>
                            <h6 class="fw-bold mb-1 text-dark">Email Support</h6>
                            <small class="text-muted">support@biharyatri.com / travel@biharyatri.com</small>
                        </div>
                    </div>
                </div>

                <div class="alert alert-danger border-0 small mb-0 mt-5">
                    <i class="bi bi-shield-fill-check me-1"></i> Standard response window is within <strong>2-4 business hours</strong>.
                </div>
            </div>
        </div>

        <!-- Query Form (Right Column) -->
        <div class="col-lg-7">
            <div class="glass-card p-5 border bg-white rounded-4 shadow-sm">
                
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

                <h3 class="fw-bold text-dark mb-4">Submit Query & Complaint Ticket</h3>
                <form action="${pageContext.request.contextPath}/contact" method="POST">
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label font-semibold text-dark">Your Full Name</label>
                            <input type="text" name="name" class="form-control" placeholder="Enter your name" value="${sessionScope.user.name}" required />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label font-semibold text-dark">Email / Mobile Number</label>
                            <input type="text" name="email" class="form-control" placeholder="Email or Mobile" value="${sessionScope.user.email}" required />
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark">Query / Complaint Subject</label>
                        <select name="subject" class="form-select">
                            <option value="Booking Modification / Cancellation">Booking Modification / Cancellation</option>
                            <option value="Razorpay Payment Dispute">Razorpay Payment Dispute</option>
                            <option value="AI Chatbot / Web Portal Issue">AI Chatbot / Web Portal Issue</option>
                            <option value="Custom Tour Package Request">Custom Tour Package Request</option>
                            <option value="General Feedback & Complaint">General Feedback & Complaint</option>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label class="form-label font-semibold text-dark">Elaborate Your Message</label>
                        <textarea name="message" class="form-control" rows="5" placeholder="Write full details of your complaint or query..." required></textarea>
                    </div>

                    <button type="submit" class="btn btn-brand w-100 py-3 font-semibold shadow-sm">
                        <i class="bi bi-send-fill me-1"></i> Submit Complaint Ticket to Admin
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

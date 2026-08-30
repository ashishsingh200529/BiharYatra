<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5 py-3">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="glass-card p-5 border shadow-lg bg-white rounded-4">
                
                <div class="text-center mb-4">
                    <i class="bi bi-person-plus text-danger display-4"></i>
                    <h2 class="fw-bold mt-2">Create Account</h2>
                    <p class="text-muted small">Sign up to unlock and customize package bookings</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger border-0 small">
                        <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="POST" class="mt-4">
                    <div class="row g-3 mb-3">
                        <div class="col-md-12">
                            <label for="name" class="form-label font-semibold">Full Name</label>
                            <div class="input-group">
                                <span class="input-group-text bg-transparent border-end-0"><i class="bi bi-person text-muted"></i></span>
                                <input type="text" name="name" id="name" class="form-control border-start-0 ps-0" placeholder="e.g. Rahul Kumar" required />
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label font-semibold">Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-end-0"><i class="bi bi-envelope text-muted"></i></span>
                            <input type="email" name="email" id="email" class="form-control border-start-0 ps-0" placeholder="name@example.com" required />
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label font-semibold">Phone Number</label>
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-end-0"><i class="bi bi-telephone text-muted"></i></span>
                            <input type="tel" name="phone" id="phone" class="form-control border-start-0 ps-0" placeholder="e.g. 9876543210" pattern="[0-9]{10}" title="Ten digit phone number" required />
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="password" class="form-label font-semibold">Password</label>
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-end-0"><i class="bi bi-key text-muted"></i></span>
                            <input type="password" name="password" id="password" class="form-control border-start-0 ps-0" placeholder="Minimum 6 characters" minlength="6" required />
                        </div>
                    </div>

                    <button type="submit" class="btn btn-brand w-100 py-2.5">Create Account</button>
                </form>

                <div class="text-center mt-4 pt-3 border-top">
                    <p class="small text-muted">Already have an account? <a href="${pageContext.request.contextPath}/login" class="text-danger fw-bold text-decoration-none">Log In here</a></p>
                </div>

            </div>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

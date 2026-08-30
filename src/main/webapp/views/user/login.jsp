<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5 py-4">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="glass-card p-5 border shadow-lg bg-white rounded-4">
                
                <div class="text-center mb-4">
                    <i class="bi bi-person-lock text-danger display-4"></i>
                    <h2 class="fw-bold mt-2">Welcome Back</h2>
                    <p class="text-muted small">Access your account to book packages and view tickets</p>
                </div>

                <!-- Alert Displays -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger border-0 small">
                        <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                    </div>
                </c:if>

                <!-- Professional Google SSO Button -->
                <div class="text-center mb-3">
                    <button type="button" data-bs-toggle="modal" data-bs-target="#googleAccountModal" class="btn btn-outline-dark w-100 py-2.5 rounded-pill font-semibold shadow-sm d-flex align-items-center justify-content-center gap-2">
                        <svg width="18" height="18" viewBox="0 0 24 24"><path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/><path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/><path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l2.85-2.22.81-.63z"/><path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 12 1 7.7 1 3.99 3.47 2.18 7.06l3.66 2.84c.87-2.6 3.3-4.52 6.16-4.52z"/></svg>
                        <span>Continue with Google</span>
                    </button>
                    
                    <div class="d-flex align-items-center my-3 text-muted small">
                        <hr class="flex-grow-1 my-0">
                        <span class="px-2 text-uppercase font-semibold" style="font-size: 10px;">OR LOGIN WITH EMAIL</span>
                        <hr class="flex-grow-1 my-0">
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/login" method="POST">
                    <div class="mb-3">
                        <label for="email" class="form-label font-semibold">Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-end-0"><i class="bi bi-envelope text-muted"></i></span>
                            <input type="email" name="email" id="email" class="form-control border-start-0 ps-0" placeholder="name@example.com" required />
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <div class="d-flex justify-content-between">
                            <label for="password" class="form-label font-semibold">Password</label>
                            <a href="${pageContext.request.contextPath}/forgot-password" class="small text-danger text-decoration-none">Forgot Password?</a>
                        </div>
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-end-0"><i class="bi bi-key text-muted"></i></span>
                            <input type="password" name="password" id="password" class="form-control border-start-0 ps-0" placeholder="••••••••" required />
                        </div>
                    </div>

                    <button type="submit" class="btn btn-brand w-100 py-2.5 mt-3">Log In</button>
                </form>

                <div class="text-center mt-4 pt-3 border-top">
                    <p class="small text-muted mb-0">Don't have an account? <a href="${pageContext.request.contextPath}/register" class="text-danger fw-bold text-decoration-none">Sign Up Now</a></p>
                    <a href="${pageContext.request.contextPath}/admin/login" class="small text-muted text-decoration-none block mt-2 d-inline-block"><i class="bi bi-shield-lock"></i> Staff Admin Login</a>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- Multi-Account Google Sign-In Modal -->
<div class="modal fade" id="googleAccountModal" tabindex="-1" aria-labelledby="googleAccountModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow-lg overflow-hidden">
            <div class="modal-header bg-light border-0 py-3">
                <div class="d-flex align-items-center">
                    <svg width="22" height="22" viewBox="0 0 24 24" class="me-2"><path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/><path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/><path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l2.85-2.22.81-.63z"/><path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 12 1 7.7 1 3.99 3.47 2.18 7.06l3.66 2.84c.87-2.6 3.3-4.52 6.16-4.52z"/></svg>
                    <h6 class="modal-title font-semibold text-dark mb-0" id="googleAccountModalLabel">Choose a Google Account</h6>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <form action="${pageContext.request.contextPath}/google-login" method="POST" class="p-4">
                <p class="text-muted small mb-3">Select a Google Account on your device to continue to <strong>BiharYatra</strong>.</p>
                
                <!-- Multi-Account Chooser List -->
                <div class="mb-3">
                    <div class="d-grid gap-2">
                        <!-- Account 1 -->
                        <button type="button" class="btn btn-outline-light text-dark border p-2.5 rounded-3 d-flex align-items-center text-start acc-btn active border-primary bg-primary-subtle" onclick="selectAccount(this, 'ashishsingh29012005@gmail.com', 'Ashish Singh');">
                            <div class="bg-danger text-white rounded-circle me-3 d-flex align-items-center justify-content-center font-bold" style="width: 36px; height: 36px;">A</div>
                            <div class="overflow-hidden">
                                <strong class="d-block small text-dark">Ashish Singh</strong>
                                <small class="text-muted" style="font-size: 11px;">ashishsingh29012005@gmail.com</small>
                            </div>
                            <i class="bi bi-check-circle-fill text-primary ms-auto fs-5 acc-icon"></i>
                        </button>
                        <!-- Account 2 -->
                        <button type="button" class="btn btn-outline-light text-dark border p-2.5 rounded-3 d-flex align-items-center text-start acc-btn" onclick="selectAccount(this, 'priya.sharma@gmail.com', 'Priya Sharma');">
                            <div class="bg-primary text-white rounded-circle me-3 d-flex align-items-center justify-content-center font-bold" style="width: 36px; height: 36px;">P</div>
                            <div class="overflow-hidden">
                                <strong class="d-block small text-dark">Priya Sharma</strong>
                                <small class="text-muted" style="font-size: 11px;">priya.sharma@gmail.com</small>
                            </div>
                            <i class="bi bi-circle text-muted ms-auto fs-5 acc-icon"></i>
                        </button>
                        <!-- Account 3 -->
                        <button type="button" class="btn btn-outline-light text-dark border p-2.5 rounded-3 d-flex align-items-center text-start acc-btn" onclick="selectAccount(this, 'vikram.tourist@gmail.com', 'Vikram Kumar');">
                            <div class="bg-success text-white rounded-circle me-3 d-flex align-items-center justify-content-center font-bold" style="width: 36px; height: 36px;">V</div>
                            <div class="overflow-hidden">
                                <strong class="d-block small text-dark">Vikram Kumar</strong>
                                <small class="text-muted" style="font-size: 11px;">vikram.tourist@gmail.com</small>
                            </div>
                            <i class="bi bi-circle text-muted ms-auto fs-5 acc-icon"></i>
                        </button>
                    </div>
                </div>

                <!-- Selected / Custom Account Form Fields -->
                <div class="p-3 bg-light rounded-3 border mb-3">
                    <div class="mb-2">
                        <label class="form-label font-semibold text-dark small mb-1">Selected Google Email</label>
                        <input type="email" name="email" id="g-modal-email" class="form-control form-control-sm" value="ashishsingh29012005@gmail.com" required />
                    </div>
                    <div>
                        <label class="form-label font-semibold text-dark small mb-1">Full Name</label>
                        <input type="text" name="name" id="g-modal-name" class="form-control form-control-sm" value="Ashish Singh" required />
                    </div>
                </div>

                <button type="submit" class="btn btn-dark w-100 py-2.5 font-semibold rounded-pill shadow-sm d-flex align-items-center justify-content-center gap-2">
                    <i class="bi bi-box-arrow-in-right fs-5"></i>
                    <span>Sign in with Selected Account</span>
                </button>
            </form>
        </div>
    </div>
</div>

<script>
    function selectAccount(btn, email, name) {
        document.querySelectorAll(".acc-btn").forEach(function(b) {
            b.className = "btn btn-outline-light text-dark border p-2.5 rounded-3 d-flex align-items-center text-start acc-btn";
            var icon = b.querySelector(".acc-icon");
            if (icon) icon.className = "bi bi-circle text-muted ms-auto fs-5 acc-icon";
        });

        btn.className = "btn btn-outline-light text-dark border p-2.5 rounded-3 d-flex align-items-center text-start acc-btn active border-primary bg-primary-subtle";
        var selIcon = btn.querySelector(".acc-icon");
        if (selIcon) selIcon.className = "bi bi-check-circle-fill text-primary ms-auto fs-5 acc-icon";

        document.getElementById("g-modal-email").value = email;
        document.getElementById("g-modal-name").value = name;
    }
</script>

<%@ include file="/views/common/footer.jsp" %>

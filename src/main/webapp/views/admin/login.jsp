<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5 py-5">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="glass-card p-5 border shadow-lg bg-dark text-white rounded-4">
                
                <div class="text-center mb-4">
                    <i class="bi bi-shield-lock-fill text-warning display-4"></i>
                    <h3 class="fw-bold mt-2 text-white">Staff Console</h3>
                    <p class="text-secondary small">Staff login for BiharYatra travel portal</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger border-0 small">
                        <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                    </div>
                </c:if>
                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger border-0 small">
                        <i class="bi bi-exclamation-triangle-fill me-1"></i> ${param.error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/login" method="POST" class="mt-4">
                    <div class="mb-3">
                        <label for="username" class="form-label font-semibold text-secondary">Username</label>
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-secondary text-secondary"><i class="bi bi-person"></i></span>
                            <input type="text" name="username" id="username" class="form-control bg-transparent text-white border-secondary ps-3" placeholder="admin" required />
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label for="password" class="form-label font-semibold text-secondary">Password</label>
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-secondary text-secondary"><i class="bi bi-key"></i></span>
                            <input type="password" name="password" id="password" class="form-control bg-transparent text-white border-secondary ps-3" placeholder="••••••••" required />
                        </div>
                    </div>

                    <button type="submit" class="btn btn-warning w-100 py-2.5 font-semibold text-dark"><i class="bi bi-box-arrow-in-right me-1"></i> Authorize Console</button>
                </form>

                <div class="text-center mt-4 pt-3 border-top border-secondary">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="small text-secondary text-decoration-none"><i class="bi bi-arrow-left"></i> Back to Main Homepage</a>
                </div>

            </div>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

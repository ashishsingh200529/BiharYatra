<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5 py-5 text-center">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="glass-card p-5 border shadow-lg bg-white rounded-4">
                <i class="bi bi-compass text-danger display-1 mb-3 d-block"></i>
                <h1 class="fw-bold text-dark display-4">404</h1>
                <h4 class="fw-bold text-muted mb-4">Destination Not Found!</h4>
                <p class="text-muted small mb-4">
                    It seems you've wandered off the track. The page or destination you are looking for does not exist or has been relocated.
                </p>
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-brand py-2.5 px-4"><i class="bi bi-house-fill me-1"></i> Go Back Home</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

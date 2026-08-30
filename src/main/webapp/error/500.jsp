<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5 py-5 text-center">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <div class="glass-card p-5 border shadow-lg bg-white rounded-4">
                <i class="bi bi-exclamation-octagon text-danger display-1 mb-3 d-block"></i>
                <h1 class="fw-bold text-dark display-4">500</h1>
                <h4 class="fw-bold text-muted mb-4">Something Went Wrong!</h4>
                <p class="text-muted small mb-4">
                    Our servers are experiencing temporary difficulty processing your travel details. Rest assured, our team is resolving the issue.
                </p>
                
                <c:if test="${pageContext.exception != null}">
                    <div class="text-start bg-light p-3 rounded border mb-4" style="max-height: 150px; overflow-y: auto;">
                        <code class="text-danger small">${pageContext.exception.message}</code>
                    </div>
                </c:if>

                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-brand py-2.5 px-4"><i class="bi bi-house-fill me-1"></i> Go Back Home</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

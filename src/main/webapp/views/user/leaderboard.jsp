<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-gradient-to-r from-warning to-danger text-dark py-5">
    <div class="container text-center py-3">
        <span class="badge bg-dark text-white px-3 py-2 rounded-pill mb-3 font-semibold"><i class="bi bi-trophy-fill me-1 text-warning"></i> Hall of Fame</span>
        <h1 class="fw-bold display-4 mb-2">BiharYatra Tourism Leaderboard</h1>
        <p class="lead text-dark max-w-2xl mx-auto mb-0">Top trivia quiz winners, verified heritage explorers, and community travel contributors.</p>
    </div>
</div>

<div class="container my-5">
    <div class="glass-card p-4 border bg-white rounded-4 shadow-sm">
        <div class="table-responsive">
            <table class="table align-middle table-hover small mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Rank</th>
                        <th>Explorer Name</th>
                        <th>Points / Badge</th>
                        <th>Reward Won</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-bold fs-5 text-warning">🥇 #1</td>
                        <td class="fw-bold text-dark">Rahul Kumar</td>
                        <td><span class="badge bg-warning text-dark me-1">🏆 Master Explorer</span> 950 pts</td>
                        <td class="fw-bold text-danger">Rs. 500 Promo Code</td>
                        <td><span class="badge bg-success-subtle text-success border">Verified</span></td>
                    </tr>
                    <tr>
                        <td class="fw-bold fs-5 text-secondary">🥈 #2</td>
                        <td class="fw-bold text-dark">Sneha Sinha</td>
                        <td><span class="badge bg-light text-dark border me-1">⭐ Gold Explorer</span> 820 pts</td>
                        <td class="fw-bold text-danger">Rs. 500 Promo Code</td>
                        <td><span class="badge bg-success-subtle text-success border">Verified</span></td>
                    </tr>
                    <tr>
                        <td class="fw-bold fs-5 text-danger">🥉 #3</td>
                        <td class="fw-bold text-dark">Amitabh Roy</td>
                        <td><span class="badge bg-light text-dark border me-1">🌟 Heritage Fellow</span> 740 pts</td>
                        <td class="fw-bold text-danger">Rs. 500 Promo Code</td>
                        <td><span class="badge bg-success-subtle text-success border">Verified</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

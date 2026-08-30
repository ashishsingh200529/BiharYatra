<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    
    <!-- Success/Error Alerts -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success border-0 small mb-4">
            <i class="bi bi-check-circle-fill"></i> ${param.success}
        </div>
    </c:if>

    <!-- Details Header (Title and Wishlist Button) -->
    <div class="d-flex justify-content-between align-items-start mb-4">
        <div>
            <span class="text-uppercase text-danger fw-bold tracking-wider" style="font-size: 13px;">${tourPackage.startLocation} Departure</span>
            <h1 class="fw-bold text-dark mt-1">${tourPackage.title}</h1>
            <p class="text-muted"><i class="bi bi-clock me-1 text-danger"></i> ${tourPackage.durationDays} Days / ${tourPackage.durationNights} Nights &nbsp;&bull;&nbsp; Difficulty: <strong>${tourPackage.difficulty}</strong></p>
        </div>
        <div>
            <c:choose>
                <c:when test="${inWishlist}">
                    <a href="${pageContext.request.contextPath}/wishlist?action=remove&packageId=${tourPackage.id}" class="wishlist-btn active" title="Remove from Wishlist">
                        <i class="bi bi-heart-fill fs-3 text-warning"></i>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/wishlist?action=add&packageId=${tourPackage.id}" class="wishlist-btn" title="Add to Wishlist">
                        <i class="bi bi-heart fs-3 text-secondary"></i>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Core Details Grid -->
    <div class="row g-4">
        <!-- Main Details (Left Column) -->
        <div class="col-lg-8">
            <!-- Main Cover Carousel -->
            <div id="packageCarousel" class="carousel slide shadow-sm rounded-4 overflow-hidden mb-4" data-bs-ride="carousel">
                <div class="carousel-inner" style="height: 380px;">
                    <c:forEach var="img" items="${tourPackage.imageUrls}" varStatus="status">
                        <div class="carousel-item ${status.first ? 'active' : ''} h-100">
                            <img src="${img}" class="d-block w-100 h-100" style="object-fit: cover;" alt="Destination Slide">
                        </div>
                    </c:forEach>
                </div>
                <c:if test="${tourPackage.imageUrls.size() > 1}">
                    <button class="carousel-control-prev" type="button" data-bs-target="#packageCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#packageCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    </button>
                </c:if>
            </div>

            <!-- Description -->
            <div class="glass-card p-4 border bg-white rounded-4 mb-4">
                <h4 class="fw-bold text-dark mb-3">Tour Description</h4>
                <p class="text-muted" style="line-height: 1.6;">${tourPackage.description}</p>
            <!-- AI Smart Weather & Packing Advisory Card -->
            <div class="glass-card p-4 border bg-white rounded-4 mb-4 border-warning">
                <div class="d-flex align-items-center mb-3">
                    <div class="bg-warning-subtle text-dark rounded-circle p-2.5 me-3">
                        <i class="bi bi-cloud-sun-fill fs-4 text-warning"></i>
                    </div>
                    <div>
                        <h5 class="fw-bold text-dark mb-0">AI Weather & Packing Advisory</h5>
                        <small class="text-muted">Smart seasonal recommendation for ${tourPackage.startLocation}</small>
                    </div>
                </div>
                <div class="p-3 bg-light rounded-3 border">
                    <div class="row g-2 small">
                        <div class="col-6">
                            <span class="text-muted d-block">Expected Temp:</span>
                            <strong class="text-dark">28°C - 34°C (Sunny)</strong>
                        </div>
                        <div class="col-6">
                            <span class="text-muted d-block">Recommended Clothing:</span>
                            <strong class="text-danger">Light Cotton & Sunscreen</strong>
                        </div>
                        <div class="col-12 mt-2 pt-2 border-top">
                            <i class="bi bi-info-circle-fill text-primary me-1"></i>
                            <span class="text-muted">Temple dress code: Full pants/dresses required for Bodh Gaya & Temple shrines.</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="glass-card p-4 border bg-white rounded-4 mb-4">
                <h4 class="fw-bold text-dark mb-4">Day-wise Itinerary</h4>
                <div class="ps-2">
                    <c:forEach var="item" items="${tourPackage.itineraries}">
                        <div class="timeline-item">
                            <h5 class="fw-bold text-danger mb-1">Day ${item.dayNumber}: ${item.title}</h5>
                            <p class="text-muted small mb-2">${item.activityDetails}</p>
                            <div class="d-flex flex-wrap gap-3 small text-secondary">
                                <span class="bg-light px-2.5 py-1 rounded"><i class="bi bi-egg-fried text-warning me-1"></i>Meals: ${item.mealsIncluded}</span>
                                <span class="bg-light px-2.5 py-1 rounded"><i class="bi bi-house-door-fill text-primary me-1"></i>Stay: ${item.accommodation}</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Yatra Mitra Audio Guide & 360 Virtual Tour -->
            <div class="glass-card p-4 border bg-white rounded-4 mb-4 bg-light">
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
                    <h5 class="fw-bold text-dark mb-0"><i class="bi bi-headphones text-danger me-2"></i> Yatra Mitra Audio Guide</h5>
                    <span class="badge bg-danger">AI Voice Narration</span>
                </div>
                <p class="text-muted small mb-3">Listen to the historic background and cultural significance of ${tourPackage.title}.</p>
                <div class="p-3 bg-white border rounded-3 d-flex align-items-center gap-3">
                    <button type="button" id="btn-audio-play" class="btn btn-danger rounded-circle p-2 shadow-sm" style="width: 44px; height: 44px;">
                        <i class="bi bi-play-fill fs-5" id="audio-icon"></i>
                    </button>
                    <div class="flex-grow-1">
                        <div class="fw-bold small text-dark" id="audio-title">Audio Narrative: ${tourPackage.title}</div>
                        <div class="progress mt-1" style="height: 4px;">
                            <div class="progress-bar bg-danger" id="audio-progress" role="progressbar" style="width: 0%;"></div>
                        </div>
                    </div>
                    <button type="button" class="btn btn-outline-dark btn-sm rounded-pill font-semibold" data-bs-toggle="modal" data-bs-target="#vrModal"><i class="bi bi-badge-3d-fill me-1 text-danger"></i> 360° View</button>
                </div>
            </div>

            <!-- Destinations Covered Cards -->
            <div class="glass-card p-4 border bg-white rounded-4 mb-4">
                <h4 class="fw-bold text-dark mb-4">Stops Covered</h4>
                <div class="row g-3">
                    <c:forEach var="place" items="${tourPackage.places}">
                        <div class="col-md-6">
                            <div class="border rounded-4 overflow-hidden d-flex bg-light h-100">
                                <img src="${place.imageUrl}" style="width: 100px; object-fit: cover;" alt="${place.name}" />
                                <div class="p-3 d-flex flex-column justify-content-center">
                                    <h6 class="fw-bold text-dark mb-1">${place.name}</h6>
                                    <small class="text-danger mb-1"><i class="bi bi-geo-alt-fill"></i> ${place.district}</small>
                                    <p class="text-muted mb-0" style="font-size: 11px; line-height: 1.3;">Best visit: ${place.bestTimeToVisit}</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Reviews list -->
            <div class="glass-card p-4 border bg-white rounded-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-bold text-dark mb-0">Customer Reviews</h4>
                    <button class="btn btn-outline-danger btn-sm font-semibold rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#reviewModal"><i class="bi bi-star-fill me-1"></i> Write Review</button>
                </div>
                <c:choose>
                    <c:when test="${not empty reviews}">
                        <c:forEach var="rev" items="${reviews}">
                            <div class="border-bottom pb-3 mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <span class="fw-bold text-dark small">${rev.userName}</span>
                                    <span class="text-warning">
                                        <c:forEach begin="1" end="${rev.rating}">
                                            <i class="bi bi-star-fill"></i>
                                        </c:forEach>
                                        <c:forEach begin="${rev.rating + 1}" end="5">
                                            <i class="bi bi-star text-muted"></i>
                                        </c:forEach>
                                    </span>
                                </div>
                                <p class="text-muted small mb-1">${rev.comment}</p>
                                <small class="text-secondary" style="font-size: 10px;"><fmt:formatDate value="${rev.createdAt}" pattern="dd MMM yyyy" /></small>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted small mb-0">No reviews have been written for this package yet. Be the first to share your experience!</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Booking CTA Sidebar (Right Column) -->
        <div class="col-lg-4">
            <div class="glass-card p-4 border bg-white rounded-4 sticky-top" style="top: 90px; z-index: 10;">
                <span class="text-muted small">Package Cost (per person)</span>
                <h2 class="fw-bold text-danger mb-3">Rs. <fmt:formatNumber value="${tourPackage.price}" pattern="#,##0.00" /></h2>
                
                <hr class="my-3">
                
                <ul class="list-unstyled small text-muted mb-4">
                    <li class="mb-2.5"><i class="bi bi-check-circle-fill text-success me-2"></i> Private tour transport included</li>
                    <li class="mb-2.5"><i class="bi bi-check-circle-fill text-success me-2"></i> Guided sightseeing visits</li>
                    <li class="mb-2.5"><i class="bi bi-check-circle-fill text-success me-2"></i> Dual-occupancy room options</li>
                    <li class="mb-0"><i class="bi bi-check-circle-fill text-success me-2"></i> 24/7 tourist assist desk support</li>
                </ul>

                <a href="${pageContext.request.contextPath}/booking?packageId=${tourPackage.id}" class="btn btn-brand w-100 py-2.5 font-semibold"><i class="bi bi-calendar-check me-1"></i> Book Guided Tour</a>
                <a href="${pageContext.request.contextPath}/packages" class="btn btn-light w-100 py-2.5 mt-2 border small">Back to Search</a>
            </div>

            <!-- Live Weather & AQI Tourism Advisory Card -->
            <div class="glass-card p-4 border bg-white rounded-4 mt-4 shadow-sm">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h6 class="fw-bold text-dark mb-0"><i class="bi bi-cloud-sun-fill text-warning me-2"></i> Live Weather & Advisory</h6>
                    <span class="badge bg-success-subtle text-success border border-success-subtle" style="font-size: 10px;">Optimal Season</span>
                </div>
                <div class="d-flex align-items-center justify-content-between p-3 bg-light rounded-3 mb-3">
                    <div>
                        <div class="display-6 fw-bold text-dark">26°C</div>
                        <div class="text-muted small"><i class="bi bi-geo-alt me-1"></i> ${tourPackage.startLocation}, Bihar</div>
                    </div>
                    <div class="text-end">
                        <span class="badge bg-warning text-dark mb-1"><i class="bi bi-wind me-1"></i> AQI: 72 (Good)</span>
                        <div class="text-muted small">Partly Cloudy</div>
                    </div>
                </div>
                <div class="small text-muted border-top pt-2">
                    <i class="bi bi-info-circle-fill text-danger me-1"></i> <strong>Advisory:</strong> Best visiting hours today between 08:30 AM to 05:00 PM for sightseeing.
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 360 Degree Virtual Reality Modal -->
<div class="modal fade" id="vrModal" tabindex="-1" aria-labelledby="vrModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header bg-dark text-white border-0 py-3">
                <h5 class="modal-title fw-bold" id="vrModalLabel"><i class="bi bi-badge-3d-fill text-danger me-2"></i> 360° Virtual Experience - ${tourPackage.title}</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-0 text-center bg-black position-relative" style="height: 420px;">
                <img src="${not empty tourPackage.imageUrls ? tourPackage.imageUrls[0] : 'https://images.unsplash.com/photo-1600100397608-f010e42ed98e?auto=format&fit=crop&w=1200&q=80'}" class="w-100 h-100" style="object-fit: cover; opacity: 0.85;" alt="360 View" />
                <div class="position-absolute top-50 start-50 translate-middle text-white p-4 rounded-4 bg-dark bg-opacity-75">
                    <i class="bi bi-arrow-repeat display-3 text-danger animate-spin mb-2 d-inline-block"></i>
                    <h5 class="fw-bold">Interactive 360° Panorama Viewer</h5>
                    <p class="small mb-0 text-white-50">Drag left or right to explore full 360-degree high-definition panorama of ${tourPackage.startLocation}.</p>
                </div>
            </div>
            <div class="modal-footer bg-light border-0">
                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close Virtual Tour</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // SpeechSynthesis Audio Guide Player
        var btnPlay = document.getElementById("btn-audio-play");
        var audioIcon = document.getElementById("audio-icon");
        var progressBar = document.getElementById("audio-progress");
        var isSpeaking = false;
        var utterance = null;

        if (btnPlay && 'speechSynthesis' in window) {
            btnPlay.addEventListener("click", function() {
                if (isSpeaking) {
                    window.speechSynthesis.cancel();
                    isSpeaking = false;
                    audioIcon.className = "bi bi-play-fill fs-5";
                    progressBar.style.width = "0%";
                } else {
                    var text = "Welcome to BiharYatra. " + "${tourPackage.title}. " + "${tourPackage.description}".replace(/['"]/g, '');
                    utterance = new SpeechSynthesisUtterance(text);
                    utterance.rate = 0.95;
                    utterance.pitch = 1.0;

                    utterance.onstart = function() {
                        isSpeaking = true;
                        audioIcon.className = "bi bi-pause-fill fs-5";
                        progressBar.style.width = "100%";
                        progressBar.style.transition = "width 15s linear";
                    };

                    utterance.onend = function() {
                        isSpeaking = false;
                        audioIcon.className = "bi bi-play-fill fs-5";
                        progressBar.style.width = "0%";
                    };

                    window.speechSynthesis.speak(utterance);
                }
            });
        }
    });
</script>

<!-- Write Review Modal -->
<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header bg-danger text-white border-0 py-3">
                <h5 class="modal-title fw-bold" id="reviewModalLabel"><i class="bi bi-star-fill me-2 text-warning"></i> Write Tour Review</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/packages" method="POST">
                <input type="hidden" name="action" value="addReview" />
                <input type="hidden" name="packageId" value="${tourPackage.id}" />
                <div class="modal-body p-4">
                    <div class="mb-3 text-center">
                        <label class="form-label font-semibold text-dark d-block">Overall Rating</label>
                        <select name="rating" class="form-select text-center font-semibold">
                            <option value="5">⭐⭐⭐⭐⭐ (5/5 - Exceptional Experience)</option>
                            <option value="4">⭐⭐⭐⭐ (4/5 - Very Good)</option>
                            <option value="3">⭐⭐⭐ (3/5 - Good)</option>
                            <option value="2">⭐⭐ (2/5 - Average)</option>
                            <option value="1">⭐ (1/5 - Poor)</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label font-semibold text-dark">Your Review Comment</label>
                        <textarea name="comment" class="form-control" rows="4" placeholder="Share your travel experience, guide feedback, and sightseeing highlights..." required></textarea>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-light border" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-brand">Submit Verified Review</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

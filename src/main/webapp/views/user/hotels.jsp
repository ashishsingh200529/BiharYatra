<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="bg-gradient-to-r from-dark to-secondary text-white py-5">
    <div class="container">
        <span class="badge bg-warning text-dark px-3 py-2 rounded-pill mb-3 font-semibold"><i class="bi bi-house-door-fill me-1"></i> Verified Stays</span>
        <h1 class="fw-bold display-5 mb-2">Heritage Homestays & Resorts</h1>
        <p class="lead text-white-50 mb-0">Stay in authentic Bihari homestays, Buddhist meditation retreats, and luxury eco-lodges.</p>
    </div>
</div>

<div class="container my-5">
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success border-0 rounded-4 shadow-sm mb-4 d-flex align-items-center">
            <i class="bi bi-check-circle-fill fs-3 me-3 text-success"></i>
            <div>
                <strong class="d-block font-semibold">Room Reserved!</strong>
                <span>${successMsg}</span>
            </div>
        </div>
    </c:if>

    <div class="row g-4">
        <!-- Hotel 1 -->
        <div class="col-md-6 col-lg-3">
            <div class="card border rounded-4 overflow-hidden shadow-sm h-100">
                <img src="https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=600&q=80" style="height: 190px; object-fit: cover;" class="card-img-top" alt="Bodh Gaya Zen Retreat" />
                <div class="card-body">
                    <span class="badge bg-success mb-2">Meditation Resort</span>
                    <h5 class="fw-bold text-dark mb-1">Bodh Gaya Zen Retreat</h5>
                    <p class="text-muted small mb-2"><i class="bi bi-geo-alt-fill text-danger me-1"></i> Bodh Gaya (Near Bodhi Tree)</p>
                    <div class="mb-3">
                        <span class="badge bg-light text-dark border me-1"><i class="bi bi-wifi me-1"></i> WiFi</span>
                        <span class="badge bg-light text-dark border me-1"><i class="bi bi-snow me-1"></i> AC</span>
                        <span class="badge bg-light text-dark border"><i class="bi bi-flower1 me-1"></i> Spa</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center border-top pt-3">
                        <div>
                            <small class="text-muted d-block" style="font-size: 11px;">Per Night</small>
                            <span class="fw-bold text-danger fs-5">Rs. 2,800</span>
                        </div>
                        <button class="btn btn-brand btn-sm font-semibold rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#bookHotelModal" data-name="Bodh Gaya Zen Retreat" data-price="2800">Book Room</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Hotel 2 -->
        <div class="col-md-6 col-lg-3">
            <div class="card border rounded-4 overflow-hidden shadow-sm h-100">
                <img src="https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80" style="height: 190px; object-fit: cover;" class="card-img-top" alt="Rajgir Heritage Homestay" />
                <div class="card-body">
                    <span class="badge bg-primary mb-2">Authentic Homestay</span>
                    <h5 class="fw-bold text-dark mb-1">Rajgir Heritage Homestay</h5>
                    <p class="text-muted small mb-2"><i class="bi bi-geo-alt-fill text-danger me-1"></i> Rajgir (Near Glass Skywalk)</p>
                    <div class="mb-3">
                        <span class="badge bg-light text-dark border me-1"><i class="bi bi-egg-fried me-1"></i> Home Food</span>
                        <span class="badge bg-light text-dark border"><i class="bi bi-shield-check me-1"></i> Verified</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center border-top pt-3">
                        <div>
                            <small class="text-muted d-block" style="font-size: 11px;">Per Night</small>
                            <span class="fw-bold text-danger fs-5">Rs. 1,800</span>
                        </div>
                        <button class="btn btn-brand btn-sm font-semibold rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#bookHotelModal" data-name="Rajgir Heritage Homestay" data-price="1800">Book Room</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Hotel 3 -->
        <div class="col-md-6 col-lg-3">
            <div class="card border rounded-4 overflow-hidden shadow-sm h-100">
                <img src="https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=600&q=80" style="height: 190px; object-fit: cover;" class="card-img-top" alt="Hotel Maurya Grand Patna" />
                <div class="card-body">
                    <span class="badge bg-danger mb-2">4-Star Luxury</span>
                    <h5 class="fw-bold text-dark mb-1">Hotel Maurya Grand</h5>
                    <p class="text-muted small mb-2"><i class="bi bi-geo-alt-fill text-danger me-1"></i> Gandhi Maidan, Patna</p>
                    <div class="mb-3">
                        <span class="badge bg-light text-dark border me-1"><i class="bi bi-water me-1"></i> Pool</span>
                        <span class="badge bg-light text-dark border"><i class="bi bi-cup-hot me-1"></i> Buffet</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center border-top pt-3">
                        <div>
                            <small class="text-muted d-block" style="font-size: 11px;">Per Night</small>
                            <span class="fw-bold text-danger fs-5">Rs. 4,500</span>
                        </div>
                        <button class="btn btn-brand btn-sm font-semibold rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#bookHotelModal" data-name="Hotel Maurya Grand" data-price="4500">Book Room</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Hotel 4 -->
        <div class="col-md-6 col-lg-3">
            <div class="card border rounded-4 overflow-hidden shadow-sm h-100">
                <img src="https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?auto=format&fit=crop&w=600&q=80" style="height: 190px; object-fit: cover;" class="card-img-top" alt="Valmiki Tiger Eco-Cottage" />
                <div class="card-body">
                    <span class="badge bg-success mb-2">Jungle Eco-Lodge</span>
                    <h5 class="fw-bold text-dark mb-1">Valmiki Eco-Cottage</h5>
                    <p class="text-muted small mb-2"><i class="bi bi-geo-alt-fill text-danger me-1"></i> Valmiki Tiger Reserve</p>
                    <div class="mb-3">
                        <span class="badge bg-light text-dark border me-1"><i class="bi bi-tree me-1"></i> Forest View</span>
                        <span class="badge bg-light text-dark border"><i class="bi bi-fire me-1"></i> Campfire</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center border-top pt-3">
                        <div>
                            <small class="text-muted d-block" style="font-size: 11px;">Per Night</small>
                            <span class="fw-bold text-danger fs-5">Rs. 3,200</span>
                        </div>
                        <button class="btn btn-brand btn-sm font-semibold rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#bookHotelModal" data-name="Valmiki Eco-Cottage" data-price="3200">Book Room</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Book Hotel Room Modal Form -->
<div class="modal fade" id="bookHotelModal" tabindex="-1" aria-labelledby="bookHotelModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header bg-danger text-white border-0 py-3">
                <h5 class="modal-title fw-bold" id="bookHotelModalLabel"><i class="bi bi-house-door-fill me-2"></i> Book Hotel & Homestay Room</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/hotels" method="POST">
                <input type="hidden" name="hotelName" id="input-h-name" value="Bodh Gaya Zen Retreat" />
                <input type="hidden" name="price" id="input-h-price" value="2800" />
                <div class="modal-body p-4 text-center">
                    <i class="bi bi-building-check display-1 text-danger mb-3 d-inline-block"></i>
                    <h4 class="fw-bold text-dark" id="modal-h-name">Bodh Gaya Zen Retreat</h4>
                    <p class="text-muted small mb-3">Confirm room details below.</p>

                    <div class="text-start mb-3">
                        <label class="form-label font-semibold text-dark small">Guest Name</label>
                        <input type="text" name="userName" class="form-control form-control-sm" placeholder="Rahul Kumar" required />
                    </div>

                    <div class="text-start mb-3">
                        <label class="form-label font-semibold text-dark small">Mobile Phone (WhatsApp)</label>
                        <input type="tel" name="userPhone" class="form-control form-control-sm" placeholder="+91 98000 00000" required />
                    </div>

                    <div class="p-3 bg-light rounded-3 border mb-3 text-start">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Per Night Tariff:</span>
                            <strong class="text-dark" id="modal-h-price">Rs. 2,800/night</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2 align-items-center">
                            <span class="text-muted">Stay Duration:</span>
                            <select name="nights" id="hotel-nights" class="form-select form-select-sm w-auto" onchange="var p = parseInt(document.getElementById('input-h-price').value); document.getElementById('modal-h-total').innerText = 'Rs. ' + (p * parseInt(this.value)).toLocaleString('en-IN');">
                                <option value="1" selected>1 Night</option>
                                <option value="2">2 Nights</option>
                                <option value="3">3 Nights</option>
                                <option value="5">5 Nights</option>
                            </select>
                        </div>
                        <div class="d-flex justify-content-between border-top pt-2 font-semibold">
                            <span class="text-dark">Total Amount:</span>
                            <strong class="text-danger fs-5" id="modal-h-total">Rs. 2,800</strong>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-brand w-100 py-3 font-semibold rounded-3 shadow-sm">Confirm Room Reservation</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var bookModal = document.getElementById('bookHotelModal');
        if (bookModal) {
            bookModal.addEventListener('show.bs.modal', function(e) {
                var btn = e.relatedTarget;
                var name = btn.getAttribute('data-name');
                var price = parseInt(btn.getAttribute('data-price'));
                document.getElementById('modal-h-name').innerText = name;
                document.getElementById('input-h-name').value = name;
                document.getElementById('input-h-price').value = price;
                document.getElementById('modal-h-price').innerText = 'Rs. ' + price + '/night';
                document.getElementById('modal-h-total').innerText = 'Rs. ' + price.toLocaleString('en-IN');
            });
        }
    });
</script>

<%@ include file="/views/common/footer.jsp" %>

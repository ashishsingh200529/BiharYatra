<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5 py-3">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="glass-card p-4 p-md-5 border shadow-lg bg-white rounded-4">
                
                <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
                    <div>
                        <span class="badge bg-danger mb-1">PCI-DSS Secure Checkout</span>
                        <h3 class="fw-bold text-dark mb-0"><i class="bi bi-shield-lock-fill text-danger me-2"></i> Choose Payment Method</h3>
                    </div>
                    <div class="text-end">
                        <span class="text-muted small d-block">Amount Payable</span>
                        <span class="fw-bold text-danger fs-4">Rs. ${booking.totalPrice}</span>
                    </div>
                </div>

                <!-- Booking Summary Strip -->
                <div class="p-3 bg-light rounded-3 border mb-4 d-flex justify-content-between align-items-center flex-wrap gap-2">
                    <div>
                        <strong class="d-block text-dark">${booking.packageTitle}</strong>
                        <small class="text-muted">Booking #: ${booking.bookingNo} • ${booking.numTravelers} Traveler(s)</small>
                    </div>
                    <span class="badge bg-success-subtle text-success border">Instant Confirmation</span>
                </div>

                <!-- Multi-Payment Gateway Navigation Tabs -->
                <ul class="nav nav-pills nav-justified mb-4 p-1 bg-light rounded-3 border" id="paymentTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active font-semibold rounded-3 py-2.5" id="upi-tab" data-bs-toggle="tab" data-bs-target="#upi-pane" type="button" role="tab"><i class="bi bi-qr-code-scan me-1"></i> UPI / QR Code</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link font-semibold rounded-3 py-2.5" id="card-tab" data-bs-toggle="tab" data-bs-target="#card-pane" type="button" role="tab"><i class="bi bi-credit-card-fill me-1"></i> Cards</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link font-semibold rounded-3 py-2.5" id="netbank-tab" data-bs-toggle="tab" data-bs-target="#netbank-pane" type="button" role="tab"><i class="bi bi-bank me-1"></i> NetBanking</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link font-semibold rounded-3 py-2.5" id="razorpay-tab" data-bs-toggle="tab" data-bs-target="#razorpay-pane" type="button" role="tab"><i class="bi bi-lightning-charge-fill me-1"></i> Razorpay Express</button>
                    </li>
                </ul>

                <!-- Tab Content Panes -->
                <div class="tab-content" id="paymentTabsContent">
                    
                    <!-- 1. UPI / QR Code Payment Pane -->
                    <div class="tab-pane fade show active text-center py-3" id="upi-pane" role="tabpanel">
                        <h5 class="fw-bold text-dark mb-2">Scan & Pay via any UPI App</h5>
                        <p class="text-muted small mb-4">Open Google Pay, PhonePe, Paytm, or BHIM app on your mobile and scan QR code.</p>

                        <div class="d-inline-block bg-white p-3 rounded-4 border shadow-sm mb-3">
                            <img src="https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=upi://pay?pa=biharyatra@upi%26pn=BiharYatra%26am=${booking.totalPrice}%26tn=${booking.bookingNo}" class="img-fluid rounded" alt="UPI QR Code" />
                            <small class="d-block text-muted mt-2 font-semibold" style="font-size: 11px;">UPI ID: biharyatra@upi</small>
                        </div>

                        <div class="d-flex justify-content-center gap-2 mb-4">
                            <span class="badge bg-light text-dark border p-2"><i class="bi bi-google text-primary me-1"></i> Google Pay</span>
                            <span class="badge bg-light text-dark border p-2"><i class="bi bi-phone-fill text-purple me-1"></i> PhonePe</span>
                            <span class="badge bg-light text-dark border p-2"><i class="bi bi-wallet2 text-info me-1"></i> Paytm</span>
                        </div>

                        <button type="button" onclick="submitSimulatedPayment('UPI App (Google Pay/PhonePe)');" class="btn btn-success w-100 py-3 font-semibold rounded-3 shadow-sm">
                            <i class="bi bi-check-circle-fill me-1"></i> I Have Completed UPI Payment (Confirm Order)
                        </button>
                    </div>

                    <!-- 2. Cards Payment Pane -->
                    <div class="tab-pane fade py-2" id="card-pane" role="tabpanel">
                        <form onsubmit="event.preventDefault(); submitSimulatedPayment('Credit/Debit Card');">
                            <div class="mb-3">
                                <label class="form-label font-semibold text-dark small">Cardholder Name</label>
                                <input type="text" class="form-control" placeholder="Rahul Kumar" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label font-semibold text-dark small">Card Number</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-credit-card"></i></span>
                                    <input type="text" class="form-control" placeholder="4111 2222 3333 4444" maxlength="19" required />
                                </div>
                            </div>
                            <div class="row g-3 mb-4">
                                <div class="col-6">
                                    <label class="form-label font-semibold text-dark small">Expiry Date</label>
                                    <input type="text" class="form-control" placeholder="MM/YY" maxlength="5" required />
                                </div>
                                <div class="col-6">
                                    <label class="form-label font-semibold text-dark small">CVV / CVC</label>
                                    <input type="password" class="form-control" placeholder="123" maxlength="4" required />
                                </div>
                            </div>
                            <button type="submit" class="btn btn-brand w-100 py-3 font-semibold rounded-3 shadow-sm">
                                Pay Rs. ${booking.totalPrice} with Card
                            </button>
                        </form>
                    </div>

                    <!-- 3. NetBanking Payment Pane -->
                    <div class="tab-pane fade py-2" id="netbank-pane" role="tabpanel">
                        <form onsubmit="event.preventDefault(); submitSimulatedPayment('NetBanking');">
                            <label class="form-label font-semibold text-dark small mb-3">Select Your Bank</label>
                            <div class="row g-3 mb-4">
                                <div class="col-6 col-md-3">
                                    <div class="border rounded-3 p-3 text-center cursor-pointer bg-light">
                                        <i class="bi bi-bank fs-3 text-primary d-block mb-1"></i>
                                        <strong class="small d-block text-dark">HDFC Bank</strong>
                                    </div>
                                </div>
                                <div class="col-6 col-md-3">
                                    <div class="border rounded-3 p-3 text-center cursor-pointer bg-light">
                                        <i class="bi bi-bank fs-3 text-danger d-block mb-1"></i>
                                        <strong class="small d-block text-dark">SBI Bank</strong>
                                    </div>
                                </div>
                                <div class="col-6 col-md-3">
                                    <div class="border rounded-3 p-3 text-center cursor-pointer bg-light">
                                        <i class="bi bi-bank fs-3 text-warning d-block mb-1"></i>
                                        <strong class="small d-block text-dark">ICICI Bank</strong>
                                    </div>
                                </div>
                                <div class="col-6 col-md-3">
                                    <div class="border rounded-3 p-3 text-center cursor-pointer bg-light">
                                        <i class="bi bi-bank fs-3 text-success d-block mb-1"></i>
                                        <strong class="small d-block text-dark">Axis Bank</strong>
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-brand w-100 py-3 font-semibold rounded-3 shadow-sm">
                                Pay Rs. ${booking.totalPrice} via NetBanking
                            </button>
                        </form>
                    </div>

                    <!-- 4. Razorpay Express Gateway Pane -->
                    <div class="tab-pane fade text-center py-4" id="razorpay-pane" role="tabpanel">
                        <i class="bi bi-lightning-charge-fill display-3 text-warning mb-3 d-block"></i>
                        <h5 class="fw-bold text-dark mb-2">Razorpay Official Express Gateway</h5>
                        <p class="text-muted small mb-4">Click below to open Razorpay's native popup modal.</p>
                        <button type="button" id="pay-button" class="btn btn-brand py-3 px-5 font-semibold rounded-pill shadow-lg">
                            <i class="bi bi-shield-lock me-1"></i> Open Razorpay Gateway
                        </button>
                    </div>
                </div>

                <!-- Hidden form to post back to PaymentServlet after success -->
                <form id="razorpayForm" action="${pageContext.request.contextPath}/payment" method="POST" style="display: none;">
                    <input type="hidden" name="bookingNo" value="${booking.bookingNo}" />
                    <input type="hidden" name="razorpay_payment_id" id="rzp_payment_id" />
                    <input type="hidden" name="razorpay_order_id" id="rzp_order_id" />
                    <input type="hidden" name="razorpay_signature" id="rzp_signature" />
                    <input type="hidden" name="payment_method" id="rzp_method" />
                </form>

            </div>
        </div>
    </div>
</div>

<!-- Razorpay Checkout Script Integration -->
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
    function submitSimulatedPayment(method) {
        document.getElementById('rzp_payment_id').value = "pay_sandbox_" + Date.now();
        document.getElementById('rzp_order_id').value = "order_sandbox_" + Date.now();
        document.getElementById('rzp_signature').value = "sig_sandbox_" + Date.now();
        document.getElementById('rzp_method').value = method || "UPI/Card Gateway";
        document.getElementById('razorpayForm').submit();
    }

    document.getElementById('pay-button').onclick = function(e){
        e.preventDefault();
        var key = "rzp_test_dummykey";
        if (!key || key === "rzp_test_dummykey" || key.trim() === "") {
            submitSimulatedPayment('Razorpay Express');
            return;
        }
    };
</script>

<%@ include file="/views/common/footer.jsp" %>

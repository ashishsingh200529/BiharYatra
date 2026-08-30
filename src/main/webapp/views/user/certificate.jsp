<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            
            <!-- Certificate Container -->
            <div id="certificate-card" class="p-5 bg-white rounded-4 border border-warning shadow-lg text-center position-relative overflow-hidden" style="border-width: 6px !important; border-style: double !important;">
                
                <!-- Background Seal Watermark -->
                <div class="position-absolute top-50 start-50 translate-middle opacity-10 pointer-events-none" style="z-index: 1;">
                    <i class="bi bi-award-fill display-1 text-warning" style="font-size: 320px;"></i>
                </div>

                <div class="position-relative" style="z-index: 2;">
                    <!-- Header Badge -->
                    <div class="mb-3">
                        <i class="bi bi-compass-fill display-4 text-danger d-inline-block mb-2"></i>
                        <h6 class="text-uppercase tracking-widest text-muted font-bold mb-0">Government of Bihar Tourism Partner</h6>
                        <h2 class="fw-bold text-dark font-serif" style="letter-spacing: 2px;">BIHAR YATRA TOURISM BOARD</h2>
                    </div>

                    <hr class="my-4 border-warning w-50 mx-auto opacity-75">

                    <!-- Title -->
                    <h3 class="font-serif text-danger text-uppercase font-bold mb-4" style="letter-spacing: 4px;">Certificate of Heritage Exploration</h3>
                    
                    <p class="text-muted fs-5 mb-2 font-sans">This official certificate is proudly awarded to</p>
                    
                    <!-- Passenger Name -->
                    <h1 class="display-5 fw-bold text-dark my-3 font-serif border-bottom border-danger d-inline-block px-5 pb-2">${passengerName}</h1>

                    <p class="text-muted fs-6 max-w-2xl mx-auto my-4 font-sans" style="line-height: 1.7;">
                        For successfully exploring the rich historical heritage, ancient Buddhist circuits, and ecological marvels of Bihar during the <strong>BiharYatra Tour Expedition 2026</strong>.
                    </p>

                    <!-- Certificate Metadata & QR Verification -->
                    <div class="row align-items-center mt-5 pt-3">
                        <div class="col-md-4 text-center text-md-start mb-3 mb-md-0">
                            <small class="text-muted d-block">Issue Date:</small>
                            <strong class="text-dark">31 August 2026</strong>
                            <small class="text-muted d-block mt-2">Certificate ID:</small>
                            <span class="badge bg-dark">CERT-BY-2026-9921</span>
                        </div>

                        <div class="col-md-4 text-center mb-3 mb-md-0">
                            <div class="d-inline-block p-2 border border-warning rounded-circle bg-warning-subtle mb-1">
                                <i class="bi bi-award-fill fs-1 text-warning"></i>
                            </div>
                            <small class="fw-bold d-block text-dark">Verified Heritage Seal</small>
                        </div>

                        <div class="col-md-4 text-center text-md-end">
                            <img src="https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=BiharYatraCertificate:CERT-BY-2026-9921" class="border p-1 rounded bg-white shadow-sm mb-1" style="width: 80px;" alt="QR Stamp" />
                            <small class="text-muted d-block" style="font-size: 10px;">Official QR Verification</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Print Actions -->
            <div class="d-flex justify-content-center gap-3 mt-4">
                <button onclick="window.print()" class="btn btn-brand py-2.5 px-4 font-semibold"><i class="bi bi-printer-fill me-1"></i> Print / Download PDF Certificate</button>
                <a href="${pageContext.request.contextPath}/profile" class="btn btn-light border py-2.5 px-4 font-semibold">Back to Profile</a>
            </div>

        </div>
    </div>
</div>

<style>
@media print {
    .custom-navbar, footer, .d-flex.justify-content-center.gap-3 {
        display: none !important;
    }
    body {
        background-color: #fff !important;
    }
    #certificate-card {
        box-shadow: none !important;
        margin: 0 !important;
    }
}
</style>

<%@ include file="/views/common/footer.jsp" %>

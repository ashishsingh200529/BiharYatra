<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            
            <c:if test="${not empty param.success}">
                <div class="alert alert-success border-0 small mb-4 shadow-sm">
                    <i class="bi bi-patch-check-fill text-success"></i> ${param.success}
                </div>
            </c:if>

            <!-- Boarding Pass / Ticket Container -->
            <div class="card border-0 shadow-lg glass-card overflow-hidden rounded-4 bg-white mb-4">
                
                <!-- Ticket Header -->
                <div class="bg-danger text-white p-4 text-center d-flex justify-content-between align-items-center flex-wrap">
                    <div class="text-start">
                        <h4 class="fw-bold mb-0"><i class="bi bi-compass-fill me-1"></i> BIHAR YATRA</h4>
                        <small style="opacity: 0.8;">Travel Boarding Pass &amp; Entry Ticket</small>
                    </div>
                    <div class="text-end mt-2 mt-md-0">
                        <span class="badge bg-white text-danger px-3 py-2 rounded-pill font-bold shadow-sm">
                            ${booking.paymentStatus}
                        </span>
                    </div>
                </div>

                <!-- Ticket Body -->
                <div class="card-body p-5">
                    <div class="row g-4">
                        <!-- Left side details -->
                        <div class="col-md-8">
                            <h5 class="fw-bold text-dark mb-4"><i class="bi bi-info-circle text-danger me-1"></i> Booking Specifications</h5>
                            
                            <div class="row g-3 small">
                                <div class="col-6 text-muted">Booking Reference:</div>
                                <div class="col-6 font-semibold text-dark">${booking.bookingNo}</div>

                                <div class="col-6 text-muted">Tour Package:</div>
                                <div class="col-6 font-semibold text-dark">${booking.packageTitle}</div>

                                <div class="col-6 text-muted">Lead Customer:</div>
                                <div class="col-6 font-semibold text-dark">${booking.userName}</div>

                                <div class="col-6 text-muted">Travel Date:</div>
                                <div class="col-6 font-semibold text-dark"><fmt:formatDate value="${booking.travelDate}" pattern="dd MMM yyyy" /></div>

                                <div class="col-6 text-muted">Travelers Count:</div>
                                <div class="col-6 font-semibold text-dark">${booking.numTravelers} Person(s)</div>

                                <div class="col-6 text-muted">Total Paid Amount:</div>
                                <div class="col-6 font-bold text-danger fs-6">Rs. ${booking.totalPrice}</div>
                            </div>
                        </div>

                        <!-- Right side QR Code -->
                        <div class="col-md-4 text-center border-start d-flex flex-column align-items-center justify-content-center">
                            <c:choose>
                                <c:when test="${not empty qrBase64}">
                                    <img src="data:image/png;base64,${qrBase64}" class="img-fluid border p-2 rounded shadow-sm bg-white mb-2" style="max-width: 170px;" alt="Booking QR Code" />
                                </c:when>
                                <c:otherwise>
                                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=170x170&data=BookingRef:${booking.bookingNo}" class="img-fluid border p-2 rounded shadow-sm bg-white mb-2" style="max-width: 170px;" alt="Booking QR Code" />
                                </c:otherwise>
                            </c:choose>
                            <span class="small font-bold text-dark d-block mt-1"><i class="bi bi-qr-code text-danger me-1"></i> Entry Gate QR Pass</span>
                            <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill mt-1">Verified Entry Pass</span>
                        </div>
                    </div>

                    <!-- Passenger details list -->
                    <hr class="my-4">
                    <h5 class="fw-bold text-dark mb-3"><i class="bi bi-people-fill text-danger me-1"></i> Registered Passenger Names</h5>
                    <div class="table-responsive">
                        <table class="table table-bordered table-sm align-middle small">
                            <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Name</th>
                                    <th>Age</th>
                                    <th>Gender</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="t" items="${booking.travelers}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td class="fw-semibold">${t.travelerName}</td>
                                        <td>${t.travelerAge}</td>
                                        <td>${t.travelerGender}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="alert alert-light border small text-muted mt-4">
                        <strong>Guidelines:</strong> Please report at least 30 minutes before your departure. Keep a soft copy of this PDF or print it out alongside a valid photo government ID card.
                    </div>
                </div>

            </div>

            <!-- Action buttons -->
            <div class="d-flex justify-content-center flex-wrap gap-2">
                <button onclick="window.print()" class="btn btn-brand py-2.5 px-4 font-semibold"><i class="bi bi-file-earmark-pdf-fill me-1"></i> Print / Save PDF Ticket</button>
                <a href="https://api.whatsapp.com/send?text=${encodeURIComponent('My confirmed BiharYatra Booking Pass #' + booking.bookingNo + ' for ' + booking.packageTitle + '!')}" target="_blank" class="btn btn-success py-2.5 px-4 font-semibold"><i class="bi bi-whatsapp me-1"></i> Share on WhatsApp</a>
                <a href="${pageContext.request.contextPath}/certificate?name=${booking.userName}" class="btn btn-outline-warning py-2.5 px-4 font-semibold text-dark"><i class="bi bi-award-fill text-warning me-1"></i> Heritage Certificate</a>
                <button id="btn-gcal" class="btn btn-outline-danger py-2.5 px-4 font-semibold"><i class="bi bi-calendar-plus-fill me-1"></i> Google Calendar</button>
                <button id="btn-ical" class="btn btn-outline-dark py-2.5 px-4 font-semibold"><i class="bi bi-calendar-event me-1"></i> iCal (.ics)</button>
                <a href="${pageContext.request.contextPath}/profile" class="btn btn-light border py-2.5 px-4 font-semibold">Profile</a>
            </div>

        </div>
    </div>
</div>

<!-- Instant Simulated WhatsApp Notification Alert -->
<div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1055;">
    <div id="waToast" class="toast align-items-center text-white bg-success border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body small py-3">
                <i class="bi bi-whatsapp fs-5 me-2"></i> <strong>WhatsApp Confirmation Sent!</strong><br>
                Booking voucher <strong>#${booking.bookingNo}</strong> delivered to ${booking.userPhone}.
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>

<style>
@media print {
    .custom-navbar, footer, .d-flex.justify-content-center.gap-3, .toast-container {
        display: none !important;
    }
    body {
        background-color: #fff !important;
    }
    .glass-card {
        border: none !important;
        box-shadow: none !important;
    }
}
</style>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var waToast = document.getElementById('waToast');
        if (waToast && typeof bootstrap !== 'undefined') {
            setTimeout(function() {
                var toast = new bootstrap.Toast(waToast, { delay: 6000 });
                toast.show();
            }, 1200);
        }

        var btnGcal = document.getElementById("btn-gcal");
        var btnIcal = document.getElementById("btn-ical");

        var pkgTitle = "${booking.packageTitle}";
        var bookingNo = "${booking.bookingNo}";

        if (btnGcal) {
            btnGcal.addEventListener("click", function() {
                var url = "https://calendar.google.com/calendar/render?action=TEMPLATE" +
                          "&text=" + encodeURIComponent("BiharYatra Tour: " + pkgTitle) +
                          "&details=" + encodeURIComponent("Confirmed Booking #" + bookingNo + " with BiharYatra Tourism.") +
                          "&location=" + encodeURIComponent("Patna, Bihar");
                window.open(url, '_blank');
            });
        }

        if (btnIcal) {
            btnIcal.addEventListener("click", function() {
                var icsData = "BEGIN:VCALENDAR\nVERSION:2.0\nPRODID:-//BiharYatra Tourism//EN\n" +
                              "BEGIN:VEVENT\nSUMMARY:BiharYatra Tour: " + pkgTitle + "\n" +
                              "DESCRIPTION:Confirmed Booking #" + bookingNo + "\n" +
                              "LOCATION:Bihar, India\nEND:VEVENT\nEND:VCALENDAR";
                var blob = new Blob([icsData], { type: 'text/calendar;charset=utf-8' });
                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.setAttribute('download', 'BiharYatra_Tour_' + bookingNo + '.ics');
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            });
        }
    });
</script>

<%@ include file="/views/common/footer.jsp" %>

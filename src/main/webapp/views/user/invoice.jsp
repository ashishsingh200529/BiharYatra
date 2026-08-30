<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <span class="badge bg-danger mb-1">Official Tax Invoice</span>
            <h2 class="fw-bold text-dark mb-0"><i class="bi bi-file-earmark-receipt-fill text-danger me-2"></i> Tax Invoice / Booking Receipt</h2>
        </div>
        <div>
            <button onclick="window.print()" class="btn btn-brand btn-sm rounded-pill font-semibold px-3 me-2"><i class="bi bi-printer-fill me-1"></i> Print / Download PDF</button>
            <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-dark btn-sm rounded-pill font-semibold">Back to Profile</a>
        </div>
    </div>

    <!-- Official Tax Invoice Document Box -->
    <div class="glass-card p-5 border bg-white rounded-4 shadow-lg" id="tax-invoice-box">
        <div class="row align-items-center border-bottom pb-4 mb-4">
            <div class="col-md-6">
                <h2 class="fw-bold text-danger mb-1">BIHAR YATRA PVT. LTD.</h2>
                <p class="text-muted small mb-1">Bihar Tourism Development Corp, Gandhi Maidan, Patna - 800001</p>
                <p class="text-muted small mb-0"><strong>GSTIN:</strong> 10AAACB1234F1Z9 | <strong>SAC Code:</strong> 998552 (Tour Operator Services)</p>
            </div>
            <div class="col-md-6 text-md-end mt-3 mt-md-0">
                <span class="badge bg-success fs-6 px-3 py-2 rounded-pill mb-2"><i class="bi bi-check-circle-fill me-1"></i> ORIGINAL TAX INVOICE</span>
                <h5 class="fw-bold text-dark mb-1">Invoice #: INV-2026-${bookingNo}</h5>
                <small class="text-muted d-block">Date: 31 August 2026</small>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-6">
                <div class="p-3 bg-light rounded-3 border">
                    <small class="text-uppercase text-muted font-semibold d-block mb-1">Billed To (Customer):</small>
                    <strong class="d-block text-dark">Rahul Kumar</strong>
                    <span class="text-muted small d-block">Phone: +91 98765 43210</span>
                    <span class="text-muted small d-block">Email: rahul.kumar@gmail.com</span>
                </div>
            </div>
            <div class="col-md-6">
                <div class="p-3 bg-light rounded-3 border">
                    <small class="text-uppercase text-muted font-semibold d-block mb-1">Payment Details:</small>
                    <strong class="d-block text-success"><i class="bi bi-check-circle-fill me-1"></i> PAID ONLINE VIA UPI</strong>
                    <span class="text-muted small d-block">Transaction ID: TXN_UPI_983742918237</span>
                    <span class="text-muted small d-block">Payment Date: 31 Aug 2026, 02:45 PM</span>
                </div>
            </div>
        </div>

        <div class="table-responsive mb-4">
            <table class="table align-middle table-bordered small">
                <thead class="table-dark">
                    <tr>
                        <th>Item Description</th>
                        <th>SAC Code</th>
                        <th class="text-end">Base Amount</th>
                        <th class="text-end">CGST (9%)</th>
                        <th class="text-end">SGST (9%)</th>
                        <th class="text-end">Total Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <strong class="d-block text-dark">Bodh Gaya & Rajgir Spiritual Tour Package</strong>
                            <small class="text-muted">3 Days / 2 Nights Heritage Circuit for 2 Travelers</small>
                        </td>
                        <td><code>998552</code></td>
                        <td class="text-end">Rs. 8,474.58</td>
                        <td class="text-end text-muted">Rs. 762.71</td>
                        <td class="text-end text-muted">Rs. 762.71</td>
                        <td class="text-end fw-bold text-dark">Rs. 10,000.00</td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr class="table-light">
                        <td colspan="5" class="text-end fw-bold text-dark">Grand Total (Inclusive of Taxes):</td>
                        <td class="text-end fw-bold text-danger fs-5">Rs. 10,000.00</td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div class="row align-items-center pt-3 border-top">
            <div class="col-md-8">
                <p class="small text-muted mb-0">This is a computer-generated official tax invoice under Section 31 of CGST Act, 2017. No signature required.</p>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                <img src="https://api.qrserver.com/v1/create-qr-code/?size=90x90&data=https://biharyatri.com/invoice?bookingNo=${bookingNo}" alt="QR Verification" class="border p-1 rounded bg-white shadow-sm" />
                <small class="d-block text-muted mt-1" style="font-size: 10px;">Scan to Verify Invoice</small>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/common/footer.jsp" %>

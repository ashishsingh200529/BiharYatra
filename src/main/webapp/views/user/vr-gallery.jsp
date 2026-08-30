<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ include file="/views/common/navbar.jsp" %>

<!-- Pannellum 360 Panorama Viewer CSS & JS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pannellum@2.5.6/build/pannellum.css"/>
<script src="https://cdn.jsdelivr.net/npm/pannellum@2.5.6/build/pannellum.js"></script>

<div class="bg-dark text-white py-5">
    <div class="container text-center py-3">
        <span class="badge bg-danger px-3 py-2 rounded-pill mb-3 font-semibold"><i class="bi bi-badge-3d-fill me-1"></i> Interactive 3D VR Experience</span>
        <h1 class="fw-bold display-4 mb-2">360° VR Virtual Tour Gallery</h1>
        <p class="lead text-white-50 max-w-2xl mx-auto mb-0">Drag & rotate to explore 360-degree interactive 3D virtual tours of Bihar's top UNESCO heritage sites.</p>
    </div>
</div>

<div class="container my-5">
    <div class="row g-4">
        <!-- VR Spot 1 -->
        <div class="col-md-6">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm h-100">
                <div class="position-relative rounded-4 overflow-hidden mb-3">
                    <img src="https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=800&q=80" style="height: 280px; width: 100%; object-fit: cover;" alt="Mahabodhi Temple VR" />
                    <div class="position-absolute top-50 start-50 translate-middle">
                        <button class="btn btn-danger btn-lg rounded-circle p-3 shadow-lg animate-pulse-glow open-vr-btn" data-title="Mahabodhi Temple 360° Virtual Tour" data-pano="https://pannellum.org/images/alma.jpg">
                            <i class="bi bi-play-circle-fill display-5 d-block"></i>
                        </button>
                    </div>
                    <span class="badge bg-dark position-absolute bottom-0 end-0 m-3"><i class="bi bi-badge-3d-fill me-1 text-warning"></i> 360° Panorama</span>
                </div>
                <h4 class="fw-bold text-dark mb-1">Mahabodhi Temple & Bodhi Tree</h4>
                <p class="text-muted small mb-0">Experience 360° views of the sacred Bodhi tree, ancient stone railings, and the 180-foot high main spire.</p>
            </div>
        </div>

        <!-- VR Spot 2 -->
        <div class="col-md-6">
            <div class="glass-card p-4 border bg-white rounded-4 shadow-sm h-100">
                <div class="position-relative rounded-4 overflow-hidden mb-3">
                    <img src="https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80" style="height: 280px; width: 100%; object-fit: cover;" alt="Nalanda Ruins VR" />
                    <div class="position-absolute top-50 start-50 translate-middle">
                        <button class="btn btn-danger btn-lg rounded-circle p-3 shadow-lg animate-pulse-glow open-vr-btn" data-title="Ancient Nalanda University 360° Virtual Tour" data-pano="https://pannellum.org/images/cerro-toco.jpg">
                            <i class="bi bi-play-circle-fill display-5 d-block"></i>
                        </button>
                    </div>
                    <span class="badge bg-dark position-absolute bottom-0 end-0 m-3"><i class="bi bi-badge-3d-fill me-1 text-warning"></i> 360° Panorama</span>
                </div>
                <h4 class="fw-bold text-dark mb-1">Ancient Nalanda University Ruins</h4>
                <p class="text-muted small mb-0">Walk virtually through the excavated red brick monasteries, Sariputra Stupa, and ancient lecture halls.</p>
            </div>
        </div>
    </div>
</div>

<!-- Interactive 360° VR Panorama Viewer Modal -->
<div class="modal fade" id="vrViewerModal" tabindex="-1" aria-labelledby="vrViewerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow-lg bg-dark text-white">
            <div class="modal-header border-0 bg-dark py-3">
                <h5 class="modal-title fw-bold text-white" id="vrViewerModalLabel"><i class="bi bi-badge-3d-fill text-danger me-2"></i> <span id="modal-vr-title">360° VR Panorama Viewer</span></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-0 position-relative" style="height: 520px; background: #000;">
                <div id="panorama" style="width: 100%; height: 100%;"></div>
                <div class="position-absolute bottom-0 start-0 m-3 px-3 py-1.5 rounded-pill bg-dark bg-opacity-75 text-white small">
                    <i class="bi bi-arrows-move me-1 text-warning"></i> Drag mouse or touch to look around 360°
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var viewer = null;
        var vrButtons = document.querySelectorAll(".open-vr-btn");
        var vrModalEl = document.getElementById("vrViewerModal");
        var vrModal = new bootstrap.Modal(vrModalEl);

        vrButtons.forEach(function(btn) {
            btn.addEventListener("click", function() {
                var title = btn.getAttribute("data-title");
                var panoUrl = btn.getAttribute("data-pano");
                
                document.getElementById("modal-vr-title").innerText = title;
                vrModal.show();

                setTimeout(function() {
                    if (viewer) {
                        try { viewer.destroy(); } catch(e) {}
                    }
                    viewer = pannellum.viewer('panorama', {
                        "type": "equirectangular",
                        "panorama": panoUrl,
                        "autoLoad": true,
                        "autoRotate": -2,
                        "compass": true,
                        "showControls": true
                    });
                }, 300);
            });
        });

        vrModalEl.addEventListener('hidden.bs.modal', function () {
            if (viewer) {
                try { viewer.destroy(); } catch(e) {}
                viewer = null;
            }
        });
    });
</script>

<%@ include file="/views/common/footer.jsp" %>

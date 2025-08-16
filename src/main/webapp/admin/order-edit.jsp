<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include-header.jsp" %>



    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }

        .main-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            overflow: hidden;
        }

        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
        }

        .order-id {
            background: rgba(255, 255, 255, 0.2);
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.9rem;
            margin-left: 0.5rem;
        }

        .form-section {
            padding: 2rem;
        }

        .form-control, .form-select {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #f59e0b;
            box-shadow: 0 0 0 4px rgba(245, 158, 11, 0.1);
        }

        .form-label {
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn {
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            border: none;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(245, 158, 11, 0.3);
            background: linear-gradient(135deg, #d97706, #b45309);
        }

        .btn-outline-secondary {
            border: 2px solid #e2e8f0;
            color: #6b7280;
        }

        .btn-outline-secondary:hover {
            background: #f8fafc;
            border-color: #f59e0b;
            color: #f59e0b;
        }

        .status-indicator {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .status-pending {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
        }

        .status-paid {
            background: rgba(16, 185, 129, 0.1);
            color: #10b981;
        }

        .status-delivered {
            background: rgba(59, 130, 246, 0.1);
            color: #3b82f6;
        }

        .status-cancelled {
            background: rgba(107, 114, 128, 0.1);
            color: #6b7280;
        }

        .payment-indicator {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .payment-cod {
            background: rgba(245, 158, 11, 0.1);
            color: #f59e0b;
        }

        .payment-vnpay {
            background: rgba(59, 130, 246, 0.1);
            color: #3b82f6;
        }

        .current-info {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .info-row:last-child {
            margin-bottom: 0;
        }

        .info-label {
            color: #6b7280;
            font-size: 0.9rem;
        }

        .alert {
            border: none;
            border-radius: 12px;
            padding: 1rem;
        }

        @media (max-width: 768px) {
            .page-header {
                padding: 1.5rem;
            }

            .form-section {
                padding: 1rem;
            }

            .current-info {
                padding: 1rem;
            }

            .info-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
        }
    </style>

<div class="container mt-4 mb-4">
    <div class="main-card">
        <!-- Header -->
        <div class="page-header">
            <h2 class="mb-0">
                <i class="bi bi-pencil-square me-2"></i>
                Sửa trạng thái đơn hàng
                <span class="order-id">#${order.id}</span>
            </h2>
        </div>

        <!-- Form Section -->
        <div class="form-section">
            <!-- Current Status Info -->
            <div class="current-info">
                <h6 class="mb-3">
                    <i class="bi bi-info-circle me-2"></i>
                    Thông tin hiện tại
                </h6>
                <div class="info-row">
                    <span class="info-label">Trạng thái:</span>
                    <div>
                        <c:choose>
                            <c:when test="${order.status == 0||order.status == 1}">
                                    <span class="status-indicator status-pending">
                                        <i class="bi bi-clock"></i>
                                        Đã đặt hàng
                                    </span>
                            </c:when>
                            <c:when test="${order.status == 2}">
                                    <span class="status-indicator status-paid">
                                        <i class="bi bi-check-circle"></i>
                                        Đã hủy
                                    </span>
                            </c:when>
                            <c:when test="${order.status == 3}">
                                    <span class="status-indicator status-delivered">
                                        <i class="bi bi-truck"></i>
                                        Đang giao
                                    </span>
                            </c:when>
                            <c:otherwise>
                                    <span class="status-indicator status-cancelled">
                                        <i class="bi bi-x-circle"></i>
                                        Đã giao
                                    </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="info-row">
                    <span class="info-label">Phương thức thanh toán:</span>
                    <div>
                        <c:choose>
                            <c:when test="${order.paymentMethod == 'COD'}">
                                    <span class="payment-indicator payment-cod">
                                        <i class="bi bi-cash"></i>
                                        COD
                                    </span>
                            </c:when>
                            <c:otherwise>
                                    <span class="payment-indicator payment-vnpay">
                                        <i class="bi bi-credit-card"></i>
                                        VNPay
                                    </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Alerts -->
            <c:if test="${param.success == '1'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i>
                    Cập nhật trạng thái đơn hàng thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                        ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Form -->
            <form action="${pageContext.request.contextPath}/admin-order?action=edit&id=${order.id}"
                  method="post"
                  id="orderForm">

                <div class="row g-4">
                    <!-- Status Selection -->
                    <div class="col-md-6">
                        <label for="status" class="form-label">
                            <i class="bi bi-flag"></i>
                            Trạng thái đơn hàng
                        </label>
                        <select id="status" name="status" class="form-select" required>
                            <option value="0" ${order.status == 0 || order.status == 1 ? 'selected' : ''}>
                                Đã đặt hàng
                            </option>
                            <option value="2" ${order.status == 2 ? 'selected' : ''}>
                                Đã hủy
                            </option>
                            <option value="3" ${order.status == 3 ? 'selected' : ''}>
                                Đang giao
                            </option>
                            <option value="4" ${order.status == 4 ? 'selected' : ''}>
                                Đã giao
                            </option>
                        </select>
                    </div>
                </div>

                <!-- Preview Changes -->
                <div id="previewChanges" class="alert alert-warning mt-3" style="display: none;">
                    <h6><i class="bi bi-info-circle me-2"></i>Xem trước thay đổi:</h6>
                    <div id="changesList"></div>
                </div>

                <!-- Buttons -->
                <div class="d-flex gap-2 mt-4">
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        <i class="bi bi-check-lg me-1"></i>
                        Cập nhật
                    </button>
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/manage-orders">
                        <i class="bi bi-arrow-left me-1"></i>
                        Quay lại
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const statusSelect = document.getElementById("status");
    const paymentSelect = document.getElementById("paymentMethod");
    const previewChanges = document.getElementById("previewChanges");
    const changesList = document.getElementById("changesList");
    const submitBtn = document.getElementById("submitBtn");

    // Original values
    const originalStatus = "${order.status}";
    const originalPayment = "${order.paymentMethod}";

    // Status names mapping
    const statusNames = {
        "0": "Đã đặt hàng",
        "1": "Đã đặt hàng",
        "2": "Đã hủy",
        "3": "Đang giao",
        "4": "Đã giao"
    };

    const paymentNames = {
        "COD": "COD (Thanh toán khi nhận hàng)",
        "VNPAY": "VNPay (Thanh toán online)"
    };

    // Auto-update payment method based on status
    statusSelect.addEventListener("change", function () {
        if (this.value === "1") { // Đã thanh toán
            paymentSelect.value = "VNPAY";
        } else if (this.value === "0") { // Chưa thanh toán
            paymentSelect.value = "COD";
        }
        updatePreview();
    });

    paymentSelect.addEventListener("change", updatePreview);

    function updatePreview() {
        const currentStatus = statusSelect.value;
        const currentPayment = paymentSelect.value;

        const hasChanges = currentStatus !== originalStatus || currentPayment !== originalPayment;

        if (hasChanges) {
            let changes = [];

            if (currentStatus !== originalStatus) {
                changes.push(`Trạng thái: ${statusNames[originalStatus]} → ${statusNames[currentStatus]}`);
            }

            if (currentPayment !== originalPayment) {
                changes.push(`Phương thức: ${paymentNames[originalPayment]} → ${paymentNames[currentPayment]}`);
            }

            changesList.innerHTML = changes.map(change => `• ${change}`).join('<br>');
            previewChanges.style.display = 'block';

            submitBtn.innerHTML = '<i class="bi bi-exclamation-circle me-1"></i> Cập nhật thay đổi';
            submitBtn.classList.remove('btn-secondary');
            submitBtn.classList.add('btn-primary');
        } else {
            previewChanges.style.display = 'none';
            submitBtn.innerHTML = '<i class="bi bi-check-lg me-1"></i> Cập nhật';
            submitBtn.classList.remove('btn-primary');
            submitBtn.classList.add('btn-secondary');
        }
    }

    // Form validation
    document.getElementById('orderForm').addEventListener('submit', function(e) {
        const currentStatus = statusSelect.value;
        const currentPayment = paymentSelect.value;

        // Validate payment method for paid status
        if (currentStatus === "1" && currentPayment === "COD") {
            e.preventDefault();
            alert("Đơn hàng đã thanh toán không thể sử dụng phương thức COD!");
            paymentSelect.focus();
            return;
        }

        // Show loading state
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Đang cập nhật...';
        submitBtn.disabled = true;
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey && e.key === 's') {
            e.preventDefault();
            document.getElementById('orderForm').submit();
        }
    });

    // Initialize preview
    updatePreview();
</script>

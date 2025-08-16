<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- DÙNG dynamic include để tránh xung đột page directive -->
<jsp:include page="../include-header.jsp" />

<!-- Bootstrap CSS & Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    .order-detail-page {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        min-height: calc(100vh - 200px);
        padding: 40px 0;
        position: relative;
    }

    .order-detail-page::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(0,0,0,0.02)"/><circle cx="75" cy="75" r="1" fill="rgba(0,0,0,0.02)"/></pattern></defs><rect width="100" height="20" fill="url(%23grain)"/></svg>');
        pointer-events: none;
    }


    .alert-success-modern {
        background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
        color: #155724;
    }

    .alert-danger-modern {
        background: linear-gradient(135deg, #f8d7da 0%, #f1b0b7 100%);
        color: #721c24;
    }

    .detail-card {
        background: white;
        border-radius: 20px;
        margin-bottom: 30px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        border: 1px solid rgba(0, 0, 0, 0.05);
        overflow: hidden;
        position: relative;
    }

    .detail-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 5px;
        height: 100%;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }

    .card-header-modern {
        background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        padding: 25px 30px;
        position: relative;
    }

    .card-title-modern {
        font-size: 1.4rem;
        font-weight: 700;
        color: #2c3e50;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .card-title-modern i {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1rem;
    }

    .cancel-btn-header {
        padding: 10px 20px;
        border-radius: 25px;
        background: linear-gradient(135deg, #fd79a8 0%, #e84393 100%);
        color: white;
        border: none;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .cancel-btn-header:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(232, 67, 147, 0.3);
        color: white;
    }

    .card-body-modern {
        padding: 30px;
    }

    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 25px;
        margin-bottom: 0;
    }

    .info-item {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .info-label {
        font-weight: 600;
        color: #6c757d;
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .info-value {
        font-size: 1.1rem;
        color: #2c3e50;
        font-weight: 600;
    }

    .status-badge-large {
        padding: 10px 20px;
        border-radius: 25px;
        font-weight: 700;
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        margin-top: 5px;
    }

    .status-pending-large {
        background: linear-gradient(135deg, #ffeaa7 0%, #fdcb6e 100%);
        color: #2d3436;
    }

    .status-paid-large {
        background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
        color: white;
    }

    .status-completed-large {
        background: linear-gradient(135deg, #00b894 0%, #00a085 100%);
        color: white;
    }

    .status-cancelled-large {
        background: linear-gradient(135deg, #636e72 0%, #2d3436 100%);
        color: white;
    }

    .customer-info {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        padding: 25px;
        border-radius: 15px;
        margin-top: 20px;
    }

    .customer-info h6 {
        justify-content: center;
        color: #2c3e50;
        font-weight: 700;
        margin-bottom: 15px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .customer-info h6 i {
        color: #667eea;
    }

    .table-modern {
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        margin-bottom: 0;
    }

    .table-modern thead th {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        font-weight: 600;
        padding: 20px;
        border: none;
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .table-modern tbody td {
        padding: 20px;
        vertical-align: middle;
        border-top: 1px solid rgba(0, 0, 0, 0.1);
        background: white;
    }

    .table-modern tbody tr:nth-child(even) td {
        background: #f8f9fa;
    }

    .table-modern tbody tr:hover td {
        background: #e3f2fd;
        transform: scale(1.01);
        transition: all 0.2s ease;
    }

    .book-title-cell {
        font-weight: 600;
        color: #2c3e50;
        font-size: 1rem;
    }

    .price-cell {
        font-weight: 600;
        color: #28a745;
        font-size: 1rem;
    }

    .quantity-cell {
        background: #667eea;
        color: white;
        padding: 8px 16px;
        border-radius: 20px;
        font-weight: 600;
        display: inline-block;
        min-width: 50px;
        text-align: center;
    }

    .total-row {
        background: orange;
        color: white;
    }

    .total-row td {
        font-weight: 700;
        font-size: 1.2rem;
        background: transparent !important;
    }

    .back-button {
        background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
        color: white;
        padding: 12px 30px;
        border-radius: 25px;
        font-weight: 600;
        border: none;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 10px;
    }

    .back-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(108, 117, 125, 0.3);
        color: white;
    }

    .action-section {
        background: white;
        border-radius: 20px;
        padding: 25px 30px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        margin-top: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
    }

    .breadcrumb-modern {
        background: white;
        padding: 15px 25px;
        border-radius: 15px;
        margin-bottom: 25px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .breadcrumb-modern .breadcrumb {
        margin: 0;
        background: none;
        padding: 0;
    }

    .breadcrumb-modern .breadcrumb-item a {
        color: #667eea;
        text-decoration: none;
        font-weight: 500;
    }

    .breadcrumb-modern .breadcrumb-item a:hover {
        color: #764ba2;
    }

    .breadcrumb-modern .breadcrumb-item.active {
        color: #2c3e50;
        font-weight: 600;
    }

    .timeline-status {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 20px;
        background: #f8f9fa;
        border-radius: 15px;
        margin-top: 20px;
    }

    .timeline-step {
        display: flex;
        flex-direction: column;
        align-items: center;
        flex: 1;
        position: relative;
    }

    .timeline-step:not(:last-child)::after {
        content: '';
        position: absolute;
        top: 20px;
        right: -50%;
        width: 100%;
        height: 2px;
        background: #e9ecef;
        z-index: 1;
    }

    .timeline-icon {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 0.9rem;
        margin-bottom: 8px;
        position: relative;
        z-index: 2;
    }

    .timeline-icon.active {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }

    .timeline-icon.inactive {
        background: #e9ecef;
        color: #6c757d;
    }

    .timeline-label {
        font-size: 0.8rem;
        text-align: center;
        font-weight: 500;
        color: #6c757d;
    }

    .timeline-label.active {
        color: #2c3e50;
        font-weight: 600;
    }

    @media (max-width: 768px) {
        .order-detail-page {
            padding: 20px 0;
        }

        .detail-card {
            border-radius: 15px;
            margin-bottom: 20px;
        }

        .card-header-modern {
            padding: 20px;
            flex-direction: column;
            align-items: flex-start;
            gap: 15px;
        }

        .card-body-modern {
            padding: 20px;
        }

        .card-title-modern {
            font-size: 1.2rem;
        }

        .info-grid {
            grid-template-columns: 1fr;
            gap: 20px;
        }

        .table-modern thead th,
        .table-modern tbody td {
            padding: 15px 10px;
            font-size: 0.9rem;
        }

        .action-section {
            padding: 20px;
            flex-direction: column;
            align-items: stretch;
        }

        .timeline-status {
            flex-direction: column;
            gap: 20px;
        }

        .timeline-step {
            flex-direction: row;
            justify-content: flex-start;
        }

        .timeline-step:not(:last-child)::after {
            display: none;
        }

        .timeline-icon {
            margin-bottom: 0;
            margin-right: 15px;
        }

        .timeline-label {
            text-align: left;
        }

        .breadcrumb-modern {
            padding: 12px 20px;
            border-radius: 10px;
        }
    }

    @media (max-width: 576px) {
        .info-value {
            font-size: 1rem;
        }

        .status-badge-large {
            padding: 8px 16px;
            font-size: 0.8rem;
        }

        .table-responsive {
            font-size: 0.85rem;
        }

        .book-title-cell {
            font-size: 0.9rem;
        }
    }
</style>

<div class="order-detail-page">
    <div class="container">
        <!-- Breadcrumb -->
        <div class="breadcrumb-modern">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-1"></i>Trang chủ
                        </a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/user-orders">
                            <i class="fas fa-history me-1"></i>Lịch sử đơn hàng
                        </a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">
                        <i class="fas fa-receipt me-1"></i>Chi tiết đơn hàng
                    </li>
                </ol>
            </nav>
        </div>

        <!-- Flash Messages -->
        <c:if test="${not empty sessionScope.flash}">
            <div class="alert alert-success-modern">
                <i class="fas fa-check-circle me-2"></i>
                    ${sessionScope.flash}
            </div>
            <c:remove var="flash" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.flash_err}">
            <div class="alert alert-danger-modern">
                <i class="fas fa-exclamation-triangle me-2"></i>
                    ${sessionScope.flash_err}
            </div>
            <c:remove var="flash_err" scope="session"/>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger-modern">
                <i class="fas fa-exclamation-triangle me-2"></i>
                    ${error}
            </div>
        </c:if>

        <c:if test="${not empty order}">
            <!-- Order Information Card -->
            <div class="detail-card">
                <div class="card-header-modern d-flex justify-content-between align-items-center flex-wrap gap-3">
                    <h2 class="card-title-modern">
                        <i class="fas fa-file-invoice-dollar"></i>
                        Thông tin đơn hàng
                    </h2>
                    <c:if test="${order.status == 0}">
                        <form method="post" action="${pageContext.request.contextPath}/cancel-order"
                              onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${order.id}? Hành động này không thể hoàn tác.');"
                              class="m-0">
                            <input type="hidden" name="orderId" value="${order.id}">
                            <button type="submit" class="cancel-btn-header">
                                <i class="fas fa-times"></i>
                                Hủy đơn hàng
                            </button>
                        </form>
                    </c:if>
                </div>

                <div class="card-body-modern">
                    <div class="info-grid">
                        <div class="text-center info-item">
                            <span class="info-label">Mã đơn hàng</span>
                            <span class="info-value">#${order.id}</span>
                        </div>

                        <div class="text-center info-item">
                            <span class="info-label">Ngày đặt hàng</span>
                            <span class=" info-value">
                                <i class="far fa-calendar-alt me-2"></i>
                                ${order.createdAt}
                            </span>
                        </div>

                        <div class="text-center info-item">
                            <span class="info-label">Phương thức thanh toán</span>
                            <span class="info-value">
                                <i class="fas fa-credit-card me-2"></i>
                                ${order.paymentMethod}
                            </span>
                        </div>

                        <div class="text-center info-item">
                            <span class="info-label">Trạng thái đơn hàng</span>
                            <div>
                                <c:choose>
                                    <c:when test="${order.status == 0||order.status == 1}">
                                        <span class="status-badge-large status-pending-large">
                                            <i class="fas fa-clock"></i>
                                            Đã đặt hàng
                                        </span>
                                    </c:when>
                                    <c:when test="${order.status == 2}">
                                        <span class="status-badge-large status-paid-large">
                                            <i class="fas fa-check-circle"></i>
                                            Đã Hủy
                                        </span>
                                    </c:when>
                                    <c:when test="${order.status == 3}">
                                        <span class="status-badge-large status-completed-large">
                                            <i class="fas fa-box-open"></i>
                                            Đang giao hàng
                                        </span>
                                    </c:when>
                                    <c:when test="${order.status == 4}">
                                        <span class="status-badge-large status-cancelled-large">
                                            <i class="fas fa-times-circle"></i>
                                            Đã giao hàng
                                        </span>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Order Status Timeline -->
                    <div class="timeline-status">
                        <div class="timeline-step">
                            <div class="timeline-icon ${order.status >= 0 ? 'active' : 'inactive'}">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <div class="timeline-label ${order.status >= 0 ? 'active' : ''}">Đã đặt hàng</div>
                        </div>

                        <div class="timeline-step">
                            <div class="timeline-icon ${order.status >= 2 ? 'active' : 'inactive'}">
                                <i class="fas fa-credit-card"></i>
                            </div>
                            <div class="timeline-label ${order.status >= 2 ? 'active' : ''}">Đã hủy</div>
                        </div>

                        <div class="timeline-step">
                            <div class="timeline-icon ${order.status >= 3 ? 'active' : 'inactive'}">
                                <i class="fas fa-shipping-fast"></i>
                            </div>
                            <div class="timeline-label ${order.status >= 3 ? 'active' : ''}">Giao hàng</div>
                        </div>

                        <div class="timeline-step">
                            <div class="timeline-icon ${order.status >= 4 ? 'active' : 'inactive'}">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="timeline-label ${order.status >= 4 ? 'active' : ''}">Hoàn thành</div>
                        </div>
                    </div>

                    <!-- Customer Information -->
                    <div class=" customer-info">
                        <h6 class="text-center">
                            <i class="fas fa-user"></i>
                            Thông tin khách hàng
                        </h6>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="text-center info-item">
                                    <span class="info-label">Họ và tên</span>
                                    <span class="info-value">${customerName}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="text-center info-item">
                                    <span class="info-label">Email</span>
                                    <span class="info-value">${customerEmail}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Products Card -->
            <div class="detail-card">
                <div class="card-header-modern">
                    <h3 class="card-title-modern">
                        <i class="fas fa-list"></i>
                        Chi tiết sản phẩm
                    </h3>
                </div>

                <div class="card-body-modern">
                    <fmt:setLocale value="vi_VN"/>
                    <div class="table-responsive">
                        <table class="table table-modern">
                            <thead>
                            <tr>
                                <th class="text-center" style="width: 50%">Tên sách</th>
                                <th class="text-center" style="width: 20%">Đơn giá</th>
                                <th class="text-center" style="width: 15%">Số lượng</th>
                                <th class="text-center" style="width: 15%">Thành tiền</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="it" items="${order.items}">
                                <tr>
                                    <td class="text-center book-title-cell">
                                        <i class="fas fa-book me-2 text-muted"></i>
                                            ${it.title}
                                    </td>
                                    <td class="text-center price-cell">
                                        <fmt:formatNumber value="${it.price}" type="currency"/>
                                    </td>
                                    <td class="text-center">
                                        <span class="quantity-cell">${it.quantity}</span>
                                    </td>
                                    <td class="text-center price-cell">
                                        <c:choose>
                                            <c:when test="${not empty it.lineTotal}">
                                                <fmt:formatNumber value="${it.lineTotal}" type="currency"/>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${it.price * it.quantity}" type="currency"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr class="total-row">
                                <td colspan="3" class="text-end">
                                    <i class="fas fa-calculator me-2"></i>
                                    <strong>Tổng cộng</strong>
                                </td>
                                <td class="text-end">
                                    <strong><fmt:formatNumber value="${order.totalAmount}" type="currency"/></strong>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>

                    <!-- Order Summary Stats -->
                    <div class="row mt-4">
                        <div class="col-md-4 col-sm-6 mb-3">
                            <div class="text-center p-3 bg-light rounded-3">
                                <i class="fas fa-books text-primary fs-4 mb-2 d-block"></i>
                                <div class="fw-bold">${fn:length(order.items)}</div>
                                <small class="text-muted">Loại sách</small>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-6 mb-3">
                            <div class="text-center p-3 bg-light rounded-3">
                                <i class="fas fa-layer-group text-success fs-4 mb-2 d-block"></i>
                                <div class="fw-bold">
                                    <c:set var="totalQty" value="0"/>
                                    <c:forEach var="it" items="${order.items}">
                                        <c:set var="totalQty" value="${totalQty + it.quantity}"/>
                                    </c:forEach>
                                        ${totalQty}
                                </div>
                                <small class="text-muted">Tổng số lượng</small>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-12 mb-3">
                            <div class="text-center p-3 bg-light rounded-3">
                                <i class="fas fa-money-bill-wave text-warning fs-4 mb-2 d-block"></i>
                                <div class="fw-bold">
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency"/>
                                </div>
                                <small class="text-muted">Tổng giá trị</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Action Section -->
            <div class="action-section">
                <a href="${pageContext.request.contextPath}/user-orders" class="btn btn-success">
                    <i class="fas fa-arrow-left"></i>
                    Quay lại lịch sử đơn hàng
                </a>

                <a href="${pageContext.request.contextPath}/user-book-store" class="btn btn-success">
                    <i class="fas fa-store"></i>
                    Tiếp tục mua sắm
                </a>
            </div>
        </c:if>

        <!-- If no order found -->
        <c:if test="${empty order}">
            <div class="detail-card">
                <div class="card-body-modern text-center">
                    <div class="empty-icon mx-auto mb-4" style="width: 100px; height: 100px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 2.5rem;">
                        <i class="fas fa-search"></i>
                    </div>
                    <h3 class="mb-3" style="color: #2c3e50;">Không tìm thấy đơn hàng</h3>
                    <p class="text-muted mb-4">Đơn hàng bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                    <a href="${pageContext.request.contextPath}/user-orders" class="btn btn-success">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại lịch sử đơn hàng
                    </a>
                </div>
            </div>
        </c:if>
    </div>
</div>

<!-- DÙNG dynamic include cho footer -->
<jsp:include page="../footer.jsp" />
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            overflow: hidden;
        }

        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem;
        }

        .stats-bar {
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            padding: 1rem;
        }

        .stat-item {
            text-align: center;
            padding: 0.5rem;
        }

        .stat-number {
            font-size: 1.5rem;
            font-weight: 700;
            color: #059669;
        }

        .stat-label {
            font-size: 0.85rem;
            color: #6b7280;
        }

        .table-container {
            background: white;
            border-radius: 0 0 15px 15px;
        }

        .table th {
            background: #1f2937;
            color: white;
            border: none;
            padding: 1rem 0.75rem;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .table td {
            padding: 1rem 0.75rem;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
        }

        .table tbody tr:hover {
            background: rgba(5, 150, 105, 0.05);
        }

        .customer-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, #059669, #047857);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 0.9rem;
            margin-right: 0.75rem;
        }

        .order-id {
            font-family: 'Courier New', monospace;
            font-weight: 600;
            color: #1f2937;
        }

        .price {
            font-weight: 700;
            color: #059669;
        }

        .badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.8rem;
        }

        .btn {
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-primary:hover {
            transform: translateY(-1px);
        }

        .btn-outline-secondary:hover {
            transform: translateY(-1px);
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6b7280;
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        @media (max-width: 768px) {
            .page-header {
                padding: 1rem;
            }

            .table-responsive {
                font-size: 0.85rem;
            }

            .btn-group {
                flex-direction: column;
                gap: 0.25rem;
            }

            .btn-group .btn {
                border-radius: 8px !important;
            }
        }
    </style>
</head>
<body>
<div class="container mt-4 mb-4">
    <div class="main-card">
        <!-- Header -->
        <div class="page-header">
            <h2 class="mb-0">
                <i class="bi bi-receipt-cutoff me-2"></i>
                Quản lý đơn hàng
            </h2>
        </div>

        <!-- Stats -->
        <div class="stats-bar">
            <div class="row">
                <div class="col-3">
                    <div class="stat-item">
                        <div class="stat-number">${fn:length(orders)}</div>
                        <div class="stat-label">Tổng đơn</div>
                    </div>
                </div>
                <div class="col-3">
                    <div class="stat-item">
                        <div class="stat-number">
                            <c:set var="orderedCount" value="0"/>
                            <c:forEach var="order" items="${orders}">
                                <c:if test="${order.status == 0||order.status == 1}">
                                    <c:set var="orderedCount" value="${orderedCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${orderedCount}
                        </div>
                        <div class="stat-label">Đã đặt hàng</div>
                    </div>
                </div>
                <div class="col-3">
                    <div class="stat-item">
                        <div class="stat-number">
                            <c:set var="canceledCount" value="0"/>
                            <c:forEach var="order" items="${orders}">
                                <c:if test="${order.status == 2}">
                                    <c:set var="canceledCount" value="${canceledCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${canceledCount}
                        </div>
                        <div class="stat-label">Đã hủy</div>
                    </div>
                </div>
                <div class="col-3">
                    <div class="stat-item">
                        <div class="stat-number">
                            <c:set var="deliveryCount" value="0"/>
                            <c:forEach var="order" items="${orders}">
                                <c:if test="${order.status == 3}">
                                    <c:set var="deliveryCount" value="${deliveryCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${deliveryCount}
                        </div>
                        <div class="stat-label">Đang giao hàng</div>
                    </div>
                </div>
                <div class="col-3">
                    <div class="stat-item">
                        <div class="stat-number">
                            <c:set var="deliveredCount" value="0"/>
                            <c:forEach var="order" items="${orders}">
                                <c:if test="${order.status == 4}">
                                    <c:set var="deliveredCount" value="${deliveredCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${deliveredCount}
                        </div>
                        <div class="stat-label">Đã giao hàng</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Table -->
        <div class="table-container">
            <c:choose>
                <c:when test="${not empty orders}">
                    <div class="table-responsive">
                        <table class="text-center table mb-0">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Khách hàng</th>
                                <th>Tổng tiền</th>
                                <th>Ngày đặt</th>
                                <th>Trạng thái</th>
                                <th>Thanh toán</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>
                                        <span class="order-id">#${order.id}</span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="customer-avatar">
                                                    ${fn:substring(order.customerName, 0, 1)}
                                            </div>
                                            <div>
                                                <div class="fw-semibold">${order.customerName}</div>
                                                <small class="text-muted">ID: ${order.userId}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                                <span class="price">
                                                    <fmt:formatNumber value="${order.totalPrice}" pattern="#,###"/>đ
                                                </span>
                                    </td>
                                    <td>
                                        <div>
                                                ${order.orderDate}
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status == 0||order.status == 1}">
                                                <span class="badge bg-primary">Đã đặt hàng</span>
                                            </c:when>
                                            <c:when test="${order.status == 2}">
                                                <span class="badge bg-danger">Đã hủy</span>
                                            </c:when>
                                            <c:when test="${order.status == 3}">
                                                <span class="badge bg-warning">Đang giao hàng</span>
                                            </c:when>
                                            <c:when test="${order.status == 4}">
                                                <span class="badge bg-success">Đã giao hàng</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.paymentMethod == 'VNPAY'}">
                                                        <span class="badge bg-primary">
                                                            <i class="bi bi-credit-card"></i> VNPay
                                                        </span>
                                            </c:when>
                                            <c:when test="${order.paymentMethod == 'COD'}">
                                                        <span class="badge bg-warning text-dark">
                                                            <i class="bi bi-cash"></i> COD
                                                        </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-light text-secondary">Khác</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a class="btn btn-outline-primary"
                                               href="${pageContext.request.contextPath}/admin-order?id=${order.id}">
                                                <i class="bi bi-eye"></i>
                                                <span class="d-none d-md-inline"> Xem</span>
                                            </a>
                                            <a class="btn btn-outline-secondary"
                                               href="${pageContext.request.contextPath}/admin-order?action=edit&id=${order.id}">
                                                <i class="bi bi-pencil-square"></i>
                                                <span class="d-none d-md-inline"> Sửa</span>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Footer -->
                    <div class="p-3 bg-light border-top">
                        <div class="d-flex justify-content-between align-items-center text-muted">
                            <small>
                                <i class="bi bi-info-circle me-1"></i>
                                Hiển thị ${fn:length(orders)} đơn hàng
                            </small>
                            <small>
                                <c:set var="totalRevenue" value="0"/>
                                <c:forEach var="order" items="${orders}">
                                    <c:if test="${order.status == 1 || order.status == 4}">
                                        <c:set var="totalRevenue" value="${totalRevenue + order.totalPrice}"/>
                                    </c:if>
                                </c:forEach>
                                Doanh thu: <strong class="text-success">
                                <fmt:formatNumber value="${totalRevenue}" pattern="#,###"/>đ
                            </strong>
                            </small>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="bi bi-inbox text-muted"></i>
                        <h5>Chưa có đơn hàng nào</h5>
                        <p class="text-muted">Các đơn hàng mới sẽ hiển thị ở đây</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="../footer.jsp" %>
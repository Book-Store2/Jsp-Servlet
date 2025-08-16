<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include-header.jsp" %>

  <style>
    body {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      font-family: 'Segoe UI', sans-serif;
    }

    .order-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .order-header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 1.5rem;
      border-radius: 15px 15px 0 0;
    }

    .table {
      background: white;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
    }

    .table th {
      background: #1f2937;
      color: white;
      border: none;
      padding: 1rem;
    }

    .table td {
      padding: 1rem;
      border-bottom: 1px solid #f1f5f9;
    }

    .table tbody tr:hover {
      background: #f8fafc;
    }

    .btn {
      border-radius: 10px;
      padding: 0.75rem 1.5rem;
      font-weight: 600;
    }

    .btn-secondary {
      background: #6b7280;
      border: none;
    }

    .btn-secondary:hover {
      background: #4b5563;
    }

    .info-item {
      background: white;
      border-radius: 10px;
      padding: 1rem;
      margin-bottom: 1rem;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .info-label {
      color: #6b7280;
      font-size: 0.9rem;
      margin-bottom: 0.25rem;
    }

    .info-value {
      color: #1f2937;
      font-weight: 600;
      font-size: 1.1rem;
    }

    .total-price {
      color: #10b981;
      font-size: 1.3rem;
    }
  </style>
</head>
<body>
<div class="container mt-4 mb-4">
  <div class="text-center  order-card">
    <!-- Header -->
    <div class="order-header">
      <h3 class="mb-0">
        <i class="bi bi-receipt me-2"></i>
        Chi tiết đơn hàng #${order.id}
      </h3>
    </div>

    <!-- Order Info -->
    <div class="p-4">
      <div class="row mb-4">
        <div class="col-md-4">
          <div class="info-item">
            <div class="info-label">Khách hàng</div>
            <div class="info-value">${order.customerName}</div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="info-item">
            <div class="info-label">Ngày đặt</div>
            <div class="info-value">${order.orderDate}</div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="info-item">
            <div class="info-label">Tổng tiền</div>
            <div class="info-value total-price">
              <span class="book-price">
    <fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###" />đ
</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Products -->
      <h4 class="mb-3">
        <i class="bi bi-box-seam me-2"></i>
        Sản phẩm trong đơn hàng
      </h4>

      <div class="table-responsive">
        <table class="text-center  table">
          <thead>
          <tr>
            <th>ID sách</th>
            <th>Tên sách</th>
            <th>Số lượng</th>
            <th>Giá</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach items="${orderDetails}" var="item">
            <tr>
              <td>#${item.bookId}</td>
              <td>${item.bookTitle}</td>
              <td>
                <span class="badge bg-success">${item.quantity}</span>
              </td>
              <td class="fw-bold text-success">
                <span class="book-price">
    <fmt:formatNumber value="${item.price}" type="number" pattern="#,###" />đ
</span>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>

      <!-- Actions -->
      <div class="mt-4 text-center">
        <a href="/manage-orders" class="btn btn-secondary">
          <i class="bi bi-arrow-left me-1"></i>
          Quay lại
        </a>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

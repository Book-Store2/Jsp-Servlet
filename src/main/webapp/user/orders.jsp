<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include-header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Bootstrap CSS & Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
  .orders-page {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: calc(100vh - 200px);
    padding: 40px 0;
    position: relative;
  }

  .orders-page::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(0,0,0,0.02)"/><circle cx="75" cy="75" r="1" fill="rgba(0,0,0,0.02)"/></pattern></defs><rect width="100" height="20" fill="url(%23grain)"/></svg>');
    pointer-events: none;
  }

  .page-header {
    background: white;
    border-radius: 20px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(102, 126, 234, 0.1);
    position: relative;
    overflow: hidden;
  }

  .page-header::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 5px;
    height: 100%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  }

  .page-title {
    font-size: 2rem;
    font-weight: 700;
    color: black;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 15px;
  }

  .page-title i {
    width: 50px;
    height: 50px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.2rem;
  }

  .empty-state {
    background: white;
    border-radius: 20px;
    padding: 60px 30px;
    text-align: center;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    margin-bottom: 30px;
  }

  .empty-icon {
    width: 100px;
    height: 100px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 25px;
    color: white;
    font-size: 2.5rem;
  }

  .empty-title {
    font-size: 1.5rem;
    font-weight: 600;
    color: #2c3e50;
    margin-bottom: 15px;
  }

  .empty-subtitle {
    color: #6c757d;
    margin-bottom: 30px;
  }

  .order-card {
    background: white;
    border-radius: 20px;
    margin-bottom: 25px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
    border: 1px solid rgba(0, 0, 0, 0.05);
    transition: all 0.3s ease;
    overflow: hidden;
    position: relative;
  }

  .order-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 40px rgba(102, 126, 234, 0.15);
  }

  .order-header {
    padding: 25px 30px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    background: #d3d0d0;
    position: relative;
  }

  .order-id {
    font-size: 1.2rem;
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 5px;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .order-date {
    color: #6c757d;
    font-size: 0.9rem;
  }

  .order-badges {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
    margin-top: 15px;
  }

  .status-badge {
    padding: 8px 16px;
    border-radius: 25px;
    font-weight: 600;
    font-size: 0.85rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    border: none;
    display: inline-flex;
    align-items: center;
    gap: 6px;
  }

  .status-pending {
    background: linear-gradient(135deg, #ffeaa7 0%, #fdcb6e 100%);
    color: #2d3436;
  }

  .status-paid {
    background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
    color: white;
  }

  .status-completed {
    background: linear-gradient(135deg, #00b894 0%, #00a085 100%);
    color: white;
  }

  .status-cancelled {
    background: linear-gradient(135deg, #636e72 0%, #2d3436 100%);
    color: white;
  }
  .status-delivery {
    background: linear-gradient(135deg, #bf8637 0%, #685d04 100%);
    color: white;
  }

  .payment-badge {
    background: rgba(102, 126, 234, 0.1);
    color: #667eea;
    border: 1px solid rgba(102, 126, 234, 0.2);
  }

  .order-body {
    padding: 25px 30px;
  }

  .order-total {
    font-size: 1.5rem;
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .order-total i {
    color: #28a745;
  }

  .order-actions {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
  }


  .btn-primary-modern {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
  }

  .btn-primary-modern:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
    color: white;
  }

  .btn-danger-modern {
    background: linear-gradient(135deg, #fd79a8 0%, #e84393 100%);
    color: white;
  }

  .btn-danger-modern:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(232, 67, 147, 0.3);
    color: white;
  }

  .btn-success-modern {
    background: linear-gradient(135deg, #00b894 0%, #00a085 100%);
    color: white;
    padding: 15px 40px;
    font-size: 1.1rem;
    margin-top: 30px;
  }

  .btn-success-modern:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 30px rgba(0, 184, 148, 0.3);
    color: white;
  }

  .order-items-preview {
    background: #f8f9fa;
    border-radius: 15px;
    padding: 20px;
    margin-top: 20px;
  }

  .items-table {
    margin: 0;
  }

  .items-table th {
    background: none;
    border: none;
    padding: 8px 12px;
    font-weight: 600;
    color: #495057;
    font-size: 0.9rem;
  }

  .items-table td {
    width: 33.3%;
    border: none;
    padding: 12px;
    vertical-align: middle;
    color: #2c3e50;
  }

  .items-table tbody tr:nth-child(even) {
    background: rgba(255, 255, 255, 0.5);
  }

  .book-title {
    font-weight: 600;
    color: #2c3e50;
  }

  .quantity-badge {
    background: #667eea;
    color: white;
    padding: 4px 12px;
    border-radius: 15px;
    font-weight: 600;
    font-size: 0.8rem;
  }

  .price-text {
    font-weight: 600;
    color: #28a745;
  }

  .action-buttons {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 20px;
    margin-top: 40px;
    padding-top: 30px;
    border-top: 1px solid rgba(0, 0, 0, 0.1);
  }

  @media (max-width: 768px) {
    .orders-page {
      padding: 20px 0;
    }

    .page-header {
      padding: 20px;
      margin-bottom: 20px;
      border-radius: 15px;
    }

    .page-title {
      font-size: 1.5rem;
      flex-direction: column;
      text-align: center;
      gap: 10px;
    }

    .order-card {
      border-radius: 15px;
      margin-bottom: 20px;
    }

    .order-header {
      padding: 20px;
    }

    .order-body {
      padding: 20px;
    }

    .order-id {
      font-size: 1rem;
    }

    .order-total {
      font-size: 1.3rem;
    }

    .order-actions {
      justify-content: center;
    }


    .empty-state {
      padding: 40px 20px;
      border-radius: 15px;
    }

    .empty-icon {
      width: 80px;
      height: 80px;
      font-size: 2rem;
    }

    .action-buttons {
      flex-direction: column;
      align-items: stretch;
    }
  }

  @media (max-width: 576px) {
    .order-badges {
      justify-content: center;
    }

    .status-badge {
      padding: 6px 12px;
      font-size: 0.75rem;
    }

    .items-table {
      font-size: 0.85rem;
    }

    .items-table th,
    .items-table td {
      padding: 8px 6px;
    }
  }
</style>

<div class="orders-page">
  <div class="container">
    <!-- Page Header -->
    <div class="page-header">
      <h1 class="page-title">
        <i class="fas fa-history"></i>
        Lịch sử đơn hàng
      </h1>
    </div>

    <c:choose>
      <c:when test="${empty orders}">
        <!-- Empty State -->
        <div class="empty-state">
          <div class="empty-icon">
            <i class="fas fa-shopping-bag"></i>
          </div>
          <h3 class="empty-title">Chưa có đơn hàng nào</h3>
          <p class="empty-subtitle">
            Bạn chưa thực hiện đơn hàng nào. Hãy khám phá cửa hàng và tìm những cuốn sách yêu thích!
          </p>
          <a href="${pageContext.request.contextPath}/user-book-store" class="btn btn-success-modern">
            <i class="fas fa-store"></i>
            Khám phá cửa hàng
          </a>
        </div>
      </c:when>
      <c:otherwise>
        <!-- Orders List -->
        <div class="row">
          <c:forEach var="o" items="${orders}">
            <div class="col-12">
              <div class="order-card">
                <!-- Order Header -->
                <div class="order-header">
                  <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
                    <div>
                      <div class="order-id">
                        <i class="fas fa-receipt"></i>
                        Đơn hàng #${o.id}
                      </div>
                      <div class="order-date">
                        <i class="far fa-calendar-alt me-1"></i>
                          ${o.createdAt}
                      </div>
                    </div>

                    <div class="order-badges">
                                            <span class="status-badge payment-badge">
                                                <i class="fas fa-credit-card"></i>
                                                ${o.paymentMethod}
                                            </span>
                      <c:choose>
                        <c:when test="${o.status == 0}">
                                                    <span class="status-badge status-pending">
                                                        <i class="fas fa-clock"></i>
                                                        Chưa thanh toán
                                                    </span>
                        </c:when>
                        <c:when test="${o.status == 1}">
                                                    <span class="status-badge status-paid">
                                                        <i class="fas fa-check-circle"></i>
                                                        Đã thanh toán
                                                    </span>
                        </c:when>
                        <c:when test="${o.status == 2}">
                                                    <span class="status-badge status-cancelled">
                                                        <i class="fas fa-box-open"></i>
                                                        Đã hủy
                                                    </span>
                        </c:when>
                        <c:when test="${o.status == 3}">
                                                    <span class="status-badge status-delivery">
                                                        <i class="fas fa-times-circle"></i>
                                                        Đang vận chuyển
                                                    </span>
                        </c:when>
                        <c:when test="${o.status == 4}">
                                                    <span class="status-badge status-completed">
                                                        <i class="fas fa-times-circle"></i>
                                                        Đã nhận
                                                    </span>
                        </c:when>
                      </c:choose>
                    </div>
                  </div>
                </div>

                <!-- Order Body -->
                <div class="order-body">
                  <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-3">
                    <div class="order-total">
                      <label>Giá trị đơn hàng: </label>
                      <i class="fas fa-money-bill-wave"></i>
                      <fmt:setLocale value="vi_VN"/>
                      <fmt:formatNumber value="${o.totalAmount}" type="currency"/>
                    </div>

                    <div class="order-actions">
                      <a class="btn btn-primary-modern"
                         href="${pageContext.request.contextPath}/user-orders-detail?id=${o.id}">
                        <i class="fas fa-eye"></i>
                        Chi tiết
                      </a>
                      <c:if test="${o.status == 0}">
                        <form method="post"
                              action="${pageContext.request.contextPath}/cancel-order"
                              onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${o.id}?');"
                              class="m-0">
                          <input type="hidden" name="orderId" value="${o.id}">
                          <button type="submit" class="btn btn-danger-modern">
                            <i class="fas fa-times"></i>
                            Hủy đơn
                          </button>
                        </form>
                      </c:if>
                    </div>
                  </div>

                  <!-- Items Preview -->
                  <c:if test="${not empty o.items}">
                    <div class="order-items-preview">
                      <h6 class="mb-3">
                        <i class="fas fa-list me-2"></i>
                        Sản phẩm trong đơn hàng
                      </h6>
                      <div class="table-responsive">
                        <table class="table items-table">
                          <thead>
                          <tr>
                            <th class="text-center">Tên sách</th>
                            <th class="text-center">Số lượng</th>
                            <th class="text-center">Giá</th>
                          </tr>
                          </thead>
                          <tbody>
                          <c:forEach var="it" items="${o.items}" end="2">
                            <tr>
                              <td class="text-center">${it.title}</td>
                              <td class="text-center">
                                <span class="text-center quantity-badge">${it.quantity}</span>
                              </td>
                              <td class="text-center price-text">
                                <fmt:formatNumber value="${it.price}" type="currency"/>
                              </td>
                            </tr>
                          </c:forEach>
                          <c:if test="${fn:length(o.items) > 3}">
                            <tr>
                              <td colspan="3" class="text-center text-muted">
                                <i class="fas fa-ellipsis-h me-2"></i>
                                Và ${fn:length(o.items) - 3} sản phẩm khác...
                              </td>
                            </tr>
                          </c:if>
                          </tbody>
                        </table>
                      </div>
                    </div>
                  </c:if>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
          <div></div>
          <a href="${pageContext.request.contextPath}/user-book-store" class="btn btn-success-modern">
            <i class="fas fa-shopping-cart"></i>
            Tiếp tục mua sắm
          </a>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<%@ include file="../footer.jsp" %>
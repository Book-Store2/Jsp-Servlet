<%@ page import="org.example.bookstorecode.model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include-header.jsp" %>
<%
  Book book = (Book) request.getAttribute("book");
  int quantity = (Integer) request.getAttribute("quantity");
%>

<!-- Bootstrap CSS & Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
  .buy-now-page {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    min-height: calc(100vh - 200px);
    padding: 40px 0;
    position: relative;
  }

  .buy-now-page::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(0,0,0,0.02)"/><circle cx="75" cy="75" r="1" fill="rgba(0,0,0,0.02)"/></pattern></defs><rect width="100" height="20" fill="url(%23grain)"/></svg>');
    pointer-events: none;
    z-index: 0;
  }

  .container {
    position: relative;
    z-index: 1;
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
    text-align: center;
  }

  .page-header::before {
    content: '';
    position: absolute;
    top: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 100px;
    height: 5px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 0 0 10px 10px;
  }

  .page-title {
    font-size: 2.2rem;
    font-weight: 700;
    color: #2c3e50;
    margin: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
  }

  .page-title i {
    width: 60px;
    height: 60px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.5rem;
  }

  .confirmation-card {
    background: white;
    border-radius: 25px;
    padding: 0;
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(0, 0, 0, 0.05);
    overflow: hidden;
    margin-bottom: 30px;
  }

  .card-header-modern {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 25px 35px;
    border: none;
    position: relative;
  }

  .card-header-modern::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 3px;
    background: linear-gradient(90deg, rgba(255,255,255,0.3), rgba(255,255,255,0.8), rgba(255,255,255,0.3));
  }

  .card-header-title {
    font-size: 1.4rem;
    font-weight: 700;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 12px;
  }

  .card-header-title i {
    font-size: 1.2rem;
  }

  .card-body-modern {
    padding: 35px;
  }

  .book-info {
    background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
    border-radius: 20px;
    padding: 30px;
    margin-bottom: 30px;
    border: 2px solid rgba(102, 126, 234, 0.1);
    position: relative;
  }

  .book-info::before {
    content: '';
    position: absolute;
    top: 15px;
    right: 15px;
    width: 40px;
    height: 40px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .book-info::after {
    content: '\f02d';
    font-family: 'Font Awesome 6 Free';
    font-weight: 900;
    position: absolute;
    top: 25px;
    right: 25px;
    color: white;
    font-size: 1rem;
  }

  .info-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 0;
    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    margin-bottom: 15px;
  }

  .info-row:last-child {
    border-bottom: none;
    margin-bottom: 0;
    padding-bottom: 0;
  }

  .info-label {
    font-weight: 600;
    color: #6c757d;
    font-size: 1rem;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .info-label i {
    width: 25px;
    text-align: center;
    color: #667eea;
  }

  .info-value {
    font-weight: 700;
    color: #2c3e50;
    font-size: 1.1rem;
  }

  .book-title-value {
    color: #667eea;
    max-width: 300px;
    text-align: right;
  }

  .price-value {
    color: #28a745;
  }

  .total-row {
    background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
    border-radius: 15px;
    padding: 20px;
    margin-top: 20px;
    border: 2px solid rgba(33, 150, 243, 0.2);
  }

  .total-amount {
    font-size: 1.5rem;
    font-weight: 800;
    color: #1976d2;
  }

  .payment-section {
    background: white;
    border-radius: 20px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(0, 0, 0, 0.05);
  }

  .section-title {
    font-size: 1.3rem;
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 25px;
    display: flex;
    align-items: center;
    gap: 12px;
    padding-bottom: 15px;
    border-bottom: 2px solid rgba(102, 126, 234, 0.1);
  }

  .section-title i {
    width: 35px;
    height: 35px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 0.9rem;
  }

  .payment-options {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }

  .payment-option {
    position: relative;
    cursor: pointer;
  }

  .payment-option input[type="radio"] {
    position: absolute;
    opacity: 0;
    cursor: pointer;
  }

  .payment-label {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 20px 25px;
    background: #f8f9fa;
    border: 2px solid #e9ecef;
    border-radius: 15px;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
  }

  .payment-label::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
    transition: left 0.5s ease;
  }

  .payment-option:hover .payment-label::before {
    left: 100%;
  }

  .payment-option input[type="radio"]:checked + .payment-label {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
    border-color: #667eea;
    transform: scale(1.02);
    box-shadow: 0 5px 20px rgba(102, 126, 234, 0.2);
  }

  .payment-icon {
    width: 45px;
    height: 45px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    transition: all 0.3s ease;
  }

  .cod-icon {
    background: linear-gradient(135deg, #ff7675 0%, #fd79a8 100%);
    color: white;
  }

  .vnpay-icon {
    background: linear-gradient(135deg, #0984e3 0%, #74b9ff 100%);
    color: white;
  }

  .payment-option input[type="radio"]:checked + .payment-label .payment-icon {
    transform: scale(1.1);
  }

  .payment-text {
    flex: 1;
  }

  .payment-title {
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 5px;
    font-size: 1.1rem;
  }

  .payment-desc {
    color: #6c757d;
    font-size: 0.9rem;
    margin: 0;
  }

  .radio-indicator {
    width: 24px;
    height: 24px;
    border: 2px solid #dee2e6;
    border-radius: 50%;
    position: relative;
    transition: all 0.3s ease;
  }

  .payment-option input[type="radio"]:checked + .payment-label .radio-indicator {
    border-color: #667eea;
    background: #667eea;
  }

  .payment-option input[type="radio"]:checked + .payment-label .radio-indicator::after {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 8px;
    height: 8px;
    background: white;
    border-radius: 50%;
  }

  .confirm-section {
    background: white;
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    text-align: center;
  }

  .confirm-btn {
    background: linear-gradient(135deg, #00b894 0%, #00a085 100%);
    color: white;
    padding: 18px 50px;
    font-size: 1.2rem;
    font-weight: 700;
    border-radius: 50px;
    border: none;
    transition: all 0.3s ease;
    text-transform: uppercase;
    letter-spacing: 1px;
    display: inline-flex;
    align-items: center;
    gap: 12px;
    margin-top: 20px;
    position: relative;
    overflow: hidden;
  }

  .confirm-btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
    transition: left 0.5s ease;
  }

  .confirm-btn:hover::before {
    left: 100%;
  }

  .confirm-btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 15px 40px rgba(0, 184, 148, 0.4);
    color: white;
  }

  .confirm-btn:active {
    transform: translateY(-1px);
  }

  .back-link {
    color: #6c757d;
    text-decoration: none;
    font-weight: 500;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 20px;
    transition: all 0.3s ease;
  }

  .back-link:hover {
    color: #667eea;
    transform: translateX(-5px);
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

  .security-note {
    background: linear-gradient(135deg, #d1ecf1 0%, #b8daff 100%);
    border-radius: 15px;
    padding: 20px;
    margin-top: 25px;
    border: 1px solid rgba(23, 162, 184, 0.2);
  }

  .security-note i {
    color: #17a2b8;
    margin-right: 10px;
    font-size: 1.1rem;
  }

  .security-text {
    color: #0c5460;
    margin: 0;
    font-weight: 500;
  }

  @media (max-width: 768px) {
    .buy-now-page {
      padding: 20px 0;
    }

    .page-header {
      padding: 25px 20px;
      margin-bottom: 20px;
      border-radius: 15px;
    }

    .page-title {
      font-size: 1.8rem;
      flex-direction: column;
      gap: 15px;
    }

    .page-title i {
      width: 50px;
      height: 50px;
      font-size: 1.2rem;
    }

    .confirmation-card {
      border-radius: 20px;
      margin-bottom: 20px;
    }

    .card-header-modern {
      padding: 20px 25px;
    }

    .card-body-modern {
      padding: 25px 20px;
    }

    .card-header-title {
      font-size: 1.2rem;
    }

    .book-info {
      padding: 25px 20px;
      border-radius: 15px;
    }

    .info-row {
      flex-direction: column;
      align-items: flex-start;
      gap: 8px;
      text-align: left;
    }

    .info-value {
      font-size: 1rem;
    }

    .book-title-value {
      text-align: left;
      max-width: 100%;
    }

    .total-amount {
      font-size: 1.3rem;
    }

    .payment-section {
      padding: 25px 20px;
      border-radius: 15px;
    }

    .payment-label {
      padding: 18px 20px;
      border-radius: 12px;
    }

    .payment-title {
      font-size: 1rem;
    }

    .confirm-section {
      padding: 25px 20px;
      border-radius: 15px;
    }

    .confirm-btn {
      padding: 15px 35px;
      font-size: 1rem;
      width: 100%;
      justify-content: center;
    }

    .breadcrumb-modern {
      padding: 12px 20px;
      border-radius: 10px;
    }
  }

  @media (max-width: 576px) {
    .payment-icon {
      width: 40px;
      height: 40px;
      font-size: 1rem;
    }

    .payment-label {
      padding: 15px 18px;
    }

    .info-label {
      font-size: 0.95rem;
    }

    .info-value {
      font-size: 0.95rem;
    }
  }
</style>

<div class="buy-now-page">
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
            <a href="${pageContext.request.contextPath}/user-book-store">
              <i class="fas fa-store me-1"></i>Cửa hàng
            </a>
          </li>
          <li class="breadcrumb-item active" aria-current="page">
            <i class="fas fa-check-circle me-1"></i>Xác nhận đặt hàng
          </li>
        </ol>
      </nav>
    </div>

    <!-- Page Header -->
    <div class="page-header">
      <h1 class="page-title">
        <i class="fas fa-check-double"></i>
        Xác nhận đặt hàng
      </h1>
    </div>

    <div class="row justify-content-center">
      <div class="col-lg-8 col-xl-7">
        <!-- Book Information Card -->
        <div class="confirmation-card">
          <div class="card-header-modern">
            <h3 class="card-header-title">
              <i class="fas fa-book-open"></i>
              Thông tin sản phẩm
            </h3>
          </div>

          <div class="card-body-modern">
            <div class="book-info">
              <div class="info-row">
                                <span class="info-label">
                                    <i class="fas fa-book"></i>
                                    Tên sách
                                </span>
                <span class="info-value book-title-value"><%= book.getTitle() %></span>
              </div>

              <div class="info-row">
                                <span class="info-label">
                                    <i class="fas fa-tag"></i>
                                    Đơn giá
                                </span>
                <span class="info-value price-value"><%= book.getPrice() %>₫</span>
              </div>

              <div class="info-row">
                                <span class="info-label">
                                    <i class="fas fa-cubes"></i>
                                    Số lượng
                                </span>
                <span class="info-value"><%= quantity %> cuốn</span>
              </div>

              <div class="total-row">
                <div class="info-row">
                                    <span class="info-label">
                                        <i class="fas fa-calculator"></i>
                                        Tổng thành tiền
                                    </span>
                  <span class="info-value total-amount">
                                        <%= book.getPrice().multiply(java.math.BigDecimal.valueOf(quantity)) %>₫
                                    </span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Payment Method Card -->
        <div class="payment-section">
          <h4 class="section-title">
            <i class="fas fa-credit-card"></i>
            Chọn phương thức thanh toán
          </h4>

          <form action="buy-now-confirm" method="post" id="confirmForm">
            <input type="hidden" name="bookId" value="<%= book.getId() %>">
            <input type="hidden" name="quantity" value="<%= quantity %>">

            <div class="payment-options">
              <div class="payment-option">
                <input type="radio" id="cod" name="payment" value="COD" checked>
                <label for="cod" class="payment-label">
                  <div class="payment-icon cod-icon">
                    <i class="fas fa-hand-holding-usd"></i>
                  </div>
                  <div class="payment-text">
                    <div class="payment-title">Thanh toán khi nhận hàng (COD)</div>
                    <div class="payment-desc">Thanh toán bằng tiền mặt khi nhận được sách</div>
                  </div>
                  <div class="radio-indicator"></div>
                </label>
              </div>

              <div class="payment-option">
                <input type="radio" id="vnpay" name="payment" value="VNPAY">
                <label for="vnpay" class="payment-label">
                  <div class="payment-icon vnpay-icon">
                    <i class="fas fa-mobile-alt"></i>
                  </div>
                  <div class="payment-text">
                    <div class="payment-title">Thanh toán VNPay</div>
                    <div class="payment-desc">Thanh toán online qua ví điện tử VNPay</div>
                  </div>
                  <div class="radio-indicator"></div>
                </label>
              </div>
            </div>

            <div class="security-note">
              <p class="security-text">
                <i class="fas fa-shield-alt"></i>
                Thông tin của bạn được bảo mật tuyệt đối. Chúng tôi cam kết không chia sẻ thông tin cá nhân với bên thứ ba.
              </p>
            </div>
          </form>
        </div>

        <!-- Confirm Section -->
        <div class="confirm-section">
          <a href="javascript:history.back()" class="back-link">
            <i class="fas fa-arrow-left"></i>
            Quay lại
          </a>

          <button type="submit" form="confirmForm" class="confirm-btn">
            <i class="fas fa-check-circle"></i>
            Xác nhận đặt hàng
          </button>

          <div class="mt-3">
            <small class="text-muted">
              <i class="fas fa-info-circle me-1"></i>
              Bằng cách đặt hàng, bạn đồng ý với điều khoản và điều kiện của chúng tôi
            </small>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
  // Add smooth interactions
  document.addEventListener('DOMContentLoaded', function() {
    // Add loading state to confirm button
    const confirmBtn = document.querySelector('.confirm-btn');
    const confirmForm = document.getElementById('confirmForm');

    confirmForm.addEventListener('submit', function() {
      confirmBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
      confirmBtn.disabled = true;
    });

    // Add click animations to payment options
    const paymentOptions = document.querySelectorAll('.payment-option input[type="radio"]');
    paymentOptions.forEach(option => {
      option.addEventListener('change', function() {
        // Remove previous selections visual feedback
        document.querySelectorAll('.payment-label').forEach(label => {
          label.style.transform = '';
        });

        // Add visual feedback to selected option
        if (this.checked) {
          this.nextElementSibling.style.transform = 'scale(1.02)';

          // Add ripple effect
          const ripple = document.createElement('div');
          ripple.style.cssText = `
                        position: absolute;
                        border-radius: 50%;
                        background: rgba(102, 126, 234, 0.3);
                        width: 20px;
                        height: 20px;
                        animation: ripple 0.6s ease-out;
                        pointer-events: none;
                        z-index: 1000;
                    `;

          const rect = this.nextElementSibling.getBoundingClientRect();
          ripple.style.left = '50%';
          ripple.style.top = '50%';
          ripple.style.transform = 'translate(-50%, -50%)';

          this.nextElementSibling.appendChild(ripple);

          setTimeout(() => {
            ripple.remove();
          }, 600);
        }
      });
    });
  });
</script>

<style>
  @keyframes ripple {
    0% {
      transform: translate(-50%, -50%) scale(0);
      opacity: 1;
    }
    100% {
      transform: translate(-50%, -50%) scale(4);
      opacity: 0;
    }
  }
</style>

<%@ include file="../footer.jsp" %>
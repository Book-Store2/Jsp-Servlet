<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Bootstrap CSS (if not already included) -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
  .custom-footer {
    background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
    color: white;
    padding: 40px 0 20px;
    /*margin-top: 50px;*/
    position: relative;
    overflow: hidden;
    text-align: center;
  }

  .custom-footer::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.03)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.03)"/></pattern></defs><rect width="100" height="20" fill="url(%23grain)"/></svg>');
    pointer-events: none;
  }

  .footer-content {
    position: relative;
    z-index: 1;
  }

  .footer-brand {
    font-size: 1.5rem;
    font-weight: 700;
    margin-bottom: 1rem;
    display: flex;
    align-items: center;
    gap: 10px;
    color: white;
  }

  .footer-brand i {
    font-size: 2rem;
    background: linear-gradient(45deg, #667eea, #764ba2);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  .footer-links li {
    margin-bottom: 8px;
  }

  .footer-links a {
    color: rgba(255, 255, 255, 0.8);
    text-decoration: none;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 8px;
  }

  .footer-links a:hover {
    color: white;
    transform: translateX(5px);
  }

  .social-links {
    display: flex;
    gap: 15px;
    margin-top: 20px;
  }

  .social-links a {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    background: rgba(255, 255, 255, 0.1);
    color: white;
    border-radius: 50%;
    transition: all 0.3s ease;
    backdrop-filter: blur(10px);
  }

  .social-links a:hover {
    background: linear-gradient(45deg, #667eea, #764ba2);
    transform: translateY(-3px);
    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
  }

  .footer-divider {
    height: 1px;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
    margin: 30px 0 20px;
  }

  .footer-bottom {
    text-align: center;
    color: rgba(255, 255, 255, 0.8);
    font-size: 0.9rem;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    flex-wrap: wrap;
  }

  .footer-bottom i {
    color: #e74c3c;
    animation: heartbeat 1.5s ease-in-out infinite;
  }

  @keyframes heartbeat {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.1); }
  }

  .footer-info {
    background: rgba(0, 0, 0, 0.2);
    padding: 15px;
    border-radius: 15px;
    margin-bottom: 20px;
    backdrop-filter: blur(10px);
  }

  .contact-item {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 10px;
    color: rgba(255, 255, 255, 0.9);
  }

  .contact-item i {
    width: 20px;
    text-align: center;
    color: #667eea;
  }

  @media (max-width: 768px) {
    .custom-footer {
      padding: 30px 0 15px;
    }

    .footer-brand {
      font-size: 1.3rem;
      justify-content: center;
      text-align: center;
    }

    .social-links {
      justify-content: center;
    }

    .footer-bottom {
      font-size: 0.85rem;
    }
  }
</style>

<footer class="custom-footer">
  <div class="container footer-content">
    <div class="row">
      <div class="col-lg-4 col-md-6 mb-4">
        <div class="footer-brand">
          <i class="fas fa-book-open"></i>
          BookStore
        </div>
        <div class="footer-info">
          <div class="contact-item">
            <i class="fas fa-map-marker-alt"></i>
            <span>24 Liêm Lạc 4, Hòa Xuân, Đã Nẵng</span>
          </div>
          <div class="contact-item">
            <i class="fas fa-phone"></i>
            <span>+84 364855442</span>
          </div>
          <div class="contact-item">
            <i class="fas fa-envelope"></i>
            <span>info@bookstore.vn</span>
          </div>
        </div>
        <div class="social-links">
          <a href="#" title="Facebook">
            <i class="fab fa-facebook-f"></i>
          </a>
          <a href="#" title="Instagram">
            <i class="fab fa-instagram"></i>
          </a>
          <a href="#" title="Twitter">
            <i class="fab fa-twitter"></i>
          </a>
          <a href="#" title="LinkedIn">
            <i class="fab fa-linkedin-in"></i>
          </a>
        </div>
      </div>

      <div class="col-lg-4 col-md-6 mb-4">
        <h5 class="mb-3">Liên kết nhanh</h5>
        <ul class="footer-links">
          <li><a href="home.jsp"><i class="fas fa-home"></i>Trang chủ</a></li>
          <li><a href="user-book-store"><i class="fas fa-store"></i>Cửa hàng</a></li>
        </ul>
      </div>

      <div class="col-lg-4 col-md-6 mb-4">
        <h5 class="mb-3">Tài khoản</h5>
        <ul class="footer-links">
          <li><a href="login"><i class="fas fa-sign-in-alt"></i>Đăng nhập</a></li>
          <li><a href="register"><i class="fas fa-user-plus"></i>Đăng ký</a></li>
          <li><a href="user-cart"><i class="fas fa-shopping-cart"></i>Giỏ hàng</a></li>
          <li><a href="user-orders"><i class="fas fa-history"></i>Đơn hàng</a></li>
        </ul>
      </div>
    </div>

    <div class="footer-divider"></div>

    <div class="footer-bottom">
      <span>&copy; 2025 BookStore</span>
      <i class="fas fa-heart"></i>
      <span>Made with love in Vietnam</span>
      <span>|</span>
      <span>All rights reserved.</span>
    </div>
  </div>
</footer>
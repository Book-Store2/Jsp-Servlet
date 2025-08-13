<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.bookstorecode.model.User" %>
<%@ page import="org.example.bookstorecode.model.Role" %>

<%
  User customer = (User) session.getAttribute("user");
%>

<!-- Bootstrap CSS (if not already included) -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
  .customer-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    padding: 15px 0;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
    position: relative;
    overflow: hidden;
  }

  .customer-header::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.05)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100" height="20" fill="url(%23grain)"/></svg>');
    pointer-events: none;
  }

  .customer-welcome {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    padding: 8px 16px;
    border-radius: 25px;
    font-weight: 600;
    font-size: 0.9rem;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.1);
  }

  .customer-nav {
    display: flex;
    align-items: center;
    gap: 20px;
    flex-wrap: wrap;
  }

  .customer-nav a {
    color: rgba(255, 255, 255, 0.9);
    text-decoration: none;
    padding: 8px 16px;
    border-radius: 20px;
    transition: all 0.3s ease;
    font-weight: 500;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.1);
    position: relative;
  }

  .customer-nav a:hover {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
  }

  .customer-nav .store-btn {
    background: rgba(40, 167, 69, 0.9);
    color: white;
  }

  .customer-nav .store-btn:hover {
    background: #28a745;
  }

  .customer-nav .cart-btn {
    background: rgba(255, 193, 7, 0.9);
    color: #212529;
    font-weight: 600;
  }

  .customer-nav .cart-btn:hover {
    background: #ffc107;
    color: #000;
  }

  .customer-nav .logout-btn {
    background: rgba(220, 53, 69, 0.9);
    color: white;
  }

  .customer-nav .logout-btn:hover {
    background: #dc3545;
  }

  @media (max-width: 768px) {
    .customer-nav {
      gap: 10px;
    }

    .customer-nav a {
      padding: 6px 12px;
      font-size: 0.9rem;
    }

    .customer-welcome {
      padding: 6px 12px;
      font-size: 0.85rem;
    }
  }
</style>

<div class="customer-header">
  <div class="container-fluid">
    <div class="row align-items-center">
      <div class="col-md-4">
        <div class="customer-welcome">
          <i class="fas fa-user-circle"></i>
          <span>Xin chào, <%= customer.getName() %></span>
        </div>
      </div>
      <div class="col-md-8">
        <nav class="customer-nav justify-content-end">
          <a href="home">
            <i class="fas fa-home"></i>
            Trang chủ
          </a>
          <a href="user-book-store" class="store-btn">
            <i class="fas fa-store"></i>
            Cửa hàng
          </a>
          <a href="user-cart" class="cart-btn">
            <i class="fas fa-shopping-cart"></i>
            Giỏ hàng
          </a>
          <a href="user-orders">
            <i class="fas fa-history"></i>
            Lịch sử đơn hàng
          </a>
          <a href="logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            Đăng xuất
          </a>
        </nav>
      </div>
    </div>
  </div>
</div>
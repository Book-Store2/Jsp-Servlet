<%@ page contentType="text/html;charset=UTF-8" %>

<!-- Bootstrap CSS (if not already included) -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    .guest-header {

      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        padding: 15px 0;
        box-shadow: 0 4px 15px rgba(108, 117, 125, 0.2);
        position: relative;
        overflow: hidden;
    }

    .guest-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.05)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100" height="20" fill="url(%23grain)"/></svg>');
        pointer-events: none;
    }

    .guest-brand {
        color: white;
        font-size: 1.2rem;
        font-weight: 700;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        text-decoration: none;
    }

    .guest-brand:hover {
        color: rgba(255, 255, 255, 0.9);
        text-decoration: none;
    }

    .guest-nav {
        display: flex;
        align-items: center;
        gap: 20px;
        flex-wrap: wrap;
    }

    .guest-nav a {
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
    }

    .guest-nav a:hover {
        background: rgba(255, 255, 255, 0.2);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    .guest-nav .store-btn {
        background: rgba(40, 167, 69, 0.9);
        color: white;
    }

    .guest-nav .store-btn:hover {
        background: #28a745;
    }

    .guest-nav .login-btn {
        background: rgba(0, 123, 255, 0.9);
        color: white;
    }

    .guest-nav .login-btn:hover {
        background: #007bff;
    }

    .guest-nav .register-btn {
        background: rgba(102, 126, 234, 0.9);
        color: white;
        font-weight: 600;
    }

    .guest-nav .register-btn:hover {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }

    @media (max-width: 768px) {
        .guest-nav {
            gap: 10px;
            margin-top: 10px;
        }

        .guest-nav a {
            padding: 6px 12px;
            font-size: 0.9rem;
        }

        .guest-brand {
            font-size: 1.1rem;
        }
    }
</style>

<div class="guest-header">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col-md-4">
                <a href="home.jsp" class="guest-brand">
                    <i class="fas fa-book-open"></i>
                    <span>BookStore</span>
                </a>
            </div>
            <div class="col-md-8">
                <nav class="guest-nav justify-content-end">
                    <a href="home.jsp">
                        <i class="fas fa-home"></i>
                        Trang chủ
                    </a>
                    <a href="user-book-store" class="store-btn">
                        <i class="fas fa-store"></i>
                        Cửa hàng
                    </a>
                    <a href="login" class="login-btn">
                        <i class="fas fa-sign-in-alt"></i>
                        Đăng nhập
                    </a>
                    <a href="register" class="register-btn">
                        <i class="fas fa-user-plus"></i>
                        Đăng ký
                    </a>
                </nav>
            </div>
        </div>
    </div>
</div>
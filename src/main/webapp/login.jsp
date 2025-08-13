<%@ page import="org.example.bookstorecode.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Đọc cookie ghi nhớ email
    String savedEmail = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("email".equals(cookie.getName())) {
                savedEmail = cookie.getValue();
                break;
            }
        }
    }

    // Không cho truy cập nếu đã đăng nhập
    User checkUser = (User) session.getAttribute("user");
    if (checkUser != null) {
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>

<%@ include file="include-header.jsp" %>

<!-- Bootstrap CSS (if not already included) -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    /* Custom styles for login form */
    .login-container {
        min-height: 80vh;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 2rem 0;
    }

    .login-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        border: 1px solid rgba(255, 255, 255, 0.2);
        overflow: hidden;
        transition: transform 0.3s ease;
    }

    .login-card:hover {
        transform: translateY(-5px);
    }

    .login-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 2rem;
        text-align: center;
        margin: -1.5rem -1.5rem 2rem -1.5rem;
    }

    .login-header h2 {
        margin: 0;
        font-weight: 600;
        font-size: 1.8rem;
    }

    .login-header i {
        font-size: 3rem;
        margin-bottom: 1rem;
        opacity: 0.9;
    }

    .form-floating {
        margin-bottom: 1rem;
    }

    .form-floating > .form-control {
        border: 2px solid #e9ecef;
        border-radius: 15px;
        height: 60px;
        transition: all 0.3s ease;
        background: rgba(248, 249, 250, 0.8);
    }

    .form-floating > .form-control:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
        background: white;
    }

    .form-floating > label {
        color: #6c757d;
        font-weight: 500;
    }

    .remember-checkbox {
        display: flex;
        align-items: center;
        gap: 10px;
        margin: 1rem 0;
        padding: 1rem;
        background: rgba(102, 126, 234, 0.05);
        border-radius: 15px;
        border: 1px solid rgba(102, 126, 234, 0.1);
    }

    .remember-checkbox input[type="checkbox"] {
        width: 20px;
        height: 20px;
        accent-color: #667eea;
    }

    .remember-checkbox label {
        margin: 0;
        color: #495057;
        font-weight: 500;
        cursor: pointer;
    }

    .btn-login {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border: none;
        border-radius: 15px;
        padding: 15px 30px;
        font-weight: 600;
        font-size: 1.1rem;
        transition: all 0.3s ease;
        width: 100%;
        margin-top: 1rem;
    }

    .btn-login:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
    }

    .alert-message {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
        padding: 1rem 1.5rem;
        border-radius: 15px;
        margin-bottom: 1.5rem;
        border: none;
        display: flex;
        align-items: center;
        gap: 10px;
        animation: slideDown 0.3s ease-out;
    }

    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .register-link {
        text-align: center;
        margin-top: 2rem;
        padding-top: 2rem;
        border-top: 1px solid rgba(0, 0, 0, 0.1);
    }

    .register-link a {
        color: #667eea;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
    }

    .register-link a:hover {
        color: #764ba2;
        transform: translateX(5px);
    }

    @media (max-width: 768px) {
        .login-container {
            padding: 1rem;
        }

        .login-card {
            margin: 0 0.5rem;
        }

        .login-header {
            padding: 1.5rem;
            margin: -1rem -1rem 1.5rem -1rem;
        }

        .login-header h2 {
            font-size: 1.5rem;
        }

        .login-header i {
            font-size: 2.5rem;
        }
    }

    .fade-in {
        animation: fadeIn 0.6s ease-in;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

<div class="login-container">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-4 col-md-7 col-sm-9">
                <div class="card login-card fade-in">
                    <div class="card-body p-4">
                        <div class="login-header">
                            <h2>Đăng nhập</h2>
                        </div>

                        <% String message = (String) request.getAttribute("message"); %>
                        <% if (message != null) { %>
                        <div class="alert-message">
                            <i class="fas fa-exclamation-triangle"></i>
                            <span><%= message %></span>
                        </div>
                        <% } %>

                        <form method="post" action="login">
                            <div class="form-floating">
                                <input type="email" class="form-control" name="email" id="email" required
                                       value="<%= savedEmail %>" placeholder="Nhập email của bạn">
                                <label for="email"><i class="fas fa-envelope me-2"></i>Địa chỉ Email</label>
                            </div>

                            <div class="form-floating">
                                <input type="password" class="form-control" name="password" id="password" required
                                       pattern=".{6,}" title="Ít nhất 6 ký tự" placeholder="Nhập mật khẩu">
                                <label for="password"><i class="fas fa-lock me-2"></i>Mật khẩu</label>
                            </div>

                            <div class="remember-checkbox">
                                <input type="checkbox" name="remember" id="remember"
                                    <%= !"".equals(savedEmail) ? "checked" : "" %>>
                                <label for="remember">
                                    Ghi nhớ đăng nhập
                                </label>
                            </div>

                            <button type="submit" class="btn btn-primary btn-login">
                                <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                            </button>
                        </form>

                        <div class="register-link">
                            <p class="mb-2 text-muted">Chưa có tài khoản?</p>
                            <a href="register">
                                <i class="fas fa-user-plus me-1"></i>Đăng ký ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (if not already included) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
    // Add real-time validation feedback
    document.addEventListener('DOMContentLoaded', function() {
        const inputs = document.querySelectorAll('form input[type="email"], form input[type="password"]');

        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                if (this.value.trim() && this.checkValidity()) {
                    this.classList.add('is-valid');
                    this.classList.remove('is-invalid');
                } else if (this.value.trim()) {
                    this.classList.add('is-invalid');
                    this.classList.remove('is-valid');
                }
            });

            input.addEventListener('focus', function() {
                this.classList.remove('is-invalid', 'is-valid');
            });
        });
    });
</script>
<%@ include file="footer.jsp" %>
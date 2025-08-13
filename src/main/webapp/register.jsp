<%@ page import="org.example.bookstorecode.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
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
    /* Custom styles for registration form */
    .register-container {
        min-height: 80vh;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 2rem 0;
    }

    .register-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        border: 1px solid rgba(255, 255, 255, 0.2);
        overflow: hidden;
        transition: transform 0.3s ease;
    }

    .register-card:hover {
        transform: translateY(-5px);
    }

    .register-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 2rem;
        text-align: center;
        margin: -1.5rem -1.5rem 2rem -1.5rem;
    }

    .register-header h2 {
        margin: 0;
        font-weight: 600;
        font-size: 1.8rem;
    }

    .register-header i {
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

    .btn-register {
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

    .btn-register:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
    }

    .error-message {
        color: #dc3545;
        font-size: 0.875rem;
        margin-top: 0.25rem;
        display: block;
        min-height: 1.2rem;
    }

    .login-link {
        text-align: center;
        margin-top: 2rem;
        padding-top: 2rem;
        border-top: 1px solid rgba(0, 0, 0, 0.1);
    }

    .login-link a {
        color: #667eea;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
    }

    .login-link a:hover {
        color: #764ba2;
        transform: translateX(5px);
    }

    .password-hint {
        font-size: 0.85rem;
        color: #6c757d;
        margin-top: 0.25rem;
        font-style: italic;
    }

    @media (max-width: 768px) {
        .register-container {
            padding: 1rem;
        }

        .register-card {
            margin: 0 0.5rem;
        }

        .register-header {
            padding: 1.5rem;
            margin: -1rem -1rem 1.5rem -1rem;
        }

        .register-header h2 {
            font-size: 1.5rem;
        }

        .register-header i {
            font-size: 2.5rem;
        }
    }

    /* Animation for form validation */
    .shake {
        animation: shake 0.5s ease-in-out;
    }

    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-5px); }
        75% { transform: translateX(5px); }
    }

    .fade-in {
        animation: fadeIn 0.6s ease-in;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

<div class="register-container">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-4 col-md-7 col-sm-9">
                <div class="card register-card fade-in">
                    <div class="card-body p-4">
                        <div class="register-header">
                            <h2>Đăng ký tài khoản</h2>
                        </div>

                        <form id="registerForm" method="post" action="register" onsubmit="return validateForm()">
                            <div class="form-floating">
                                <input type="text" class="form-control" name="name" id="name" placeholder="Nhập tên của bạn">
                                <label for="name"><i class="fas fa-user me-2"></i>Tên đầy đủ</label>
                                <span id="nameError" class="error-message"></span>
                            </div>

                            <div class="form-floating">
                                <input type="email" class="form-control" name="email" id="email" placeholder="Nhập email của bạn">
                                <label for="email"><i class="fas fa-envelope me-2"></i>Địa chỉ Email</label>
                                <span id="emailError" class="error-message"></span>
                            </div>

                            <div class="form-floating">
                                <input type="password" class="form-control" name="password" id="password" placeholder="Nhập mật khẩu">
                                <label for="password"><i class="fas fa-lock me-2"></i>Mật khẩu</label>
                                <div class="password-hint">
                                    <i class="fas fa-info-circle me-1"></i>Mật khẩu ít nhất 6 ký tự
                                </div>
                                <span id="passwordError" class="error-message"></span>
                            </div>

                            <input type="hidden" name="role" value="CUSTOMER" />

                            <button type="submit" class="btn btn-primary btn-register">
                                <i class="fas fa-user-plus me-2"></i>Đăng ký ngay
                            </button>
                        </form>

                        <div class="login-link">
                            <p class="mb-2 text-muted">Đã có tài khoản?</p>
                            <a href="login">
                                <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập tại đây
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
    function validateForm() {
        let isValid = true;

        // Clear previous errors
        document.getElementById("nameError").innerText = "";
        document.getElementById("emailError").innerText = "";
        document.getElementById("passwordError").innerText = "";

        // Remove shake animation
        document.querySelectorAll('.form-floating').forEach(el => el.classList.remove('shake'));

        const name = document.getElementById("name").value.trim();
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value;

        // Validate name
        if (name.length < 2 || name.length > 50) {
            document.getElementById("nameError").innerText = "Tên phải từ 2 đến 50 ký tự.";
            document.getElementById("name").closest('.form-floating').classList.add('shake');
            isValid = false;
        }

        // Validate email
        const emailRegex = /^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$/;
        if (!emailRegex.test(email)) {
            document.getElementById("emailError").innerText = "Email không hợp lệ.";
            document.getElementById("email").closest('.form-floating').classList.add('shake');
            isValid = false;
        }

        // Validate password
        if (password.length < 6) {
            document.getElementById("passwordError").innerText = "Mật khẩu phải có ít nhất 6 ký tự.";
            document.getElementById("password").closest('.form-floating').classList.add('shake');
            isValid = false;
        }

        return isValid;
    }

    // Add real-time validation feedback
    document.addEventListener('DOMContentLoaded', function() {
        const inputs = document.querySelectorAll('#registerForm input[type="text"], #registerForm input[type="email"], #registerForm input[type="password"]');

        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                if (this.value.trim()) {
                    this.classList.add('is-valid');
                    this.classList.remove('is-invalid');
                }
            });

            input.addEventListener('focus', function() {
                this.classList.remove('is-invalid', 'is-valid');
            });
        });
    });
</script>
<%@ include file="footer.jsp" %>
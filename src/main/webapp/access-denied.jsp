<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="include-header.jsp" %>

<!-- Bootstrap CSS (if not already included) -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<%
  // Xử lý nút "Đăng nhập với vai trò khác"
  String action = request.getParameter("action");
  if ("relogin".equals(action)) {
    session.invalidate(); // Xóa session

    // Xóa cookie email/password nếu có
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
      for (Cookie cookie : cookies) {
        if ("email".equals(cookie.getName()) || "password".equals(cookie.getName())) {
          cookie.setMaxAge(0);
          cookie.setPath("/");
          response.addCookie(cookie);
        }
      }
    }

    response.sendRedirect("login"); // Chuyển về trang đăng nhập
    return;
  }
%>

<style>
  .access-denied-container {
    min-height: 80vh;
    background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 2rem 0;
    position: relative;
    overflow: hidden;
  }

  .access-denied-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.05)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100" height="20" fill="url(%23grain)"/></svg>');
    pointer-events: none;
  }

  .access-denied-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 25px;
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
    border: 1px solid rgba(255, 255, 255, 0.2);
    overflow: hidden;
    transition: transform 0.3s ease;
    position: relative;
    z-index: 1;
    max-width: 500px;
    width: 100%;
  }

  .access-denied-card:hover {
    transform: translateY(-5px);
  }

  .access-denied-header {
    background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
    color: white;
    padding: 2.5rem 2rem;
    text-align: center;
    margin: -1.5rem -1.5rem 2rem -1.5rem;
    position: relative;
  }

  .access-denied-icon {
    font-size: 4rem;
    margin-bottom: 1rem;
    opacity: 0.9;
    animation: shake 2s ease-in-out infinite;
  }

  @keyframes shake {
    0%, 100% { transform: translateX(0); }
    10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
    20%, 40%, 60%, 80% { transform: translateX(5px); }
  }

  .access-denied-title {
    font-size: 1.8rem;
    font-weight: 700;
    margin: 0;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
  }

  .access-denied-content {
    padding: 0 2rem 2rem;
    text-align: center;
  }

  .access-denied-message {
    font-size: 1.1rem;
    color: #6c757d;
    margin-bottom: 2rem;
    line-height: 1.6;
  }

  .access-denied-buttons {
    display: flex;
    flex-direction: column;
    gap: 15px;
    margin-top: 2rem;
  }

  .btn-access-denied {
    padding: 15px 30px;
    border-radius: 50px;
    font-weight: 600;
    font-size: 1.1rem;
    border: none;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    transition: all 0.3s ease;
    width: 100%;
  }

  .btn-relogin {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
  }

  .btn-relogin:hover {
    background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
    color: white;
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
  }

  .btn-home {
    background: rgba(108, 117, 125, 0.1);
    color: #495057;
    border: 2px solid rgba(108, 117, 125, 0.3);
  }

  .btn-home:hover {
    background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
    color: white;
    border-color: transparent;
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(108, 117, 125, 0.3);
  }

  .warning-badge {
    background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
    color: #212529;
    padding: 8px 20px;
    border-radius: 25px;
    font-size: 0.9rem;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 1.5rem;
    animation: pulse 2s ease-in-out infinite;
  }

  @keyframes pulse {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.05); }
  }

  .security-info {
    background: rgba(23, 162, 184, 0.1);
    border: 1px solid rgba(23, 162, 184, 0.2);
    border-radius: 15px;
    padding: 20px;
    margin-top: 2rem;
    color: #17a2b8;
    font-size: 0.9rem;
    display: flex;
    align-items: flex-start;
    gap: 10px;
  }

  .security-info i {
    margin-top: 3px;
    color: #17a2b8;
  }

  @media (max-width: 768px) {
    .access-denied-container {
      padding: 1rem;
    }

    .access-denied-header {
      padding: 2rem 1.5rem;
      margin: -1rem -1rem 1.5rem -1rem;
    }

    .access-denied-icon {
      font-size: 3rem;
    }

    .access-denied-title {
      font-size: 1.5rem;
    }

    .access-denied-content {
      padding: 0 1.5rem 1.5rem;
    }

    .btn-access-denied {
      padding: 12px 25px;
      font-size: 1rem;
    }
  }

  .fade-in {
    animation: fadeIn 0.8s ease-in;
  }

  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
  }
</style>

<div class="access-denied-container">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-12">
        <div class="access-denied-card fade-in">
          <div class="access-denied-header">
            <div class="access-denied-icon">
              <i class="fas fa-shield-alt"></i>
            </div>
            <h2 class="access-denied-title">Truy cập bị từ chối!</h2>
          </div>

          <div class="access-denied-content">
            <div class="warning-badge">
              <i class="fas fa-exclamation-triangle"></i>
              <span>Lỗi xác thực</span>
            </div>

            <p class="access-denied-message">
              Bạn không có quyền truy cập trang này! Vui lòng đăng nhập bằng vai trò phù hợp hoặc quay lại trang chủ.
            </p>

            <div class="access-denied-buttons">
              <form method="get" style="margin: 0;">
                <input type="hidden" name="action" value="relogin">
                <button type="submit" class="btn-access-denied btn-relogin">
                  <i class="fas fa-sign-in-alt"></i>
                  Đăng nhập với vai trò khác
                </button>
              </form>

              <form method="get" action="home" style="margin: 0;">
                <button type="submit" class="btn-access-denied btn-home">
                  <i class="fas fa-home"></i>
                  Quay lại trang chủ
                </button>
              </form>
            </div>

            <div class="security-info">
              <i class="fas fa-info-circle"></i>
              <div>
                <strong>Thông tin bảo mật:</strong><br>
                Hệ thống đã ghi lại lần truy cập này. Nếu đây không phải là bạn, vui lòng liên hệ quản trị viên.
              </div>
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
  document.addEventListener('DOMContentLoaded', function() {
    // Add loading effects to buttons
    const buttons = document.querySelectorAll('.btn-access-denied');

    buttons.forEach(button => {
      button.addEventListener('click', function() {
        this.style.opacity = '0.7';
        this.style.pointerEvents = 'none';

        const originalContent = this.innerHTML;
        this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';

        // Prevent multiple clicks
        setTimeout(() => {
          this.innerHTML = originalContent;
          this.style.opacity = '1';
          this.style.pointerEvents = 'auto';
        }, 3000);
      });
    });

    // Add keyboard navigation
    document.addEventListener('keydown', function(e) {
      if (e.key === 'Enter') {
        const reloginBtn = document.querySelector('button[name="action"][value="relogin"]');
        if (reloginBtn) {
          reloginBtn.click();
        }
      } else if (e.key === 'Escape') {
        const homeBtn = document.querySelector('button[type="submit"][formaction="home"]');
        if (homeBtn) {
          homeBtn.click();
        }
      }
    });

    // Auto redirect after 30 seconds (optional)
    let countdown = 30;
    const countdownElement = document.createElement('div');
    countdownElement.className = 'text-center mt-3';
    countdownElement.style.color = '#6c757d';
    countdownElement.style.fontSize = '0.9rem';

    const updateCountdown = () => {
      countdownElement.innerHTML = `<small><i class="fas fa-clock me-1"></i>Tự động chuyển về trang chủ sau ${countdown} giây</small>`;
      countdown--;

      if (countdown < 0) {
        window.location.href = 'home';
      }
    };

    // Uncomment the lines below to enable auto redirect
    // document.querySelector('.access-denied-content').appendChild(countdownElement);
    // updateCountdown();
    // setInterval(updateCountdown, 1000);
  });
</script>

<%@ include file="footer.jsp" %>
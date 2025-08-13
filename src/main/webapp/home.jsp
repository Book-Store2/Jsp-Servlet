<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="include-header.jsp" %>

<!-- Bootstrap CSS (if not already included) -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    .hero-section {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 100px 0;
        position: relative;
        overflow: hidden;
    }

    .hero-section::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.05)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100" height="20" fill="url(%23grain)"/></svg>');
        pointer-events: none;
    }

    .hero-content {
        position: relative;
        z-index: 1;
        text-align: center;
    }

    .hero-title {
        font-size: 3.5rem;
        font-weight: 700;
        margin-bottom: 2rem;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        animation: fadeInUp 1s ease-out;
    }

    .hero-subtitle {
        font-size: 1.5rem;
        margin-bottom: 3rem;
        opacity: 0.9;
        animation: fadeInUp 1s ease-out 0.3s both;
    }

    .hero-buttons {
        animation: fadeInUp 1s ease-out 0.6s both;
    }

    .hero-btn {
        padding: 15px 40px;
        font-size: 1.2rem;
        font-weight: 600;
        border-radius: 50px;
        margin: 0 15px;
        transition: all 0.3s ease;
        border: none;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 10px;
    }

    .hero-btn-primary {
        background: rgba(255, 255, 255, 0.2);
        color: white;
        border: 2px solid rgba(255, 255, 255, 0.3);
        backdrop-filter: blur(10px);
    }

    .hero-btn-primary:hover {
        background: white;
        color: #667eea;
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
    }

    .hero-btn-secondary {
        background: transparent;
        color: white;
        border: 2px solid rgba(255, 255, 255, 0.5);
    }

    .hero-btn-secondary:hover {
        background: rgba(255, 255, 255, 0.1);
        color: white;
        transform: translateY(-3px);
        border-color: white;
    }

    .features-section {
        padding: 80px 0;
        background: #f8f9fa;
    }

    .feature-card {
        background: white;
        border-radius: 20px;
        padding: 40px 30px;
        text-align: center;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        border: 1px solid rgba(102, 126, 234, 0.1);
        margin-bottom: 30px;
        height: 100%;
    }

    .feature-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 20px 40px rgba(102, 126, 234, 0.15);
    }

    .feature-icon {
        width: 80px;
        height: 80px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 25px;
        color: white;
        font-size: 2rem;
    }

    .feature-title {
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 15px;
        color: #2c3e50;
    }

    .feature-description {
        color: #6c757d;
        line-height: 1.6;
    }

    .stats-section {
        background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
        color: white;
        padding: 60px 0;
    }

    .stat-item {
        text-align: center;
        padding: 20px;
    }

    .stat-number {
        font-size: 3rem;
        font-weight: 700;
        display: block;
        margin-bottom: 10px;
        background: linear-gradient(45deg, #667eea, #764ba2);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .stat-label {
        font-size: 1.1rem;
        opacity: 0.9;
    }

    .cta-section {
        padding: 80px 0;
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white;
        text-align: center;
    }

    .cta-title {
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 20px;
    }

    .cta-subtitle {
        font-size: 1.3rem;
        margin-bottom: 40px;
        opacity: 0.9;
    }

    .cta-btn {
        background: white;
        color: #28a745;
        padding: 15px 40px;
        font-size: 1.2rem;
        font-weight: 600;
        border-radius: 50px;
        border: none;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        transition: all 0.3s ease;
    }

    .cta-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        color: #28a745;
    }

    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(50px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @media (max-width: 768px) {
        .hero-title {
            font-size: 2.5rem;
        }

        .hero-subtitle {
            font-size: 1.2rem;
        }

        .hero-btn {
            padding: 12px 30px;
            font-size: 1rem;
            margin: 10px 5px;
        }

        .feature-card {
            padding: 30px 20px;
        }

        .stat-number {
            font-size: 2.5rem;
        }

        .cta-title {
            font-size: 2rem;
        }

        .cta-subtitle {
            font-size: 1.1rem;
        }
    }
</style>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="hero-content">
            <h1 class="hero-title">
                <i class="fas fa-book-open me-3"></i>
                Chào mừng đến với BookStore
            </h1>
            <p class="hero-subtitle">
                Khám phá thế giới tri thức với hàng ngàn cuốn sách chất lượng cao
            </p>
            <div class="hero-buttons">
                <a href="user-book-store" class="hero-btn hero-btn-primary">
                    <i class="fas fa-store"></i>
                    Khám phá cửa hàng
                </a>
                <a href="register" class="hero-btn hero-btn-secondary">
                    <i class="fas fa-user-plus"></i>
                    Đăng ký ngay
                </a>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="features-section">
    <div class="container">
        <div class="row text-center mb-5">
            <div class="col-12">
                <h2 class="display-4 fw-bold mb-3" style="color: #2c3e50;">Tại sao chọn chúng tôi?</h2>
                <p class="lead text-muted">Những ưu điểm vượt trội khi mua sách tại BookStore</p>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shipping-fast"></i>
                    </div>
                    <h3 class="feature-title">Giao hàng nhanh chóng</h3>
                    <p class="feature-description">
                        Giao hàng toàn quốc trong 24-48h. Miễn phí vận chuyển cho đơn hàng trên 200.000₫
                    </p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-medal"></i>
                    </div>
                    <h3 class="feature-title">Chất lượng đảm bảo</h3>
                    <p class="feature-description">
                        100% sách chính hãng, mới 100%. Đổi trả trong 7 ngày nếu có lỗi từ nhà sản xuất
                    </p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h3 class="feature-title">Hỗ trợ 24/7</h3>
                    <p class="feature-description">
                        Đội ngũ chăm sóc khách hàng nhiệt tình, sẵn sàng hỗ trợ bạn mọi lúc mọi nơi
                    </p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-tags"></i>
                    </div>
                    <h3 class="feature-title">Giá cả cạnh tranh</h3>
                    <p class="feature-description">
                        Cam kết giá tốt nhất thị trường. Nhiều chương trình khuyến mãi hấp dẫn
                    </p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-book-reader"></i>
                    </div>
                    <h3 class="feature-title">Đa dạng thể loại</h3>
                    <p class="feature-description">
                        Hàng nghìn đầu sách từ văn học, khoa học, công nghệ đến sách thiếu nhi
                    </p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3 class="feature-title">Thanh toán an toàn</h3>
                    <p class="feature-description">
                        Nhiều phương thức thanh toán linh hoạt, bảo mật thông tin khách hàng tuyệt đối
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Stats Section -->
<section class="stats-section">
    <div class="container">
        <div class="row">
            <div class="col-md-3 col-sm-6">
                <div class="stat-item">
                    <span class="stat-number">10,000+</span>
                    <div class="stat-label">Đầu sách</div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="stat-item">
                    <span class="stat-number">50,000+</span>
                    <div class="stat-label">Khách hàng hài lòng</div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="stat-item">
                    <span class="stat-number">99%</span>
                    <div class="stat-label">Đánh giá tích cực</div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="stat-item">
                    <span class="stat-number">24/7</span>
                    <div class="stat-label">Hỗ trợ khách hàng</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="cta-section">
    <div class="container">
        <h2 class="cta-title">Sẵn sàng khám phá?</h2>
        <p class="cta-subtitle">Bắt đầu hành trình đọc sách cùng BookStore ngay hôm nay</p>
        <a href="user-book-store" class="cta-btn">
            <i class="fas fa-rocket"></i>
            Mua sách ngay
        </a>
    </div>
</section>

<!-- Bootstrap JS (if not already included) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<%@ include file="footer.jsp" %>
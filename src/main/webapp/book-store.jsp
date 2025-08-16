
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.bookstorecode.model.Book" %>

<%@ include file="include-header.jsp" %>

<!-- Bootstrap CSS (if not already included) -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    .store-hero {
        background: #5c6ac5;
        color: white;
        padding: 40px 0 20px;
        position: relative;
        overflow: hidden;
    }

    .store-hero::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.05)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100" height="20" fill="url(%23grain)"/></svg>');
        pointer-events: none;
    }

    .store-title {
        font-size: 2.5rem;
        font-weight: 700;
        text-align: center;
        margin-bottom: 20px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        position: relative;
        z-index: 1;
    }

    .alert-custom {
        border-radius: 15px;
        padding: 15px 20px;
        margin-bottom: 30px;
        border: none;
        display: flex;
        align-items: center;
        gap: 10px;
        animation: slideDown 0.3s ease-out;
    }

    .alert-success-custom {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white;
    }

    .alert-danger-custom {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
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

    .books-container {
        padding: 40px 0;
        background: whitesmoke;
        min-height: 70vh;
    }

    .book-card {
        background: white;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        border: 1px solid rgba(102, 126, 234, 0.1);
        height: 100%;
        display: flex;
        flex-direction: column;
    }

    .book-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 20px 40px rgba(102, 126, 234, 0.15);
    }

    .book-image {
        width: 100%;
        height: 250px;
        object-fit: cover;
        border-bottom: 3px solid #f8f9fa;
    }

    .book-content {
        padding: 25px;
        flex: 1;
        display: flex;
        flex-direction: column;
    }

    .book-title {
        font-size: 1.3rem;
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 10px;
        line-height: 1.4;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .book-author {
        color: #6c757d;
        font-size: 1rem;
        margin-bottom: 15px;
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .book-price {
        font-size: 1.5rem;
        font-weight: 700;
        color: #e74c3c;
        margin-bottom: 10px;
    }

    .book-stats {
        display: flex;
        gap: 20px;
        margin-bottom: 20px;
        font-size: 0.9rem;
        color: #6c757d;
    }

    .book-stat {
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .book-actions {
        margin-top: auto;
        padding-top: 20px;
        border-top: 2px solid #f8f9fa;
    }

    .quantity-container {
        margin-bottom: 15px;
    }

    .quantity-container label {
        text-align: center;
        font-weight: 600;
        color: #495057;
        margin-bottom: 8px;
        display: block;
        font-size: 0.9rem;
    }

    .quantity-input {
        border: 2px solid #e9ecef;
        border-radius: 10px;
        padding: 8px 15px;
        font-size: 1rem;
        transition: all 0.3s ease;
    }

    .quantity-input:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
        outline: none;
    }

    .book-buttons {
        display: flex;
        gap: 10px;
    }

    .btn-book {
        flex: 1;
        padding: 12px;
        border-radius: 15px;
        border: none;
        font-weight: 600;
        font-size: 0.9rem;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .btn-add-cart {
        background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
        color: #212529;
    }

    .btn-add-cart:hover {
        background: linear-gradient(135deg, #e0a800 0%, #e8630a 100%);
        color: #212529;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(255, 193, 7, 0.3);
    }

    .btn-buy-now {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white;
    }

    .btn-buy-now:hover {
        background: linear-gradient(135deg, #218838 0%, #1ba085 100%);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
    }

    .out-of-stock {
        background: #f8f9fa;
        border: 2px dashed #dee2e6;
        opacity: 0.7;
    }

    .out-of-stock .book-image {
        filter: grayscale(50%);
    }

    .stock-warning {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
        padding: 15px;
        border-radius: 15px;
        text-align: center;
        font-weight: 600;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        margin-top: auto;
    }

    .pagination-custom {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
        flex-wrap: wrap;
    }

    .page-link-custom {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 50px;
        height: 50px;
        border-radius: 15px;
        border: 2px solid #e9ecef;
        background: white;
        color: #495057;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .page-link-custom:hover {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-color: transparent;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
    }

    .page-link-custom.active {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-color: transparent;
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
    }

    .page-nav-btn {
        padding: 12px 20px;
        border-radius: 25px;
        background: rgba(102, 126, 234, 0.1);
        color: #667eea;
        border: 2px solid rgba(102, 126, 234, 0.2);
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .page-nav-btn:hover {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-color: transparent;
        transform: translateY(-2px);
    }

    .no-books {
        text-align: center;
        padding: 80px 20px;
        background: white;
        border-radius: 20px;
        margin: 40px 0;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .no-books i {
        font-size: 4rem;
        color: #dee2e6;
        margin-bottom: 30px;
    }

    .no-books h3 {
        color: #6c757d;
        margin-bottom: 20px;
    }

    .no-books p {
        color: #8e9ba7;
        font-size: 1.1rem;
    }

    @media (max-width: 768px) {
        .store-title {
            font-size: 2rem;
        }

        .book-buttons {
            flex-direction: column;
        }

        .btn-book {
            flex: none;
        }

        .pagination-custom {
            gap: 5px;
        }

        .page-link-custom {
            width: 40px;
            height: 40px;
        }

        .page-nav-btn {
            padding: 8px 15px;
            font-size: 0.9rem;
        }
    }
</style>

<!-- Store Hero Section -->
<section class="store-hero">
    <div class="container">
        <h1 class="store-title">
            📚 Mỗi trang sách – Một chân trời mới
        </h1>
    </div>
</section>

<!-- Main Content -->
<div class="books-container">
    <div class="container">
        <!-- Messages -->
        <%
            String message = request.getParameter("message");
            String error = request.getParameter("error");
        %>
        <% if (message != null) { %>
        <div class="alert-custom alert-success-custom">
            <i class="fas fa-check-circle"></i>
            <span><%= message %></span>
        </div>
        <% } else if (error != null) { %>
        <div class="alert-custom alert-danger-custom">
            <i class="fas fa-exclamation-triangle"></i>
            <span><%= error %></span>
        </div>
        <% } %>

        <%
            List<Book> books = (List<Book>) request.getAttribute("books");
            Integer currentPageObj = (Integer) request.getAttribute("currentPage");
            Integer totalPagesObj = (Integer) request.getAttribute("totalPages");

            int currentPage = (currentPageObj != null) ? currentPageObj : 1;
            int totalPages = (totalPagesObj != null) ? totalPagesObj : 1;
        %>

        <% if (books == null || books.isEmpty()) { %>
        <!-- No Books Found -->
        <div class="no-books">
            <i class="fas fa-book-open"></i>
            <h3>Không có sách nào để hiển thị.</h3>
            <p>Hiện tại không có sách nào trong cửa hàng. Vui lòng quay lại sau!</p>
        </div>
        <% } else { %>
        <!-- Books Grid -->
        <div class="row">
            <% for (Book b : books) { %>
            <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                <div class="book-card <%= (b.getStock() == 0) ? "out-of-stock" : "" %>">
                    <img
                            src="<%= b.getImage() %>"
                            alt="<%= b.getTitle() %>"
                            class="book-image"
                            data-bs-toggle="tooltip"
                            data-bs-placement="bottom"
                            title="<%= b.getDescription() %>"
                            onerror="this.src='https://via.placeholder.com/300x250/f8f9fa/6c757d?text=No+Image'">


                    <div class="book-content">
                        <h4 class="book-title"><%= b.getTitle() %></h4>

                        <div class="book-author">
                            <i class="fas fa-user"></i>
                            <strong>Tác giả:</strong> <%= b.getAuthor() %>
                        </div>

                        <div class="book-price">
                            <strong>Giá:</strong> <%= b.getPrice() %>₫
                        </div>

                        <div class="book-stats">
                            <div class="book-stat">
                                <i class="fas fa-chart-line"></i>
                                <strong>Đã bán:</strong> <%= b.getSold() %>
                            </div>
                            <div class="book-stat">
                                <i class="fas fa-boxes"></i>
                                <strong>Tồn kho:</strong> <%= b.getStock() %>
                            </div>
                        </div>

                        <% if (b.getStock() > 0) { %>
                        <div class="book-actions">
                            <form method="post" action="book-action">
                                <input type="hidden" name="bookId" value="<%= b.getId() %>">

                                <div class="quantity-container">
                                    <label for="quantity_<%= b.getId() %>">
                                        Số lượng: <input type="number"
                                                        class="quantity-input"
                                                        name="quantity"
                                                        id="quantity_<%= b.getId() %>"
                                                        value="1"
                                                        min="1"
                                                        max="<%= b.getStock() %>"
                                                        required>
                                    </label>

                                </div>

                                <div class="book-buttons">
                                    <button type="submit" name="action" value="add" class="btn-book btn-add-cart">
                                        <i class="fas fa-cart-plus"></i>
                                        Thêm vào giỏ
                                    </button>
                                    <button type="submit" name="action" value="buy" class="btn-book btn-buy-now">
                                        <i class="fas fa-shopping-bag"></i>
                                        Mua ngay
                                    </button>
                                </div>
                            </form>
                        </div>
                        <% } else { %>
                        <div class="stock-warning">
                            <i class="fas fa-exclamation-triangle"></i>
                            <span>⚠️ Hết hàng</span>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <!-- PHÂN TRANG -->
        <% if (totalPages > 1) { %>
        <div class="pagination-container">
            <div class="container">
                <div class="pagination-custom">
                    <!-- Previous Page -->
                    <% if (currentPage > 1) { %>
                    <a href="user-book-store?page=<%= currentPage - 1 %>" class="page-nav-btn">
                        <i class="fas fa-chevron-left"></i>
                        Trang trước
                    </a>
                    <% } %>

                    <!-- Page Numbers -->
                    <div style="display: flex; gap: 5px; flex-wrap: wrap;">
                        <% for (int i = 1; i <= totalPages; i++) { %>
                        <% if (i == currentPage) { %>
                        <span class="page-link-custom active"><%= i %></span>
                        <% } else { %>
                        <a href="user-book-store?page=<%= i %>" class="page-link-custom"><%= i %></a>
                        <% } %>
                        <% } %>
                    </div>

                    <!-- Next Page -->
                    <% if (currentPage < totalPages) { %>
                    <a href="user-book-store?page=<%= currentPage + 1 %>" class="page-nav-btn">
                        Trang sau
                        <i class="fas fa-chevron-right"></i>
                    </a>
                    <% } %>
                </div>
            </div>
        </div>
        <% } %>
        <% } %>
    </div>
</div>

<!-- Bootstrap JS (if not already included) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
    // Add smooth scrolling for pagination
    document.addEventListener('DOMContentLoaded', function() {
        const pageLinks = document.querySelectorAll('.page-link-custom, .page-nav-btn');

        pageLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                // Add loading effect
                this.style.opacity = '0.7';
                this.style.pointerEvents = 'none';

                // Scroll to top smoothly
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
        });

        // Quantity input validation
        const quantityInputs = document.querySelectorAll('.quantity-input');

        quantityInputs.forEach(input => {
            input.addEventListener('input', function() {
                const max = parseInt(this.getAttribute('max'));
                const min = parseInt(this.getAttribute('min'));
                let value = parseInt(this.value);

                if (value > max) {
                    this.value = max;
                    this.style.borderColor = '#ffc107';

                    // Show warning
                    let warning = this.parentElement.querySelector('.stock-limit-warning');
                    if (!warning) {
                        warning = document.createElement('small');
                        warning.className = 'stock-limit-warning';
                        warning.style.color = '#ffc107';
                        warning.style.display = 'block';
                        warning.style.marginTop = '5px';
                        warning.innerHTML = '<i class="fas fa-exclamation-triangle me-1"></i>Số lượng tối đa: ' + max;
                        this.parentElement.appendChild(warning);
                    }

                    setTimeout(() => {
                        if (warning) warning.remove();
                        this.style.borderColor = '';
                    }, 3000);

                } else if (value < min) {
                    this.value = min;
                }
            });

            // Add focus effects
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });

            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });

        // Form submission loading effect
        const bookForms = document.querySelectorAll('.book-actions form');

    });
    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(function (el) {
            bootstrap.Tooltip.getOrCreateInstance(el);
        });
    });
</script>

<%@ include file="footer.jsp" %>
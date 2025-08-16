<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.bookstorecode.model.CartItem" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="org.example.bookstorecode.service.CartDao" %>

<%
    CartDao cart = (CartDao) session.getAttribute("cart");
    String csrfToken = (String) session.getAttribute("csrfToken"); // Giả sử CSRF token được lưu trong session
    if (csrfToken == null) {
        csrfToken = java.util.UUID.randomUUID().toString();
        session.setAttribute("csrfToken", csrfToken);
    }
%>
<%@ include file="../include-header.jsp" %>

<!-- Bootstrap CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    .cart-hero {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 40px 0 20px;
        position: relative;
        overflow: hidden;
    }

    .cart-hero::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.05)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100" height="20" fill="url(%23grain)"/></svg>');
        pointer-events: none;
    }

    .cart-title {
        font-size: 2.5rem;
        font-weight: 700;
        text-align: center;
        margin-bottom: 20px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        position: relative;
        z-index: 1;
    }

    .cart-container {
        padding: 40px 0;
        background: #f8f9fa;
        min-height: 70vh;
    }

    .empty-cart {
        text-align: center;
        padding: 80px 20px;
        background: white;
        border-radius: 25px;
        margin: 40px 0;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    }

    .empty-cart i {
        font-size: 5rem;
        color: #dee2e6;
        margin-bottom: 30px;
        animation: bounce 2s ease-in-out infinite;
    }

    @keyframes bounce {
        0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
        40% { transform: translateY(-10px); }
        60% { transform: translateY(-5px); }
    }

    .empty-cart h3 {
        color: #6c757d;
        margin-bottom: 20px;
        font-size: 1.8rem;
        font-weight: 600;
    }

    .empty-cart p {
        color: #8e9ba7;
        font-size: 1.1rem;
        margin-bottom: 30px;
    }

    .btn-shop-now {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white;
        padding: 15px 40px;
        border-radius: 50px;
        font-weight: 600;
        font-size: 1.1rem;
        border: none;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        transition: all 0.3s ease;
    }

    .btn-shop-now:hover {
        background: linear-gradient(135deg, #218838 0%, #1ba085 100%);
        color: white;
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(40, 167, 69, 0.4);
    }

    .cart-table-container {
        background: white;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        padding: 30px;
        margin-bottom: 30px;
        position: relative;
    }

    .cart-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
    }

    .cart-table th {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 20px 15px;
        font-weight: 600;
        text-align: center;
        border: none;
        font-size: 1rem;
    }

    .cart-table th:first-child
    {
        display: flex;
        border-radius: 15px 0 0 0;
        align-items: center;
    }

    .cart-table th:last-child {
        border-radius: 0 15px 0 0;
    }

    .cart-table td {
        padding: 20px 15px;
        text-align: center;
        border-bottom: 1px solid #f8f9fa;
        vertical-align: middle;
    }

    .cart-table tr:last-child td {
        border-bottom: none;
    }

    .cart-table tr:hover {
        background: rgba(102, 126, 234, 0.05);
    }

    .book-title {
        font-weight: 600;
        color: #2c3e50;
        font-size: 1.1rem;
        max-width: 200px;
        margin: 0 auto;
        line-height: 1.4;
    }

    .price-display {
        font-size: 1.2rem;
        font-weight: 600;
        color: #e74c3c;
    }

    .quantity-input {
        border: 2px solid #e9ecef;
        border-radius: 10px;
        padding: 8px 12px;
        font-size: 1rem;
        width: 80px;
        text-align: center;
        transition: all 0.3s ease;
    }

    .quantity-input:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
        outline: none;
    }

    .subtotal-display {
        font-size: 1.2rem;
        font-weight: 600;
        color: #28a745;
    }

    .total-row {
        background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
    }

    .total-row td {
        font-weight: 700;
        font-size: 1.3rem;
        color: #2c3e50;
        padding: 25px 15px;
        border-bottom: none;
    }

    .custom-checkbox {
        width: 20px;
        height: 20px;
        accent-color: #667eea;
        cursor: pointer;
    }

    .action-buttons {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: space-between;
        align-items: flex-start;
    }

    .remove-selected-form {
        justify-items: center;
        flex: 1;
        min-width: 300px;
    }

    .checkout-form {
        justify-content: center;
        margin: 0 auto;
        flex: 1;
        width: 40%;
    }

    .btn-remove-selected {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
        padding: 15px 30px;
        border-radius: 15px;
        border: none;
        font-weight: 600;
        font-size: 1.1rem;
        display: flex;
        align-items: center;
        gap: 10px;
        transition: all 0.3s ease;
        width: 10%;
        justify-content: center;
    }

    .btn-remove-selected:hover {
        background: linear-gradient(135deg, #c82333 0%, #a71e2a 100%);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);
    }

    .checkout-section h4 {
        color: #2c3e50;
        margin-bottom: 25px;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .payment-options {
        margin-bottom: 30px;
    }

    .payment-option {
        background: rgba(102, 126, 234, 0.05);
        border: 2px solid rgba(102, 126, 234, 0.1);
        border-radius: 15px;
        padding: 20px;
        margin-bottom: 15px;
        transition: all 0.3s ease;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .payment-option:hover {
        background: rgba(102, 126, 234, 0.1);
        border-color: rgba(102, 126, 234, 0.3);
    }

    .payment-option input[type="radio"] {
        width: 20px;
        height: 20px;
        accent-color: #667eea;
    }

    .payment-option.selected {
        background: rgba(102, 126, 234, 0.15);
        border-color: #667eea;
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.2);
    }

    .payment-label {
        font-weight: 600;
        color: #2c3e50;
        margin: 0;
        flex: 1;
        cursor: pointer;
    }

    .payment-icon {
        font-size: 1.5rem;
        color: #667eea;
    }

    .btn-checkout {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white;
        padding: 18px 40px;
        border-radius: 15px;
        border: none;
        font-weight: 600;
        font-size: 1.2rem;
        display: flex;
        align-items: center;
        gap: 10px;
        transition: all 0.3s ease;
        width: 50%;
        justify-content: center;
        margin: 0 auto;
    }

    .btn-checkout:hover {
        background: linear-gradient(135deg, #218838 0%, #1ba085 100%);
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(40, 167, 69, 0.4);
    }

    .error-message {
        color: #dc3545;
        font-weight: 600;
        margin-top: 15px;
        padding: 15px;
        background: rgba(220, 53, 69, 0.1);
        border: 1px solid rgba(220, 53, 69, 0.2);
        border-radius: 10px;
        display: none;
    }

    .loading-overlay {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(255, 255, 255, 0.8);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 1000;
        display: none;
    }

    .loading-spinner {
        font-size: 2rem;
        color: #667eea;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    @media (max-width: 768px) {
        .cart-title {
            font-size: 2rem;
        }

        .cart-table-container {
            padding: 20px;
            overflow-x: auto;
        }

        .cart-table {
            min-width: 600px;
        }

        .cart-table th,
        .cart-table td {
            padding: 15px 10px;
            font-size: 0.9rem;
        }

        .book-title {
            font-size: 1rem;
            max-width: 150px;
        }

        .quantity-input {
            width: 60px;
        }

        .action-buttons {
            flex-direction: column;
        }

        .remove-selected-form,
        .checkout-form {
            min-width: auto;
            width: 100%;
        }

        .checkout-form {
            margin-top: 20px;
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

<!-- Cart Hero Section -->
<section class="cart-hero">
    <div class="container">
        <h1 class="cart-title">
            <i class="fas fa-shopping-cart me-3"></i>
           Giỏ hàng của bạn
        </h1>
    </div>
</section>

<!-- Main Content -->
<div class="cart-container">
    <div class="container">
        <% if (cart == null || cart.getItems().isEmpty()) { %>
        <!-- Empty Cart -->
        <div class="empty-cart fade-in">
            <i class="fas fa-shopping-cart"></i>
            <h3>Giỏ hàng trống</h3>
            <p>Bạn chưa có sản phẩm nào trong giỏ hàng. Hãy khám phá cửa hàng của chúng tôi!</p>
            <a href="user-book-store" class="btn-shop-now">
                Mua sắm ngay
            </a>
        </div>
        <% } else { %>
        <!-- Cart Items -->
        <form action="remove-selected-from-cart" method="post" class="fade-in">
            <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
            <div class="cart-table-container position-relative">
                <div class="loading-overlay" id="cart-loading">
                    <i class="fas fa-spinner loading-spinner"></i>
                </div>
                <table class="cart-table">
                    <thead>
                    <tr>
                        <th scope="col">
                            <input type="checkbox" class="custom-checkbox" id="selectAll" onchange="toggleSelectAll()" aria-label="Chọn tất cả sản phẩm"> &nbsp;Chọn tất cả
                        </th>
                        <th scope="col">Sách</th>
                        <th scope="col">Đơn giá</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Thành tiền</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        BigDecimal total = BigDecimal.ZERO;
                        for (CartItem item : cart.getItems()) {
                            BigDecimal price = item.getBook().getPrice();
                            int quantity = item.getQuantity();
                            BigDecimal subtotal = price.multiply(BigDecimal.valueOf(quantity));
                            int bookId = item.getBook().getId();
                            total = total.add(subtotal);
                    %>
                    <tr id="row-<%= bookId %>">
                        <td>
                            <input type="checkbox" name="bookId" value="<%= bookId %>" class="custom-checkbox item-checkbox" onchange="updateSelectAll()" aria-label="Chọn sách <%= item.getBook().getTitle() %>">
                        </td>
                        <td>
                            <div class="book-title"><%= item.getBook().getTitle() %></div>
                        </td>
                        <td>
                            <span class="price-display" id="price-<%= bookId %>"><%= String.format("%,d", price.intValue()) %></span> ₫
                        </td>
                        <td>
                            <input type="number"
                                   class="quantity-input"
                                   value="<%= quantity %>"
                                   min="1"
                                   max="<%= item.getBook().getStock() %>"
                                   data-book-id="<%= bookId %>"
                                   onchange="updateQuantity(this)"
                                   aria-label="Số lượng sách <%= item.getBook().getTitle() %>"
                                   title="Tối đa <%= item.getBook().getStock() %> sản phẩm">
                        </td>
                        <td>
                            <span class="subtotal-display" id="subtotal-<%= bookId %>"><%= String.format("%,d", subtotal.intValue()) %></span> ₫
                        </td>
                    </tr>
                    <% } %>
                    <tr class="total-row">
                        <td colspan="4"><strong>Tổng cộng:</strong></td>
                        <td><strong><span id="total"><%= String.format("%,d", total.intValue()) %></span> ₫</strong></td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div class="action-buttons">
                <div class="remove-selected-form">
                    <button type="submit" class="btn-remove-selected" aria-label="Xóa các sản phẩm đã chọn">
                        <i class="fas fa-trash-alt"></i>
                        Xóa
                    </button>
                </div>
            </div>
        </form>

        <div class="checkout-form">
            <form action="checkout" method="post">
                <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                <h4>
                    <i class="fas fa-credit-card"></i>
                    Phương thức thanh toán
                </h4>

                <div class="payment-options">
                    <label class="payment-option" for="cod">
                        <input type="radio" name="payment" value="COD" id="cod" checked aria-label="Thanh toán khi nhận hàng (COD)">
                        <i class="fas fa-truck payment-icon"></i>
                        <span class="payment-label">Thanh toán khi nhận hàng (COD)</span>
                    </label>

                    <label class="payment-option" for="vnpay">
                        <input type="radio" name="payment" value="VNPAY" id="vnpay" aria-label="Thanh toán qua VNPay">
                        <i class="fas fa-mobile-alt payment-icon"></i>
                        <span class="payment-label">Thanh toán qua VNPay</span>
                    </label>
                </div>

                <button type="submit" class="btn-checkout" aria-label="Đặt hàng ngay">
                    <i class="fas fa-check-circle"></i>
                    Đặt hàng ngay
                </button>
            </form>
        </div>
    </div>

    <div class="error-message" id="error-msg">
        <i class="fas fa-exclamation-triangle me-2"></i>
        <span id="error-text"></span>
    </div>
    <% } %>
</div>

<!-- Bootstrap JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
    // Select All functionality
    function toggleSelectAll() {
        const selectAllCheckbox = document.getElementById('selectAll');
        const itemCheckboxes = document.querySelectorAll('.item-checkbox');

        itemCheckboxes.forEach(checkbox => {
            checkbox.checked = selectAllCheckbox.checked;
        });
    }

    function updateSelectAll() {
        const selectAllCheckbox = document.getElementById('selectAll');
        const itemCheckboxes = document.querySelectorAll('.item-checkbox');
        const checkedItems = document.querySelectorAll('.item-checkbox:checked');

        selectAllCheckbox.checked = itemCheckboxes.length === checkedItems.length;
        selectAllCheckbox.indeterminate = checkedItems.length > 0 && checkedItems.length < itemCheckboxes.length;
    }

    // Update quantity function
    function updateQuantity(input) {
        const bookId = input.dataset.bookId;
        const quantity = parseInt(input.value);
        const max = parseInt(input.getAttribute('max'));
        const min = parseInt(input.getAttribute('min'));

        // Validate quantity
        if (isNaN(quantity) || quantity < min) {
            input.value = min;
            showError('Số lượng không hợp lệ. Tối thiểu là 1.');
            return;
        }
        if (quantity > max) {
            input.value = max;
            showError(`Số lượng tối đa cho sản phẩm này là ${max}.`);
            return;
        }

        // Show loading overlay
        const loadingOverlay = document.getElementById('cart-loading');
        if (loadingOverlay) loadingOverlay.style.display = 'flex';

        const data = new URLSearchParams();
        data.append("bookId", bookId);
        data.append("quantity", quantity);
        data.append("csrfToken", '<%= csrfToken %>');

        console.log("✅ Sending:", bookId, quantity);

        fetch('update-cart-ajax', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: data
        })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    updateCartDisplay(bookId, data.subtotal, data.total);
                    showSuccess('Cập nhật số lượng thành công!');
                } else {
                    input.value = data.currentQuantity || input.value;
                    showError(data.message || 'Lỗi khi cập nhật số lượng.');
                }
            })
            .catch(() => {
                showError('Có lỗi xảy ra khi gửi yêu cầu.');
            })
            .finally(() => {
                // Hide loading overlay
                if (loadingOverlay) loadingOverlay.style.display = 'none';
            });
    }

    // Update cart display without reload
    function updateCartDisplay(bookId, subtotal, total) {
        const subtotalElement = document.getElementById(`subtotal-${bookId}`);
        const totalElement = document.getElementById('total');

        if (subtotalElement && totalElement) {
            subtotalElement.textContent = formatCurrency(subtotal);
            totalElement.textContent = formatCurrency(total);
        }
    }

    // Format currency helper
    function formatCurrency(amount) {
        return amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    // Show error message
    function showError(message) {
        const errorElement = document.getElementById('error-msg');
        const errorText = document.getElementById('error-text');

        if (errorElement && errorText) {
            errorText.textContent = message;
            errorElement.style.display = 'block';
            errorElement.style.background = 'rgba(220, 53, 69, 0.1)';
            errorElement.style.borderColor = 'rgba(220, 53, 69, 0.2)';
            errorElement.style.color = '#dc3545';

            setTimeout(() => {
                errorElement.style.display = 'none';
            }, 5000);
        }
    }

    // Show success message
    function showSuccess(message) {
        const errorElement = document.getElementById('error-msg');
        const errorText = document.getElementById('error-text');

        if (errorElement && errorText) {
            errorText.textContent = message;
            errorElement.style.display = 'block';
            errorElement.style.background = 'rgba(40, 167, 69, 0.1)';
            errorElement.style.borderColor = 'rgba(40, 167, 69, 0.2)';
            errorElement.style.color = '#28a745';

            setTimeout(() => {
                errorElement.style.display = 'none';
            }, 3000);
        }
    }

    // Payment option selection effects
    document.addEventListener('DOMContentLoaded', function() {
        const paymentOptions = document.querySelectorAll('.payment-option');
        const radioButtons = document.querySelectorAll('input[name="payment"]');

        paymentOptions.forEach(option => {
            option.addEventListener('click', function() {
                const radio = this.querySelector('input[type="radio"]');
                if (radio) {
                    radio.checked = true;
                    updatePaymentSelection();
                }
            });
        });

        radioButtons.forEach(radio => {
            radio.addEventListener('change', updatePaymentSelection);
        });

        function updatePaymentSelection() {
            paymentOptions.forEach(option => {
                const radio = option.querySelector('input[type="radio"]');
                if (radio && radio.checked) {
                    option.classList.add('selected');
                } else {
                    option.classList.remove('selected');
                }
            });
        }

        updatePaymentSelection();

        const removeForm = document.querySelector('form[action="remove-selected-from-cart"]');
        if (removeForm) {
            removeForm.addEventListener('submit', function(e) {
                const checkedItems = document.querySelectorAll('.item-checkbox:checked');

                if (checkedItems.length === 0) {
                    e.preventDefault();
                    showError('Vui lòng chọn ít nhất một sản phẩm để xóa!');
                    return false;
                }

                if (!confirm(`Bạn có chắc muốn xóa ${checkedItems.length} sản phẩm đã chọn?`)) {
                    e.preventDefault();
                    return false;
                }

                const button = this.querySelector('.btn-remove-selected');
                button.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
                button.disabled = true;
            });
        }

        const checkoutForm = document.querySelector('form[action="checkout"]');
        if (checkoutForm) {
            checkoutForm.addEventListener('submit', function(e) {
                const button = this.querySelector('.btn-checkout');
                button.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý đơn hàng...';
                button.disabled = true;

                const inputs = this.querySelectorAll('input, button');
                inputs.forEach(input => input.disabled = true);
            });
        }

        // Add hover effects to table rows
        const tableRows = document.querySelectorAll('.cart-table tbody tr:not(.total-row)');
        tableRows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.01)';
                this.style.transition = 'all 0.3s ease';
            });

            row.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1)';
            });
        });

        // Add focus effects to quantity inputs
        const quantityInputs = document.querySelectorAll('.quantity-input');
        quantityInputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.style.transform = 'scale(1.05)';
                this.parentElement.style.backgroundColor = 'rgba(102, 126, 234, 0.05)';
            });

            input.addEventListener('blur', function() {
                this.style.transform = 'scale(1)';
                this.parentElement.style.backgroundColor = '';
            });
        });
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey && e.key === 'a' && e.target.tagName !== 'INPUT') {
            e.preventDefault();
            const selectAllCheckbox = document.getElementById('selectAll');
            if (selectAllCheckbox) {
                selectAllCheckbox.checked = !selectAllCheckbox.checked;
                toggleSelectAll();
            }
        }

        if (e.key === 'Delete') {
            const removeButton = document.querySelector('.btn-remove-selected');
            if (removeButton) {
                removeButton.click();
            }
        }

        if (e.key === 'Enter' && e.ctrlKey) {
            const checkoutButton = document.querySelector('.btn-checkout');
            if (checkoutButton) {
                checkoutButton.click();
            }
        }
    });
</script>

<%@ include file="../footer.jsp" %>
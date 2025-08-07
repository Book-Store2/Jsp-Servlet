<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.bookstorecode.model.CartItem" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="org.example.bookstorecode.service.CartDao" %>

<%
    CartDao cart = (CartDao) session.getAttribute("cart");
%>
<%@ include file="../include-header.jsp" %>
<h2>🛒 Giỏ hàng của bạn</h2>

<% if (cart == null || cart.getItems().isEmpty()) { %>
<p>Giỏ hàng trống.</p>
<% } else { %>
<form action="remove-selected-from-cart" method="post">
    <table border="1" cellpadding="10" cellspacing="0">
        <tr>
            <th>Chọn</th>
            <th>Sách</th>
            <th>Đơn giá</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
        </tr>
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
                <input type="checkbox" name="bookId" value="<%= bookId %>">
            </td>
            <td><%= item.getBook().getTitle() %></td>
            <td><span id="price-<%= bookId %>"><%= price %></span> ₫</td>
            <td>
                <input type="number"
                       value="<%= quantity %>"
                       min="1"
                       max="<%= item.getBook().getStock() %>"
                       data-book-id="<%= bookId %>"
                       onchange="updateQuantity(this)">
            </td>
            <td><span id="subtotal-<%= bookId %>"><%= subtotal %></span> ₫</td>
        </tr>
        <% } %>
        <tr>
            <td colspan="4"><strong>Tổng cộng:</strong></td>
            <td><strong><span id="total"><%= total %></span> ₫</strong></td>
        </tr>
    </table>
    <br>
    <button type="submit">🗑️ Xóa sản phẩm đã chọn</button>
</form>

<br><br>
<form action="checkout" method="post">
    <strong>Phương thức thanh toán</strong><br>
    <label><input type="radio" name="payment" value="COD" checked> Thanh toán khi nhận hàng (COD)</label><br>
    <label><input type="radio" name="payment" value="VNPAY"> Thanh toán qua VNPay</label><br><br>
    <button type="submit">✅ Đặt hàng</button>
</form>

<p id="error-msg" style="color:red;"></p>

<script>
    function updateQuantity(input) {
        const bookId = input.dataset.bookId;
        const quantity = input.value;

        const data = new URLSearchParams();
        data.append("bookId", bookId);
        data.append("quantity", quantity);

        console.log("✅ Sending:", bookId, quantity);

        fetch('update-cart-ajax', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: data
        }).then(res => {
            if (res.ok) {
                location.reload();
            } else {
                const errorMsg = document.getElementById("error-message");
                if (errorMsg) errorMsg.textContent = "Lỗi khi cập nhật số lượng.";
            }
        }).catch(() => {
            const errorMsg = document.getElementById("error-message");
            if (errorMsg) errorMsg.textContent = "Có lỗi xảy ra khi gửi yêu cầu.";
        });
    }
</script>


<p id="error-message" style="color:red;"></p>
<% } %>

<%@ include file="../footer.jsp" %>

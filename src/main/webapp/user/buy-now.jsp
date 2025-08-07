<%@ page import="org.example.bookstorecode.model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include-header.jsp" %>
<%
  Book book = (Book) request.getAttribute("book");
  int quantity = (Integer) request.getAttribute("quantity");
%>

<h2>Xác nhận mua ngay</h2>
<p><strong>Sách:</strong> <%= book.getTitle() %></p>
<p><strong>Giá:</strong> <%= book.getPrice() %>₫</p>
<p><strong>Số lượng:</strong> <%= quantity %></p>
<p><strong>Thành tiền:</strong> <%= book.getPrice().multiply(java.math.BigDecimal.valueOf(quantity)) %>₫</p>

<form action="buy-now-confirm" method="post">
  <input type="hidden" name="bookId" value="<%= book.getId() %>">
  <input type="hidden" name="quantity" value="<%= quantity %>">

  <label><input type="radio" name="payment" value="COD" checked> Thanh toán khi nhận hàng</label><br>
  <label><input type="radio" name="payment" value="VNPAY"> Thanh toán VNPay</label><br><br>

  <button type="submit">✅ Xác nhận đặt hàng</button>
</form>

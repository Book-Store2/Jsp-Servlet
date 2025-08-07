<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include-header.jsp" %>
<h3>Chi tiết đơn hàng #${order.id}</h3>
<p>Khách hàng: ${order.customerName}</p>
<p>Tổng tiền: ${order.totalPrice}</p>
<p>Ngày đặt: ${order.orderDate}</p>

<h4>Sản phẩm trong đơn hàng:</h4>
<table class="table">
  <thead>
  <tr>
    <th>ID sách</th>
    <th>Tên sách</th>
    <th>Số lượng</th>
    <th>Giá</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach items="${orderDetails}" var="item">
    <tr>
      <td>${item.bookId}</td>
      <td>${item.bookTitle}</td>
      <td>${item.quantity}</td>
      <td>${item.price}</td>
    </tr>
  </c:forEach>
  </tbody>
</table>

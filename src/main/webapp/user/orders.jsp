<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.bookstorecode.dto.OrderCustomerDetail" %>
<%@ page import="org.example.bookstorecode.dto.OrderDetailDto" %>

<%@ include file="../include-header.jsp" %>
<h2>📦 Danh sách đơn hàng của bạn</h2>

<%
  List<OrderCustomerDetail> orders = (List<OrderCustomerDetail>) request.getAttribute("orders");
  if (orders == null || orders.isEmpty()) {
%>
<p>Không có đơn hàng nào.</p>
<%
} else {
  for (OrderCustomerDetail order : orders) {
%>
<hr>
<p><strong>Người đặt:</strong> <%= order.getUser().getName() %> - <%= order.getUser().getEmail() %></p>
<p><strong>Ngày đặt:</strong> <%= order.getCreatedAt() %></p>
<p><strong>Tổng tiền:</strong> <%= order.getTotalAmount() %> ₫</p>
<p><strong>Thanh toán:</strong> <%= order.getPaymentMethod() %></p>
<p><strong>Trạng thái:</strong> <% if (Integer.parseInt(order.getStatus()) == 0) { %>
  🕐 Chưa thanh toán
  <% } else if (Integer.parseInt(order.getStatus()) == 1) { %>
  ✅ Đã thanh toán
  <% } else if (Integer.parseInt(order.getStatus()) == 2) { %>
  ✅ Đã giao
  <% } else if (Integer.parseInt(order.getStatus()) == 3) { %>
  <span style="color:red;">❌ Đã hủy</span>
  <% } %></p>
<ul>
  <% for (OrderDetailDto detail : order.getDetails()) { %>
  <li><%= detail.getBookTitle() %> - SL: <%= detail.getQuantity() %> x <%= detail.getPrice() %> ₫</li>
  <% } %>
</ul>
<%
    }
  }
%>

<%@ include file="../footer.jsp" %>




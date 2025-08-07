<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.bookstorecode.model.User" %>
<%@ page import="org.example.bookstorecode.model.Role" %>

<%
  User customer = (User) session.getAttribute("user");
%>

<div style="background-color:#f4f4f4; padding:10px;">
  Xin chào, <b><%= customer.getName() %></b> |
  <a href="logout">Đăng xuất</a> |
  <a href="home">Trang chủ</a> |
  <a href="user-book-store">Cửa hàng</a> |
  <a href="user-cart">Giỏ hàng</a> |
  <a href="user-orders">Lịch sử đơn hàng</a>
</div>
<hr>

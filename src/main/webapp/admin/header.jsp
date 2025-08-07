<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.bookstorecode.model.User" %>
<%@ page import="org.example.bookstorecode.model.Role" %>
<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || admin.getRole() == Role.CUSTOMER) {
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>
<div style="background-color:#eee; padding:10px;">
    <b>ADMIN:</b> <%= admin.getName() %> |
    <a href="logout">Đăng xuất</a> |
    <a href="home">Trang chủ</a> |
    <a href="manage-books">Quản lý sách</a> |
    <a href="manage-categories">Quản lý danh mục</a> |
    <a href="manage-orders">Quản lý đơn hàng</a>
</div>
<hr>


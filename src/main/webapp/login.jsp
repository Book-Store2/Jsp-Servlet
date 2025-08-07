<%@ page import="org.example.bookstorecode.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Đọc cookie ghi nhớ email
    String savedEmail = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("email".equals(cookie.getName())) {
                savedEmail = cookie.getValue();
                break;
            }
        }
    }

    // Không cho truy cập nếu đã đăng nhập
    User checkUser = (User) session.getAttribute("user");
    if (checkUser != null) {
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>

<%@ include file="include-header.jsp" %>

<% String message = (String) request.getAttribute("message"); %>
<% if (message != null) { %>
<div style="color: red;"><%= message %></div>
<% } %>

<h2>Đăng nhập</h2>
<form method="post" action="login">
    Email: <input type="email" name="email" required value="<%= savedEmail %>"><br>
    Mật khẩu: <input type="password" name="password" required pattern=".{6,}" title="Ít nhất 6 ký tự"><br>
    <label><input type="checkbox" name="remember" <%= !"".equals(savedEmail) ? "checked" : "" %>> Ghi nhớ đăng nhập</label><br><br>
    <button type="submit">Đăng nhập</button>
</form>
<a href="register">Chưa có tài khoản?</a>

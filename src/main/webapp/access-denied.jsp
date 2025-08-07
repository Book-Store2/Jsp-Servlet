<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="include-header.jsp" %>
<%
  // Xử lý nút "Đăng nhập với vai trò khác"
  String action = request.getParameter("action");
  if ("relogin".equals(action)) {
    session.invalidate(); // Xóa session

    // Xóa cookie email/password nếu có
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
      for (Cookie cookie : cookies) {
        if ("email".equals(cookie.getName()) || "password".equals(cookie.getName())) {
          cookie.setMaxAge(0);
          cookie.setPath("/");
          response.addCookie(cookie);
        }
      }
    }

    response.sendRedirect("login"); // Chuyển về trang đăng nhập
    return;
  }
%>

<h2 style="color:red;">Bạn không có quyền truy cập trang này!</h2>
<p>Vui lòng đăng nhập bằng vai trò phù hợp hoặc quay lại trang chủ.</p>

<form method="get">
  <input type="hidden" name="action" value="relogin">
  <button type="submit">Đăng nhập với vai trò khác</button>
</form>

<form method="get" action="home">
  <button type="submit">Quay lại trang chủ</button>
</form>



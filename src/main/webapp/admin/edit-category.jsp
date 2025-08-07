<%@ page import="org.example.bookstorecode.model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="../include-header.jsp" %>
<%
    Category cat = (Category) request.getAttribute("category");
%>
<h2>Sửa danh mục</h2>
<form method="post" action="/category-update">
    <input type="hidden" name="id" value="<%= cat.getId() %>">
    <input type="text" name="name" value="<%= cat.getName() %>" required>
    <button type="submit">Cập nhật</button>
</form>


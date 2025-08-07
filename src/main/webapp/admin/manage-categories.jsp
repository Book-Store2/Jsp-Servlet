<%@ page import="org.example.bookstorecode.model.Category" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="../include-header.jsp" %>

<h2>Quản lý danh mục</h2>
<form method="post" action="category-create">
    <input type="text" name="name" placeholder="Tên danh mục" required>
    <button type="submit">Thêm mới</button>
</form>

<table border="1" cellpadding="10">
    <tr>
        <th>STT</th><th>Tên danh mục</th><th>Hành động</th>
    </tr>
    <%
        List<Category> categories = (List<Category>) request.getAttribute("categories");
        int stt = 1;
        for (Category c : categories) {
    %>
    <tr>
        <td><%= stt++ %></td>
        <td><%= c.getName() %></td>
        <td>
            <a href="category-edit?id=<%= c.getId() %>">Sửa</a> |
            <a href="category-delete?id=<%= c.getId() %>" onclick="return confirm('Xóa?')">Xóa</a>
        </td>
    </tr>
    <% } %>
</table>


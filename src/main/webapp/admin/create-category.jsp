<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="../include-header.jsp" %>

<h2>Thêm danh mục mới</h2>

<form method="post" action="category-create">
    <label for="name">Tên danh mục:</label><br>
    <input type="text" id="name" name="name" required><br><br>

    <button type="submit">Thêm</button>
    <a href="manage-categories">Quay lại</a>
</form>


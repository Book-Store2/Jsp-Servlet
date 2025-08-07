<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.bookstorecode.model.Category" %>
<%@ page import="java.util.List" %>
<%@ include file="../include-header.jsp" %>

<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    String error = (String) request.getAttribute("error");
    String success = request.getParameter("success");
%>

<h2>➕ Thêm sách mới</h2>

<% if (error != null) { %>
<div style="color:red;"><%= error %></div>
<% } %>

<form action="book-create" method="post" enctype="multipart/form-data">
    Tiêu đề: <input type="text" name="title" required><br><br>
    Tác giả: <input type="text" name="author" required><br><br>
    Giá: <input type="number" step="0.01" name="price" required><br><br>
    Ảnh (upload):
    <input type="file" name="image" accept="image/*" required onchange="previewImage(this)"><br>
    <img id="preview" src="#" alt="Xem trước ảnh" style="max-width: 200px; display: none; margin-top: 10px;"><br><br>
    Mô tả:<br>
    <textarea name="description" rows="5" cols="40" required></textarea><br><br>
    Kho còn: <input type="number" name="stock" required><br><br>
    Đã bán: <input type="number" name="sold" value="0" required><br><br>
    Thể loại:
    <select name="categoryId" required>
        <option value="">-- Chọn thể loại --</option>
        <% for (Category c : categories) { %>
        <option value="<%= c.getId() %>"><%= c.getName() %></option>
        <% } %>
    </select><br><br>
    Trạng thái:
    <select name="status" required>
        <option value="ACTIVE">Hiển thị</option>
        <option value="INACTIVE">Ẩn</option>
    </select><br><br>
    <button type="submit">Thêm sách</button>
</form>

<br>
<a href="manage-books">⬅️ Quay lại danh sách</a>
<script>
    function previewImage(input) {
        const preview = document.getElementById('preview');
        const file = input.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        } else {
            preview.src = '#';
            preview.style.display = 'none';
        }
    }
</script>
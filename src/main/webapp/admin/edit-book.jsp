<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.bookstorecode.model.Book" %>
<%@ page import="org.example.bookstorecode.model.Category" %>
<%@ page import="java.util.List" %>
<%@ include file="../include-header.jsp" %>

<%
    Book book = (Book) request.getAttribute("book");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<h2>✏️ Chỉnh sửa sách</h2>

<form action="book-update" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%= book.getId() %>">
    <input type="hidden" name="oldImage" value="<%= book.getImage() %>">

    Tiêu đề: <input type="text" name="title" value="<%= book.getTitle() %>" required><br><br>
    Tác giả: <input type="text" name="author" value="<%= book.getAuthor() %>" required><br><br>
    Giá: <input type="number" step="0.01" name="price" value="<%= book.getPrice() %>" required><br><br>

    Ảnh (upload):
    <input type="file" name="image" accept="image/*" onchange="previewImage(this)"><br>
    <img id="preview" src="<%= book.getImage() %>" alt="Xem trước ảnh"
         style="max-width: 200px; display: <%= book.getImage() != null ? "block" : "none" %>; margin-top: 10px;"><br><br>

    Mô tả:<br>
    <textarea name="description" rows="5" cols="40" required><%= book.getDescription() %></textarea><br><br>
    Kho còn: <input type="number" name="stock" value="<%= book.getStock() %>" required><br><br>
    Đã bán: <input type="number" name="sold" value="<%= book.getSold() %>" required><br><br>

    Thể loại:
    <select name="categoryId" required>
        <% for (Category c : categories) { %>
        <option value="<%= c.getId() %>" <%= c.getId() == book.getCategoryId() ? "selected" : "" %>><%= c.getName() %></option>
        <% } %>
    </select><br><br>

    Trạng thái:
    <select name="status" required>
        <option value="ACTIVE" <%= book.getStatus().name().equals("ACTIVE") ? "selected" : "" %>>Hiển thị</option>
        <option value="INACTIVE" <%= book.getStatus().name().equals("INACTIVE") ? "selected" : "" %>>Ẩn</option>
    </select><br><br>

    <button type="submit">Cập nhật</button>
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


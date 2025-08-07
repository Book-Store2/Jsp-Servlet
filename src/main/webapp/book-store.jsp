<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.bookstorecode.model.Book" %>

<%@ include file="include-header.jsp" %>

<h2>📚 Danh sách sách</h2>
<%
    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>
<% if (message != null) { %>
<p style="color:green;"><%= message %></p>
<% } else if (error != null) { %>
<p style="color:red;"><%= error %></p>
<% } %>
<%
    List<Book> books = (List<Book>) request.getAttribute("books");
    int currentPage = (Integer) request.getAttribute("currentPage");
    int totalPages = (Integer) request.getAttribute("totalPages");
%>

<% if (books == null || books.isEmpty()) { %>
<p>Không có sách nào để hiển thị.</p>
<% } else { %>
<div style="display: flex; flex-wrap: wrap;">
    <% for (Book b : books) { %>
    <div style="width: 260px; border: 1px solid #ccc; margin: 10px; padding: 10px;">
        <img src="<%= b.getImage() %>" alt="Ảnh sách" width="100%">
        <h4><%= b.getTitle() %></h4>
        <p><strong>Tác giả:</strong> <%= b.getAuthor() %></p>
        <p><strong>Giá:</strong> <%= b.getPrice() %>₫</p>
        <p><strong>Đã bán:</strong> <%= b.getSold() %> | <strong>Tồn kho:</strong> <%= b.getStock() %></p>

        <% if (b.getStock() > 0) { %>
        <form method="post" action="book-action">
            <input type="hidden" name="bookId" value="<%= b.getId() %>">
            Số lượng:
            <input type="number" name="quantity" value="1" min="1" max="<%= b.getStock() %>" required>
            <br><br>
            <button type="submit" name="action" value="add">➕ Thêm vào giỏ</button>
            <button type="submit" name="action" value="buy">🛒 Mua ngay</button>
        </form>
        <% } else { %>
        <p style="color: red;">⚠️ Hết hàng</p>
        <% } %>
    </div>
    <% } %>
</div>

<!-- PHÂN TRANG -->
<div style="text-align:center; margin-top: 20px;">
    <% if (currentPage > 1) { %>
    <a href="book-store?page=<%= currentPage - 1 %>">⬅️ Trang trước</a>
    <% } %>

    <% for (int i = 1; i <= totalPages; i++) { %>
    <% if (i == currentPage) { %>
    <strong>[<%= i %>]</strong>
    <% } else { %>
    <a href="book-store?page=<%= i %>"><%= i %></a>
    <% } %>
    <% } %>

    <% if (currentPage < totalPages) { %>
    <a href="book-store?page=<%= currentPage + 1 %>">Trang sau ➡️</a>
    <% } %>
</div>
<% } %>

<%@ include file="footer.jsp" %>

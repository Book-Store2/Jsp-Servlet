<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="org.example.bookstorecode.model.Book" %>
<%@ page import="org.example.bookstorecode.service.BookDao" %>
<%@ page import="org.example.bookstorecode.service.CategoryDao" %>
<%@ page import="org.example.bookstorecode.model.Category" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%@ include file="../include-header.jsp" %>

<h2>📚 Quản lý sách</h2>
<%
  CategoryDao categoryDao = new CategoryDao();
  List<Category> categories = categoryDao.findAll();
  String selectedCategory = request.getParameter("category");
%>
<!-- FORM TÌM KIẾM -->
<form method="get" action="manage-books">
  Tên sách: <input type="text" name="title" value="<%= request.getParameter("title") != null ? request.getParameter("title") : "" %>">
  Tác giả: <input type="text" name="author" value="<%= request.getParameter("author") != null ? request.getParameter("author") : "" %>">
  Giá từ: <input type="number" step="0.01" name="minPrice" value="<%= request.getParameter("minPrice") != null ? request.getParameter("minPrice") : "" %>">
  đến: <input type="number" step="0.01" name="maxPrice" value="<%= request.getParameter("maxPrice") != null ? request.getParameter("maxPrice") : "" %>">
  Thể loại:
  <select name="category">
    <option value="">--Tất cả--</option>
    <% for (Category c : categories) { %>
    <option value="<%= c.getName() %>" <%= (c.getName().equals(selectedCategory)) ? "selected" : "" %>><%= c.getName() %></option>
    <% } %>
  </select>
  <button type="submit">Tìm kiếm</button>
  <a href="manage-books">🔄 Reset</a>
</form>

<br>
<a href="book-create">➕ Thêm sách mới</a>
<br><br>

<!-- XỬ LÝ DỮ LIỆU -->
<%
  String title = request.getParameter("title");
  String author = request.getParameter("author");
  String min = request.getParameter("minPrice");
  String max = request.getParameter("maxPrice");
  String category = request.getParameter("category");
  BigDecimal minPrice = (min != null && !min.isEmpty()) ? new BigDecimal(min) : null;
  BigDecimal maxPrice = (max != null && !max.isEmpty()) ? new BigDecimal(max) : null;

  BookDao dao = new BookDao();
  List<Book> list;

  if ((title == null || title.isEmpty()) &&
          (author == null || author.isEmpty()) &&
          (minPrice == null && maxPrice == null) &&
          (category == null || category.isEmpty())) {
    list = dao.findAll();
  } else {
    list = dao.search(title, author, minPrice, maxPrice, category);
  }
%>

<!-- HIỂN THỊ KẾT QUẢ -->
<table border="1" cellpadding="10" cellspacing="0">
  <tr>
    <th>STT</th>
    <th>Tiêu đề</th>
    <th>Tác giả</th>
    <th>Giá</th>
    <th>Ảnh</th>
    <th>Mô tả</th>
    <th>Kho còn</th>
    <th>Lượt bán</th>
    <th>Thể loại</th>
    <th>Ngày tạo</th>
    <th>Hành động</th>
  </tr>

  <%
    Map<Integer, String> categoryMap = new HashMap<>();
    for (Category c : categories) {
      categoryMap.put(c.getId(), c.getName());
    }
    int stt = 1;
    for (Book b : list) {
  %>
  <tr>
    <td><%= stt++ %></td>
    <td><%= b.getTitle() %></td>
    <td><%= b.getAuthor() %></td>
    <td><%= b.getPrice() %></td>
    <td><img src="<%= b.getImage() %>" width="60"></td>
    <td><%= b.getDescription() %></td>
    <td><%= b.getStock() %></td>
    <td><%= b.getSold() %></td>
    <td><%= categoryMap.getOrDefault(b.getCategoryId(), "Không rõ") %></td>
    <td><%= b.getCreatedAt() %></td>
    <td>
      <a href="/book-edit?id=<%= b.getId() %>">✏️ Sửa</a> |
      <a href="/book-delete?id=<%= b.getId() %>" onclick="return confirm('Xác nhận xoá sách này?')">❌ Xóa</a>
    </td>
  </tr>
  <%
    }
    if (list.isEmpty()) {
  %>
  <tr><td colspan="9" style="text-align: center;">Không tìm thấy sách nào phù hợp.</td></tr>
  <%
    }
  %>
</table>

<%@ include file="../footer.jsp" %>


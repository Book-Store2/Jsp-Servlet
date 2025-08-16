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

  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  <style>
    :root {
      --primary-color: #6366f1;
      --secondary-color: #8b5cf6;
      --success-color: #10b981;
      --warning-color: #f59e0b;
      --danger-color: #ef4444;
      --dark-color: #1f2937;
      --light-color: #f8fafc;
      --border-color: #e2e8f0;
      --text-color: #374151;
      --text-muted: #6b7280;
    }

    * {
      box-sizing: border-box;
    }

    body {
      font-family: 'Inter', sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      margin: 0;
      color: var(--text-color);
    }

    .container-fluid {
      max-width: 1400px;
    }

    .main-card {
      margin: 30px auto;
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      overflow: hidden;
    }

    .page-header {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: white;
      padding: 2rem;
      margin: -1px -1px 0 -1px;
    }

    .page-title {
      font-size: 2rem;
      font-weight: 700;
      margin: 0;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    .search-section {
      background: var(--light-color);
      border-bottom: 1px solid var(--border-color);
      padding: 2rem;
    }

    .search-form {
      background: white;
      border-radius: 16px;
      padding: 1.5rem;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
      border: 1px solid var(--border-color);
    }

    .form-control, .form-select {
      border: 2px solid var(--border-color);
      border-radius: 12px;
      padding: 0.75rem 1rem;
      font-size: 0.95rem;
      transition: all 0.3s ease;
      background: white;
    }

    .form-control:focus, .form-select:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
      outline: none;
    }

    .btn {
      border-radius: 12px;
      font-weight: 500;
      padding: 0.75rem 1.5rem;
      transition: all 0.3s ease;
      border: none;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
    }

    .btn-primary {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: white;
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
      background: linear-gradient(135deg, #5855eb, #7c3aed);
    }

    .btn-outline-secondary {
      border: 2px solid var(--border-color);
      color: greenyellow;
    }

    .btn-outline-secondary:hover {
      background: var(--light-color);
      border-color: var(--primary-color);
      color: var(--primary-color);
    }

    .btn-success {
      background: var(--success-color);
      color: white;
    }

    .btn-success:hover {
      background: #059669;
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(16, 185, 129, 0.3);
    }

    .table-section {
      padding: 2rem;
    }

    .table-responsive {
      border-radius: 16px;
      overflow: hidden;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
      border: 1px solid var(--border-color);
    }

    .table {
      margin: 0;
      background: white;
    }

    .table th {
      background: var(--dark-color);
      color: white;
      font-weight: 600;
      text-transform: uppercase;
      font-size: 0.85rem;
      letter-spacing: 0.5px;
      padding: 1rem;
      border: none;
      position: sticky;
      top: 0;
      z-index: 10;
    }

    .table td {
      padding: 1rem;
      vertical-align: middle;
      border-bottom: 1px solid var(--border-color);
      border-right: none;
      border-left: none;
    }

    .table tbody tr {
      transition: all 0.3s ease;
    }

    .table tbody tr:hover {
      background: rgba(99, 102, 241, 0.05);
      transform: scale(1.001);
    }

    .book-image {
      width: 60px;
      height: 80px;
      object-fit: cover;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
      transition: transform 0.3s ease;
    }

    .book-image:hover {
      transform: scale(1.1);
    }

    .book-title {
      font-weight: 600;
      color: var(--dark-color);
      max-width: 200px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .book-author {
      color: var(--text-muted);
      font-size: 0.9rem;
    }

    .book-price {
      font-weight: 700;
      color: var(--success-color);
      font-size: 1.1rem;
    }

    .book-description {
      max-width: 250px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      color: var(--text-muted);
      font-size: 0.9rem;
    }

    .stock-badge {
      display: inline-block;
      padding: 0.25rem 0.75rem;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 600;
    }

    .action-buttons {
      display: flex;
      gap: 0.5rem;
      align-items: center;
    }

    .btn-sm {
      padding: 0.4rem 0.8rem;
      font-size: 0.8rem;
      border-radius: 8px;
    }

    .btn-warning {
      background: var(--warning-color);
      color: white;
      border: none;
    }

    .btn-warning:hover {
      background: #d97706;
      color: white;
    }

    .btn-danger {
      background: var(--danger-color);
      color: white;
      border: none;
    }

    .btn-danger:hover {
      background: #dc2626;
      color: white;
    }

    .empty-state {
      text-align: center;
      padding: 3rem;
      color: var(--text-muted);
    }

    .empty-state i {
      font-size: 4rem;
      color: var(--border-color);
      margin-bottom: 1rem;
    }

    .stats-row {
      display: flex;
      gap: 1rem;
      margin-bottom: 2rem;
      flex-wrap: wrap;
    }

    .stat-card {
      background: white;
      border-radius: 16px;
      padding: 1.5rem;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
      border: 1px solid var(--border-color);
      display: flex;
      align-items: center;
      gap: 1rem;
    }

    .stat-icon {
      width: 50px;
      height: 50px;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
    }

    .stat-icon.books {
      background: rgba(99, 102, 241, 0.1);
      color: var(--primary-color);
    }

    .stat-content h3 {
      margin: 0;
      font-size: 1.5rem;
      font-weight: 700;
      color: var(--dark-color);
    }

    .stat-content p {
      margin: 0;
      font-size: 0.9rem;
      color: var(--text-muted);
    }

    @media (max-width: 768px) {
      .page-header {
        padding: 1.5rem;
      }

      .page-title {
        font-size: 1.5rem;
      }

      .search-section, .table-section {
        padding: 1rem;
      }

      .search-form {
        padding: 1rem;
      }

      .stats-row {
        flex-direction: column;
      }

      .action-buttons {
        flex-direction: column;
        align-items: stretch;
      }

      .table th, .table td {
        padding: 0.5rem;
        font-size: 0.85rem;
      }
    }

    @media (max-width: 576px) {
      body {
        padding: 10px 0;
      }

      .main-card {
        margin: 0 10px;
        border-radius: 16px;
      }
    }

    /* Custom scrollbar */
    .table-responsive::-webkit-scrollbar {
      height: 8px;
    }

    .table-responsive::-webkit-scrollbar-track {
      background: var(--light-color);
    }

    .table-responsive::-webkit-scrollbar-thumb {
      background: var(--border-color);
      border-radius: 4px;
    }

    .table-responsive::-webkit-scrollbar-thumb:hover {
      background: var(--text-muted);
    }
  </style>
<div class="container-fluid">
  <div class="main-card">
    <!-- Header -->
    <div class="page-header">
      <h1 class="page-title">
        <i class="bi bi-book-fill"></i>
        Quản lý sách
      </h1>
    </div>

    <!-- Search Section -->
    <div class="search-section">
      <%
        CategoryDao categoryDao = new CategoryDao();
        List<Category> categories = categoryDao.findAll();
        String selectedCategory = request.getParameter("category");
      %>

      <form method="get" action="manage-books" class="search-form">
        <div class="row g-3">
          <div class="col-md-3">
            <label class="form-label fw-medium">Tên sách</label>
            <input type="text"
                   class="form-control"
                   name="title"
                   placeholder="Nhập tên sách..."
                   value="<%= request.getParameter("title") != null ? request.getParameter("title") : "" %>">
          </div>
          <div class="col-md-3">
            <label class="form-label fw-medium">Tác giả</label>
            <input type="text"
                   class="form-control"
                   name="author"
                   placeholder="Nhập tên tác giả..."
                   value="<%= request.getParameter("author") != null ? request.getParameter("author") : "" %>">
          </div>
          <div class="col-md-2">
            <label class="form-label fw-medium">Giá từ</label>
            <input type="number"
                   step="0.01"
                   class="form-control"
                   name="minPrice"
                   placeholder="0"
                   value="<%= request.getParameter("minPrice") != null ? request.getParameter("minPrice") : "" %>">
          </div>
          <div class="col-md-2">
            <label class="form-label fw-medium">Đến</label>
            <input type="number"
                   step="0.01"
                   class="form-control"
                   name="maxPrice"
                   placeholder="999999"
                   value="<%= request.getParameter("maxPrice") != null ? request.getParameter("maxPrice") : "" %>">
          </div>
          <div class="col-md-2">
            <label class="form-label fw-medium">Thể loại</label>
            <select name="category" class="form-select">
              <option value="">Tất cả thể loại</option>
              <% for (Category c : categories) { %>
              <option value="<%= c.getName() %>" <%= (c.getName().equals(selectedCategory)) ? "selected" : "" %>>
                <%= c.getName() %>
              </option>
              <% } %>
            </select>
          </div>
        </div>

        <div class="row mt-4">
          <div class="col-md-6">
            <button type="submit" class="btn btn-primary me-2">
              <i class="bi bi-search"></i>
              Tìm kiếm
            </button>
            <a href="manage-books" class="btn btn-outline-secondary">
              <i class="bi bi-arrow-clockwise"></i>
              Reset
            </a>
          </div>
          <div class="col-md-6 text-md-end">
            <a href="book-create" class="btn btn-success">
              <i class="bi bi-plus-circle"></i>
              Thêm sách mới
            </a>
          </div>
        </div>
      </form>
    </div>

    <!-- Table Section -->
    <div class="table-section">
      <!-- Process Data -->
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

      <!-- Stats -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon books">
            <i class="bi bi-book"></i>
          </div>
          <div class="stat-content">
            <h3 class="text-center"><%= list.size() %></h3>
            <p>Sách tìm thấy</p>
          </div>
        </div>
      </div>

      <!-- Results Table -->
      <div class="table-responsive">
        <table class="text-center table">
          <thead>
          <tr>
            <th>STT</th>
            <th>Ảnh</th>
            <th>Thông tin sách</th>
            <th>Giá</th>
            <th>Kho</th>
            <th>Đã bán</th>
            <th>Thể loại</th>
            <th>Ngày tạo</th>
            <th>Hành động</th>
          </tr>
          </thead>
          <tbody>
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
            <td>
              <img src="<%= b.getImage() %>"
                   alt="<%= b.getTitle() %>"
                   class="book-image">
            </td>
            <td>
              <div class="text-start book-title" title="<%= b.getTitle() %>">
                <%= b.getTitle() %>
              </div>
              <div class="text-start book-author">
                <i class="bi bi-person"></i>
                <%= b.getAuthor() %>
              </div>
              <div class="text-start book-description mt-1" title="<%= b.getDescription() %>">
                <%= b.getDescription() %>
              </div>
            </td>
            <td>
                                    <span class="book-price">
                                        <%= String.format("%,.0f", b.getPrice()) %>đ
                                    </span>
            </td>
            <td>
                                    <span class="stock-badge <%= b.getStock() > 20 ? "stock-high" : (b.getStock() > 5 ? "stock-medium" : "stock-low") %>">
                                        <%= b.getStock() %>
                                    </span>
            </td>
            <td>
              <i class="bi bi-graph-up text-success"></i>
              <%= b.getSold() %>
            </td>
            <td>
                                    <span class="badge bg-success">
                                        <%= categoryMap.getOrDefault(b.getCategoryId(), "Không rõ") %>
                                    </span>
            </td>
            <td>
              <small class="text-muted">
                <%= b.getCreatedAt() %>
              </small>
            </td>
            <td>
              <div class="action-buttons">
                <a href="/book-edit?id=<%= b.getId() %>"
                   class="btn btn-warning btn-sm"
                   title="Chỉnh sửa">
                  <i class="bi bi-pencil-square"></i>
                </a>
                <a href="/book-delete?id=<%= b.getId() %>"
                   class="btn btn-danger btn-sm"
                   title="Xóa"
                   onclick="return confirm('Bạn có chắc chắn muốn xóa sách này không?')">
                  <i class="bi bi-trash"></i>
                </a>
              </div>
            </td>
          </tr>
          <%
            }
            if (list.isEmpty()) {
          %>
          <tr>
            <td colspan="9" class="empty-state">
              <i class="bi bi-search"></i>
              <h5>Không tìm thấy sách nào</h5>
              <p>Hãy thử thay đổi điều kiện tìm kiếm của bạn</p>
            </td>
          </tr>
          <%
            }
          %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Add smooth animations
  document.addEventListener('DOMContentLoaded', function() {
    // Animate cards on scroll
    const cards = document.querySelectorAll('.stat-card, .search-form');
    cards.forEach((card, index) => {
      card.style.opacity = '0';
      card.style.transform = 'translateY(20px)';
      setTimeout(() => {
        card.style.transition = 'all 0.6s ease';
        card.style.opacity = '1';
        card.style.transform = 'translateY(0)';
      }, index * 100);
    });

    // Animate table rows
    const rows = document.querySelectorAll('tbody tr');
    rows.forEach((row, index) => {
      row.style.opacity = '0';
      row.style.transform = 'translateX(-20px)';
      setTimeout(() => {
        row.style.transition = 'all 0.4s ease';
        row.style.opacity = '1';
        row.style.transform = 'translateX(0)';
      }, index * 50);
    });
  });

  // Add loading state to search button
  document.querySelector('form').addEventListener('submit', function() {
    const btn = this.querySelector('button[type="submit"]');
    btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Đang tìm...';
    btn.disabled = true;
  });
</script>
<%@ include file="../footer.jsp" %>
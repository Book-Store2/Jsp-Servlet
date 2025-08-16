<%@ page import="org.example.bookstorecode.model.Category" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ include file="../include-header.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            overflow: hidden;
        }

        .page-header {
            background: linear-gradient(135deg, #8b5cf6, #7c3aed);
            color: white;
            padding: 2rem;
        }

        .add-form {
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            padding: 1.5rem;
        }

        .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #8b5cf6;
            box-shadow: 0 0 0 4px rgba(139, 92, 246, 0.1);
        }

        .btn {
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #8b5cf6, #7c3aed);
            border: none;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(139, 92, 246, 0.3);
        }

        .btn-sm {
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
        }

        .btn-warning {
            background: #f59e0b;
            border: none;
            color: white;
        }

        .btn-warning:hover {
            background: #d97706;
            color: white;
        }

        .btn-danger {
            background: #ef4444;
            border: none;
        }

        .btn-danger:hover {
            background: #dc2626;
        }

        .table-container {
            padding: 1.5rem;
        }

        .table {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border: 1px solid #e2e8f0;
        }

        .table th {
            background: #1f2937;
            color: white;
            font-weight: 600;
            border: none;
            padding: 1rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
        }

        .table tbody tr:hover {
            background: rgba(139, 92, 246, 0.05);
        }

        .category-name {
            font-weight: 600;
            color: #1f2937;
        }

        .stats-card {
            background: white;
            border-radius: 12px;
            padding: 1rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border: 1px solid #e2e8f0;
            text-align: center;
        }

        .stats-number {
            font-size: 2rem;
            font-weight: 700;
            color: #8b5cf6;
        }

        .stats-label {
            color: #6b7280;
            font-size: 0.9rem;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6b7280;
        }

        .empty-state i {
            font-size: 4rem;
            color: #d1d5db;
            margin-bottom: 1rem;
        }

        @media (max-width: 768px) {
            .page-header {
                padding: 1.5rem;
            }

            .add-form {
                padding: 1rem;
            }

            .table-container {
                padding: 1rem;
            }

            .table-responsive {
                font-size: 0.9rem;
            }

            .btn-group {
                flex-direction: column;
                gap: 0.25rem;
            }
        }
    </style>
</head>
<body>
<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    String error = (String) request.getAttribute("error");
    String success = request.getParameter("success");
%>

<div class="container mt-4 mb-4">
    <div class="main-card">
        <!-- Header -->
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="mb-0">
                        <i class="bi bi-tags-fill me-2"></i>
                        Quản lý danh mục
                    </h2>
                </div>
                <div class="col-md-4">
                    <div class="stats-card">
                        <div class="stats-number"><%= categories != null ? categories.size() : 0 %></div>
                        <div class="stats-label">Danh mục</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add Form -->
        <div class="add-form">
            <!-- Alerts -->
            <% if (success != null && success.equals("1")) { %>
            <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
                <i class="bi bi-check-circle me-2"></i>
                Thao tác thành công!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <% if (error != null) { %>
            <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
                <i class="bi bi-exclamation-triangle me-2"></i>
                <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <form method="post" action="category-create" id="addForm">
                <div class="row g-3 align-items-end">
                    <div class="col-md-8">
                        <label for="categoryName" class="form-label fw-semibold">
                            <i class="bi bi-plus-circle me-1"></i>
                            Thêm danh mục mới
                        </label>
                        <input type="text"
                               class="form-control"
                               id="categoryName"
                               name="name"
                               placeholder="Nhập tên danh mục..."
                               required
                               maxlength="100">
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="bi bi-plus-lg me-1"></i>
                            Thêm mới
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Table -->
        <div class="table-container">
            <% if (categories != null && !categories.isEmpty()) { %>
            <div class="table-responsive">
                <table class="text-center table mb-0">
                    <thead>
                    <tr>
                        <th style="width: 80px;">Số thứ tự</th>
                        <th>Tên danh mục</th>
                        <th style="width: 200px;">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        int stt = 1;
                        for (Category c : categories) {
                    %>
                    <tr>
                        <td>
                            <span class="badge bg-secondary"><%= stt++ %></span>
                        </td>
                        <td>
                            <div class="category-name"><%= c.getName() %></div>
<%--                            <small type="hidden" class="text-muted">ID: <%= c.getId() %></small>--%>
                        </td>
                        <td>
                            <div class="btn-group" role="group">
                                <a href="category-edit?id=<%= c.getId() %>"
                                   class="btn btn-warning btn-sm"
                                   title="Chỉnh sửa">
                                    <i class="bi bi-pencil-square"></i>
                                    <span class="d-none d-md-inline"> Sửa</span>
                                </a>
                                <button type="button"
                                        class="btn btn-danger btn-sm"
                                        onclick="deleteCategory(<%= c.getId() %>, '<%= c.getName() %>')"
                                        title="Xóa">
                                    <i class="bi bi-trash"></i>
                                    <span class="d-none d-md-inline"> Xóa</span>
                                </button>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="empty-state">
                <i class="bi bi-folder-x"></i>
                <h5>Chưa có danh mục nào</h5>
                <p>Hãy thêm danh mục đầu tiên bằng form ở trên</p>
            </div>
            <% } %>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    Xác nhận xóa
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa danh mục <strong id="categoryToDelete"></strong> không?</p>
                <div class="alert alert-warning">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    <strong>Cảnh báo:</strong> Hành động này không thể hoàn tác!
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-danger" id="confirmDelete">
                    <i class="bi bi-trash me-1"></i>
                    Xác nhận xóa
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let deleteId = null;

    // Delete category function
    function deleteCategory(id, name) {
        deleteId = id;
        document.getElementById('categoryToDelete').textContent = name;
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }

    // Confirm delete
    document.getElementById('confirmDelete').addEventListener('click', function() {
        if (deleteId) {
            window.location.href = 'category-delete?id=' + deleteId;
        }
    });

    // Form validation
    document.getElementById('addForm').addEventListener('submit', function(e) {
        const name = document.getElementById('categoryName').value.trim();

        if (name.length < 2) {
            e.preventDefault();
            alert('Tên danh mục phải có ít nhất 2 ký tự!');
            document.getElementById('categoryName').focus();
            return;
        }

        // Check for duplicates
        const existingNames = [
            <% if (categories != null) {
                for (Category c : categories) { %>
            '<%= c.getName().replace("'", "\\'") %>',
            <% }
        } %>
        ];

        if (existingNames.includes(name)) {
            e.preventDefault();
            alert('Tên danh mục đã tồn tại!');
            document.getElementById('categoryName').focus();
            return;
        }
    });

    // Auto-clear form after successful submission
    <% if (success != null && success.equals("1")) { %>
    document.getElementById('categoryName').value = '';
    <% } %>

    // Character counter
    const nameInput = document.getElementById('categoryName');
    nameInput.addEventListener('input', function() {
        if (this.value.length > 80) {
            this.style.borderColor = '#f59e0b';
        } else if (this.value.length > 95) {
            this.style.borderColor = '#ef4444';
        } else {
            this.style.borderColor = '#e2e8f0';
        }
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl+N to focus on add input
        if (e.ctrlKey && e.key === 'n') {
            e.preventDefault();
            document.getElementById('categoryName').focus();
        }
    });

    // Auto-focus on page load
    document.getElementById('categoryName').focus();

    // Smooth animations
    document.addEventListener('DOMContentLoaded', function() {
        const rows = document.querySelectorAll('tbody tr');
        rows.forEach((row, index) => {
            row.style.opacity = '0';
            row.style.transform = 'translateY(20px)';
            setTimeout(() => {
                row.style.transition = 'all 0.4s ease';
                row.style.opacity = '1';
                row.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });
</script>
<%@ include file="../footer.jsp" %>
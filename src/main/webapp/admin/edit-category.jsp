<%@ page import="org.example.bookstorecode.model.Category" %>
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

        .form-card {
            margin-bottom: 30px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px 20px 0 0;
            padding: 1.5rem;
        }

        .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #06b6d4;
            box-shadow: 0 0 0 4px rgba(6, 182, 212, 0.1);
        }

        .btn {
            border-radius: 12px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: green;
            border: none;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(6, 182, 212, 0.3);
        }

        .btn-secondary {
            background: blueviolet;
            border: none;
        }

        .btn-secondary:hover {
            background: darkviolet;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<%
    Category cat = (Category) request.getAttribute("category");
    String error = (String) request.getAttribute("error");
    String success = request.getParameter("success");
%>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="form-card">
                <!-- Header -->
                <div class="form-header">
                    <h3 class="mb-0">
                        <i class="bi bi-pencil-square me-2"></i>
                        Sửa danh mục
                    </h3>
                </div>

                <!-- Form -->
                <div class="p-4">
                    <!-- Alerts -->
                    <% if (success != null && success.equals("1")) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle me-2"></i>
                        Cập nhật danh mục thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

                    <% if (error != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i>
                        <%= error %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

                    <form method="post" action="/category-update" id="categoryForm">
                        <input type="hidden" name="id" value="<%= cat.getId() %>">

                        <!-- Category Name -->
                        <div class="mb-4">
                            <label for="categoryName" class="form-label fw-semibold">
                                <i class="bi bi-tag me-1"></i>
                                Tên danh mục
                            </label>
                            <input type="text"
                                   class="form-control"
                                   id="categoryName"
                                   name="name"
                                   value="<%= cat.getName() %>"
                                   placeholder="Nhập tên danh mục..."
                                   required
                                   maxlength="100">
                            <div class="form-text">
                                <span id="charCount"><%= cat.getName().length() %></span>/100 ký tự
                            </div>
                        </div>

                        <!-- Buttons -->
                        <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-check-lg me-1"></i>
                                Cập nhật
                            </button>
                            <a href="/manage-categories" class="btn btn-primary">
                                <i class="bi bi-arrow-left me-1"></i>
                                Quay lại
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Character counter
    const input = document.getElementById('categoryName');
    const charCount = document.getElementById('charCount');

    input.addEventListener('input', function() {
        charCount.textContent = this.value.length;

        // Visual feedback for character limit
        const parent = this.parentElement;
        const formText = parent.querySelector('.form-text');

        if (this.value.length > 80) {
            formText.className = 'form-text text-warning';
        } else if (this.value.length > 95) {
            formText.className = 'form-text text-danger';
        } else {
            formText.className = 'form-text text-muted';
        }
    });

    // Form validation
    document.getElementById('categoryForm').addEventListener('submit', function(e) {
        const name = input.value.trim();

        if (name.length < 2) {
            e.preventDefault();
            alert('Tên danh mục phải có ít nhất 2 ký tự!');
            input.focus();
        }
    });

    // Auto focus
    input.focus();

    // Keyboard shortcut Ctrl+S
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey && e.key === 's') {
            e.preventDefault();
            document.getElementById('categoryForm').submit();
        }
    });
</script>
<%@ include file="../footer.jsp" %>
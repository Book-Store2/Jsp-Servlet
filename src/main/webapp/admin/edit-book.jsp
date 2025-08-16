<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.bookstorecode.model.Book" %>
<%@ page import="org.example.bookstorecode.model.Category" %>
<%@ page import="java.util.List" %>

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

        .container {
            max-width: 900px;
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            margin: -1px -1px 0 -1px;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="40" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/><circle cx="20" cy="20" r="15" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/><circle cx="80" cy="80" r="20" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/></svg>');
            z-index: 0;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            position: relative;
            z-index: 1;
        }

        .book-id-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            margin-left: auto;
        }

        .form-section {
            padding: 2rem;
        }

        .form-container {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid var(--border-color);
        }

        .form-label {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-control, .form-select, .form-control-file {
            border: 2px solid var(--border-color);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: white;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--warning-color);
            box-shadow: 0 0 0 4px rgba(245, 158, 11, 0.1);
            outline: none;
        }

        .textarea-container {
            position: relative;
        }

        .form-control.textarea {
            min-height: 120px;
            resize: vertical;
        }

        .current-image-section {
            background: var(--light-color);
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
            margin-bottom: 1rem;
            border: 1px solid var(--border-color);
        }

        .current-image {
            max-width: 200px;
            max-height: 250px;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
            margin-bottom: 1rem;
        }

        .image-upload-container {
            border: 2px dashed var(--border-color);
            border-radius: 12px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            background: var(--light-color);
            cursor: pointer;
        }

        .image-upload-container:hover {
            border-color: var(--warning-color);
            background: rgba(245, 158, 11, 0.05);
        }

        .image-upload-container.dragover {
            border-color: var(--warning-color);
            background: rgba(245, 158, 11, 0.1);
        }

        .upload-icon {
            font-size: 3rem;
            color: var(--text-muted);
            margin-bottom: 1rem;
        }

        .image-preview {
            max-width: 100%;
            max-height: 300px;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            margin-top: 1rem;
        }

        .btn {
            border-radius: 12px;
            font-weight: 500;
            padding: 0.75rem 2rem;
            transition: all 0.3s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--warning-color), #d97706);
            color: white;
            font-size: 1.1rem;
            padding: 1rem 2rem;
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(245, 158, 11, 0.3);
            background: linear-gradient(135deg, #d97706, #b45309);
            color: white;
        }

        .btn-secondary {
            background: blueviolet;
            color: white;
        }

        .btn-secondary:hover {
            background: var(--dark-color);
            transform: translateY(-2px);
            color: white;
        }

        .btn-outline-danger {
            border: 2px solid var(--danger-color);
            color: var(--danger-color);
            background: transparent;
        }

        .btn-outline-danger:hover {
            background: var(--danger-color);
            border-color: var(--danger-color);
            color: white;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .status-options {
            display: flex;
            gap: 1rem;
            margin-top: 0.5rem;
        }

        .status-option {
            flex: 1;
            position: relative;
        }

        .status-radio {
            display: none;
        }

        .status-label {
            display: block;
            padding: 1rem;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background: white;
        }

        .status-radio:checked + .status-label {
            border-color: var(--warning-color);
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .status-label:hover {
            border-color: var(--warning-color);
        }

        .required-indicator {
            color: var(--danger-color);
            font-weight: 700;
        }

        .change-indicator {
            background: rgba(245, 158, 11, 0.1);
            border-left: 4px solid var(--warning-color);
            padding: 0.5rem 1rem;
            border-radius: 0 8px 8px 0;
            margin-bottom: 1rem;
            font-size: 0.9rem;
            color: var(--warning-color);
        }

        /* Modal Styles */
        .modal-content {
            border-radius: 16px;
            border: none;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
        }

        .modal-header {
            border-bottom: 1px solid var(--border-color);
            border-radius: 16px 16px 0 0;
            padding: 1.5rem;
        }

        .modal-header.success {
            background: linear-gradient(135deg, var(--success-color), #059669);
            color: white;
        }

        .modal-header.error {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
            color: white;
        }

        .modal-header.warning {
            background: linear-gradient(135deg, var(--warning-color), #d97706);
            color: white;
        }

        .modal-title {
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .modal-body {
            padding: 1.5rem;
            font-size: 1.1rem;
        }

        .modal-footer {
            border-top: 1px solid var(--border-color);
            padding: 1rem 1.5rem;
        }

        .btn-close {
            filter: invert(1) grayscale(100%) brightness(200%);
        }

        /* Loading Animation */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 5px solid rgba(255, 255, 255, 0.3);
            border-top: 5px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Form Validation */
        .form-control.is-invalid, .form-select.is-invalid {
            border-color: var(--danger-color);
            box-shadow: 0 0 0 4px rgba(239, 68, 68, 0.1);
        }

        .form-control.is-valid, .form-select.is-valid {
            border-color: var(--success-color);
            box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.1);
        }

        .invalid-feedback {
            display: block;
            color: var(--danger-color);
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        .valid-feedback {
            display: block;
            color: var(--success-color);
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-header {
                padding: 1.5rem;
            }

            .page-title {
                font-size: 1.5rem;
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .book-id-badge {
                margin-left: 0;
                align-self: flex-start;
            }

            .form-section {
                padding: 1rem;
            }

            .form-container {
                padding: 1.5rem;
            }

            .button-group {
                flex-direction: column;
            }

            .status-options {
                flex-direction: column;
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

            .current-image-section {
                padding: 1rem;
            }

            .image-upload-container {
                padding: 1rem;
            }
        }

        /* Animation Classes */
        .fade-in {
            animation: fadeIn 0.6s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-group {
            margin-bottom: 1.5rem;
            opacity: 0;
            animation: slideInUp 0.6s ease-out forwards;
        }

        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .form-group:nth-child(4) { animation-delay: 0.4s; }
        .form-group:nth-child(5) { animation-delay: 0.5s; }
        .form-group:nth-child(6) { animation-delay: 0.6s; }
        .form-group:nth-child(7) { animation-delay: 0.7s; }
        .form-group:nth-child(8) { animation-delay: 0.8s; }
        .form-group:nth-child(9) { animation-delay: 0.9s; }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Image comparison */
        .image-comparison {
            display: flex;
            gap: 2rem;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
        }

        .image-item {
            text-align: center;
            flex: 1;
            min-width: 200px;
        }

        .image-item h6 {
            color: var(--text-muted);
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .vs-divider {
            font-size: 2rem;
            color: var(--warning-color);
            font-weight: 700;
        }

        @media (max-width: 576px) {
            .image-comparison {
                flex-direction: column;
                gap: 1rem;
            }

            .vs-divider {
                transform: rotate(90deg);
            }
        }
    </style>
</head>
<body>
<%
    Book book = (Book) request.getAttribute("book");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    String error = (String) request.getAttribute("error");
    String success = request.getParameter("success");
%>

<div class="container">
    <div class="main-card fade-in">
        <!-- Header -->
        <div class="page-header">
            <h1 class="page-title">
                <i class="bi bi-pencil-square"></i>
                Chỉnh sửa sách
                <span class="book-id-badge">ID: <%= book.getId() %></span>
            </h1>
        </div>

        <!-- Change Indicator -->
        <div class="change-indicator">
            <i class="bi bi-info-circle"></i>
            Bạn đang chỉnh sửa thông tin sách. Những thay đổi sẽ có hiệu lực ngay lập tức.
        </div>

        <!-- Form Section -->
        <div class="form-section">
            <div class="form-container">
                <form action="book-update" method="post" enctype="multipart/form-data" id="bookUpdateForm">
                    <input type="hidden" name="id" value="<%= book.getId() %>">
                    <input type="hidden" name="oldImage" value="<%= book.getImage() %>">

                    <!-- Title -->
                    <div class="form-group">
                        <label for="title" class="form-label">
                            <i class="bi bi-book"></i>
                            Tiêu đề <span class="required-indicator">*</span>
                        </label>
                        <input type="text"
                               class="form-control"
                               id="title"
                               name="title"
                               value="<%= book.getTitle() %>"
                               placeholder="Nhập tiêu đề sách..."
                               required>
                    </div>

                    <!-- Author -->
                    <div class="form-group">
                        <label for="author" class="form-label">
                            <i class="bi bi-person-fill"></i>
                            Tác giả <span class="required-indicator">*</span>
                        </label>
                        <input type="text"
                               class="form-control"
                               id="author"
                               name="author"
                               value="<%= book.getAuthor() %>"
                               placeholder="Nhập tên tác giả..."
                               required>
                    </div>

                    <!-- Price -->
                    <div class="form-group">
                        <label for="price" class="form-label">
                            <i class="bi bi-currency-dollar"></i>
                            Giá <span class="required-indicator">*</span>
                        </label>
                        <input type="number"
                               step="0.01"
                               class="form-control"
                               id="price"
                               name="price"
                               value="<%= book.getPrice() %>"
                               placeholder="0.00"
                               min="0"
                               required>
                    </div>

                    <!-- Image Upload -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="bi bi-image-fill"></i>
                            Ảnh sách
                        </label>

                        <!-- Current Image -->
                        <div class="current-image-section">
                            <h6><i class="bi bi-image"></i> Ảnh hiện tại</h6>
                            <img src="<%= book.getImage() %>"
                                 alt="<%= book.getTitle() %>"
                                 class="current-image"
                                 id="currentImage">
                        </div>

                        <!-- Upload New Image -->
                        <div class="image-upload-container" id="imageUploadContainer">
                            <div class="upload-icon">
                                <i class="bi bi-cloud-upload"></i>
                            </div>
                            <h5>Tải ảnh mới lên (tùy chọn)</h5>
                            <p class="text-muted">Kéo thả ảnh vào đây hoặc click để chọn</p>
                            <p class="text-muted small">Hỗ trợ: JPG, PNG, GIF (Tối đa 5MB)</p>
                            <input type="file"
                                   name="image"
                                   id="imageInput"
                                   accept="image/*"
                                   style="display: none;">
                            <button type="button" class="btn btn-secondary btn-sm" onclick="document.getElementById('imageInput').click()">
                                <i class="bi bi-folder-open"></i>
                                Chọn ảnh mới
                            </button>
                        </div>

                        <!-- New Image Preview -->
                        <div id="imageComparisonContainer" style="display: none;">
                            <div class="image-comparison">
                                <div class="image-item">
                                    <h6>Ảnh hiện tại</h6>
                                    <img src="<%= book.getImage() %>"
                                         alt="Current"
                                         class="image-preview"
                                         style="max-width: 200px;">
                                </div>
                                <div class="vs-divider">→</div>
                                <div class="image-item">
                                    <h6>Ảnh mới</h6>
                                    <img id="imagePreview"
                                         class="image-preview"
                                         style="display: none; max-width: 200px;"
                                         alt="New image preview">
                                </div>
                            </div>
                            <div class="text-center mt-3">
                                <button type="button" class="btn btn-outline-danger btn-sm" onclick="resetImageUpload()">
                                    <i class="bi bi-x-circle"></i>
                                    Hủy thay đổi ảnh
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label for="description" class="form-label">
                            <i class="bi bi-text-paragraph"></i>
                            Mô tả <span class="required-indicator">*</span>
                        </label>
                        <div class="textarea-container">
                                <textarea class="form-control textarea"
                                          id="description"
                                          name="description"
                                          placeholder="Nhập mô tả về cuốn sách..."
                                          required><%= book.getDescription() %></textarea>
                        </div>
                    </div>

                    <!-- Stock and Sold -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="stock" class="form-label">
                                    <i class="bi bi-box-seam"></i>
                                    Số lượng tồn kho <span class="required-indicator">*</span>
                                </label>
                                <input type="number"
                                       class="form-control"
                                       id="stock"
                                       name="stock"
                                       value="<%= book.getStock() %>"
                                       placeholder="0"
                                       min="0"
                                       required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="sold" class="form-label">
                                    <i class="bi bi-graph-up"></i>
                                    Đã bán <span class="required-indicator">*</span>
                                </label>
                                <input type="number"
                                       class="form-control"
                                       id="sold"
                                       name="sold"
                                       value="<%= book.getSold() %>"
                                       min="0"
                                       required>
                            </div>
                        </div>
                    </div>

                    <!-- Category -->
                    <div class="form-group">
                        <label for="categoryId" class="form-label">
                            <i class="bi bi-tags-fill"></i>
                            Thể loại <span class="required-indicator">*</span>
                        </label>
                        <select class="form-select" id="categoryId" name="categoryId" required>
                            <% for (Category c : categories) { %>
                            <option value="<%= c.getId() %>" <%= c.getId() == book.getCategoryId() ? "selected" : "" %>>
                                <%= c.getName() %>
                            </option>
                            <% } %>
                        </select>
                    </div>

                    <!-- Status -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="bi bi-toggle-on"></i>
                            Trạng thái <span class="required-indicator">*</span>
                        </label>
                        <div class="status-options">
                            <div class="status-option">
                                <input type="radio"
                                       class="status-radio"
                                       id="statusActive"
                                       name="status"
                                       value="ACTIVE"
                                    <%= book.getStatus().name().equals("ACTIVE") ? "checked" : "" %>>
                                <label for="statusActive" class="status-label">
                                    <i class="bi bi-eye-fill"></i><br>
                                    <strong>Hiển thị</strong><br>
                                    <small>Sách sẽ hiện trên website</small>
                                </label>
                            </div>
                            <div class="status-option">
                                <input type="radio"
                                       class="status-radio"
                                       id="statusInactive"
                                       name="status"
                                       value="INACTIVE"
                                    <%= book.getStatus().name().equals("INACTIVE") ? "checked" : "" %>>
                                <label for="statusInactive" class="status-label">
                                    <i class="bi bi-eye-slash-fill"></i><br>
                                    <strong>Ẩn</strong><br>
                                    <small>Sách sẽ bị ẩn khỏi website</small>
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- Buttons -->
                    <div class="button-group">
                        <button type="submit" class="btn btn-warning" id="submitBtn">
                            <i class="bi bi-check-circle"></i>
                            Cập nhật sách
                        </button>
                        <a href="manage-books" class="btn btn-secondary">
                            <i class="bi bi-arrow-left"></i>
                            Quay lại danh sách
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Success Modal -->
<div class="modal fade" id="successModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header success">
                <h5 class="modal-title">
                    <i class="bi bi-check-circle-fill"></i>
                    Cập nhật thành công!
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p class="mb-0">Thông tin sách đã được cập nhật thành công!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" onclick="window.location.href='manage-books'">
                    <i class="bi bi-list"></i>
                    Xem danh sách sách
                </button>
                <button type="button" class="btn btn-warning" data-bs-dismiss="modal">
                    <i class="bi bi-pencil"></i>
                    Tiếp tục chỉnh sửa
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Error Modal -->
<div class="modal fade" id="errorModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header error">
                <h5 class="modal-title">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    Lỗi cập nhật!
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p id="errorMessage" class="mb-0">Đã xảy ra lỗi khi cập nhật sách.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle"></i>
                    Đóng
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Confirmation Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header warning">
                <h5 class="modal-title">
                    <i class="bi bi-question-circle-fill"></i>
                    Xác nhận cập nhật
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p class="mb-3">Bạn có chắc chắn muốn cập nhật thông tin sách này không?</p>
                <div id="changesPreview" class="alert alert-warning">
                    <h6><i class="bi bi-info-circle"></i> Những thay đổi sẽ được áp dụng:</h6>
                    <ul id="changesList" class="mb-0"></ul>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning" id="confirmUpdateBtn">
                    <i class="bi bi-check-circle"></i>
                    Xác nhận cập nhật
                </button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle"></i>
                    Hủy
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Loading Overlay -->
<div id="loadingOverlay" class="loading-overlay" style="display: none;">
    <div class="loading-spinner"></div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Original values for comparison
    const originalValues = {
        title: '<%= book.getTitle() %>',
        author: '<%= book.getAuthor() %>',
        price: '<%= book.getPrice() %>',
        description: '<%= book.getDescription() %>',
        stock: '<%= book.getStock() %>',
        sold: '<%= book.getSold() %>',
        categoryId: '<%= book.getCategoryId() %>',
        status: '<%= book.getStatus().name() %>',
        image: '<%= book.getImage() %>'
    };

    // Show modals based on server response
    document.addEventListener('DOMContentLoaded', function() {
        <% if (success != null && success.equals("1")) { %>
        new bootstrap.Modal(document.getElementById('successModal')).show();
        <% } %>

        <% if (error != null) { %>
        document.getElementById('errorMessage').textContent = '<%= error %>';
        new bootstrap.Modal(document.getElementById('errorModal')).show();
        <% } %>

        // Auto-resize textarea
        const textarea = document.getElementById('description');
        function resizeTextarea() {
            textarea.style.height = 'auto';
            textarea.style.height = textarea.scrollHeight + 'px';
        }
        resizeTextarea();
        textarea.addEventListener('input', resizeTextarea);
    });

    // Image upload functionality
    const imageInput = document.getElementById('imageInput');
    const imagePreview = document.getElementById('imagePreview');
    const uploadContainer = document.getElementById('imageUploadContainer');
    const comparisonContainer = document.getElementById('imageComparisonContainer');
    const currentImageSection = document.querySelector('.current-image-section');

    // File input change handler
    imageInput.addEventListener('change', function(e) {
        if (e.target.files.length > 0) {
            previewImage(e.target.files[0]);
        }
    });

    // Drag and drop functionality
    uploadContainer.addEventListener('click', function() {
        imageInput.click();
    });

    uploadContainer.addEventListener('dragover', function(e) {
        e.preventDefault();
        uploadContainer.classList.add('dragover');
    });

    uploadContainer.addEventListener('dragleave', function(e) {
        e.preventDefault();
        uploadContainer.classList.remove('dragover');
    });

    uploadContainer.addEventListener('drop', function(e) {
        e.preventDefault();
        uploadContainer.classList.remove('dragover');

        const files = e.dataTransfer.files;
        if (files.length > 0) {
            const file = files[0];
            if (file.type.startsWith('image/')) {
                imageInput.files = files;
                previewImage(file);
            }
        }
    });

    // Preview image function
    function previewImage(file) {
        if (file && file.type.startsWith('image/')) {
            // Check file size (5MB limit)
            if (file.size > 5 * 1024 * 1024) {
                alert('Kích thước ảnh không được vượt quá 5MB!');
                imageInput.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                imagePreview.src = e.target.result;
                imagePreview.style.display = 'block';

                // Show comparison
                currentImageSection.style.display = 'none';
                uploadContainer.style.display = 'none';
                comparisonContainer.style.display = 'block';
            };
            reader.readAsDataURL(file);
        }
    }

    // Reset image upload
    function resetImageUpload() {
        imageInput.value = '';
        imagePreview.style.display = 'none';
        currentImageSection.style.display = 'block';
        uploadContainer.style.display = 'block';
        comparisonContainer.style.display = 'none';
    }

    // Form validation and change detection
    function validateForm() {
        const title = document.getElementById('title').value.trim();
        const author = document.getElementById('author').value.trim();
        const price = document.getElementById('price').value;
        const description = document.getElementById('description').value.trim();
        const stock = document.getElementById('stock').value;
        const categoryId = document.getElementById('categoryId').value;

        // Clear previous validation
        document.querySelectorAll('.form-control, .form-select').forEach(el => {
            el.classList.remove('is-invalid', 'is-valid');
        });
        document.querySelectorAll('.invalid-feedback').forEach(el => el.remove());

        let isValid = true;

        if (!title) {
            markInvalid('title', 'Vui lòng nhập tiêu đề sách!');
            isValid = false;
        } else {
            markValid('title');
        }

        if (!author) {
            markInvalid('author', 'Vui lòng nhập tên tác giả!');
            isValid = false;
        } else {
            markValid('author');
        }

        if (!price || price <= 0) {
            markInvalid('price', 'Vui lòng nhập giá hợp lệ!');
            isValid = false;
        } else {
            markValid('price');
        }

        if (!description) {
            markInvalid('description', 'Vui lòng nhập mô tả sách!');
            isValid = false;
        } else {
            markValid('description');
        }

        if (!stock || stock < 0) {
            markInvalid('stock', 'Vui lòng nhập số lượng tồn kho hợp lệ!');
            isValid = false;
        } else {
            markValid('stock');
        }

        if (!categoryId) {
            markInvalid('categoryId', 'Vui lòng chọn thể loại!');
            isValid = false;
        } else {
            markValid('categoryId');
        }

        return isValid;
    }

    function markInvalid(fieldId, message) {
        const field = document.getElementById(fieldId);
        field.classList.add('is-invalid');

        const feedback = document.createElement('div');
        feedback.className = 'invalid-feedback';
        feedback.textContent = message;
        field.parentNode.appendChild(feedback);
    }

    function markValid(fieldId) {
        const field = document.getElementById(fieldId);
        field.classList.add('is-valid');
    }

    // Detect changes
    function getChanges() {
        const currentValues = {
            title: document.getElementById('title').value.trim(),
            author: document.getElementById('author').value.trim(),
            price: document.getElementById('price').value,
            description: document.getElementById('description').value.trim(),
            stock: document.getElementById('stock').value,
            sold: document.getElementById('sold').value,
            categoryId: document.getElementById('categoryId').value,
            status: document.querySelector('input[name="status"]:checked').value,
            image: imageInput.files.length > 0 ? 'changed' : originalValues.image
        };

        const changes = [];

        if (currentValues.title !== originalValues.title) {
            changes.push(`Tiêu đề: "${originalValues.title}" → "${currentValues.title}"`);
        }

        if (currentValues.author !== originalValues.author) {
            changes.push(`Tác giả: "${originalValues.author}" → "${currentValues.author}"`);
        }

        if (parseFloat(currentValues.price) !== parseFloat(originalValues.price)) {
            changes.push(`Giá: ${originalValues.price}đ → ${currentValues.price}đ`);
        }

        if (currentValues.description !== originalValues.description) {
            changes.push('Mô tả sách đã được thay đổi');
        }

        if (parseInt(currentValues.stock) !== parseInt(originalValues.stock)) {
            changes.push(`Tồn kho: ${originalValues.stock} → ${currentValues.stock}`);
        }

        if (parseInt(currentValues.sold) !== parseInt(originalValues.sold)) {
            changes.push(`Đã bán: ${originalValues.sold} → ${currentValues.sold}`);
        }

        if (currentValues.categoryId !== originalValues.categoryId) {
            const categorySelect = document.getElementById('categoryId');
            const newCategoryName = categorySelect.options[categorySelect.selectedIndex].text;
            changes.push(`Thể loại đã được thay đổi → ${newCategoryName}`);
        }

        if (currentValues.status !== originalValues.status) {
            const statusText = currentValues.status === 'ACTIVE' ? 'Hiển thị' : 'Ẩn';
            changes.push(`Trạng thái → ${statusText}`);
        }

        if (imageInput.files.length > 0) {
            changes.push('Ảnh sách đã được thay đổi');
        }

        return changes;
    }

    // Form submission with confirmation
    document.getElementById('bookUpdateForm').addEventListener('submit', function(e) {
        e.preventDefault();

        if (!validateForm()) {
            return;
        }

        const changes = getChanges();

        if (changes.length === 0) {
            alert('Không có thay đổi nào để cập nhật!');
            return;
        }

        // Show confirmation modal
        const changesList = document.getElementById('changesList');
        changesList.innerHTML = '';
        changes.forEach(change => {
            const li = document.createElement('li');
            li.textContent = change;
            changesList.appendChild(li);
        });

        const confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
        confirmModal.show();
    });

    // Confirm update button
    document.getElementById('confirmUpdateBtn').addEventListener('click', function() {
        const submitBtn = document.getElementById('submitBtn');
        const loadingOverlay = document.getElementById('loadingOverlay');

        // Show loading
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Đang cập nhật...';
        submitBtn.disabled = true;
        loadingOverlay.style.display = 'flex';

        // Hide confirmation modal
        bootstrap.Modal.getInstance(document.getElementById('confirmModal')).hide();

        // Submit form
        document.getElementById('bookUpdateForm').submit();
    });

    // Input validation on the fly
    document.getElementById('price').addEventListener('input', function(e) {
        if (e.target.value < 0) {
            e.target.value = 0;
        }
    });

    document.getElementById('stock').addEventListener('input', function(e) {
        if (e.target.value < 0) {
            e.target.value = 0;
        }
    });

    document.getElementById('sold').addEventListener('input', function(e) {
        if (e.target.value < 0) {
            e.target.value = 0;
        }
    });

    // Real-time change detection
    let changeTimeout;
    function detectChanges() {
        clearTimeout(changeTimeout);
        changeTimeout = setTimeout(() => {
            const changes = getChanges();
            const hasChanges = changes.length > 0;

            const submitBtn = document.getElementById('submitBtn');
            if (hasChanges) {
                submitBtn.innerHTML = '<i class="bi bi-exclamation-circle"></i> Cập nhật thay đổi (' + changes.length + ')';
                submitBtn.classList.add('btn-warning');
                submitBtn.classList.remove('btn-secondary');
            } else {
                submitBtn.innerHTML = '<i class="bi bi-check-circle"></i> Cập nhật sách';
                submitBtn.classList.remove('btn-warning');
                submitBtn.classList.add('btn-warning');
            }
        }, 300);
    }

    // Add change detection to all form inputs
    document.querySelectorAll('input, textarea, select').forEach(input => {
        input.addEventListener('input', detectChanges);
        input.addEventListener('change', detectChanges);
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl+S to save
        if (e.ctrlKey && e.key === 's') {
            e.preventDefault();
            document.getElementById('bookUpdateForm').dispatchEvent(new Event('submit'));
        }

        // Escape to cancel
        if (e.key === 'Escape') {
            window.location.href = 'manage-books';
        }
    });

    // Unsaved changes warning
    window.addEventListener('beforeunload', function(e) {
        const changes = getChanges();
        if (changes.length > 0) {
            e.preventDefault();
            e.returnValue = '';
            return 'Bạn có thay đổi chưa được lưu. Bạn có chắc muốn rời khỏi trang?';
        }
    });

    // Remove warning when form is submitted
    document.getElementById('bookUpdateForm').addEventListener('submit', function() {
        window.removeEventListener('beforeunload', arguments.callee);
    });
</script>
<%@ include file="../footer.jsp" %>
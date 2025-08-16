<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            padding: 20px 0;
            color: var(--text-color);
        }

        .container {
            max-width: 800px;
        }

        .main-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            overflow: hidden;
            margin-bottom: 2rem;
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
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            outline: none;
        }

        .form-control-file {
            padding: 0.5rem;
        }

        .textarea-container {
            position: relative;
        }

        .form-control.textarea {
            min-height: 120px;
            resize: vertical;
        }

        .image-upload-container {
            border: 2px dashed var(--border-color);
            border-radius: 12px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            background: var(--light-color);
        }

        .image-upload-container:hover {
            border-color: var(--primary-color);
            background: rgba(99, 102, 241, 0.05);
        }

        .image-upload-container.dragover {
            border-color: var(--primary-color);
            background: rgba(99, 102, 241, 0.1);
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

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            font-size: 1.1rem;
            padding: 1rem 2rem;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
            background: linear-gradient(135deg, #5855eb, #7c3aed);
        }

        .btn-secondary {
            background: var(--text-muted);
            color: white;
        }

        .btn-secondary:hover {
            background: var(--dark-color);
            transform: translateY(-2px);
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
            border-color: var(--primary-color);
            background: rgba(99, 102, 241, 0.1);
            color: var(--primary-color);
        }

        .status-label:hover {
            border-color: var(--primary-color);
        }

        .required-indicator {
            color: var(--danger-color);
            font-weight: 700;
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

        .modal-header.success .btn-close,
        .modal-header.error .btn-close {
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-header {
                padding: 1.5rem;
            }

            .page-title {
                font-size: 1.5rem;
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
    </style>
</head>
<body>
<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    String error = (String) request.getAttribute("error");
    String success = request.getParameter("success");
%>

<div class="container">
    <div class="main-card fade-in">
        <!-- Header -->
        <div class="page-header">
            <h1 class="page-title">
                <i class="bi bi-plus-circle-fill"></i>
                Thêm sách mới
            </h1>
        </div>

        <!-- Form Section -->
        <div class="form-section">
            <div class="form-container">
                <form action="book-create" method="post" enctype="multipart/form-data" id="bookCreateForm">

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
                               placeholder="0.00"
                               min="0"
                               required>
                    </div>

                    <!-- Image Upload -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="bi bi-image-fill"></i>
                            Ảnh sách <span class="required-indicator">*</span>
                        </label>
                        <div class="image-upload-container" id="imageUploadContainer">
                            <div class="upload-icon">
                                <i class="bi bi-cloud-upload"></i>
                            </div>
                            <h5>Kéo thả ảnh vào đây hoặc click để chọn</h5>
                            <p class="text-muted">Hỗ trợ: JPG, PNG, GIF (Tối đa 5MB)</p>
                            <input type="file"
                                   name="image"
                                   id="imageInput"
                                   accept="image/*"
                                   required
                                   style="display: none;">
                            <button type="button" class="btn btn-secondary" onclick="document.getElementById('imageInput').click()">
                                <i class="bi bi-folder-open"></i>
                                Chọn ảnh
                            </button>
                        </div>
                        <img id="imagePreview"
                             class="image-preview"
                             style="display: none;"
                             alt="Xem trước ảnh">
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
                                          required></textarea>
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
                                       value="0"
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
                            <option value="">-- Chọn thể loại --</option>
                            <% for (Category c : categories) { %>
                            <option value="<%= c.getId() %>"><%= c.getName() %></option>
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
                                       checked>
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
                                       value="INACTIVE">
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
                        <button type="submit" class="btn btn-primary" id="submitBtn">
                            <i class="bi bi-plus-circle"></i>
                            Thêm sách
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
                    Thành công!
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p class="mb-0">Sách đã được thêm thành công vào hệ thống!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" onclick="window.location.href='manage-books'">
                    <i class="bi bi-list"></i>
                    Xem danh sách sách
                </button>
                <button type="button" class="btn btn-secondary" onclick="window.location.reload()">
                    <i class="bi bi-plus"></i>
                    Thêm sách khác
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
                    Lỗi!
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p id="errorMessage" class="mb-0">Đã xảy ra lỗi khi thêm sách.</p>
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

<!-- Loading Overlay -->
<div id="loadingOverlay" class="loading-overlay" style="display: none;">
    <div class="loading-spinner"></div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Show modals based on server response
    document.addEventListener('DOMContentLoaded', function() {
        <% if (success != null && success.equals("1")) { %>
        new bootstrap.Modal(document.getElementById('successModal')).show();
        <% } %>

        <% if (error != null) { %>
        document.getElementById('errorMessage').textContent = '<%= error %>';
        new bootstrap.Modal(document.getElementById('errorModal')).show();
        <% } %>
    });

    // Image upload functionality
    const imageInput = document.getElementById('imageInput');
    const imagePreview = document.getElementById('imagePreview');
    const uploadContainer = document.getElementById('imageUploadContainer');

    // File input change handler
    imageInput.addEventListener('change', function(e) {
        previewImage(e.target.files[0]);
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
                uploadContainer.style.display = 'none';
            };
            reader.readAsDataURL(file);
        }
    }

    // Form submission with loading state
    document.getElementById('bookCreateForm').addEventListener('submit', function(e) {
        const submitBtn = document.getElementById('submitBtn');
        const loadingOverlay = document.getElementById('loadingOverlay');

        // Show loading
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Đang xử lý...';
        submitBtn.disabled = true;
        loadingOverlay.style.display = 'flex';
    });

    // Form validation
    function validateForm() {
        const title = document.getElementById('title').value.trim();
        const author = document.getElementById('author').value.trim();
        const price = document.getElementById('price').value;
        const description = document.getElementById('description').value.trim();
        const stock = document.getElementById('stock').value;
        const categoryId = document.getElementById('categoryId').value;

        if (!title) {
            alert('Vui lòng nhập tiêu đề sách!');
            return false;
        }

        if (!author) {
            alert('Vui lòng nhập tên tác giả!');
            return false;
        }

        if (!price || price <= 0) {
            alert('Vui lòng nhập giá hợp lệ!');
            return false;
        }

        if (!description) {
            alert('Vui lòng nhập mô tả sách!');
            return false;
        }

        if (!stock || stock < 0) {
            alert('Vui lòng nhập số lượng tồn kho hợp lệ!');
            return false;
        }

        if (!categoryId) {
            alert('Vui lòng chọn thể loại!');
            return false;
        }

        if (!imageInput.files[0]) {
            alert('Vui lòng chọn ảnh sách!');
            return false;
        }

        return true;
    }

    // Add validation to form submission
    document.getElementById('bookCreateForm').addEventListener('submit', function(e) {
        if (!validateForm()) {
            e.preventDefault();
            const submitBtn = document.getElementById('submitBtn');
            const loadingOverlay = document.getElementById('loadingOverlay');

            // Reset button state
            submitBtn.innerHTML = '<i class="bi bi-plus-circle"></i> Thêm sách';
            submitBtn.disabled = false;
            loadingOverlay.style.display = 'none';
        }
    });

    // Auto-resize textarea
    const textarea = document.getElementById('description');
    textarea.addEventListener('input', function() {
        this.style.height = 'auto';
        this.style.height = this.scrollHeight + 'px';
    });

    // Price formatting
    document.getElementById('price').addEventListener('input', function(e) {
        let value = e.target.value;
        if (value < 0) {
            e.target.value = 0;
        }
    });

    // Stock formatting
    document.getElementById('stock').addEventListener('input', function(e) {
        let value = e.target.value;
        if (value < 0) {
            e.target.value = 0;
        }
    });

    document.getElementById('sold').addEventListener('input', function(e) {
        let value = e.target.value;
        if (value < 0) {
            e.target.value = 0;
        }
    });
</script>
<%@ include file="../footer.jsp" %>
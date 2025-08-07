package org.example.bookstorecode.controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.example.bookstorecode.model.Book;
import org.example.bookstorecode.model.Category;
import org.example.bookstorecode.model.Status;
import org.example.bookstorecode.service.BookDao;
import org.example.bookstorecode.service.CategoryDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Properties;

@WebServlet(name = "BookServlet", urlPatterns = {"/manage-books", "/book-create", "/book-edit", "/book-update", "/book-delete"})
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class BookServlet extends HttpServlet {
    private BookDao bookDao = new BookDao();
    private final CategoryDao categoryDao = new CategoryDao();
    private Cloudinary cloudinary;

    @Override
    public void init(){
        Properties props = new Properties();
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("cloudinary.properties")) {
            props.load(input);
            cloudinary = new Cloudinary(ObjectUtils.asMap(
                    "cloud_name", props.getProperty("cloud_name"),
                    "api_key", props.getProperty("api_key"),
                    "api_secret", props.getProperty("api_secret")
            ));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        List<Category> categories = categoryDao.findAll();

        switch (action) {
            case "/manage-books":
                String title = req.getParameter("title");
                String author = req.getParameter("author");
                String min = req.getParameter("minPrice");
                String max = req.getParameter("maxPrice");
                String category = req.getParameter("category");

                BigDecimal minPrice = (min != null && !min.isEmpty()) ? new BigDecimal(min) : null;
                BigDecimal maxPrice = (max != null && !max.isEmpty()) ? new BigDecimal(max) : null;

                List<Book> books;
                if ((title == null || title.isEmpty()) &&
                        (author == null || author.isEmpty()) &&
                        (minPrice == null && maxPrice == null) &&
                        (category == null || category.isEmpty())) {
                    books = bookDao.findAll();
                } else {
                    books = bookDao.search(title, author, minPrice, maxPrice, category);
                }

                req.setAttribute("categories", categories);
                req.setAttribute("books", books);
                req.setAttribute("selectedCategory", category);

                req.getRequestDispatcher("/admin/manage-books.jsp").forward(req, resp);
                break;

            case "/book-create":
                req.setAttribute("categories", categories);
                req.getRequestDispatcher("/admin/create-book.jsp").forward(req, resp);
                break;

            case "/book-edit":
                int id = Integer.parseInt(req.getParameter("id"));
                Book book = bookDao.findById(id);
                if (book != null) {
                    req.setAttribute("book", book);
                    req.setAttribute("categories", categories);
                    req.getRequestDispatcher("/admin/edit-book.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect("manage-books");
                }
                break;

            case "/book-delete":
                int deleteId = Integer.parseInt(req.getParameter("id"));
                bookDao.softDelete(deleteId);
                resp.sendRedirect("manage-books");
                break;

            default:
                resp.sendRedirect("manage-books");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        req.setCharacterEncoding("UTF-8");

        String title = req.getParameter("title");
        String author = req.getParameter("author");
        String priceStr = req.getParameter("price");
        String description = req.getParameter("description");
        String stockStr = req.getParameter("stock");
        String soldStr = req.getParameter("sold");
        String categoryIdStr = req.getParameter("categoryId");
        String statusStr = req.getParameter("status");
        Part filePart = req.getPart("image");

        String error = null;

        if (title == null ||
                author == null ||
                description == null ||
                priceStr == null || stockStr == null || soldStr == null ||
                categoryIdStr == null || statusStr == null) {
            error = "Vui lòng nhập đầy đủ các trường!";
        } else if (filePart.getSubmittedFileName() == null || filePart.getSubmittedFileName().isEmpty() ||
                !filePart.getSubmittedFileName().matches(".*\\.(jpg|jpeg|png)$")) {
            error = "Ảnh không hợp lệ! Chỉ chấp nhận jpg, jpeg, png.";
        }

        if ("/book-create".equals(action)) {
            if (error != null) {
                req.setAttribute("error", error);
                req.setAttribute("categories", categoryDao.findAll());
                req.getRequestDispatcher("/admin/create-book.jsp").forward(req, resp);
                return;
            }

            File tempFile = File.createTempFile("upload-", ".tmp");
            try (InputStream input = filePart.getInputStream(); OutputStream out = new FileOutputStream(tempFile)) {
                byte[] buffer = new byte[8192];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }

            String imageUrl;
            try {
                Map uploadResult = cloudinary.uploader().upload(tempFile, ObjectUtils.emptyMap());
                imageUrl = uploadResult.get("secure_url").toString();
            } catch (Exception e) {
                tempFile.delete();
                req.setAttribute("error", "Lỗi khi upload ảnh lên Cloudinary.");
                req.setAttribute("categories", categoryDao.findAll());
                req.getRequestDispatcher("/admin/create-book.jsp").forward(req, resp);
                return;
            } finally {
                tempFile.delete();
            }

            BigDecimal price = new BigDecimal(priceStr);
            int stock = Integer.parseInt(stockStr);
            int sold = Integer.parseInt(soldStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            Status status = Status.valueOf(statusStr);

            Book newBook = new Book(title, author, price, imageUrl, description, stock, sold, categoryId, status);
            bookDao.add(newBook);
            resp.sendRedirect("manage-books");

        } else if ("/book-update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            BigDecimal price = new BigDecimal(priceStr);
            int stock = Integer.parseInt(stockStr);
            int sold = Integer.parseInt(soldStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            Status status = Status.valueOf(statusStr);

            String oldImageUrl = req.getParameter("oldImage");
            String imageUrl = oldImageUrl;

            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                // ✅ Xoá ảnh cũ trên Cloudinary nếu có
                String publicId = extractPublicId(oldImageUrl);
                if (publicId != null) {
                    cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
                }

                // ✅ Upload ảnh mới
                File tempFile = File.createTempFile("upload-", ".tmp");
                try (InputStream input = filePart.getInputStream(); OutputStream out = new FileOutputStream(tempFile)) {
                    byte[] buffer = new byte[8192];
                    int bytesRead;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                }
                Map uploadResult = cloudinary.uploader().upload(tempFile, ObjectUtils.emptyMap());
                imageUrl = uploadResult.get("secure_url").toString();
                tempFile.delete();
            }

            Book updatedBook = new Book(id, title, author, price, imageUrl, description, stock, sold, categoryId, LocalDateTime.now(), status);
            bookDao.update(updatedBook);
            resp.sendRedirect("manage-books");
        }
    }
    public String extractPublicId(String imageUrl) {
        try {
            // Tách sau /upload/
            String[] parts = imageUrl.split("/upload/");
            if (parts.length < 2) return null;

            String path = parts[1]; // v1691234567/foldername/image.jpg

            // Bỏ phần version (bắt đầu bằng v + số)
            if (path.startsWith("v")) {
                int slashIndex = path.indexOf("/");
                if (slashIndex != -1) {
                    path = path.substring(slashIndex + 1); // foldername/image.jpg
                }
            }

            int dotIndex = path.lastIndexOf(".");
            return dotIndex > 0 ? path.substring(0, dotIndex) : path;
        } catch (Exception e) {
            return null;
        }
    }

}

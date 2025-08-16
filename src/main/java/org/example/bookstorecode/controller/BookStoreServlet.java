package org.example.bookstorecode.controller;

import org.example.bookstorecode.model.Book;
import org.example.bookstorecode.model.Role;
import org.example.bookstorecode.model.User;
import org.example.bookstorecode.service.BookDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/user-book-store")
public class BookStoreServlet extends HttpServlet {
    private BookDao bookDao = new BookDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user != null && user.getRole() == Role.ADMIN) {
            response.sendRedirect("access-denied.jsp");
            return;
        }
        int page = 1;
        int pageSize = 8;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        if (page < 1) page = 1;
        // Lấy tất cả sách ACTIVE từ CSDL
        List<Book> allBooks = bookDao.findAll();  // chỉ trả về sách trạng thái ACTIVE
        int totalBooks = allBooks.size();

        // Tính toán tổng số trang
        int totalPages = (int) Math.ceil(totalBooks / (double) pageSize);
        if (totalPages < 1) {
            totalPages = 1;
        }
        if (page > totalPages) {
            page = totalPages;
        }
        // Lấy danh sách sách cho trang hiện tại (10 sách mỗi trang)
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalBooks);
        List<Book> pageBooks = new ArrayList<>();
        if (startIndex < totalBooks) {
            pageBooks = allBooks.subList(startIndex, endIndex);
        }
        // Thiết lập dữ liệu để gửi sang JSP
        request.setAttribute("books", pageBooks);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        // Chuyển tiếp đến trang JSP để hiển thị danh sách sách
        request.getRequestDispatcher("/book-store.jsp").forward(request, response);
    }
}

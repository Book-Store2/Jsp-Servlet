package org.example.bookstorecode.controller;

import org.example.bookstorecode.model.Book;
import org.example.bookstorecode.model.User;
import org.example.bookstorecode.service.BookDao;
import org.example.bookstorecode.service.CartDao;
import org.example.bookstorecode.service.OrderDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/book-action")
public class BookActionServlet extends HttpServlet {
    private final BookDao bookDao = new BookDao();
    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int bookId;
        int quantity;
        try {
            bookId = Integer.parseInt(request.getParameter("bookId"));
            quantity = Integer.parseInt(request.getParameter("quantity"));
        } catch (NumberFormatException e) {
            response.sendRedirect("user-book-store?error=invalid-input");
            return;
        }
        String action = request.getParameter("action");
        Book book = bookDao.findById(bookId);
        if (book == null || book.getStatus().name().equals("INACTIVE")) {
            response.sendRedirect("user-book-store?error=book-notfound");
            return;
        }
        if (quantity <= 0 || quantity > book.getStock()) {
            response.sendRedirect("user-book-store?error=invalid-quantity");
            return;
        }
        if ("add".equals(action)) {
            // ➕ Thêm vào giỏ
            CartDao cart = (CartDao) session.getAttribute("cart");
            if (cart == null) {
                cart = new CartDao();
            }
            cart.addItem(book, quantity);
            session.setAttribute("cart", cart);

            String msg = URLEncoder.encode("Đã thêm vào giỏ hàng", "UTF-8");
            response.sendRedirect("user-book-store?message=" + msg);
        } else if ("buy".equals(action)) {
            // 🛒 Mua ngay → forward đến trang xác nhận
            request.setAttribute("book", book);
            request.setAttribute("quantity", quantity);
            request.getRequestDispatcher("user/buy-now.jsp").forward(request, response);

        } else {
            response.sendRedirect("user-book-store?error=invalid-action");
        }
    }
}

package org.example.bookstorecode.controller;

import org.example.bookstorecode.model.Book;
import org.example.bookstorecode.model.User;
import org.example.bookstorecode.service.BookDao;
import org.example.bookstorecode.service.CartDao;
import org.example.bookstorecode.service.OrderDao;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/buy-now-confirm")
public class BuyNowConfirmServlet extends HttpServlet {
    private final BookDao bookDao = new BookDao();
    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String payment = request.getParameter("payment");
        int status = "VNPAY".equals(payment) ? 1 : 0;
        Book book = bookDao.findById(bookId);
        if (book == null || quantity <= 0 || quantity > book.getStock()) {
            response.sendRedirect("user-book-store?error=invalid-buy");
            return;
        }
        // Tạo đơn hàng mới
        CartDao tempCart = new CartDao();
        tempCart.addItem(book, quantity);
        int orderId = orderDao.createOrder(user.getId(), tempCart, status, payment);
        // Cập nhật tồn kho
        bookDao.updateStockAndSold(bookId, -quantity, +quantity);
        String msg = URLEncoder.encode("✅ Đã đặt hàng ngay thành công!", "UTF-8");
        response.sendRedirect("user-orders?message=" + msg);
    }
}

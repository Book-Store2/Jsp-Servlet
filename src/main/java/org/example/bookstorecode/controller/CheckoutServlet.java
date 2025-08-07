package org.example.bookstorecode.controller;

import org.example.bookstorecode.model.Book;
import org.example.bookstorecode.model.CartItem;
import org.example.bookstorecode.model.User;
import org.example.bookstorecode.service.BookDao;
import org.example.bookstorecode.service.CartDao;
import org.example.bookstorecode.service.OrderDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private final BookDao bookDao = new BookDao();
    private final OrderDao orderDao = new OrderDao(); // bạn sẽ tạo lớp này

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        CartDao cart = (CartDao) session.getAttribute("cart");

        if (user == null || cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("user-cart");
            return;
        }

        String payment = request.getParameter("payment"); // COD or VNPAY
        int status = "VNPAY".equals(payment) ? 1 : 0;

        // Kiểm tra tồn kho
        for (CartItem item : cart.getItems()) {
            Book book = bookDao.findById(item.getBook().getId());
            if (book == null || book.getStock() < item.getQuantity()) {
                session.setAttribute("error", "❌ Sách '" + item.getBook().getTitle() + "' không đủ số lượng.");
                response.sendRedirect("user-cart");
                return;
            }
        }

        // Lưu đơn hàng
        int orderId = orderDao.createOrder(user.getId(), cart, status, payment);

        // Cập nhật tồn kho
        for (CartItem item : cart.getItems()) {
            Book book = item.getBook();
            int qty = item.getQuantity();
            bookDao.updateStockAndSold(book.getId(), -qty, +qty); // bạn viết hàm này
        }

        session.removeAttribute("cart");
        session.setAttribute("message", "✅ Đặt hàng thành công! Mã đơn: " + orderId);
        response.sendRedirect("user-orders");
    }
}


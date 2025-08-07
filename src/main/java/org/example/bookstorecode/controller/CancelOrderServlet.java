package org.example.bookstorecode.controller;

import org.example.bookstorecode.service.BookDao;
import org.example.bookstorecode.service.OrderDao;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {
    private final OrderDao orderDao = new OrderDao();
    private final BookDao bookDao = new BookDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Thiết lập mã hóa UTF-8 để tránh lỗi tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        int orderId = Integer.parseInt(request.getParameter("id"));
        // Kiểm tra trạng thái đơn hàng
        if (!orderDao.isCancelable(orderId)) {
            response.sendRedirect("user/orders.jsp?error=Không thể hủy đơn này");
            return;
        }
        // Tăng lại tồn kho, giảm lại sold
        orderDao.restoreStockFromOrder(orderId);
        // Đánh dấu đã hủy
        orderDao.cancelOrder(orderId);
        // Hiển thị thông báo với tiếng Việt rõ ràng
        String msg = URLEncoder.encode("Đã hủy đơn hàng", "UTF-8");
        response.sendRedirect("user-orders?message=" + msg);
    }
}


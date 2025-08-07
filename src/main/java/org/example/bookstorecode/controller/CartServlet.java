package org.example.bookstorecode.controller;

import org.example.bookstorecode.service.CartDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet xử lý giỏ hàng
 * - /user-cart: Hiển thị trang giỏ hàng
 * - /update-cart-ajax: Cập nhật số lượng sản phẩm qua AJAX
 */
@WebServlet(urlPatterns = {"/user-cart", "/update-cart-ajax"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị trang giỏ hàng
        request.getRequestDispatcher("/user/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String path = req.getServletPath();
        System.out.println("📌 Path received: " + path);

        if ("/update-cart-ajax".equals(path)) {
            String bookIdStr = req.getParameter("bookId");
            String quantityStr = req.getParameter("quantity");

            System.out.println("📥 bookId = " + bookIdStr + ", quantity = " + quantityStr);

            if (bookIdStr == null || quantityStr == null || bookIdStr.isEmpty() || quantityStr.isEmpty()) {
                System.out.println("❌ Dữ liệu rỗng hoặc thiếu");
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu dữ liệu.");
                return;
            }

            int bookId, quantity;
            try {
                bookId = Integer.parseInt(bookIdStr);
                quantity = Integer.parseInt(quantityStr);
            } catch (NumberFormatException e) {
                System.out.println("❌ Sai định dạng số: " + e.getMessage());
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Sai định dạng.");
                return;
            }

            HttpSession session = req.getSession();
            CartDao cart = (CartDao) session.getAttribute("cart");

            if (cart == null) {
                System.out.println("❌ Không tìm thấy cart trong session");
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Không có giỏ hàng.");
                return;
            }

            cart.update(bookId, quantity);
            System.out.println("✅ Đã cập nhật giỏ hàng: bookId = " + bookId + ", quantity = " + quantity);
            resp.setStatus(HttpServletResponse.SC_OK);
        }
    }

}
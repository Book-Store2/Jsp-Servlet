package org.example.bookstorecode.controller;

import org.example.bookstorecode.model.Book;
import org.example.bookstorecode.service.BookDao;
import org.example.bookstorecode.service.CartDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    private final BookDao bookDao = new BookDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId;
        int quantity;
        try {
            bookId = Integer.parseInt(request.getParameter("bookId"));
            quantity = Integer.parseInt(request.getParameter("quantity"));
        } catch (NumberFormatException e) {
            response.sendRedirect("user-book-store?error=invalid-data");
            return;
        }
        Book book = bookDao.findById(bookId);
        if (book == null || book.getStatus().name().equals("INACTIVE")) {
            response.sendRedirect("user-book-store?error=notfound");
            return;
        }
        if (quantity <= 0 || quantity > book.getStock()) {
            response.sendRedirect("user-book-store?error=invalid-quantity");
            return;
        }
        HttpSession session = request.getSession();
        CartDao cart = (CartDao) session.getAttribute("cart");
        if (cart == null) {
            cart = new CartDao();
        }
        cart.addItem(book, quantity);
        session.setAttribute("cart", cart);
        session.setAttribute("message", "✅ Đã thêm vào giỏ hàng");
        response.sendRedirect("cart");
    }
}
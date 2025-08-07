package org.example.bookstorecode.controller;

import org.example.bookstorecode.model.Book;
import org.example.bookstorecode.service.BookDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/buy-now")
public class BuyNowServlet extends HttpServlet {
    private final BookDao bookDao = new BookDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Book book = bookDao.findById(bookId);
        if (book == null || quantity <= 0 || quantity > book.getStock()) {
            response.sendRedirect("user-book-store?error=invalid-buy");
            return;
        }
        request.setAttribute("book", book);
        request.setAttribute("quantity", quantity);
        request.getRequestDispatcher("user/buy-now.jsp").forward(request, response);
    }
}

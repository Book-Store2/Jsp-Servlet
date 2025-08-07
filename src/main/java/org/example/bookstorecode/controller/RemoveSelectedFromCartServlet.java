package org.example.bookstorecode.controller;

import org.example.bookstorecode.service.CartDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/remove-selected-from-cart")
public class RemoveSelectedFromCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] selectedBookIds = request.getParameterValues("bookId");
        HttpSession session = request.getSession();

        CartDao cart = (CartDao) session.getAttribute("cart");

        if (selectedBookIds != null && cart != null) {
            for (String bookIdStr : selectedBookIds) {
                int bookId = Integer.parseInt(bookIdStr);
                cart.remove(bookId);
            }
        }

        response.sendRedirect("user-cart");
    }
}


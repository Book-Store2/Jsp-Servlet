package org.example.bookstorecode.controller;


import org.example.bookstorecode.dto.OrderCustomerDetail;
import org.example.bookstorecode.model.Order;
import org.example.bookstorecode.model.User;
import org.example.bookstorecode.service.OrderDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user-orders")
public class OrderServlet extends HttpServlet {
    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<OrderCustomerDetail> orders = orderDao.findAllByUserId(user.getId());
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("user/orders.jsp").forward(request, response);
    }
}


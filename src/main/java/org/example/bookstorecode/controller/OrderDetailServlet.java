package org.example.bookstorecode.controller;


import org.example.bookstorecode.dto.OrderDetailView;
import org.example.bookstorecode.model.User;
import org.example.bookstorecode.service.OrderDao;
import org.example.bookstorecode.service.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/user-orders-detail")
public class OrderDetailServlet extends HttpServlet {
    private final OrderDao orderDao = new OrderDao();
    private final UserDao userDao   = new UserDao();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        HttpSession session = req.getSession(false);
        User logged = (session != null) ? (User) session.getAttribute("user") : null;
        if (logged == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String idParam = req.getParameter("id");
        long orderId;
        try {
            orderId = Long.parseLong(idParam);
        } catch (Exception ex) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu hoặc sai id đơn hàng");
            return;
        }

        // Lấy chi tiết đơn (header + items)
        OrderDetailView view = orderDao.findDetailById(orderId, logged.getId());
        if (view == null) {
            req.setAttribute("error", "Không tìm thấy đơn hàng hoặc không thuộc về bạn.");
            req.getRequestDispatcher("user/order-detail.jsp").forward(req, resp);
            return;
        }

        // Lấy tên + email user qua userId
        User owner = userDao.findUserById((int) view.getUserId());
        if (owner != null) {
            req.setAttribute("customerName", owner.getName());
            req.setAttribute("customerEmail", owner.getEmail());
        }

        req.setAttribute("order", view);
        req.getRequestDispatcher("user/order-detail.jsp").forward(req, resp);
    }
}



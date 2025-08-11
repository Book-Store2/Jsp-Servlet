package org.example.bookstorecode.controller;

import org.example.bookstorecode.model.User;
import org.example.bookstorecode.service.BookDao;
import org.example.bookstorecode.service.OrderDao;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {
    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        User logged = (session != null) ? (User) session.getAttribute("user") : null;
        if (logged == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        long orderId;
        try {
            orderId = Long.parseLong(req.getParameter("orderId"));
        } catch (Exception ex) {
            req.getSession().setAttribute("flash_err", "orderId không hợp lệ");
            resp.sendRedirect(req.getContextPath() + "/user-orders");
            return;
        }

        try {
            boolean ok = orderDao.cancelUnpaidOrder(orderId, logged.getId()); // chỉ status=0
            if (ok) {
                req.getSession().setAttribute("flash", "Đã hủy đơn #" + orderId);
            } else {
                req.getSession().setAttribute("flash_err", "Không thể hủy (đơn đã thanh toán/đã nhận/đã hủy).");
            }
        } catch (RuntimeException e) {
            req.getSession().setAttribute("flash_err", "Có lỗi khi hủy đơn.");
        }
        resp.sendRedirect(req.getContextPath() + "/user-orders-detail?id=" + orderId);
    }
}


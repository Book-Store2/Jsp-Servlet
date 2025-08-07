package org.example.bookstorecode.controller;

import org.example.bookstorecode.dto.OrderDetailDto;
import org.example.bookstorecode.dto.OrderDto;
import org.example.bookstorecode.service.OrderDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/admin-order", "/manage-orders"})
public class AdminOrderServlet extends HttpServlet {
    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();
        String action = req.getParameter("action");
        if (uri.endsWith("/manage-orders")) {
            // 👉 Hiển thị danh sách tất cả đơn hàng
            List<OrderDto> orders = orderDao.getAllOrderDTOs();
            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);
            return;
        }
        // 👉 Xử lý chi tiết hoặc sửa đơn hàng
        int orderId = Integer.parseInt(req.getParameter("id"));
        OrderDto order = orderDao.getOrderDTOById(orderId);
        req.setAttribute("order", order);

        if ("edit".equals(action)) {
            req.getRequestDispatcher("/admin/order-edit.jsp").forward(req, resp);
        } else {
            List<OrderDetailDto> orderDetails = orderDao.getOrderDetails(orderId);
            req.setAttribute("orderDetails", orderDetails);
            req.getRequestDispatcher("/admin/order-detail.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int orderId = Integer.parseInt(req.getParameter("id"));
        int status = Integer.parseInt(req.getParameter("status"));
        orderDao.updateOrderStatus(orderId, status);
        resp.sendRedirect(req.getContextPath() + "/manage-orders");
    }
}

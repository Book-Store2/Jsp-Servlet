package org.example.bookstorecode.controller;

import org.example.bookstorecode.dto.OrderDetailView;
import org.example.bookstorecode.model.User;
import org.example.bookstorecode.service.OrderDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/user-orders"})
public class OrderUserServlet extends HttpServlet {
    protected OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<OrderDetailView> orders = orderDao.findAllDetailByUserId(user.getId());
        request.setAttribute("orders", orders);
        // Luôn forward bằng đường dẫn tuyệt đối tới JSP nằm trong WEB-INF
        request.getRequestDispatcher("user/orders.jsp").forward(request, response);
    }
}
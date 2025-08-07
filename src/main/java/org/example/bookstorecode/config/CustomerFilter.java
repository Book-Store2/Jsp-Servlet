package org.example.bookstorecode.config;

import org.example.bookstorecode.model.Role;
import org.example.bookstorecode.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = {
        "/user-book-store",
        "/add-to-cart",
        "/book-action",
        "/buy-now-confirm",
        "/buy-now",
        "/cancel-order",
        "/user-cart",
        "/checkout",
        "/user-orders",
        "/remove-selected-from-cart"
})
public class CustomerFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();
        String path = uri.substring(req.getContextPath().length());
        // 1. Cho phép tất cả truy cập /user-book-store (kể cả chưa đăng nhập)
        if (path.equals("/user-book-store")) {
            chain.doFilter(request, response);
            return;
        }
        // 2. Các URL còn lại yêu cầu: đã login và có role CUSTOMER
        HttpSession session = req.getSession(false);
        boolean isCustomer = false;
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null && user.getRole() == Role.CUSTOMER) {
                isCustomer = true;
            }
        }
        if (isCustomer) {
            chain.doFilter(request, response); // Cho phép truy cập
        } else {
            res.sendRedirect(req.getContextPath() + "/access-denied.jsp"); // Từ chối
        }
    }
}

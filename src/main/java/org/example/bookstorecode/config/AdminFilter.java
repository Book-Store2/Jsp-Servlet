package org.example.bookstorecode.config;

import org.example.bookstorecode.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {
        "/manage-books",
        "/book-create",
        "/book-edit",
        "/book-update",
        "/book-delete",
        "/manage-categories",
        "/category-create",
        "/category-edit",
        "/category-update",
        "/category-delete",
        "/manage-orders",
        "/admin-order-detail",
        "/admin-order-edit"
})
public class AdminFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        boolean isAdmin = false;
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null && "ADMIN".equals(user.getRole().name())) {
                isAdmin = true;
            }
        }
        if (isAdmin) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/access-denied.jsp");
        }
    }
}

package org.example.bookstorecode.controller;

import org.example.bookstorecode.model.Role;
import org.example.bookstorecode.model.User;
import org.example.bookstorecode.service.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("register.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name").trim();
        String email = req.getParameter("email").trim();
        String password = req.getParameter("password").trim();
        String roleParam = req.getParameter("role");
        Role role = Role.valueOf(roleParam);
        boolean validName = name.matches(".{2,50}");
        boolean validEmail = email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$");
        boolean validPassword = password.matches(".{6,}");
        if (!validName || !validEmail || !validPassword) {
            req.setAttribute("error", "Thông tin không hợp lệ!");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }
        UserDao userDao = new UserDao();
        if (userDao.findByEmail(email) != null) {
            req.setAttribute("error", "Email đã được sử dụng!");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }
        userDao.insert(new User(name, email, password, role));
        resp.sendRedirect("login?success=1");
    }
}

package org.example.bookstorecode.controller;

import org.example.bookstorecode.model.User;
import org.example.bookstorecode.service.UserDao;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String success = req.getParameter("success");
        if ("1".equals(success)) {
            req.setAttribute("message", "✅ Đăng ký thành công. Vui lòng đăng nhập.");
        }
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email").trim();
        String password = req.getParameter("password").trim();
        String remember = req.getParameter("remember");

        User user = userDao.findByEmail(email);

        if (user == null || !BCrypt.checkpw(password, user.getPassword())) {
            req.setAttribute("message", "❌ Email hoặc mật khẩu không đúng!");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        // Lưu session
        HttpSession session = req.getSession();
        session.setAttribute("user", user);

        Cookie emailCookie = new Cookie("email", "on".equals(remember) ? email : "");
        emailCookie.setMaxAge("on".equals(remember) ? 7 * 24 * 60 * 60 : 0); // 7 ngày hoặc xóa
        emailCookie.setHttpOnly(true);
        resp.addCookie(emailCookie);
        resp.sendRedirect("home"); // Tuỳ bạn định nghĩa
    }
}

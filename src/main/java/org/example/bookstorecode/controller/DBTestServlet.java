package org.example.bookstorecode.controller;

import org.example.bookstorecode.repository.DBConnection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/db-test")
public class DBTestServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null) {
                response.getWriter().println("✅ Kết nối thành công đến CSDL!");
            } else {
                response.getWriter().println("❌ Kết nối thất bại.");
            }
        } catch (Exception e) {
            response.getWriter().println("❌ Lỗi: " + e.getMessage());
        }
    }
}


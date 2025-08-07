package org.example.bookstorecode.service;

import org.example.bookstorecode.model.Role;
import org.example.bookstorecode.model.User;
import org.example.bookstorecode.repository.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDao {
    private static final Logger LOGGER = Logger.getLogger(UserDao.class.getName());
    public void insert(User user) {
        String sql = "INSERT INTO users (name, email, password, role, created_at) VALUES (?, ?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            // ✅ Mã hóa mật khẩu
            String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            ps.setString(3, hashed);
            ps.setString(4, user.getRole().name());
            ps.executeUpdate();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi tạo tài khoản!", e);
            throw new RuntimeException("Hệ thống đang bận, vui lòng thử lại sau.");
        }
    }

    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        Role.valueOf(rs.getString("role")),
                        rs.getTimestamp("created_at").toLocalDateTime()
                );
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi truy vấn user theo email!", e);
            throw new RuntimeException("Hệ thống đang bận, vui lòng thử lại sau.");
        }
        return null;
    }
}

package org.example.bookstorecode.service;

import org.example.bookstorecode.model.Role;
import org.example.bookstorecode.model.User;
import org.example.bookstorecode.repository.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.time.LocalDateTime;
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
    public User findUserById(int id) {
        String sql = "SELECT id, name, email, password, role, created_at FROM users WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));

                // role có thể là ENUM/varchar trong DB, map sang enum của bạn
                String roleStr = rs.getString("role");
                try {
                    u.setRole(Role.valueOf(roleStr));
                } catch (Exception ignore) { u.setRole(null); }

                Timestamp ts = rs.getTimestamp("created_at");
                if (ts != null) u.setCreatedAt(ts.toLocalDateTime());
                else u.setCreatedAt(LocalDateTime.now());

                return u;
            }
        } catch (SQLException e) {
            throw new RuntimeException("findUserById error", e);
        }
    }
}

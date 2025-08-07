package org.example.bookstorecode.service;

import org.example.bookstorecode.model.Category;
import org.example.bookstorecode.model.Status;
import org.example.bookstorecode.repository.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {

    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories where status = 'ACTIVE'";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt("id"), rs.getString("name"), Status.valueOf(rs.getString("status"))));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Category findById(int id) {
        String sql = "SELECT * FROM categories WHERE id = ? and status = 'ACTIVE'";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Category(rs.getInt("id"), rs.getString("name"), Status.valueOf(rs.getString("status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void add(Category category) {
        String sql = "INSERT INTO categories(name, status) VALUES(?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, Status.ACTIVE.name());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Category category) {
        String sql = "UPDATE categories SET name = ? WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setInt(2, category.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void softDelete(int id) {
        String sql = "UPDATE categories SET status = 'INACTIVE' WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Category findActiveById(int id) {
        String sql = "SELECT * FROM categories WHERE id = ? AND status = 'ACTIVE'";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Category(rs.getInt("id"), rs.getString("name"), Status.valueOf(rs.getString("status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}


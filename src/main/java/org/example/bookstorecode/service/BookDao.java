package org.example.bookstorecode.service;

import org.example.bookstorecode.model.Book;
import org.example.bookstorecode.model.Status;
import org.example.bookstorecode.repository.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BookDao {
    public List<Book> findAll() {
        List<Book> bookList = new ArrayList<>();
        String sql = "select * from books where status = 'ACTIVE' and stock > 0";
        Connection connection = DBConnection.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Book book = new Book(
                        resultSet.getInt("id"),
                        resultSet.getString("title"),
                        resultSet.getString("author"),
                        resultSet.getBigDecimal("price"),
                        resultSet.getString("image"),
                        resultSet.getString("description"),
                        resultSet.getInt("stock"),
                        resultSet.getInt("sold"),
                        resultSet.getInt("category_id"),
                        resultSet.getTimestamp("created_at").toLocalDateTime(),
                        Status.valueOf(resultSet.getString("status"))
                );
                bookList.add(book);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return bookList;
    }

    public void add(Book book) {
        String sql = "INSERT INTO books (title, author, price, image, description, stock, sold, category_id, created_at, status) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection connection = DBConnection.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, book.getTitle());
            preparedStatement.setString(2, book.getAuthor());
            preparedStatement.setBigDecimal(3, book.getPrice());
            preparedStatement.setString(4, book.getImage());
            preparedStatement.setString(5, book.getDescription());
            preparedStatement.setInt(6, book.getStock());
            preparedStatement.setInt(7, book.getSold());
            preparedStatement.setInt(8, book.getCategoryId());
            preparedStatement.setTimestamp(9, Timestamp.valueOf(LocalDateTime.now()));
            preparedStatement.setString(10, book.getStatus().name());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Book findById(int id) {
        String sql = "select * from books where id = ?";
        Connection connection = DBConnection.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return new Book(
                        resultSet.getInt("id"),
                        resultSet.getString("title"),
                        resultSet.getString("author"),
                        resultSet.getBigDecimal("price"),
                        resultSet.getString("image"),
                        resultSet.getString("description"),
                        resultSet.getInt("stock"),
                        resultSet.getInt("sold"),
                        resultSet.getInt("category_id"),
                        resultSet.getTimestamp("created_at").toLocalDateTime(),
                        Status.valueOf(resultSet.getString("status"))
                );
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public void update(Book book) {
        String sql = "update books set title=?, author=?, price=?, image=?, description=?, stock = ?, sold = ?, category_id=? WHERE id=?";
        Connection connection = DBConnection.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, book.getTitle());
            preparedStatement.setString(2, book.getAuthor());
            preparedStatement.setBigDecimal(3, book.getPrice());
            preparedStatement.setString(4, book.getImage());
            preparedStatement.setString(5, book.getDescription());
            preparedStatement.setInt(6, book.getStock());
            preparedStatement.setInt(7, book.getSold());
            preparedStatement.setInt(8, book.getCategoryId());
            preparedStatement.setInt(9, book.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void softDelete(int id) {
        String sql = "UPDATE books SET status = 'INACTIVE' WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Book> search(String title, String author, BigDecimal minPrice, BigDecimal maxPrice, String categoryName) {
        List<Book> result = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT b.* FROM books b JOIN categories c ON b.category_id = c.id WHERE b.status = 'ACTIVE' AND c.status = 'ACTIVE'");

        if (title != null && !title.trim().isEmpty()) {
            sql.append(" AND b.title LIKE ?");
            params.add("%" + title.trim() + "%");
        }

        if (author != null && !author.trim().isEmpty()) {
            sql.append(" AND b.author LIKE ?");
            params.add("%" + author.trim() + "%");
        }

        if (minPrice != null) {
            sql.append(" AND b.price >= ?");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append(" AND b.price <= ?");
            params.add(maxPrice);
        }

        if (categoryName != null && !categoryName.trim().isEmpty()) {
            sql.append(" AND c.name = ?");
            params.add(categoryName.trim());
        }

        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Book(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getBigDecimal("price"),
                        rs.getString("image"),
                        rs.getString("description"),
                        rs.getInt("stock"),
                        rs.getInt("sold"),
                        rs.getInt("category_id"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        Status.valueOf(rs.getString("status"))
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public void updateStockAndSold(int bookId, int stockChange, int soldChange) {
        String sql = "UPDATE books SET stock = stock + ?, sold = sold + ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, stockChange);  // -quantity để trừ
            ps.setInt(2, soldChange);   // +quantity để cộng
            ps.setInt(3, bookId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

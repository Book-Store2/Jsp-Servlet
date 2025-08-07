package org.example.bookstorecode.service;

import org.example.bookstorecode.dto.OrderCustomerDetail;
import org.example.bookstorecode.dto.OrderDetailDto;
import org.example.bookstorecode.dto.OrderDto;
import org.example.bookstorecode.model.CartItem;
import org.example.bookstorecode.model.Order;
import org.example.bookstorecode.model.User;
import org.example.bookstorecode.repository.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class OrderDao {
    public int createOrder(int userId, CartDao cart, int status, String paymentMethod) {
        String insertOrder = "INSERT INTO orders (user_id, total_price, order_date, status, payment_method) VALUES (?, ?, NOW(), ?, ?)";
        String insertDetail = "INSERT INTO order_details (order_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement psOrder = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, userId);
                psOrder.setBigDecimal(2, cart.getTotal());
                psOrder.setInt(3, status);
                psOrder.setString(4, paymentMethod);
                psOrder.executeUpdate();

                ResultSet rs = psOrder.getGeneratedKeys();
                if (rs.next()) {
                    int orderId = rs.getInt(1);

                    try (PreparedStatement psDetail = conn.prepareStatement(insertDetail)) {
                        for (CartItem item : cart.getItems()) {
                            psDetail.setInt(1, orderId);
                            psDetail.setInt(2, item.getBook().getId());
                            psDetail.setInt(3, item.getQuantity());
                            psDetail.setBigDecimal(4, item.getBook().getPrice());
                            psDetail.addBatch();
                        }
                        psDetail.executeBatch();
                    }

                    conn.commit();
                    return orderId;
                } else {
                    conn.rollback();
                    throw new SQLException("Không lấy được orderId");
                }
            } catch (Exception e) {
                conn.rollback();
                throw new RuntimeException(e);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // ✅ Kiểm tra đơn có thể hủy không (chỉ COD - status = 0)
    public boolean isCancelable(int orderId) {
        String sql = "SELECT status FROM orders WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int status = rs.getInt("status");
                return status == 0; // chỉ COD mới được hủy
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Cập nhật đơn hàng sang trạng thái "đã hủy"
    public void cancelOrder(int orderId) {
        String sql = "UPDATE orders SET status = 3 WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ✅ Phục hồi tồn kho và giảm lại số đã bán từ chi tiết đơn hàng
    public void restoreStockFromOrder(int orderId) {
        String sql = "SELECT book_id, quantity FROM order_details WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int bookId = rs.getInt("book_id");
                int qty = rs.getInt("quantity");

                // Tăng tồn kho lại và giảm sold
                String updateBook = "UPDATE books SET stock = stock + ?, sold = sold - ? WHERE id = ?";
                try (PreparedStatement ps2 = conn.prepareStatement(updateBook)) {
                    ps2.setInt(1, qty);
                    ps2.setInt(2, qty);
                    ps2.setInt(3, bookId);
                    ps2.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Order> findOrdersByUserId(int userId) {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalPrice(rs.getBigDecimal("total_price"));
                order.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
                order.setStatus(rs.getInt("status"));
                order.setPaymentMethod(rs.getString("payment_method"));
                orderList.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }

    public List<OrderDto> getAllOrderDTOs() {
        List<OrderDto> orders = new ArrayList<>();
        String sql = "SELECT orders.id, orders.user_id, users.name AS customer_name, " +
                "orders.total_price, orders.order_date, orders.status, orders.payment_method " +
                "FROM orders JOIN users ON orders.user_id = users.id " +
                "ORDER BY orders.order_date DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                OrderDto order = new OrderDto();

                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setTotalPrice(rs.getBigDecimal("total_price"));
                order.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
                order.setStatus(rs.getInt("status"));
                order.setPaymentMethod(rs.getString("payment_method"));

                orders.add(order);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching orders", e);
        }

        return orders;
    }

    public void updateOrderStatus(int orderId, int status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, status);
            ps.setInt(2, orderId);

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Error updating order status", e);
        }
    }

    public List<OrderDetailDto> getOrderDetails(int orderId) {
        List<OrderDetailDto> details = new ArrayList<>();
        String sql = "SELECT od.book_id, b.title AS book_title, od.quantity, od.price " +
                "FROM order_details od JOIN books b ON od.book_id = b.id WHERE od.order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDetailDto detail = new OrderDetailDto(
                        rs.getInt("book_id"),
                        rs.getString("book_title"),
                        rs.getInt("quantity"),
                        rs.getBigDecimal("price")
                );
                details.add(detail);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching order details", e);
        }
        return details;
    }

    public OrderDto getOrderDTOById(int orderId) {
        OrderDto order = null;
        String sql = "SELECT orders.id, orders.user_id, users.name AS customer_name, orders.total_price, " +
                "orders.order_date, orders.status, orders.payment_method " +
                "FROM orders JOIN users ON orders.user_id = users.id WHERE orders.id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                order = new OrderDto(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("customer_name"),
                        rs.getBigDecimal("total_price"),
                        rs.getTimestamp("order_date").toLocalDateTime(),
                        rs.getInt("status"),
                        rs.getString("payment_method")
                );
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching order by ID", e);
        }
        return order;
    }
    public List<OrderCustomerDetail> findAllByUserId(int userId) {
        List<OrderCustomerDetail> results = new ArrayList<>();

        String sql = "SELECT \n" +
                "            o.id AS order_id,\n" +
                "            o.order_date,\n" +
                "            o.total_price,\n" +
                "            o.status,\n" +
                "            o.payment_method,\n" +
                "            u.name AS user_name,\n" +
                "            u.email,\n" +
                "            b.id AS book_id,\n" +
                "            b.title AS book_title,\n" +
                "            od.quantity,\n" +
                "            od.price\n" +
                "        FROM orders o\n" +
                "        JOIN users u ON o.user_id = u.id\n" +
                "        JOIN order_details od ON o.id = od.order_id\n" +
                "        JOIN books b ON od.book_id = b.id\n" +
                "        WHERE o.user_id = ?\n" +
                "        ORDER BY o.order_date DESC";



        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            Map<Integer, OrderCustomerDetail> map = new LinkedHashMap<>();

            while (rs.next()) {
                int orderId = rs.getInt("order_id");

                OrderCustomerDetail dto = map.get(orderId);
                if (dto == null) {
                    dto = new OrderCustomerDetail();
                    dto.setCreatedAt(rs.getTimestamp("order_date").toLocalDateTime());
                    dto.setTotalAmount(rs.getBigDecimal("total_price"));
                    dto.setStatus(String.valueOf(rs.getInt("status")));
                    dto.setPaymentMethod(rs.getString("payment_method"));

                    User user = new User();
                    user.setName(rs.getString("user_name"));
                    user.setEmail(rs.getString("email"));
                    dto.setUser(user);

                    dto.setDetails(new ArrayList<>());
                    map.put(orderId, dto);
                }

                OrderDetailDto detail = new OrderDetailDto(
                        rs.getInt("book_id"),
                        rs.getString("book_title"),
                        rs.getInt("quantity"),
                        rs.getBigDecimal("price")
                );
                dto.getDetails().add(detail);
            }

            results.addAll(map.values());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return results;
    }


}

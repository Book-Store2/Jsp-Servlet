package org.example.bookstorecode.service;

import org.example.bookstorecode.dto.*;
import org.example.bookstorecode.model.CartItem;
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
    public List<OrderDetailView> findAllDetailByUserId(int userId) {
        String sql = "SELECT \n" +
                "            o.id AS order_id,\n" +
                "            o.user_id,\n" +
                "            o.order_date,\n" +
                "            o.total_price,\n" +
                "            o.status,\n" +
                "            o.payment_method,\n" +
                "            od.book_id,\n" +
                "            b.title AS book_title,\n" +
                "            od.quantity,\n" +
                "            od.price\n" +
                "        FROM orders o\n" +
                "        JOIN order_details od ON od.order_id = o.id\n" +
                "        JOIN books b ON b.id = od.book_id\n" +
                "        WHERE o.user_id = ?\n" +
                "        ORDER BY o.order_date DESC, od.id";

        Map<Long, OrderDetailView> map = new LinkedHashMap<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    long orderId = rs.getLong("order_id");
                    OrderDetailView view = map.get(orderId);
                    if (view == null) {
                        view = new OrderDetailView();
                        view.setId(orderId);
                        view.setUserId(rs.getLong("user_id"));
                        view.setCreatedAt(rs.getTimestamp("order_date").toLocalDateTime());
                        view.setStatus(rs.getInt("status"));
                        view.setPaymentMethod(rs.getString("payment_method"));
                        view.setTotalAmount(rs.getBigDecimal("total_price")); // đã có ở orders
                        view.setItems(new ArrayList<>());
                        map.put(orderId, view);
                    }

                    OrderItemDto item = new OrderItemDto();
                    item.setBookId(rs.getLong("book_id"));
                    item.setTitle(rs.getString("book_title"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getBigDecimal("price"));
                    // lineTotal = price * quantity
                    item.setLineTotal(item.getPrice().multiply(new java.math.BigDecimal(item.getQuantity())));
                    view.getItems().add(item);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return new ArrayList<>(map.values());
    }


    public OrderDetailView findDetailById(long orderId, long userId) {
        String sqlHeader = "SELECT o.id, o.user_id, o.order_date, o.status, o.payment_method,\n" +
                "               COALESCE(SUM(od.quantity * od.price),0) AS total_amount\n" +
                "        FROM orders o\n" +
                "        LEFT JOIN order_details od ON od.order_id = o.id\n" +
                "        WHERE o.id = ? AND o.user_id = ?\n" +
                "        GROUP BY o.id, o.user_id, o.order_date, o.status, o.payment_method";

        String sqlItems = "SELECT od.book_id, b.title, od.quantity, od.price,\n" +
                "               (od.quantity*od.price) AS line_total\n" +
                "        FROM order_details od\n" +
                "        JOIN books b ON b.id = od.book_id\n" +
                "        WHERE od.order_id = ?\n" +
                "        ORDER BY od.id";

        try (Connection con = DBConnection.getConnection()) {
            OrderDetailView view = null;

            // Lấy thông tin chung của đơn hàng
            try (PreparedStatement ps = con.prepareStatement(sqlHeader)) {
                ps.setLong(1, orderId);
                ps.setLong(2, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        view = new OrderDetailView();
                        view.setId(rs.getLong("id"));
                        view.setUserId(rs.getLong("user_id"));
                        view.setCreatedAt(rs.getTimestamp("order_date").toLocalDateTime());
                        view.setStatus(rs.getInt("status"));
                        view.setPaymentMethod(rs.getString("payment_method"));
                        view.setTotalAmount(rs.getBigDecimal("total_amount"));
                    } else {
                        return null; // không tìm thấy đơn hoặc không thuộc user
                    }
                }
            }

            // Lấy danh sách sản phẩm trong đơn
            List<OrderItemDto> items = new ArrayList<>();
            try (PreparedStatement ps = con.prepareStatement(sqlItems)) {
                ps.setLong(1, orderId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        OrderItemDto item = new OrderItemDto();
                        item.setBookId(rs.getLong("book_id"));
                        item.setTitle(rs.getString("title"));
                        item.setQuantity(rs.getInt("quantity"));
                        item.setPrice(rs.getBigDecimal("price"));
                        item.setLineTotal(rs.getBigDecimal("line_total"));
                        items.add(item);
                    }
                }
            }
            view.setItems(items);
            return view;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /** HỦY ĐƠN + HOÀN KHO trong 1 transaction. Dùng DBConnection, chặn âm sold. */
    public boolean cancelUnpaidOrder(long orderId, long userId) {
        String sqlUpdateOrder = "UPDATE orders\n" +
                "        SET status = 3\n" +
                "        WHERE id = ? AND user_id = ? AND status = 0";
        // nếu muốn bắt buộc COD: thêm "AND payment_method = 'COD'"

        String sqlRestoreStock = "UPDATE books b\n" +
                "        JOIN order_details od ON od.book_id = b.id\n" +
                "        SET b.stock = b.stock + od.quantity,\n" +
                "            b.sold  = GREATEST(b.sold - od.quantity, 0)\n" +
                "        WHERE od.order_id = ?";

        try (Connection con = DBConnection.getConnection()) {
            boolean ok = false;
            try {
                con.setAutoCommit(false);

                // 1) đổi trạng thái đơn nếu còn hủy được
                int n;
                try (PreparedStatement ps = con.prepareStatement(sqlUpdateOrder)) {
                    ps.setLong(1, orderId);
                    ps.setLong(2, userId);
                    n = ps.executeUpdate();
                }
                if (n == 0) { con.rollback(); return false; }

                // 2) hoàn kho
                try (PreparedStatement ps2 = con.prepareStatement(sqlRestoreStock)) {
                    ps2.setLong(1, orderId);
                    ps2.executeUpdate();
                }

                con.commit();
                ok = true;
            } catch (Exception ex) {
                con.rollback();
                throw ex;
            } finally {
                con.setAutoCommit(true);
            }
            return ok;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

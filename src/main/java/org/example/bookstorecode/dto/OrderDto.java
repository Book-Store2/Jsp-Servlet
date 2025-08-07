package org.example.bookstorecode.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class OrderDto {
    private int id;
    private int userId;
    private String customerName;  // Thêm tên khách hàng vào đây
    private BigDecimal totalPrice;
    private LocalDateTime orderDate;
    private int status;
    private String paymentMethod;

    public OrderDto() {}

    public OrderDto(int id, int userId, String customerName, BigDecimal totalPrice,
                    LocalDateTime orderDate, int status, String paymentMethod) {
        this.id = id;
        this.userId = userId;
        this.customerName = customerName;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.status = status;
        this.paymentMethod = paymentMethod;
    }

    // Getter & Setter đầy đủ cho tất cả thuộc tính
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
}

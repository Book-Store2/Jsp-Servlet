package org.example.bookstorecode.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class OrderDetailView {
    private long id;
    private long userId;
    private LocalDateTime createdAt;
    private int status; // 0,1,2,3
    private String paymentMethod; // "COD" | "VNPAY" ...
    private BigDecimal totalAmount;
    private List<OrderItemDto> items;

    public OrderDetailView() {
    }

    public OrderDetailView(long id, long userId, LocalDateTime createdAt, int status, String paymentMethod, BigDecimal totalAmount, List<OrderItemDto> items) {
        this.id = id;
        this.userId = userId;
        this.createdAt = createdAt;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.totalAmount = totalAmount;
        this.items = items;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
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

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public List<OrderItemDto> getItems() {
        return items;
    }

    public void setItems(List<OrderItemDto> items) {
        this.items = items;
    }
}

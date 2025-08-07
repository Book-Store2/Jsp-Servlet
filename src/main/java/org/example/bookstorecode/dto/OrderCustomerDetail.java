package org.example.bookstorecode.dto;

import org.example.bookstorecode.model.User;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class OrderCustomerDetail {
    private LocalDateTime createdAt;
    private BigDecimal totalAmount;
    private String paymentMethod;
    private String status;
    private List<OrderDetailDto> details;
    private User user;

    public OrderCustomerDetail() {
    }

    public OrderCustomerDetail(LocalDateTime createdAt, BigDecimal totalAmount, String paymentMethod, String status, List<OrderDetailDto> details, User user) {
        this.createdAt = createdAt;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.details = details;
        this.user = user;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<OrderDetailDto> getDetails() {
        return details;
    }

    public void setDetails(List<OrderDetailDto> details) {
        this.details = details;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}

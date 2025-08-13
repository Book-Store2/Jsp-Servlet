package org.example.bookstorecode.dto;

import java.math.BigDecimal;

public class OrderItemDto {
    private long bookId;
    private String title;
    private int quantity;
    private java.math.BigDecimal price;
    private java.math.BigDecimal lineTotal;

    public OrderItemDto() {
    }

    public OrderItemDto(long bookId, String title, int quantity, BigDecimal price, BigDecimal lineTotal) {
        this.bookId = bookId;
        this.title = title;
        this.quantity = quantity;
        this.price = price;
        this.lineTotal = lineTotal;
    }

    public long getBookId() {
        return bookId;
    }

    public void setBookId(long bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getLineTotal() {
        return lineTotal;
    }

    public void setLineTotal(BigDecimal lineTotal) {
        this.lineTotal = lineTotal;
    }
}

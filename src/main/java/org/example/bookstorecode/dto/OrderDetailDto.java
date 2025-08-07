package org.example.bookstorecode.dto;

import java.math.BigDecimal;

public class OrderDetailDto {
    private int bookId;
    private String bookTitle;
    private int quantity;
    private BigDecimal price;

    public OrderDetailDto() {
    }

    public OrderDetailDto(int bookId, String bookTitle, int quantity, BigDecimal price) {
        this.bookId = bookId;
        this.bookTitle = bookTitle;
        this.quantity = quantity;
        this.price = price;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
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
}


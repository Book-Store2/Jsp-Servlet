package org.example.bookstorecode.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Book {
    private int id;
    private String title;
    private String author;
    private BigDecimal price;
    private String image;
    private String description;
    private int stock;
    private int sold;
    private int categoryId;
    private LocalDateTime createdAt;
    private Status status;

    public Book() {
    }

    public Book(int id, String title, String author, BigDecimal price, String image, String description, int stock, int sold, int categoryId, LocalDateTime createdAt, Status status) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.price = price;
        this.image = image;
        this.description = description;
        this.stock = stock;
        this.sold = sold;
        this.categoryId = categoryId;
        this.createdAt = createdAt;
        this.status = status;
    }

    public Book(String title, String author, BigDecimal price, String image, String description, int stock, int sold, int categoryId, Status status) {
        this.title = title;
        this.author = author;
        this.price = price;
        this.image = image;
        this.description = description;
        this.stock = stock;
        this.sold = sold;
        this.categoryId = categoryId;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getSold() {
        return sold;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }
}

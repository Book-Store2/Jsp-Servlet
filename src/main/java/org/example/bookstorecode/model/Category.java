package org.example.bookstorecode.model;

public class Category {
    private int id;
    private String name;
    private Status status;

    public Category() {
    }

    public Category(String name,Status status) {
        this.name = name;
        this.status = status;
    }

    public Category(int id, String name, Status status) {
        this.id = id;
        this.name = name;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }
}

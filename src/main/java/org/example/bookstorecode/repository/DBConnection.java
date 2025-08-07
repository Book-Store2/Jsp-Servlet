package org.example.bookstorecode.repository;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static final String URL = "jdbc:mysql://localhost:3306/book_store";
    public static final String USER = "root";
    public static final String PASSWORD = "codegym";
    public static Connection getConnection(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL,USER,PASSWORD);
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }
}

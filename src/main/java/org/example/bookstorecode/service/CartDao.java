package org.example.bookstorecode.service;

import org.example.bookstorecode.model.Book;
import org.example.bookstorecode.model.CartItem;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class CartDao {
    private List<CartItem> cartItems = new ArrayList<>();

    public void addItem(Book book, int quantity) {
        for (CartItem item : cartItems) {
            if (item.getBook().getId() == book.getId()) {
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }
        cartItems.add(new CartItem(book, quantity));
    }

    public BigDecimal getTotal() {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            total = total.add(item.getBook().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
        }
        return total;
    }

    public List<CartItem> getItems() {
        return cartItems;
    }

    public void remove(int bookId) {
        for (Iterator<CartItem> iterator = cartItems.iterator(); iterator.hasNext(); ) {
            CartItem item = iterator.next();
            if (item.getBook().getId() == bookId) {
                iterator.remove(); // đúng cách để xóa phần tử trong List
                break;
            }
        }
    }
    public void update(int bookId, int quantity) {
        for (CartItem item : cartItems) {
            if (item.getBook().getId() == bookId) {
                if (quantity <= 0) {
                    cartItems.remove(item); // tự động xóa nếu quantity <= 0
                } else {
                    item.setQuantity(quantity);
                }
                return;
            }
        }
    }

}

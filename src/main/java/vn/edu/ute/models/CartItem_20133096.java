package vn.edu.ute.models;

public class CartItem_20133096 {
    private int bookId;
    private String title;
    private String coverImage;
    private double price;
    private int quantity;
    private int maxQuantity; // Dùng để check giới hạn số lượng tồn kho

    // Nút Generate -> Constructor, Getters & Setters cho toàn bộ thuộc tính trên
    public CartItem_20133096() {}
    public CartItem_20133096(int bookId, String title, String coverImage, double price, int quantity, int maxQuantity) {
        this.bookId = bookId; this.title = title; this.coverImage = coverImage;
        this.price = price; this.quantity = quantity; this.maxQuantity = maxQuantity;
    }
    // TODO: BẠN TỰ GENERATE GETTER/SETTER VÀO ĐÂY NHÉ
}
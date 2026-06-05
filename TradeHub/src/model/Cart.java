package model;

public class Cart {
    private int id;
    private int userId;
    private int productId;
    private int quantity;
    private String createdTime;

    private String productName;
    private float productPrice;
    private String productImage;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getCreatedTime() { return createdTime; }
    public void setCreatedTime(String createdTime) { this.createdTime = createdTime; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public float getProductPrice() { return productPrice; }
    public void setProductPrice(float productPrice) { this.productPrice = productPrice; }
    public String getProductImage() { return productImage; }
    public void setProductImage(String productImage) { this.productImage = productImage; }

    public float getSubtotal() { return productPrice * quantity; }
}
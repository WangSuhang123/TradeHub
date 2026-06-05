package model;

public class OrderItem {
    private int id;
    private float price;
    private int productId;
    private int orderId;
    private Product product;
    private Order order;
    private String productName;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public OrderItem() {
        super();
    }

    @Override
    public String toString() {
        return "OrderItem [id=" + id + ", price=" + price + ", productId=" + productId + ", orderId=" + orderId
                + ", productName=" + productName + "]";
    }
}
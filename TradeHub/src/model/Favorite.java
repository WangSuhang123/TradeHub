package model;

import java.util.Date;

public class Favorite {
    private int id;
    private int userId;
    private int productId;
    private Date createdTime;
    private Product product;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Favorite() {
        super();
    }

    @Override
    public String toString() {
        return "Favorite [id=" + id + ", userId=" + userId + ", productId=" + productId + ", createdTime=" + createdTime + "]";
    }
}
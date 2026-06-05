package model;

import java.util.Date;

public class Product {
    private int id;
    private String name;
    private float price;
    private float priceOriginal;
    private String description;
    private String image;
    private int conditionLevel;
    private int status;
    private int views;
    private Date createdTime;
    private int userId;
    private int categoryId;
    private Category category;
    private User user;
    private String userName;
    private String categoryName;

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

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public float getPriceOriginal() {
        return priceOriginal;
    }

    public void setPriceOriginal(float priceOriginal) {
        this.priceOriginal = priceOriginal;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getConditionLevel() {
        return conditionLevel;
    }

    public void setConditionLevel(int conditionLevel) {
        this.conditionLevel = conditionLevel;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getConditionText() {
        switch (conditionLevel) {
            case 1: return "全新";
            case 2: return "几乎全新";
            case 3: return "有使用痕迹";
            case 4: return "老旧";
            default: return "未知";
        }
    }

    public String getStatusText() {
        switch (status) {
            case 0: return "在售";
            case 1: return "已售";
            case 2: return "已下架";
            default: return "未知";
        }
    }

    public Product() {
        super();
    }

    @Override
    public String toString() {
        return "Product [id=" + id + ", name=" + name + ", price=" + price + ", priceOriginal=" + priceOriginal
                + ", description=" + description + ", image=" + image + ", conditionLevel=" + conditionLevel
                + ", status=" + status + ", views=" + views + ", createdTime=" + createdTime + ", userId=" + userId
                + ", categoryId=" + categoryId + ", userName=" + userName + ", categoryName=" + categoryName + "]";
    }
}
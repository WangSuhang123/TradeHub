package dao;

import model.Product;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DataSourceUtils;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {

    public void insert(Product p) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "INSERT INTO product(name,price,price_original,description,image,condition_level,user_id,category_id) VALUES(?,?,?,?,?,?,?,?)";
        r.update(sql, p.getName(), p.getPrice(), p.getPriceOriginal(), p.getDescription(),
                p.getImage(), p.getConditionLevel(), p.getUserId(), p.getCategoryId());
    }

    public void update(Product p) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE product SET name=?,price=?,price_original=?,description=?,image=?,condition_level=?,category_id=? WHERE id=?";
        r.update(sql, p.getName(), p.getPrice(), p.getPriceOriginal(), p.getDescription(),
                p.getImage(), p.getConditionLevel(), p.getCategoryId(), p.getId());
    }

    public void delete(int id) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "DELETE FROM product WHERE id=?";
        r.update(sql, id);
    }

    private String productColumns() {
        return "p.id,p.name,p.price,p.price_original priceOriginal,p.description,p.image,p.condition_level conditionLevel,p.status,p.views,p.created_time createdTime,p.user_id userId,p.category_id categoryId,u.name userName,c.name categoryName";
    }

    public Product getById(int id) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT " + productColumns() + " FROM product p LEFT JOIN user u ON p.user_id=u.id LEFT JOIN category c ON p.category_id=c.id WHERE p.id=?";
        return r.query(sql, new BeanHandler<Product>(Product.class), id);
    }

    public List<Product> getLatestList(int pageNo, int pageSize) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT " + productColumns() + " FROM product p LEFT JOIN user u ON p.user_id=u.id LEFT JOIN category c ON p.category_id=c.id WHERE p.status=0 ORDER BY p.created_time DESC LIMIT ?,?";
        return r.query(sql, new BeanListHandler<Product>(Product.class), (pageNo - 1) * pageSize, pageSize);
    }

    public List<Product> getHotList(int limit) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT " + productColumns() + " FROM product p LEFT JOIN user u ON p.user_id=u.id LEFT JOIN category c ON p.category_id=c.id WHERE p.status=0 ORDER BY p.views DESC LIMIT ?";
        return r.query(sql, new BeanListHandler<Product>(Product.class), limit);
    }

    public List<Product> getByCategory(int categoryId, int pageNo, int pageSize, String sort) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String orderBy = " ORDER BY p.created_time DESC";
        if ("hot".equals(sort)) orderBy = " ORDER BY p.views DESC";
        else if ("price_asc".equals(sort)) orderBy = " ORDER BY p.price ASC";
        else if ("price_desc".equals(sort)) orderBy = " ORDER BY p.price DESC";

        String sql;
        if (categoryId > 0) {
            sql = "SELECT " + productColumns() + " FROM product p LEFT JOIN user u ON p.user_id=u.id LEFT JOIN category c ON p.category_id=c.id WHERE p.status=0 AND p.category_id=?" + orderBy + " LIMIT ?,?";
            return r.query(sql, new BeanListHandler<Product>(Product.class), categoryId, (pageNo - 1) * pageSize, pageSize);
        } else {
            sql = "SELECT " + productColumns() + " FROM product p LEFT JOIN user u ON p.user_id=u.id LEFT JOIN category c ON p.category_id=c.id WHERE p.status=0" + orderBy + " LIMIT ?,?";
            return r.query(sql, new BeanListHandler<Product>(Product.class), (pageNo - 1) * pageSize, pageSize);
        }
    }

    public int getCountByCategory(int categoryId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql;
        if (categoryId > 0) {
            sql = "SELECT COUNT(*) FROM product WHERE status=0 AND category_id=?";
            return r.query(sql, new ScalarHandler<Long>(), categoryId).intValue();
        } else {
            sql = "SELECT COUNT(*) FROM product WHERE status=0";
            return r.query(sql, new ScalarHandler<Long>()).intValue();
        }
    }

    public void incrementViews(int id) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE product SET views=views+1 WHERE id=?";
        r.update(sql, id);
    }

    public void updateStatus(int id, int status) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE product SET status=? WHERE id=?";
        r.update(sql, status, id);
    }

    public void updateStatus(Connection con, int id, int status) throws SQLException {
        QueryRunner r = new QueryRunner();
        String sql = "UPDATE product SET status=? WHERE id=?";
        r.update(con, sql, status, id);
    }

    public List<Product> search(String keyword, int categoryId, float priceMin, float priceMax, String sort, int pageNo, int pageSize) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        StringBuilder sql = new StringBuilder("SELECT " + productColumns() + " FROM product p LEFT JOIN user u ON p.user_id=u.id LEFT JOIN category c ON p.category_id=c.id WHERE p.status=0");

        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            String[] words = keyword.trim().split("\\s+");
            for (String word : words) {
                if (!word.isEmpty()) {
                    sql.append(" AND p.name LIKE ?");
                    params.add("%" + word + "%");
                }
            }
        }
        if (categoryId > 0) {
            sql.append(" AND p.category_id=?");
            params.add(categoryId);
        }
        if (priceMin > 0) {
            sql.append(" AND p.price>=?");
            params.add(priceMin);
        }
        if (priceMax < Float.MAX_VALUE) {
            sql.append(" AND p.price<=?");
            params.add(priceMax);
        }

        String orderBy = " ORDER BY p.created_time DESC";
        if ("hot".equals(sort)) orderBy = " ORDER BY p.views DESC";
        else if ("price_asc".equals(sort)) orderBy = " ORDER BY p.price ASC";
        else if ("price_desc".equals(sort)) orderBy = " ORDER BY p.price DESC";
        sql.append(orderBy).append(" LIMIT ?,?");
        params.add((pageNo - 1) * pageSize);
        params.add(pageSize);

        return r.query(sql.toString(), new BeanListHandler<Product>(Product.class), params.toArray());
    }

    public int getSearchCount(String keyword, int categoryId, float priceMin, float priceMax) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM product WHERE status=0");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            String[] words = keyword.trim().split("\\s+");
            for (String word : words) {
                if (!word.isEmpty()) {
                    sql.append(" AND name LIKE ?");
                    params.add("%" + word + "%");
                }
            }
        }
        if (categoryId > 0) {
            sql.append(" AND category_id=?");
            params.add(categoryId);
        }
        if (priceMin > 0) {
            sql.append(" AND price>=?");
            params.add(priceMin);
        }
        if (priceMax < Float.MAX_VALUE) {
            sql.append(" AND price<=?");
            params.add(priceMax);
        }
        return r.query(sql.toString(), new ScalarHandler<Long>(), params.toArray()).intValue();
    }

    public List<Product> getByUserId(int userId, int pageNo, int pageSize) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT " + productColumns() + " FROM product p LEFT JOIN user u ON p.user_id=u.id LEFT JOIN category c ON p.category_id=c.id WHERE p.user_id=? ORDER BY p.created_time DESC LIMIT ?,?";
        return r.query(sql, new BeanListHandler<Product>(Product.class), userId, (pageNo - 1) * pageSize, pageSize);
    }

    public int getCountByUserId(int userId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT COUNT(*) FROM product WHERE user_id=?";
        return r.query(sql, new ScalarHandler<Long>(), userId).intValue();
    }
}
package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import model.Cart;
import utils.DataSourceUtils;

public class CartDao {

    public void add(int userId, int productId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        Cart existing = getByUserAndProduct(userId, productId);
        if (existing != null) {
            String sql = "UPDATE cart SET quantity=quantity+1 WHERE user_id=? AND product_id=?";
            r.update(sql, userId, productId);
        } else {
            String sql = "INSERT INTO cart(user_id,product_id,quantity,created_time) VALUES(?,?,1,NOW())";
            r.update(sql, userId, productId);
        }
    }

    public void updateQuantity(int id, int quantity) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE cart SET quantity=? WHERE id=?";
        r.update(sql, quantity, id);
    }

    public void delete(int id) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "DELETE FROM cart WHERE id=?";
        r.update(sql, id);
    }

    public void deleteByUserId(int userId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "DELETE FROM cart WHERE user_id=?";
        r.update(sql, userId);
    }

    public void deleteByIds(int userId, int[] ids) throws SQLException {
        if (ids == null || ids.length == 0) return;
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        StringBuilder sql = new StringBuilder("DELETE FROM cart WHERE user_id=? AND id IN (");
        List<Object> params = new ArrayList<>();
        params.add(userId);
        for (int i = 0; i < ids.length; i++) {
            sql.append("?");
            if (i < ids.length - 1) sql.append(",");
            params.add(ids[i]);
        }
        sql.append(")");
        r.update(sql.toString(), params.toArray());
    }

    public void deleteByProductId(int productId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "DELETE FROM cart WHERE product_id=?";
        r.update(sql, productId);
    }

    public Cart getByUserAndProduct(int userId, int productId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT * FROM cart WHERE user_id=? AND product_id=?";
        return r.query(sql, new BeanHandler<>(Cart.class), userId, productId);
    }

    public List<Cart> findByUserId(int userId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT c.id,c.user_id userId,c.product_id productId,c.quantity,c.created_time createdTime,p.name productName,p.price productPrice,p.image productImage FROM cart c LEFT JOIN product p ON c.product_id=p.id WHERE c.user_id=? ORDER BY c.created_time DESC";
        return r.query(sql, new BeanListHandler<>(Cart.class), userId);
    }

    public int getCount(int userId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT COUNT(*) FROM cart WHERE user_id=?";
        Number count = r.query(sql, new ScalarHandler<>(), userId);
        return count != null ? count.intValue() : 0;
    }
}
package dao;

import model.Product;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DataSourceUtils;

import java.sql.SQLException;
import java.util.List;

public class FavoriteDao {

    public void add(int userId, int productId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "INSERT IGNORE INTO favorite(user_id,product_id) VALUES(?,?)";
        r.update(sql, userId, productId);
    }

    public void remove(int userId, int productId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "DELETE FROM favorite WHERE user_id=? AND product_id=?";
        r.update(sql, userId, productId);
    }

    public boolean isFavorited(int userId, int productId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT COUNT(*) FROM favorite WHERE user_id=? AND product_id=?";
        Long count = r.query(sql, new ScalarHandler<Long>(), userId, productId);
        return count != null && count > 0;
    }

    public List<Product> getFavoritesByUser(int userId, int pageNo, int pageSize) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT p.*,u.name user_name,c.name category_name FROM favorite f LEFT JOIN product p ON f.product_id=p.id LEFT JOIN user u ON p.user_id=u.id LEFT JOIN category c ON p.category_id=c.id WHERE f.user_id=? ORDER BY f.created_time DESC LIMIT ?,?";
        return r.query(sql, new BeanListHandler<Product>(Product.class), userId, (pageNo - 1) * pageSize, pageSize);
    }

    public int getFavoriteCount(int userId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT COUNT(*) FROM favorite WHERE user_id=?";
        return r.query(sql, new ScalarHandler<Long>(), userId).intValue();
    }
}
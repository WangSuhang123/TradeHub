package dao;

import model.Category;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import utils.DataSourceUtils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {

    public List<Category> getAllCategories() {
        try {
            QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
            String sql = "SELECT * FROM category";
            return r.query(sql, new BeanListHandler<Category>(Category.class));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new ArrayList<Category>();
    }

    public void add(Category category) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "INSERT INTO category(name,description) VALUES(?,?)";
        r.update(sql, category.getName(), category.getDescription());
    }

    public void update(Category category) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE category SET name=?,description=? WHERE id=?";
        r.update(sql, category.getName(), category.getDescription(), category.getId());
    }

    public void delete(int id) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "DELETE FROM category WHERE id=?";
        r.update(sql, id);
    }

    public Category getById(int id) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT * FROM category WHERE id=?";
        List<Category> list = r.query(sql, new BeanListHandler<Category>(Category.class), id);
        return list.isEmpty() ? null : list.get(0);
    }
}
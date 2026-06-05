package dao;

import model.Carousel;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import utils.DataSourceUtils;

import java.sql.SQLException;
import java.util.List;

public class CarouselDao {

    public void insert(Carousel c) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "INSERT INTO carousel(title,image,link,sort_order,status) VALUES(?,?,?,?,?)";
        r.update(sql, c.getTitle(), c.getImage(), c.getLink(), c.getSortOrder(), c.getStatus());
    }

    public void update(Carousel c) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE carousel SET title=?,image=?,link=?,sort_order=?,status=? WHERE id=?";
        r.update(sql, c.getTitle(), c.getImage(), c.getLink(), c.getSortOrder(), c.getStatus(), c.getId());
    }

    public void delete(int id) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "DELETE FROM carousel WHERE id=?";
        r.update(sql, id);
    }

    public Carousel getById(int id) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT id,title,image,link,sort_order sortOrder,status FROM carousel WHERE id=?";
        return r.query(sql, new BeanHandler<>(Carousel.class), id);
    }

    public List<Carousel> findAll() throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT id,title,image,link,sort_order sortOrder,status FROM carousel ORDER BY sort_order ASC, id ASC";
        return r.query(sql, new BeanListHandler<>(Carousel.class));
    }

    public List<Carousel> findActive() throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT id,title,image,link,sort_order sortOrder,status FROM carousel WHERE status=1 ORDER BY sort_order ASC, id ASC";
        return r.query(sql, new BeanListHandler<>(Carousel.class));
    }

    public void updateSortOrder(int id, int sortOrder) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE carousel SET sort_order=? WHERE id=?";
        r.update(sql, sortOrder, id);
    }

    public void updateStatus(int id, int status) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE carousel SET status=? WHERE id=?";
        r.update(sql, status, id);
    }
}

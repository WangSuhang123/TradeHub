package dao;

import model.Order;
import model.OrderItem;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DataSourceUtils;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {

    public void insertOrder(Connection con, Order order) throws SQLException {
        QueryRunner r = new QueryRunner();
        String sql = "INSERT INTO `order`(total,status,name,phone,address,seller_msg,datetime,buyer_id,seller_id) VALUES(?,?,?,?,?,?,?,?,?)";
        r.update(con, sql,
                order.getTotal(), order.getStatus(), order.getName(), order.getPhone(),
                order.getAddress(), order.getSellerMsg(), order.getDatetime(),
                order.getBuyerId(), order.getSellerId());
    }

    public int getLastInsertId(Connection con) throws SQLException {
        QueryRunner r = new QueryRunner();
        String sql = "SELECT LAST_INSERT_ID()";
        Number result = r.query(con, sql, new ScalarHandler<Number>());
        return result.intValue();
    }

    public void insertOrderItem(Connection con, OrderItem item) throws SQLException {
        QueryRunner r = new QueryRunner();
        String sql = "INSERT INTO orderitem(price,product_id,order_id) VALUES(?,?,?)";
        r.update(con, sql, item.getPrice(), item.getProductId(), item.getOrderId());
    }

    public List<Order> selectByBuyer(int buyerId, int pageNo, int pageSize) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT o.id,o.total,o.status,o.name,o.phone,o.address,o.seller_msg sellerMsg,o.datetime,o.buyer_id buyerId,o.seller_id sellerId,b.name buyerName,b.phone buyerPhone,s.name sellerName,s.phone sellerPhone FROM `order` o LEFT JOIN user b ON o.buyer_id=b.id LEFT JOIN user s ON o.seller_id=s.id WHERE o.buyer_id=? ORDER BY o.datetime DESC LIMIT ?,?";
        return r.query(sql, new BeanListHandler<Order>(Order.class), buyerId, (pageNo - 1) * pageSize, pageSize);
    }

    public List<Order> selectBySeller(int sellerId, int pageNo, int pageSize) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT o.id,o.total,o.status,o.name,o.phone,o.address,o.seller_msg sellerMsg,o.datetime,o.buyer_id buyerId,o.seller_id sellerId,b.name buyerName,b.phone buyerPhone,s.name sellerName,s.phone sellerPhone FROM `order` o LEFT JOIN user b ON o.buyer_id=b.id LEFT JOIN user s ON o.seller_id=s.id WHERE o.seller_id=? ORDER BY o.datetime DESC LIMIT ?,?";
        return r.query(sql, new BeanListHandler<Order>(Order.class), sellerId, (pageNo - 1) * pageSize, pageSize);
    }

    public Order selectById(int id) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT o.id,o.total,o.status,o.name,o.phone,o.address,o.seller_msg sellerMsg,o.datetime,o.buyer_id buyerId,o.seller_id sellerId,b.name buyerName,b.phone buyerPhone,s.name sellerName,s.phone sellerPhone FROM `order` o LEFT JOIN user b ON o.buyer_id=b.id LEFT JOIN user s ON o.seller_id=s.id WHERE o.id=?";
        return r.query(sql, new BeanHandler<Order>(Order.class), id);
    }

    public List<OrderItem> selectOrderItems(int orderId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT oi.id,oi.price,oi.product_id productId,oi.order_id orderId,p.name productName FROM orderitem oi LEFT JOIN product p ON oi.product_id=p.id WHERE oi.order_id=?";
        return r.query(sql, new BeanListHandler<OrderItem>(OrderItem.class), orderId);
    }

    public void updateStatus(int id, int status) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE `order` SET status=? WHERE id=?";
        r.update(sql, status, id);
    }

    public void updateStatus(Connection con, int id, int status) throws SQLException {
        QueryRunner r = new QueryRunner();
        String sql = "UPDATE `order` SET status=? WHERE id=?";
        r.update(con, sql, status, id);
    }

    public int getOrderCountByBuyer(int buyerId, int status) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql;
        if (status >= 0) {
            sql = "SELECT COUNT(*) FROM `order` WHERE buyer_id=? AND status=?";
            return r.query(sql, new ScalarHandler<Long>(), buyerId, status).intValue();
        } else {
            sql = "SELECT COUNT(*) FROM `order` WHERE buyer_id=?";
            return r.query(sql, new ScalarHandler<Long>(), buyerId).intValue();
        }
    }

    public int getOrderCountBySeller(int sellerId, int status) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql;
        if (status >= 0) {
            sql = "SELECT COUNT(*) FROM `order` WHERE seller_id=? AND status=?";
            return r.query(sql, new ScalarHandler<Long>(), sellerId, status).intValue();
        } else {
            sql = "SELECT COUNT(*) FROM `order` WHERE seller_id=?";
            return r.query(sql, new ScalarHandler<Long>(), sellerId).intValue();
        }
    }

    public void deleteOrder(Connection con, int id) throws SQLException {
        QueryRunner r = new QueryRunner();
        String sql = "DELETE FROM `order` WHERE id=?";
        r.update(con, sql, id);
    }

    public void deleteOrderItem(Connection con, int orderId) throws SQLException {
        QueryRunner r = new QueryRunner();
        String sql = "DELETE FROM orderitem WHERE order_id=?";
        r.update(con, sql, orderId);
    }
}
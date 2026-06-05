package service;

import dao.OrderDao;
import dao.ProductDao;
import model.Order;
import model.OrderItem;
import model.Page;
import utils.DataSourceUtils;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class OrderService {
    private OrderDao oDao = new OrderDao();
    private ProductDao pDao = new ProductDao();

    public boolean addOrder(Order order) {
        Connection con = null;
        try {
            con = DataSourceUtils.getConnection();
            con.setAutoCommit(false);

            oDao.insertOrder(con, order);
            int id = oDao.getLastInsertId(con);
            order.setId(id);

            for (OrderItem item : order.getItemList()) {
                item.setOrderId(id);
                oDao.insertOrderItem(con, item);
                pDao.updateStatus(con, item.getProductId(), 1);
            }

            con.commit();
            return true;
        } catch (SQLException e) {
            try {
                if (con != null) con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        }
    }

    public void cancelOrder(int orderId) {
        Connection con = null;
        try {
            con = DataSourceUtils.getConnection();
            con.setAutoCommit(false);

            Order order = oDao.selectById(orderId);
            if (order != null && order.getStatus() == 0) {
                oDao.updateStatus(con, orderId, 4);
                List<OrderItem> items = oDao.selectOrderItems(orderId);
                for (OrderItem item : items) {
                    pDao.updateStatus(con, item.getProductId(), 0);
                }
            }

            con.commit();
        } catch (SQLException e) {
            try {
                if (con != null) con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }
    }

    public void payOrder(int orderId) {
        try {
            oDao.updateStatus(orderId, 1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void shipOrder(int orderId) {
        try {
            oDao.updateStatus(orderId, 2);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void confirmReceive(int orderId) {
        try {
            oDao.updateStatus(orderId, 3);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        Connection con = null;
        try {
            con = DataSourceUtils.getConnection();
            con.setAutoCommit(false);
            oDao.deleteOrderItem(con, id);
            oDao.deleteOrder(con, id);
            con.commit();
        } catch (SQLException e) {
            try {
                if (con != null) con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }
    }

    public List<Order> selectByBuyer(int buyerId, int pageNo, int pageSize) {
        try {
            List<Order> orders = oDao.selectByBuyer(buyerId, pageNo, pageSize);
            for (Order order : orders) {
                order.setItemList(oDao.selectOrderItems(order.getId()));
            }
            return orders;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Order> selectBySeller(int sellerId, int pageNo, int pageSize) {
        try {
            List<Order> orders = oDao.selectBySeller(sellerId, pageNo, pageSize);
            for (Order order : orders) {
                order.setItemList(oDao.selectOrderItems(order.getId()));
            }
            return orders;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Order selectById(int id) {
        try {
            Order order = oDao.selectById(id);
            if (order != null) {
                List<OrderItem> items = oDao.selectOrderItems(id);
                order.setItemList(items);
            }
            return order;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateStatus(int id, int status) {
        try {
            oDao.updateStatus(id, status);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
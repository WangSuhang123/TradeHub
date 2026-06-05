package service;

import java.sql.SQLException;
import java.util.List;
import dao.CartDao;
import model.Cart;

public class CartService {
    private CartDao cDao = new CartDao();

    public void add(int userId, int productId) {
        try {
            cDao.add(userId, productId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateQuantity(int id, int quantity) {
        try {
            cDao.updateQuantity(id, quantity);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        try {
            cDao.delete(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void clear(int userId) {
        try {
            cDao.deleteByUserId(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteByIds(int userId, int[] ids) {
        try {
            cDao.deleteByIds(userId, ids);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteByProductId(int productId) {
        try {
            cDao.deleteByProductId(productId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Cart> getCartList(int userId) {
        try {
            return cDao.findByUserId(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getCartCount(int userId) {
        try {
            return cDao.getCount(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void deleteByUserId(int userId) {
        try {
            cDao.deleteByUserId(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
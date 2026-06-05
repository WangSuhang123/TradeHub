package service;

import dao.FavoriteDao;
import model.Product;

import java.sql.SQLException;
import java.util.List;

public class FavoriteService {
    private FavoriteDao fDao = new FavoriteDao();

    public boolean add(int userId, int productId) {
        try {
            fDao.add(userId, productId);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean remove(int userId, int productId) {
        try {
            fDao.remove(userId, productId);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isFavorited(int userId, int productId) {
        try {
            return fDao.isFavorited(userId, productId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Product> getFavoritesByUser(int userId, int pageNo, int pageSize) {
        try {
            return fDao.getFavoritesByUser(userId, pageNo, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getFavoriteCount(int userId) {
        try {
            return fDao.getFavoriteCount(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
package service;

import dao.ProductDao;
import model.Page;
import model.Product;

import java.sql.SQLException;
import java.util.List;

public class ProductService {
    private ProductDao pDao = new ProductDao();

    public void insert(Product p) {
        try {
            pDao.insert(p);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Product p) {
        try {
            pDao.update(p);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        try {
            pDao.delete(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Product getById(int id) {
        try {
            return pDao.getById(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> getLatestList(int pageNo, int pageSize) {
        try {
            return pDao.getLatestList(pageNo, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> getHotList(int limit) {
        try {
            return pDao.getHotList(limit);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Page getProductPage(int categoryId, int pageNumber, String sort) {
        Page p = new Page();
        p.setPageNumber(pageNumber);
        try {
            int totalCount = pDao.getCountByCategory(categoryId);
            p.SetPageSizeAndTotalCount(12, totalCount);
            List list = pDao.getByCategory(categoryId, pageNumber, 12, sort);
            p.setList(list);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return p;
    }

    public void incrementViews(int id) {
        try {
            pDao.incrementViews(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateStatus(int id, int status) {
        try {
            pDao.updateStatus(id, status);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Page search(String keyword, int categoryId, float priceMin, float priceMax, String sort, int pageNumber) {
        Page p = new Page();
        p.setPageNumber(pageNumber);
        try {
            int totalCount = pDao.getSearchCount(keyword, categoryId, priceMin, priceMax);
            p.SetPageSizeAndTotalCount(12, totalCount);
            List list = pDao.search(keyword, categoryId, priceMin, priceMax, sort, pageNumber, 12);
            p.setList(list);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return p;
    }

    public List<Product> getByUserId(int userId, int pageNo, int pageSize) {
        try {
            return pDao.getByUserId(userId, pageNo, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getCountByUserId(int userId) {
        try {
            return pDao.getCountByUserId(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
package service;

import dao.CategoryDao;
import model.Category;

import java.sql.SQLException;
import java.util.List;

public class CategoryService {
    private CategoryDao cDao = new CategoryDao();

    public List<Category> getAllCategories() {
        return cDao.getAllCategories();
    }

    public void add(Category category) {
        try {
            cDao.add(category);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Category category) {
        try {
            cDao.update(category);
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

    public Category getById(int id) {
        try {
            return cDao.getById(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
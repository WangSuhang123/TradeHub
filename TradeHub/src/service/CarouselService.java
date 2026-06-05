package service;

import dao.CarouselDao;
import model.Carousel;

import java.sql.SQLException;
import java.util.List;

public class CarouselService {
    private CarouselDao cDao = new CarouselDao();

    public void add(Carousel c) {
        try {
            cDao.insert(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Carousel c) {
        try {
            cDao.update(c);
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

    public Carousel getById(int id) {
        try {
            return cDao.getById(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Carousel> getAll() {
        try {
            return cDao.findAll();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Carousel> getActive() {
        try {
            return cDao.findActive();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateSortOrder(int id, int sortOrder) {
        try {
            cDao.updateSortOrder(id, sortOrder);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void toggleStatus(int id) {
        try {
            Carousel c = cDao.getById(id);
            if (c != null) {
                cDao.updateStatus(id, c.getStatus() == 1 ? 0 : 1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

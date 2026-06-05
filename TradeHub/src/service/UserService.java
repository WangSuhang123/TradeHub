package service;

import dao.UserDao;
import model.Page;
import model.User;

import java.sql.SQLException;
import java.util.List;

public class UserService {
    private UserDao uDao = new UserDao();

    public User login(String studentId, String password) {
        try {
            return uDao.selectByStudentIdPassword(studentId, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean register(User user) {
        try {
            if (uDao.isStudentIdExist(user.getStudentId())) return false;
            if (uDao.isUsernameExist(user.getUsername())) return false;
            if (user.getEmail() != null && !user.getEmail().isEmpty() && uDao.isEmailExist(user.getEmail())) return false;
            uDao.addUser(user);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User selectById(int id) {
        try {
            return uDao.selectById(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateUser(User user) {
        try {
            uDao.updateUser(user);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updatePwd(int id, String newPwd) {
        try {
            uDao.updatePwd(id, newPwd);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void banUser(int id, int status) {
        try {
            uDao.updateStatus(id, status);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getUserCount() {
        try {
            return uDao.getUserCount();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Page getUserPage(int pageNumber) {
        Page p = new Page();
        p.setPageNumber(pageNumber);
        int totalCount = 0;
        try {
            totalCount = uDao.getUserCount();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        p.SetPageSizeAndTotalCount(10, totalCount);
        try {
            java.util.List list = uDao.getUserPage(pageNumber, 10);
            p.setList(list);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return p;
    }
}
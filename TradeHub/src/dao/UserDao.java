package dao;

import model.User;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DataSourceUtils;

import java.sql.SQLException;
import java.util.List;

public class UserDao {
    public void addUser(User user) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "INSERT INTO user(username,student_id,email,password,name,phone,address,avatar,school,qq,isadmin,status) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
        r.update(sql, user.getUsername(), user.getStudentId(), user.getEmail(), user.getPassword(),
                user.getName(), user.getPhone(), user.getAddress(), user.getAvatar(),
                user.getSchool(), user.getQq(), user.isIsadmin(), user.getStatus());
    }

    public boolean isStudentIdExist(String studentId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT * FROM user WHERE student_id = ?";
        User u = r.query(sql, new BeanHandler<User>(User.class), studentId);
        return u != null;
    }

    public boolean isUsernameExist(String username) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT * FROM user WHERE username = ?";
        User u = r.query(sql, new BeanHandler<User>(User.class), username);
        return u != null;
    }

    public boolean isEmailExist(String email) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT * FROM user WHERE email = ?";
        User u = r.query(sql, new BeanHandler<User>(User.class), email);
        return u != null;
    }

    public User selectByStudentIdPassword(String studentId, String password) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT * FROM user WHERE student_id=? AND password=? AND status=1";
        return r.query(sql, new BeanHandler<User>(User.class), studentId, password);
    }

    public User selectById(int id) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT * FROM user WHERE id=?";
        return r.query(sql, new BeanHandler<User>(User.class), id);
    }

    public void updateUser(User user) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE user SET name=?, phone=?, address=?, avatar=?, school=?, qq=? WHERE id=?";
        r.update(sql, user.getName(), user.getPhone(), user.getAddress(), user.getAvatar(),
                user.getSchool(), user.getQq(), user.getId());
    }

    public void updatePwd(int userId, String newPwd) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE user SET password=? WHERE id=?";
        r.update(sql, newPwd, userId);
    }

    public void updateStatus(int id, int status) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE user SET status=? WHERE id=?";
        r.update(sql, status, id);
    }

    public int getUserCount() throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT COUNT(*) FROM user";
        return r.query(sql, new ScalarHandler<Long>()).intValue();
    }

    public List<User> getUserPage(int pageNo, int pageSize) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT * FROM user ORDER BY id LIMIT ?,?";
        return r.query(sql, new BeanListHandler<User>(User.class), (pageNo - 1) * pageSize, pageSize);
    }

    public int selectUserCount() throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT COUNT(*) FROM user";
        return r.query(sql, new ScalarHandler<Long>()).intValue();
    }
}
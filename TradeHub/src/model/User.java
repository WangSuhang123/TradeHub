package model;

public class User {
    private int id;
    private String username;
    private String studentId;
    private String email;
    private String password;
    private String name;
    private String phone;
    private String address;
    private String avatar;
    private String school;
    private String qq;
    private boolean isadmin = false;
    private int status = 1;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public boolean isIsadmin() {
        return isadmin;
    }

    public void setIsadmin(boolean isadmin) {
        this.isadmin = isadmin;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public User() {
        super();
    }

    public User(String username, String studentId, String email, String password, String name, String phone, String school) {
        this.username = username;
        this.studentId = studentId;
        this.email = email;
        this.password = password;
        this.name = name;
        this.phone = phone;
        this.school = school;
        this.isadmin = false;
        this.status = 1;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", username=" + username + ", studentId=" + studentId + ", email=" + email
                + ", password=" + password + ", name=" + name + ", phone=" + phone + ", address=" + address
                + ", avatar=" + avatar + ", school=" + school + ", qq=" + qq + ", isadmin=" + isadmin
                + ", status=" + status + "]";
    }
}
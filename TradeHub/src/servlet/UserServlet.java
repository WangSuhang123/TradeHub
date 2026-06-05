package servlet;

import model.Page;
import model.Product;
import model.User;
import service.ProductService;
import service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserServlet extends BaseServlet {
    private UserService uService = new UserService();
    private ProductService pService = new ProductService();

    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "/user_login.jsp";
    }

    public String login(HttpServletRequest request, HttpServletResponse response) {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            return "/user_login.jsp";
        }
        String studentId = request.getParameter("student_id");
        String password = request.getParameter("password");
        User user = uService.login(studentId, password);
        if (user == null) {
            request.setAttribute("failMsg", "学号或密码错误，请重新登录！");
            return "/user_login.jsp";
        }
        if (user.getStatus() == 0) {
            request.setAttribute("failMsg", "您的账号已被封禁，请联系管理员！");
            return "/user_login.jsp";
        }
        request.getSession().setAttribute("user", user);
        return "redirect:/index";
    }

    public String register(HttpServletRequest request, HttpServletResponse response) {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            return "/user_register.jsp";
        }
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        if (!password.equals(confirmPassword)) {
            request.setAttribute("failMsg", "两次密码不一致！");
            return "/user_register.jsp";
        }
        User user = new User();
        user.setUsername(request.getParameter("username"));
        user.setStudentId(request.getParameter("student_id"));
        user.setPassword(password);
        user.setName(request.getParameter("name"));
        user.setPhone(request.getParameter("phone"));
        user.setSchool(request.getParameter("school"));
        user.setEmail(request.getParameter("email"));
        user.setQq(request.getParameter("qq"));
        user.setIsadmin(false);
        user.setStatus(1);
        if (uService.register(user)) {
            request.setAttribute("msg", "注册成功，请登录！");
        } else {
            request.setAttribute("failMsg", "学号或用户名已被注册！");
        }
        return "/user_register.jsp";
    }

    public String logout(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().invalidate();
        return "redirect:/index";
    }

    public String center(HttpServletRequest request, HttpServletResponse response) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/user?method=login";
        }
        User user = uService.selectById(sessionUser.getId());
        request.setAttribute("user", user);
        return "/user_center.jsp";
    }

    public String changeAddress(HttpServletRequest request, HttpServletResponse response) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/user?method=login";
        }
        User user = uService.selectById(sessionUser.getId());
        user.setName(request.getParameter("name"));
        user.setPhone(request.getParameter("phone"));
        user.setAddress(request.getParameter("address"));
        user.setSchool(request.getParameter("school"));
        user.setQq(request.getParameter("qq"));
        uService.updateUser(user);
        request.getSession().setAttribute("user", user);
        request.setAttribute("msg", "信息修改成功！");
        return "/user_center.jsp";
    }

    public String changePwd(HttpServletRequest request, HttpServletResponse response) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/user?method=login";
        }
        String oldPwd = request.getParameter("password");
        String newPwd = request.getParameter("newPassword");
        if (!sessionUser.getPassword().equals(oldPwd)) {
            request.setAttribute("failMsg", "原密码错误！");
            return "/user_center.jsp";
        }
        uService.updatePwd(sessionUser.getId(), newPwd);
        sessionUser.setPassword(newPwd);
        request.getSession().setAttribute("user", sessionUser);
        request.setAttribute("msg", "密码修改成功！");
        return "/user_center.jsp";
    }

    public String myProducts(HttpServletRequest request, HttpServletResponse response) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/user?method=login";
        }
        int pageNumber = 1;
        if (request.getParameter("pageNumber") != null) {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }
        Page p = new Page();
        p.setPageNumber(pageNumber);
        int totalCount = pService.getCountByUserId(sessionUser.getId());
        p.SetPageSizeAndTotalCount(10, totalCount);
        java.util.List<Product> list = pService.getByUserId(sessionUser.getId(), pageNumber, 10);
        p.setList((java.util.List) list);
        request.setAttribute("p", p);
        return "/user_products.jsp";
    }

    public String myFavorites(HttpServletRequest request, HttpServletResponse response) {
        return "redirect:/favorite?method=list";
    }
}
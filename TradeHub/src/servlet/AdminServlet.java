package servlet;

import model.Category;
import model.Page;
import model.Product;
import model.User;
import service.CategoryService;
import service.ProductService;
import service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminServlet extends BaseServlet {
    private UserService uService = new UserService();
    private ProductService pService = new ProductService();
    private CategoryService cService = new CategoryService();

    public String index(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("userCount", uService.getUserCount());
        int productCount = pService.getCountByUserId(0);
        request.setAttribute("categoryList", cService.getAllCategories());
        return "/admin/index.jsp";
    }

    public String userList(HttpServletRequest request, HttpServletResponse response) {
        int pageNumber = 1;
        if (request.getParameter("pageNumber") != null) {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }
        Page p = uService.getUserPage(pageNumber);
        request.setAttribute("p", p);
        return "/admin/user_list.jsp";
    }

    public String banUser(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        int status = Integer.parseInt(request.getParameter("status"));
        uService.banUser(id, status);
        return "redirect:/admin?method=userList";
    }

    public String productList(HttpServletRequest request, HttpServletResponse response) {
        int pageNumber = 1;
        if (request.getParameter("pageNumber") != null) {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }
        Page p = pService.getProductPage(0, pageNumber, "newest");
        request.setAttribute("p", p);
        return "/admin/product_list.jsp";
    }

    public String offShelf(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = pService.getById(id);
        if (product != null && product.getStatus() != 2) {
            pService.updateStatus(id, 2);
        }
        return "redirect:/admin?method=productList";
    }

    public String categoryList(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("categoryList", cService.getAllCategories());
        return "/admin/category_list.jsp";
    }

    public String categoryAdd(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        Category category = new Category();
        category.setName(name);
        category.setDescription(description);
        cService.add(category);
        return "redirect:/admin?method=categoryList";
    }

    public String categoryEdit(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        Category category = new Category();
        category.setId(id);
        category.setName(name);
        category.setDescription(description);
        cService.update(category);
        return "redirect:/admin?method=categoryList";
    }

    public String categoryDelete(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        cService.delete(id);
        return "redirect:/admin?method=categoryList";
    }
}
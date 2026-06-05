package servlet;

import model.Page;
import model.Product;
import model.User;
import service.FavoriteService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class FavoriteServlet extends BaseServlet {
    private FavoriteService fService = new FavoriteService();

    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "/user_favorites.jsp";
    }

    public String add(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "json:{\"ok\":false,\"msg\":\"请先登录\"}";
        }
        int productId = Integer.parseInt(request.getParameter("productId"));
        fService.add(user.getId(), productId);
        return "json:{\"ok\":true}";
    }

    public String remove(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "json:{\"ok\":false,\"msg\":\"请先登录\"}";
        }
        int productId = Integer.parseInt(request.getParameter("productId"));
        fService.remove(user.getId(), productId);
        return "json:{\"ok\":true}";
    }

    public String list(HttpServletRequest request, HttpServletResponse response) {
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
        int totalCount = fService.getFavoriteCount(sessionUser.getId());
        p.SetPageSizeAndTotalCount(10, totalCount);
        List<Product> list = fService.getFavoritesByUser(sessionUser.getId(), pageNumber, 10);
        p.setList((java.util.List) list);
        request.setAttribute("p", p);
        return "/user_favorites.jsp";
    }
}
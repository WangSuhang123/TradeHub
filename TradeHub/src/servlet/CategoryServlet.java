package servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CategoryServlet extends BaseServlet {

    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "/admin/category_list.jsp";
    }
}
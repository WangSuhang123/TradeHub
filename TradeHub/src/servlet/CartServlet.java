package servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Cart;
import model.Product;
import model.User;
import service.CartService;
import service.ProductService;

@WebServlet("/cart")
public class CartServlet extends BaseServlet {
    private CartService cService = new CartService();
    private ProductService pService = new ProductService();

    public void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User u = (User) request.getSession().getAttribute("user");
        if (u == null) {
            writeJson(response, "{\"success\":false,\"message\":\"请登录后操作\"}");
            return;
        }
        int productId = Integer.parseInt(request.getParameter("productId"));
        Product product = pService.getById(productId);
        if (product != null && product.getUserId() == u.getId()) {
            writeJson(response, "{\"success\":false,\"message\":\"不能添加自己的商品\"}");
            return;
        }
        cService.add(u.getId(), productId);
        writeJson(response, "{\"success\":true,\"message\":\"已加入购物车\"}");
    }

    private void writeJson(HttpServletResponse response, String json) throws IOException {
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().print(json);
    }

    public void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User u = (User) request.getSession().getAttribute("user");
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/user?method=login");
            return;
        }
        List<Cart> cartList = cService.getCartList(u.getId());
        float total = 0;
        if (cartList != null) {
            for (Cart c : cartList) {
                total += c.getSubtotal();
            }
        }
        request.setAttribute("cartList", cartList);
        request.setAttribute("total", total);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    public void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User u = (User) request.getSession().getAttribute("user");
        if (u == null) {
            writeJson(response, "{\"success\":false,\"message\":\"请登录后操作\"}");
            return;
        }
        int id = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        if (quantity < 1) quantity = 1;
        if (quantity > 99) quantity = 99;
        cService.updateQuantity(id, quantity);
        writeJson(response, "{\"success\":true}");
    }

    public void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User u = (User) request.getSession().getAttribute("user");
        if (u == null) {
            writeJson(response, "{\"success\":false,\"message\":\"请登录后操作\"}");
            return;
        }
        int id = Integer.parseInt(request.getParameter("id"));
        cService.delete(id);
        writeJson(response, "{\"success\":true}");
    }

    public void batchDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User u = (User) request.getSession().getAttribute("user");
        if (u == null) {
            writeJson(response, "{\"success\":false,\"message\":\"请登录后操作\"}");
            return;
        }
        String[] idStrs = request.getParameterValues("ids");
        if (idStrs != null) {
            int[] ids = new int[idStrs.length];
            for (int i = 0; i < idStrs.length; i++) {
                ids[i] = Integer.parseInt(idStrs[i]);
            }
            cService.deleteByIds(u.getId(), ids);
        }
        writeJson(response, "{\"success\":true}");
    }

    public void count(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User u = (User) request.getSession().getAttribute("user");
        int count = 0;
        if (u != null) {
            count = cService.getCartCount(u.getId());
        }
        writeJson(response, "{\"count\":" + count + "}");
    }

    public void checkout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User u = (User) request.getSession().getAttribute("user");
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/user?method=login");
            return;
        }
        String[] idStrs = request.getParameterValues("ids");
        if (idStrs == null || idStrs.length == 0) {
            response.sendRedirect(request.getContextPath() + "/cart?method=list");
            return;
        }
        List<Cart> cartList = cService.getCartList(u.getId());
        float total = 0;
        StringBuilder productIds = new StringBuilder();
        if (cartList != null) {
            for (String idStr : idStrs) {
                int cartId = Integer.parseInt(idStr);
                for (Cart c : cartList) {
                    if (c.getId() == cartId) {
                        total += c.getSubtotal();
                        if (productIds.length() > 0) productIds.append(",");
                        productIds.append(c.getProductId());
                        break;
                    }
                }
            }
        }
        request.setAttribute("selectedIds", idStrs);
        request.setAttribute("productIds", productIds.toString());
        request.setAttribute("cartList", cartList);
        request.setAttribute("total", total);
        request.getRequestDispatcher("/order_submit.jsp").forward(request, response);
    }

    public void clearAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User u = (User) request.getSession().getAttribute("user");
        if (u == null) {
            writeJson(response, "{\"success\":false,\"message\":\"请登录后操作\"}");
            return;
        }
        cService.clear(u.getId());
        writeJson(response, "{\"success\":true}");
    }
}
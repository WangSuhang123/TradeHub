package servlet;

import model.Order;
import model.OrderItem;
import model.Product;
import model.User;
import service.OrderService;
import service.ProductService;
import service.CartService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderServlet extends BaseServlet {
    private OrderService oService = new OrderService();
    private ProductService pService = new ProductService();

    public String index(HttpServletRequest request, HttpServletResponse response) {
        return myOrders(request, response);
    }

    public String submit(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/user?method=login";
        }
        int productId = Integer.parseInt(request.getParameter("productId"));
        Product product = pService.getById(productId);
        if (product == null || product.getStatus() != 0) {
            return "redirect:/product?method=list";
        }
        request.setAttribute("product", product);
        return "/order_submit.jsp";
    }

    public String confirm(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/user?method=login";
        }
        int productId = Integer.parseInt(request.getParameter("productId"));
        Product product = pService.getById(productId);
        if (product == null || product.getStatus() != 0) {
            return "redirect:/product?method=list";
        }
        if (product.getUserId() == user.getId()) {
            request.setAttribute("product", product);
            request.setAttribute("failMsg", "不能购买自己发布的商品");
            return "/order_submit.jsp";
        }

        Order order = new Order();
        order.setTotal(product.getPrice());
        order.setStatus(0);
        order.setName(request.getParameter("name"));
        order.setPhone(request.getParameter("phone"));
        order.setAddress(request.getParameter("address"));
        order.setSellerMsg(request.getParameter("seller_msg"));
        order.setDatetime(new Date());
        order.setBuyerId(user.getId());
        order.setSellerId(product.getUserId());

        OrderItem item = new OrderItem();
        item.setPrice(product.getPrice());
        item.setProductId(productId);
        List<OrderItem> itemList = new ArrayList<OrderItem>();
        itemList.add(item);
        order.setItemList(itemList);

        if (!oService.addOrder(order)) {
            request.setAttribute("product", product);
            request.setAttribute("failMsg", "订单创建失败，请稍后重试");
            return "/order_submit.jsp";
        }
        return "redirect:/order?method=myOrders";
    }

    public String confirmCart(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/user?method=login";
        }
        String productIdsParam = request.getParameter("productIds");
        if (productIdsParam == null || productIdsParam.isEmpty()) {
            return "redirect:/cart?method=list";
        }
        String[] productIds = productIdsParam.split(",");
        CartService cartService = new CartService();
        int orderCount = 0;
        for (String pid : productIds) {
            try {
                int productId = Integer.parseInt(pid.trim());
                Product product = pService.getById(productId);
                if (product == null || product.getStatus() != 0) continue;
                if (product.getUserId() == user.getId()) continue;

                Order order = new Order();
                order.setTotal(product.getPrice());
                order.setStatus(0);
                order.setName(request.getParameter("name"));
                order.setPhone(request.getParameter("phone"));
                order.setAddress(request.getParameter("address"));
                order.setSellerMsg(request.getParameter("seller_msg"));
                order.setDatetime(new Date());
                order.setBuyerId(user.getId());
                order.setSellerId(product.getUserId());

                OrderItem item = new OrderItem();
                item.setPrice(product.getPrice());
                item.setProductId(productId);
                List<OrderItem> itemList = new ArrayList<OrderItem>();
                itemList.add(item);
                order.setItemList(itemList);

                if (oService.addOrder(order)) {
                    orderCount++;
                }
            } catch (NumberFormatException e) {
                continue;
            }
        }
        cartService.deleteByUserId(user.getId());
        return "redirect:/order?method=myOrders";
    }

    public String myOrders(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/user?method=login";
        }

        String tab = request.getParameter("tab");
        if (tab == null) tab = "buyer";

        List<Order> buyerOrders = oService.selectByBuyer(user.getId(), 1, 50);
        List<Order> sellerOrders = oService.selectBySeller(user.getId(), 1, 50);

        request.setAttribute("buyerOrders", buyerOrders);
        request.setAttribute("sellerOrders", sellerOrders);
        request.setAttribute("tab", tab);
        return "/order_list.jsp";
    }

    public String pay(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/user?method=login";
        }
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order order = oService.selectById(orderId);
        if (order != null && order.getBuyerId() == user.getId() && order.getStatus() == 0) {
            oService.payOrder(orderId);
        }
        return "redirect:/order?method=myOrders";
    }

    public String ship(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/user?method=login";
        }
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order order = oService.selectById(orderId);
        if (order != null && order.getSellerId() == user.getId() && order.getStatus() == 1) {
            oService.shipOrder(orderId);
        }
        return "redirect:/order?method=myOrders";
    }

    public String confirmReceive(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/user?method=login";
        }
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order order = oService.selectById(orderId);
        if (order != null && order.getBuyerId() == user.getId() && order.getStatus() == 2) {
            oService.confirmReceive(orderId);
        }
        return "redirect:/order?method=myOrders";
    }

    public String cancel(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/user?method=login";
        }
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order order = oService.selectById(orderId);
        if (order != null && order.getStatus() == 0) {
            if (order.getBuyerId() == user.getId() || order.getSellerId() == user.getId()) {
                oService.cancelOrder(orderId);
            }
        }
        return "redirect:/order?method=myOrders";
    }
}
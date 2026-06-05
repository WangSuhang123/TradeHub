package servlet;

import model.Page;
import model.Product;
import model.User;
import service.CategoryService;
import service.ProductService;
import service.CartService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.util.UUID;

public class ProductServlet extends BaseServlet {
    private ProductService pService = new ProductService();
    private CategoryService cService = new CategoryService();
    private CartService cartService = new CartService();

    public String index(HttpServletRequest request, HttpServletResponse response) {
        return list(request, response);
    }

    public String list(HttpServletRequest request, HttpServletResponse response) {
        int categoryId = 0;
        int pageNumber = 1;
        String sort = request.getParameter("sort");
        if (request.getParameter("categoryId") != null)
            categoryId = Integer.parseInt(request.getParameter("categoryId"));
        if (request.getParameter("pageNumber") != null)
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        if (sort == null) sort = "newest";

        Page p = pService.getProductPage(categoryId, pageNumber, sort);
        request.setAttribute("p", p);
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("sort", sort);
        return "/product_list.jsp";
    }

    public String detail(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        pService.incrementViews(id);
        Product product = pService.getById(id);
        if (product == null) {
            return "redirect:/index";
        }
        request.setAttribute("product", product);
        return "/product_detail.jsp";
    }

    public String search(HttpServletRequest request, HttpServletResponse response) {
        String keyword = request.getParameter("keyword");
        int categoryId = 0;
        float priceMin = 0;
        float priceMax = Float.MAX_VALUE;
        int pageNumber = 1;
        String sort = request.getParameter("sort");

        if (request.getParameter("categoryId") != null)
            categoryId = Integer.parseInt(request.getParameter("categoryId"));
        if (request.getParameter("priceMin") != null && !request.getParameter("priceMin").isEmpty())
            priceMin = Float.parseFloat(request.getParameter("priceMin"));
        if (request.getParameter("priceMax") != null && !request.getParameter("priceMax").isEmpty())
            priceMax = Float.parseFloat(request.getParameter("priceMax"));
        if (request.getParameter("pageNumber") != null)
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        if (sort == null) sort = "newest";

        Page p = pService.search(keyword, categoryId, priceMin, priceMax, sort, pageNumber);
        request.setAttribute("p", p);
        request.setAttribute("keyword", keyword);
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("priceMin", priceMin > 0 ? priceMin : null);
        request.setAttribute("priceMax", priceMax < Float.MAX_VALUE ? priceMax : null);
        request.setAttribute("sort", sort);
        return "/product_search.jsp";
    }

    public String publish(HttpServletRequest request, HttpServletResponse response) throws Exception {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/user?method=login";
        }

        if ("GET".equalsIgnoreCase(request.getMethod())) {
            request.setAttribute("categoryList", cService.getAllCategories());
            return "/product_publish.jsp";
        }

        Product product = new Product();
        for (Part part : request.getParts()) {
            String fieldName = part.getName();
            if (part.getSubmittedFileName() == null || part.getSubmittedFileName().isEmpty()) {
                String value = request.getParameter(fieldName);
                if (value == null) continue;
                switch (fieldName) {
                    case "name":
                        product.setName(value);
                        break;
                    case "price":
                        product.setPrice(Float.parseFloat(value));
                        break;
                    case "price_original":
                        if (value != null && !value.isEmpty()) {
                            product.setPriceOriginal(Float.parseFloat(value));
                        }
                        break;
                    case "description":
                        product.setDescription(value);
                        break;
                    case "condition_level":
                        product.setConditionLevel(Integer.parseInt(value));
                        break;
                    case "category_id":
                        product.setCategoryId(Integer.parseInt(value));
                        break;
                }
            } else {
                String fileName = part.getSubmittedFileName();
                if (fileName != null && !fileName.isEmpty()) {
                    String uploadPath = request.getServletContext().getRealPath("/picture/");
                    String uuidName = UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf("."));
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    part.write(uploadPath + uuidName);
                    product.setImage("picture/" + uuidName);
                }
            }
        }
        product.setUserId(user.getId());
        pService.insert(product);
        return "redirect:/product?method=list";
    }

    public String edit(HttpServletRequest request, HttpServletResponse response) throws Exception {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/user?method=login";
        }

        if ("GET".equalsIgnoreCase(request.getMethod())) {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = pService.getById(id);
            if (product == null || product.getUserId() != user.getId()) {
                return "redirect:/user?method=myProducts";
            }
            request.setAttribute("product", product);
            request.setAttribute("categoryList", cService.getAllCategories());
            return "/product_edit.jsp";
        }

        Product product = new Product();
        int productId = 0;
        for (Part part : request.getParts()) {
            String fieldName = part.getName();
            if (part.getSubmittedFileName() == null || part.getSubmittedFileName().isEmpty()) {
                String value = request.getParameter(fieldName);
                if (value == null) continue;
                switch (fieldName) {
                    case "id":
                        productId = Integer.parseInt(value);
                        break;
                    case "name":
                        product.setName(value);
                        break;
                    case "price":
                        product.setPrice(Float.parseFloat(value));
                        break;
                    case "price_original":
                        if (value != null && !value.isEmpty()) {
                            product.setPriceOriginal(Float.parseFloat(value));
                        }
                        break;
                    case "description":
                        product.setDescription(value);
                        break;
                    case "condition_level":
                        product.setConditionLevel(Integer.parseInt(value));
                        break;
                    case "category_id":
                        product.setCategoryId(Integer.parseInt(value));
                        break;
                }
            } else {
                String fileName = part.getSubmittedFileName();
                if (fileName != null && !fileName.isEmpty()) {
                    String uploadPath = request.getServletContext().getRealPath("/picture/");
                    String uuidName = UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf("."));
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    part.write(uploadPath + uuidName);
                    product.setImage("picture/" + uuidName);
                }
            }
        }

        Product existing = pService.getById(productId);
        if (existing == null || existing.getUserId() != user.getId()) {
            return "redirect:/user?method=myProducts";
        }
        product.setId(productId);
        if (product.getImage() == null) {
            product.setImage(existing.getImage());
        }
        pService.update(product);
        return "redirect:/product?method=detail&id=" + productId;
    }

    public String delete(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/user?method=login";
        }
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = pService.getById(id);
        if (product != null && product.getUserId() == user.getId()) {
            cartService.deleteByProductId(id);
            pService.updateStatus(id, 2);
        }
        return "redirect:/user?method=myProducts";
    }
}
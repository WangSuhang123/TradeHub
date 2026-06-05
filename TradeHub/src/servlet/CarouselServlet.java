package servlet;

import model.Carousel;
import model.User;
import service.CarouselService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.util.UUID;

public class CarouselServlet extends BaseServlet {
    private CarouselService cService = new CarouselService();

    private User requireAdmin(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !user.isIsadmin()) {
            return null;
        }
        return user;
    }

    public String list(HttpServletRequest request, HttpServletResponse response) {
        if (requireAdmin(request, response) == null) {
            return "redirect:/index";
        }
        request.setAttribute("carouselList", cService.getAll());
        return "/admin/carousel_list.jsp";
    }

    public String add(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (requireAdmin(request, response) == null) {
            return "redirect:/index";
        }

        if ("GET".equalsIgnoreCase(request.getMethod())) {
            return "/admin/carousel_edit.jsp";
        }

        Carousel carousel = new Carousel();
        for (Part part : request.getParts()) {
            String fieldName = part.getName();
            if (part.getSubmittedFileName() == null || part.getSubmittedFileName().isEmpty()) {
                String value = request.getParameter(fieldName);
                if (value == null) continue;
                switch (fieldName) {
                    case "title":
                        carousel.setTitle(value.length() > 50 ? value.substring(0, 50) : value);
                        break;
                    case "link":
                        carousel.setLink(value);
                        break;
                    case "sort_order":
                        carousel.setSortOrder(Integer.parseInt(value));
                        break;
                    case "status":
                        carousel.setStatus(Integer.parseInt(value));
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
                    carousel.setImage("picture/" + uuidName);
                }
            }
        }
        if (carousel.getSortOrder() < 0) carousel.setSortOrder(0);
        if (carousel.getStatus() != 1) carousel.setStatus(0);
        cService.add(carousel);
        return "redirect:/carousel?method=list";
    }

    public String edit(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (requireAdmin(request, response) == null) {
            return "redirect:/index";
        }

        if ("GET".equalsIgnoreCase(request.getMethod())) {
            int id = Integer.parseInt(request.getParameter("id"));
            Carousel carousel = cService.getById(id);
            if (carousel == null) {
                return "redirect:/carousel?method=list";
            }
            request.setAttribute("carousel", carousel);
            return "/admin/carousel_edit.jsp";
        }

        int id = 0;
        Carousel carousel = new Carousel();
        for (Part part : request.getParts()) {
            String fieldName = part.getName();
            if (part.getSubmittedFileName() == null || part.getSubmittedFileName().isEmpty()) {
                String value = request.getParameter(fieldName);
                if (value == null) continue;
                switch (fieldName) {
                    case "id":
                        id = Integer.parseInt(value);
                        break;
                    case "title":
                        carousel.setTitle(value.length() > 50 ? value.substring(0, 50) : value);
                        break;
                    case "link":
                        carousel.setLink(value);
                        break;
                    case "sort_order":
                        carousel.setSortOrder(Integer.parseInt(value));
                        break;
                    case "status":
                        carousel.setStatus(Integer.parseInt(value));
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
                    carousel.setImage("picture/" + uuidName);
                }
            }
        }

        Carousel existing = cService.getById(id);
        if (existing == null) {
            return "redirect:/carousel?method=list";
        }
        carousel.setId(id);
        if (carousel.getImage() == null) {
            carousel.setImage(existing.getImage());
        }
        if (carousel.getSortOrder() < 0) carousel.setSortOrder(0);
        if (carousel.getStatus() != 1) carousel.setStatus(0);
        cService.update(carousel);
        return "redirect:/carousel?method=list";
    }

    public String delete(HttpServletRequest request, HttpServletResponse response) {
        if (requireAdmin(request, response) == null) {
            return "redirect:/index";
        }
        int id = Integer.parseInt(request.getParameter("id"));
        cService.delete(id);
        return "redirect:/carousel?method=list";
    }

    public String toggleStatus(HttpServletRequest request, HttpServletResponse response) {
        if (requireAdmin(request, response) == null) {
            return "redirect:/index";
        }
        int id = Integer.parseInt(request.getParameter("id"));
        cService.toggleStatus(id);
        return "redirect:/carousel?method=list";
    }

    public String moveUp(HttpServletRequest request, HttpServletResponse response) {
        if (requireAdmin(request, response) == null) {
            return "redirect:/index";
        }
        int id = Integer.parseInt(request.getParameter("id"));
        Carousel c = cService.getById(id);
        if (c != null && c.getSortOrder() > 0) {
            cService.updateSortOrder(id, c.getSortOrder() - 1);
        }
        return "redirect:/carousel?method=list";
    }

    public String moveDown(HttpServletRequest request, HttpServletResponse response) {
        if (requireAdmin(request, response) == null) {
            return "redirect:/index";
        }
        int id = Integer.parseInt(request.getParameter("id"));
        Carousel c = cService.getById(id);
        if (c != null) {
            cService.updateSortOrder(id, c.getSortOrder() + 1);
        }
        return "redirect:/carousel?method=list";
    }
}

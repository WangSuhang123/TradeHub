package servlet;

import service.CarouselService;
import service.ProductService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndexServlet extends BaseServlet {
    private ProductService pService = new ProductService();
    private CarouselService carouselService = new CarouselService();

    public String index(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("latestList", pService.getLatestList(1, 12));
        request.setAttribute("hotList", pService.getHotList(10));
        request.setAttribute("carouselList", carouselService.getActive());
        return "/index.jsp";
    }
}
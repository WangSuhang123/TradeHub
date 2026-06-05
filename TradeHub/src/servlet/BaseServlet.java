package servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;

public class BaseServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        String methodName = request.getParameter("method");
        if (methodName == null || methodName.isEmpty()) {
            methodName = "index";
        }

        try {
            Method method = this.getClass().getMethod(methodName,
                    HttpServletRequest.class, HttpServletResponse.class);
            String result = (String) method.invoke(this, request, response);

            if (result != null) {
                if (result.startsWith("redirect:")) {
                    response.sendRedirect(request.getContextPath() + result.substring(9));
                } else if (result.startsWith("json:")) {
                    response.setContentType("application/json;charset=utf-8");
                    response.getWriter().print(result.substring(5));
                } else {
                    request.getRequestDispatcher(result).forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index");
        }
    }
}
package xyz.forum.filters;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


public class AuthorityFilter implements Filter {
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession(false);
        try {
            if (session.getAttribute("user") == null) {
                if (!ajaxDofilterSessionNull(request, response)) {
                    response.sendRedirect("/login.html");
                }
            }
        } catch (Exception e) {
            response.sendRedirect("/login.html");
        } finally {
            filterChain.doFilter(request, response);
        }
    }

    private static boolean ajaxDofilterSessionNull(HttpServletRequest request, HttpServletResponse response) {
        boolean isAjax = false;
        if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equals("XMLHttpRequest")) {
            // ajax请求
            response.setHeader("sessionstatus", "timeout");
            isAjax = true;
        }
        return isAjax;
    }

    public void destroy() {
    }
}

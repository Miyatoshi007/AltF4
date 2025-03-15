package com.AltF4.filters;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.AltF4.model.User;

@WebFilter("/*")
public class AuthFilter implements Filter {
	private static final List<String> EXCLUDED_PATHS = Arrays.asList("/index", "/login", "/signup", "/logout",
			"/forgotPass", "/forgotPass/checkMail", "/forgotPass/checkOTP", "/forgotPass/changePass",
			"/listPremiumCourse", "/error");
	private static final List<String> STATIC_RESOURCES = Arrays.asList("/assets/", "/css/", "/js/", "/images/",
			"/fonts/", "/favicon.ico");
	private static final String JSP_PATH = "/views/";
	private static final String ADMIN_PATHS = "/admin/";
	private static final String ROLE_ADMIN = "Admin";

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// Initialization logic (if any).
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		String uri = req.getRequestURI();
		HttpSession session = req.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

		// Check if the request targets a static resource
		boolean isStaticResource = STATIC_RESOURCES.stream().anyMatch(uri::contains);

		// Check if the path is explicitly excluded
		boolean isExcludedPath = EXCLUDED_PATHS.stream().anyMatch(uri::endsWith);

		// Check if it's a public JSP path
		boolean isPublicJSP = uri.startsWith(req.getContextPath() + JSP_PATH);

		// Check if the path is an admin-only route
		boolean isAdminPath = uri.startsWith(req.getContextPath() + ADMIN_PATHS);

		// Allow static resources, excluded paths, or public JSPs to pass through
		if (isStaticResource || isExcludedPath || isPublicJSP) {
			chain.doFilter(request, response);
			return;
		}

		if (user == null) {
			session = req.getSession(true);
			String secureUrl = uri + (req.getQueryString() != null ? "?" + req.getQueryString() : "");
			session.setAttribute("secureUrl", secureUrl);

			resp.sendRedirect(req.getContextPath() + "/login?error=unauthorized");
			return;
		}

		if (user.isLocked()) {
			resp.sendRedirect(req.getContextPath() + "/login?error=account_locked");
			return;
		}

		if (isAdminPath && (user.getRole() == null || !ROLE_ADMIN.equals(user.getRole()))) {
			resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
			return;
		}

		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {

	}
}

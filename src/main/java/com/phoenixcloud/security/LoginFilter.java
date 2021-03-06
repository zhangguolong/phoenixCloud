package com.phoenixcloud.security;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.phoenixcloud.util.MiscUtils;

public class LoginFilter implements Filter {

	private static final Logger logger = MiscUtils.getLogger();
	private static final String[] EXEMPT_URLS = {
		"/login.jsp",
		"/register.jsp",
		"/system/login.do",
		"/system/register.do",
		"/logout.jsp",
		"/agency/agencyMgmt!getAgency.do",
		
		"/css/",
		"/js/",
		"/img/",
		"/image/",
	};
	
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		logger.info("Starting Filter : "+getClass().getSimpleName());
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		logger.debug("Entering LoginFilter.doFilter()");
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		
		if (httpRequest.getSession().getAttribute("user") == null) {
			String requestURI = httpRequest.getRequestURI();
			String contextPath = httpRequest.getContextPath();

			/*
			 * If the requested resource is npt exempt then redirect to the logout page.
			 * 
			 * bug fix: removed root directory auto-exemption. If you want to have a resource
			 * be an exemption, you must explicitely add to EXEMPT_URLS array.
			 */
			if (!inListOfExemptions(requestURI, contextPath)) {
				httpResponse.sendRedirect(contextPath + "/logout.jsp");
				return;
			}
		}
		chain.doFilter(request, response);
	}
	
	boolean inListOfExemptions(String requestURI, String contextPath) {
		for (String exemptUrl : EXEMPT_URLS) {
	        if (requestURI.startsWith(contextPath + exemptUrl)) {
	        	return true;
	        }
        }
		
		return false;
	}

	public void destroy() {
		// TODO Auto-generated method stub

	}

}

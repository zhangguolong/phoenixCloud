<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.phoenixcloud.bean.*" %>
<%@taglib uri="/WEB-INF/security.tld" prefix="security" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >

<%
String ctx = request.getContextPath();
SysStaff staff = (SysStaff)session.getAttribute("user");
%>

<head>
    <title>凤凰书城-后台管理</title>
</head>
		
	   <frameset rows="55,*"  >							   
		<frame name="f_t" src="<%=ctx %>/top.jsp"  border="0" frameborder="0" scrolling="no" id="header">
		<frameset cols="202, *"  frameborder="0" border="0" framespacing="0" name="fs_lr">
		<frame name="f_l"  src="<%=ctx %>/left_menu.jsp" border="0" frameborder="0"  scrolling="no" framespacing="0"  id="left">
		<security:phoenixSec purviewCode="PERSONAL_INFO_MENU">
		<frame name="f_r" src="<%=ctx %>/system/editUser.do?staff.staffId=<%=staff.getStaffId() %>" scrolling="auto" border="0" frameborder="0"  id="right" marginheight="890">
		</security:phoenixSec>
		<security:phoenixSec purviewCode="PERSONAL_INFO_MENU" reverse="true">
		<frame name="f_r" src="<%=ctx %>/blank.jsp" scrolling="auto" border="0" frameborder="0"  id="right" marginheight="890">
		</security:phoenixSec>
		<noframes>
			此 HTML 框架集显示多个 Web 页。若要查看此框架集，请使用支持 HTML 4.0 及更高版本的 Web 浏览器。
		</noframes>
	   </frameset>


</html>
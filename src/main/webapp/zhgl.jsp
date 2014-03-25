<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.phoenixcloud.bean.*"%>
<%@page import="com.phoenixcloud.dao.ctrl.*"%>
<%@page import="com.phoenixcloud.util.SpringUtils"%>

<%
String ctx = request.getContextPath();
PubOrgDao orgDao = (PubOrgDao)SpringUtils.getBean(PubOrgDao.class);
SysStaff staff = (SysStaff)session.getAttribute("user");
PubOrg org = orgDao.find(staff.getOrgId().toString());
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta name="keywords" content="江苏凤凰数字出版传媒有限公司">
<meta name="description" content="江苏凤凰数字出版传媒有限公司">
<title></title>
<link rel="stylesheet" href="css/common.css" />
<link rel="stylesheet" href="css/page.css" />
<link rel="stylesheet" href="<%=ctx%>/css/zTreeStyle/zTreeStyle.css"
	type="text/css">


<script src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<script type="text/javascript"
	src="<%=ctx %>/js/ztree/jquery.ztree.core-3.5.js"></script>

</head>

<body>
	<div class="local">
		当前机构：<%=org.getOrgName() %></div>
	<div class="right_main">
		<div class="head">
			<img src="image/home_icon.jpg">&nbsp;账号管理&gt;首页
		</div>
		<div class="zhgl">
			<!--左侧菜单-->
			<div class="left_dtree" style="width:20%;overflow:scroll">
				<div class="tree_title margin_top_15" style="width:100%">机构</div>
				<div id="agencyTree" class="ztree"></div>
			</div>
			<!--左侧菜单-->
			<!--右侧内容-->
			<div class="rcontent margin_top_20"
				style="float: right; width: 79%; margin-top: -730px;overflow:scroll">
				<div class="box_info1 margin_bottom_20">
					<div class="line_title margin_top_5">
						<img src="image/user_photo.jpg">&nbsp;用户
					</div>
					<div class="line_btn margin_top_10">
						<img src="image/btn1.jpg">&nbsp;&nbsp;<img
							src="image/btn2.jpg">&nbsp;&nbsp;<img src="image/btn3.jpg">&nbsp;&nbsp;<img
							src="image/btn4.jpg">
					</div>
				</div>
				<table class="list_table1">
					<thead>
						<tr>
							<th>用户名</th>
							<th>账号</th>
							<th>创建时间</th>
							<th>所属机构</th>
							<th>是否有效</th>
						</tr>
					</thead>
					<tbody id="userTblBody">
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--右侧内容-->
		</div>
	</div>
</body>

<script type="text/javascript">

var zTreeObj,
setting = {
	view: {
		selectedMulti: false
	},
	async: {
		enable: true,
		url: "<%=ctx%>/agency/agencyMgmt!getAgency.do",
		autoParam: ["type", "selfId"]
	},
	callback: {
		onClick: onSelOrg
	}
},
zTreeNodes = [];

var isLoadingUser = false;
function onSelOrg(event, treeId, treeNode, clickFlag) {
	if (treeNode != null && !treeNode.isParent) {
		if (isLoadingUser) {
			alert("正在加载用户数据，请稍后！");
			return;
		}
		isLoadingUser = true;
		isLoadingUser = true;userTblBody
		jQuery.ajax({
			url: "<%=ctx%>/system/getAllUser.do";
			data: {selfId:treeNode.selfId},
			dataType: "json",
			timeout: 30000,
			async: false,
			success: function(userArr) {
				if (userArr == null || userArr.length == 0) {
					alert("加载用户数据失败！");
				}
				alert("加载用户成功！");
				jQuery("#userTblBody").children("tr").remove();
				
				isLoadingUser = false;
			}
			error: function(req,txt) {
				alert("加载用户失败！");
				isLoadingUser = false;
			}
		})
	}
}

$(function() {	
	jQuery("select").each(function(idx) {
		jQuery(this).val(this.getAttribute("value"));
	});
	
	zTreeObj = $.fn.zTree.init($("#agencyTree"), setting, zTreeNodes);
	jQuery("#agencyTree").on("blur", function(event) {
		jQuery(this).css("display", "none");
	});
});
</script>

</html>
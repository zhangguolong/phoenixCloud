<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.WebApplicationContext" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.math.*" %>
<%@page import="java.util.*" %>
<%@page import="com.phoenixcloud.bean.*"%>
<%@page import="com.phoenixcloud.system.service.ISysService" %>
<%@page import="com.phoenixcloud.book.service.IRBookMgmtService" %>
<%@taglib uri="/WEB-INF/security.tld" prefix="security" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String ctx = (String) request.getContextPath();
WebApplicationContext context = (WebApplicationContext)this.getServletContext().getAttribute(
		WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
ISysService iSysService = (ISysService)context.getBean("sysServiceImpl");
IRBookMgmtService iBookService = (IRBookMgmtService)context.getBean("bookMgmtServiceImpl");
List<SysPurview> purviewList = (List<SysPurview>)request.getAttribute("purviewList");
if (purviewList == null) {
	purviewList = new ArrayList<SysPurview>();
}
List<SysStaffPurview> staffPurList = (List<SysStaffPurview>)request.getAttribute("staffPurList");
if (staffPurList == null) {
	staffPurList = new ArrayList<SysStaffPurview>();
}

List<SysStaffRegCode> staffRegCodeList = (List<SysStaffRegCode>)request.getAttribute("staffRegCodeList");
if (staffRegCodeList == null) {
	staffRegCodeList = new ArrayList<SysStaffRegCode>();
}

String tabId = (String)request.getAttribute("tabId");
if (tabId == null || tabId.isEmpty()) {
	tabId = "purviewTabTable";
}

SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="<%=ctx%>/css/bootstrap.min.css" />
	<link rel="stylesheet" href="<%=ctx%>/css/bootstrap-responsive.min.css" />
	<link rel="stylesheet" href="<%=ctx%>/css/unicorn.main.css" />
	<link rel="stylesheet" href="<%=ctx%>/css/uniform.css" />
	<link rel="stylesheet" href="<%=ctx%>/css/select2.css" />
	<link rel="stylesheet" href="<%=ctx%>/css/unicorn.grey.css" class="skin-color" />
	<link rel="stylesheet" href="<%=ctx%>/css/zTreeStyle/zTreeStyle.css" type="text/css">
	
	<script src="<%=ctx%>/js/jquery.min.js"></script>
	<script src="<%=ctx%>/js/jquery.uniform.js"></script>
	<script src="<%=ctx%>/js/jquery.ui.custom.js"></script>
	<script src="<%=ctx%>/js/bootstrap.min.js"></script>
	<script src="<%=ctx%>/js/unicorn.js"></script>
	<script src="<%=ctx%>/js/select2.min.js"></script>
	<script src="<%=ctx%>/js/jquery.dataTables.min.js"></script>
	<script src="<%=ctx%>/js/unicorn.tables.js"></script>
	<script type="text/javascript" src="<%=ctx%>/js/ztree/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="<%=ctx%>/js/ztree/jquery.ztree.excheck-3.5.js"></script>
	
<title>权限管理</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<jsp:include page="admin_sidebar.jsp" flush="true"></jsp:include>
	<div id="content">
		<div id="content-header">
			<h1>凤凰云端</h1>
		</div>
		<security:phoenixSec purviewCode="managePurview">
		<div class="widget-box">
			<div class="widget-content">
				&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="btn" name="addItem" onclick="addItem();" value="新建"/>
				&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="btn" name="removeItems" onclick="removeItems();" value="删除"/>
			</div>
		</div>
		</security:phoenixSec>
		<div class="widget-box">
			
			<div class="widget-title">
				<ul class="nav nav-tabs">
					<li class="">
						<a href="#staffPurTab" data-toggle="tab">功能权限配置</a>
					</li>
					<li class="" style="display:none">
						<a href="#staffRegCodeTab" data-toggle="tab">图书下载权限配置</a>
					</li>
				</ul>
			</div>
			<div class="widget-content tab-content" style="padding: 0px; border-left-width: 0px;">			
				<!-- 功能权限配置 -->
				<div id="staffPurTab" class="tab-pane" style="display:block">
					<div class="span6">
						<div class="widget-box">
							<div class="widget-title">
								<span class="icon">
									<i class="icon-user"></i>
								</span>
								<h5>账号列表</h5>
							</div>
							<div class="widget-content">
								<div id="agencyTree" class="ztree" style="padding: 0px;">
								</div>
							</div>
						</div>
					</div>
					<div class="span6">
						<div class="widget-box">
							<div class="widget-title">
								<span class="icon">
									<i class="icon-user"></i>
								</span>
								<h5>权限点列表</h5>
							</div>
							<div class="widget-content">
								<div id="purTree" class="ztree" style="padding: 0px;">
								</div>
							</div>
						</div>
					</div>
					<div class="span6">
						<button class="btn btn-primary" type="button"  onclick="savePurCfg();">保存</button>
					</div>
				</div>
				
				<!-- 图书下载权限配置 -->
				<div id="staffRegCodeTab" class="tab-pane">
					<table id="staffRegCodeTabTable" class="table table-bordered data-table">
						<thead>
							<tr>
								<th style="width:1%">
									<div id="uniform-title-table-checkbox" class="checker">
										<span class="">
											<input id="title-table-checkbox" type="checkbox" name="title-table-checkbox" style="opacity: 0;">
										</span>
									</div>
								</th>
								<th style="width:5%">标识</th>
								<th>账号</th>
								<th>书籍标识</th>
								<th>注册码</th>
								<th>失效日期</th>
								<th>是否有效</th>
								<th>创建时间</th>
								<th>更新时间</th>
								<th>备注</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<%
						for (SysStaffRegCode regCode : staffRegCodeList) {
							String createTime = sdf.format(regCode.getCreateTime());
							String updateTime = sdf.format(regCode.getUpdateTime());
							String acntName = "无";
							SysStaff staff = iSysService.findStaffById(regCode.getStaffId().toString());
							if (staff != null) {
								acntName = staff.getName();
							}
							String codeVal = "无";
							String expireDate = "无";
							String isValid = "否";
							RRegCode bookRgcode = iBookService.findRegCode(regCode.getRegCodeId().toString());
							if (bookRgcode != null) {
								codeVal = bookRgcode.getCode();
								expireDate = new SimpleDateFormat("yyyy/MM/dd").format(bookRgcode.getValidDate());
								if (bookRgcode.getIsValid() == (byte)1) {
									isValid = "是";
								}
							}
						%>
							<tr>
								<td style="width:1%">
									<div id="uniform-undefined" class="checker">
										<span class="">
											<input type="checkbox" style="opacity: 0;" value="<%=regCode.getId()%>">
										</span>
									</div>
								</td>
								<td style="width:5%"><%=regCode.getId() %></td>
								<td><%=acntName %></td>
								<td><%=regCode.getBookId() %></td>
								<td><%=codeVal %></td>
								<td><%=expireDate %></td>
								<td><%=isValid %></td>
								<td><%=createTime %></td>
								<td><%=updateTime %></td>
								<td><%=regCode.getNotes() %></td>
								<td>
									<a class="tip-top" data-original-title="修改" href="<%=ctx%>/system/system_editStaffRegCode.do?staffRegCode.ssrcId=<%=regCode.getId()%>"><i class="icon-edit"></i></a>
									<a class="tip-top" data-original-title="删除" href="#"><i class="icon-remove"></i></a>
								</td>
							</tr>
						<%} %>
						</tbody>
					</table>		
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" flush="true" />
</body>
<script type="text/javascript">

function removeItems() {
	var ids = "";
	var tabId = jQuery(".tab-content > div").filter(".active")[0].id;
	var checkedItems = jQuery("#" + tabId +" tbody").find("input:checked");
	if (checkedItems == null || checkedItems.length == 0) {
		alert("请选择要删除的项目！");
		return;
	}
	for (var i = 0; i < checkedItems.length; i++) {
		ids += checkedItems[i].value;
		if (i != (checkedItems.length - 1)) {
			ids += ",";
		}
	}
	
	if (tabId == "purviewTab") {
		jQuery.ajax({
			url: "<%=ctx%>/system/system_removePurview.do",
			type: "POST",
			async: "false",
			timeout: 30000,
			data: {purIdArr:ids},
			success: function() {
				alert("删除成功！");
				window.location.href = "<%=ctx%>/system/system_getAllPurview.do?tabId=" + tabId;
			},
			error: function() {
				alert("删除失败！");
			}
		});
	} else if (tabId == "staffPurTab") {
		jQuery.ajax({
			url: "<%=ctx%>/system/system_removeStaffPur.do",
			type: "POST",
			async: "false",
			timeout: 30000,
			data: {staffPurIdArr:ids},
			success: function() {
				alert("删除成功！");
				window.location.href = "<%=ctx%>/system/system_getAllPurview.do?tabId=" + tabId;
			},
			error: function() {
				alert("删除失败！");
			}
		});
	} else if (tabId == "staffRegCodeTab") {
		jQuery.ajax({
			url: "<%=ctx%>/system/system_removeStaffRegCode.do",
			type: "POST",
			async: "false",
			timeout: 30000,
			data: {staffRegCodeIdArr:ids},
			success: function() {
				alert("删除成功！");
				window.location.href = "<%=ctx%>/system/system_getAllPurview.do?tabId=" + tabId;
			},
			error: function() {
				alert("删除失败！");
			}
		});
	}
}

function addItem() {
	var tabId = jQuery(".tab-content > div").filter(".active")[0].id;
	if (tabId == "purviewTab") {
		location.href = "<%=ctx%>/addPurview.jsp";
	} else if (tabId == "staffPurTab") {
		location.href = "<%=ctx%>/addStaffPur.jsp";
	} else if (tabId == "staffRegCodeTab") {
		location.href = "<%=ctx%>/addStaffRegCode.jsp";
	}
}

var zAgencyTreeObj,
agencySetting = {
	view: {
		selectedMulti: false
	},
	check:{//复选框设置 
        enable:true,
        chkStyle:"checkbox",
		chkboxType:{"Y":"","N":""}
    },
	async: {
		enable: true,
		url: "<%=ctx%>/agency/agencyMgmt!getStaff.do",
		autoParam: ["type", "selfId"]
	},
	callback: {
		onClick: onClickUser,
	}
},
zAgencyTreeNodes = [];

function onClickUser(event, treeId, treeNode, clickFlag) {
	if (treeNode.isParent) {
		return;
	}
	unCheckAll();
	jQuery.ajax({
		url: "<%=ctx%>/system/system_getPurByStaff.do",
		data: {selfId:treeNode.selfId},
		async: false,
		timeout: 30000,
		dataType: "JSON",
		success: function(ret) {
			if (ret == null || ret.length == 0) {
				alert("Unknown error");
				return;
			}
			jQuery(zPurTreeObj.getNodes()).each(function () {
				if (containsId(this.selfId, ret)) {
					zPurTreeObj.checkNode(this, true, false, false);
				}
				checkPurNodes(ret, this.children);
			});
		},
		error: function(XMLRequest, textInfo) {
			if (textInfo != null) {
				alert(textInfo);
			} else {
				alert("Unknown error!")
			}
		}
	});
}

function unCheckAll() {
	jQuery(zPurTreeObj.getNodes()).each(function() {
		zPurTreeObj.checkNode(this, false, true, false);
	});
}

function containsId(id, idArr) {
	var flag = false;
	jQuery(idArr).each(function() {
		if (this == id) {
			flag = true;
			return false;
		}
	});
	return flag;
}

function checkPurNodes(ret, children) {
	if (children != null && children.length > 0) {
		jQuery(children).each(function() {
			if (containsId(this.selfId, ret)) {
				zPurTreeObj.checkNode(this, true, false, false);
			}
			checkPurNodes(ret, this.children);
		});
	}
}


var zPurTreeObj,
purSetting = {
		view: {
			selectedMulti: false
		},
		check:{//复选框设置 
	        enable:true,
	        chkStyle:"checkbox",
			chkboxType:{"Y":"ps","N":"ps"}
	    },
		async: {
			enable: true,
			url: "<%=ctx%>/system/system_getAllPur.do",
			autoParam: ["selfId"]
		},
		callback: {
			onAsyncSuccess: onAsyncSuccess,
		}
	},
zPurTreeNodes = [];

function onAsyncSuccess(event, treeId, treeNode, msg) {
	zPurTreeObj.setting.async.enable=false;
}

var checkedUsers = null, checkedPurs = null;

function savePurCfg() {
	if (checkedUsers != null || checkedPurs != null) {
		alert("正在保存配置，请稍后重试！");
		return;
	}
	
	checkedUsers = zAgencyTreeObj.getCheckedNodes();
	if (checkedUsers == null || checkedUsers.length == 0) {
		checkedUsers = null;
		alert("请选择要配置的账号！");
		return;
	}
	
	checkedPurs = zPurTreeObj.getCheckedNodes();
	if (checkedPurs == null || checkedPurs.length == 0) {
		checkedUsers = null;
		checkedPurs = null;
		alert("请选择要配置的权限！");
		return;
	}
	
	var staffIdArr = "", purIdArr = "";
	jQuery(checkedUsers).each(function(idx) {
		staffIdArr += this.selfId;
		if (idx != (checkedUsers.length - 1)) {
			staffIdArr += ",";
		}
	});
	jQuery(checkedPurs).each(function(idx) {
		purIdArr += this.selfId;
		if (idx != (checkedPurs.length - 1)) {
			purIdArr += ",";
		}
	});
	
	jQuery.ajax({
		url: "<%=ctx%>/system/system_saveStaffPur.do",
		data: {staffIdArr:staffIdArr, purIdArr:purIdArr},
		async: true,
		timeout: 30000,
		success: function() {
			alert("保存配置权限成功！");
			checkedUsers = null;
			checkedPurs = null;
			window.location.reload(true);
		}, 
		error: function(XMLRequest, textInfo) {
			if (textInfo != null) {
				alert(textInfo);
			} else {
				alert("保存权限出错！");
			}
			checkedUsers = null;
			checkedPurs = null;
		}
	});
}

jQuery(document).ready(function() {
	
	zAgencyTreeObj = $.fn.zTree.init($("#agencyTree"), agencySetting, zAgencyTreeNodes);
	zPurTreeObj = $.fn.zTree.init($("#purTree"), purSetting, zPurTreeNodes);
	
	// 设置激活tab
	var activeTabId = "<%=tabId%>";
	jQuery("#" + activeTabId).addClass("active");
	if (activeTabId == "purviewTab") {
		jQuery(".nav-tabs > li:eq(0)").addClass("active");
	} else if (activeTabId == "staffPurTab") {
		jQuery(".nav-tabs > li:eq(1)").addClass("active");
	} else if (activeTabId == "staffRegCodeTab") {
		jQuery(".nav-tabs > li:eq(2)").addClass("active");
	}
	
	// 删除权限
	jQuery("#purviewTabTable").on("click", "td a.tip-top:nth-child(2)", function(e) {
		var id = jQuery(this.parentNode.parentNode).find("input:first-child").val().toString();
		jQuery.ajax({
			url: "<%=ctx%>/system/system_removePurview.do",
			type: "POST",
			async: "false",
			timeout: 30000,
			data: {purIdArr: id},
			success: function() {
				alert("删除成功！");
				window.location.href = "<%=ctx%>/system/system_getAllPurview.do?tabId=purviewTab";
			},
			error: function() {
				alert("删除失败！");
			}
		});
		return false;
	});
	
	// 删除权限配置
	jQuery("#staffPurTabTable").on("click", "td a.tip-top:nth-child(2)", function(e) {
		var id = jQuery(this.parentNode.parentNode).find("input:first-child").val().toString();
		jQuery.ajax({
			url: "<%=ctx%>/system/system_removeStaffPur.do",
			type: "POST",
			async: "false",
			timeout: 30000,
			data: {staffPurIdArr: id},
			success: function() {
				alert("删除成功！");
				window.location.href = "<%=ctx%>/system/system_getAllPurview.do?tabId=staffPurTab";
			},
			error: function() {
				alert("删除失败！");
			}
		});
		return false;
	});
	
	// 删除注册码
	jQuery("#staffRegCodeTabTable").on("click", "td a.tip-top:nth-child(2)", function(e) {
		var id = jQuery(this.parentNode.parentNode).find("input:first-child").val().toString();
		jQuery.ajax({
			url: "<%=ctx%>/system/system_removeStaffRegCode.do",
			type: "POST",
			async: "false",
			timeout: 30000,
			data: {staffRegCodeIdArr: id},
			success: function() {
				alert("删除成功！");
				window.location.href = "<%=ctx%>/system/system_getAllPurview.do?tabId=staffRegCodeTab";
			},
			error: function() {
				alert("删除失败！");
			}
		});
		return false;
	});
	
});
</script>
</html>
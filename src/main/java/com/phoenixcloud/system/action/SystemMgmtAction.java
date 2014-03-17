package com.phoenixcloud.system.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.dispatcher.RequestMap;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.opensymphony.xwork2.ActionSupport;
import com.phoenixcloud.bean.PubHw;
import com.phoenixcloud.bean.SysPurview;
import com.phoenixcloud.bean.SysStaff;
import com.phoenixcloud.bean.SysStaffPurview;
import com.phoenixcloud.bean.SysStaffRegCode;
import com.phoenixcloud.dao.ctrl.SysPurviewDao;
import com.phoenixcloud.dao.ctrl.SysStaffPurviewDao;
import com.phoenixcloud.system.service.ISysService;
import com.phoenixcloud.util.MiscUtils;

@Scope("prototype")
@Component
public class SystemMgmtAction extends ActionSupport implements RequestAware,ServletResponseAware,SessionAware{
	
	private static final long serialVersionUID = 735713101705200424L;
	
	private RequestMap request;
	private HttpServletResponse response;
	private SessionMap session;
	
	@Resource(name="sysServiceImpl")
	private ISysService iSysService;
	
	private SysStaff staff;
	private String userIdArr;
	
	private PubHw hw;
	private String hwIdArr;
	
	private SysPurview purview;
	private String purIdArr;
	
	private SysStaffPurview staffPur;
	private String staffPurIdArr;
	
	private SysStaffRegCode staffRegCode;
	private String staffRegCodeIdArr;
	
	private String tabId;
	
	private BigInteger selfId;
	
	@Autowired
	private SysPurviewDao sysPurDao;
	
	@Autowired
	private SysStaffPurviewDao staffPurDao;
	
	private String staffIdArr;
	
	public void setiSysService(ISysService iSysService) {
		this.iSysService = iSysService;
	}

	@Override
	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
		this.response = response;
	}

	@Override
	public void setRequest(Map<String, Object> request) {
		// TODO Auto-generated method stub
		this.request = (RequestMap)request;
	}
	
	public SysStaff getStaff() {
		return staff;
	}

	public void setStaff(SysStaff staff) {
		this.staff = staff;
	}

	public String getUserIdArr() {
		return userIdArr;
	}

	public void setUserIdArr(String userIdArr) {
		this.userIdArr = userIdArr;
	}

	public PubHw getHw() {
		return hw;
	}

	public void setHw(PubHw hw) {
		this.hw = hw;
	}

	public String getHwIdArr() {
		return hwIdArr;
	}

	public void setHwIdArr(String hwIdArr) {
		this.hwIdArr = hwIdArr;
	}

	public SysPurview getPurview() {
		return purview;
	}

	public void setPurview(SysPurview purview) {
		this.purview = purview;
	}

	public String getPurIdArr() {
		return purIdArr;
	}

	public void setPurIdArr(String purIdArr) {
		this.purIdArr = purIdArr;
	}

	public SysStaffPurview getStaffPur() {
		return staffPur;
	}

	public void setStaffPur(SysStaffPurview staffPur) {
		this.staffPur = staffPur;
	}

	public String getStaffPurIdArr() {
		return staffPurIdArr;
	}

	public void setStaffPurIdArr(String staffPurIdArr) {
		this.staffPurIdArr = staffPurIdArr;
	}

	public SysStaffRegCode getStaffRegCode() {
		return staffRegCode;
	}

	public void setStaffRegCode(SysStaffRegCode staffRegCode) {
		this.staffRegCode = staffRegCode;
	}

	public String getStaffRegCodeIdArr() {
		return staffRegCodeIdArr;
	}

	public void setStaffRegCodeIdArr(String staffRegCodeIdArr) {
		this.staffRegCodeIdArr = staffRegCodeIdArr;
	}

	public String getTabId() {
		return tabId;
	}

	public void setTabId(String tabId) {
		this.tabId = tabId;
	}

	public String getAllUser(){
		List<SysStaff> staffList = iSysService.getAllStaff();
		request.put("staffList", staffList);
		return "success";
	}
	
	public String getStaffIdArr() {
		return staffIdArr;
	}

	public void setStaffIdArr(String staffIdArr) {
		this.staffIdArr = staffIdArr;
	}

	public BigInteger getSelfId() {
		return selfId;
	}

	public void setSelfId(BigInteger selfId) {
		this.selfId = selfId;
	}

	public String addUser() {
		Date curDate = new Date();
		staff.setCreateTime(curDate);
		staff.setUpdateTime(curDate);
		iSysService.saveStaff(staff);
		return null;
	}
	
	public String editUser() {
		staff = iSysService.findStaffById(staff.getId());
		return "success";
	}
	
	public String removeUser() {
		if (userIdArr.length() == 0) {
			return null;
		}
		String userId[] = userIdArr.split(",");
		for (String id : userId) {
			iSysService.removeStaff(id);
		}
		return null;
	}
	
	public String saveUser() {
		staff.setUpdateTime(new Date());
		iSysService.saveStaff(staff);
		return null;
	}
		
	public String getAllHw() {
		List<PubHw> hwList = iSysService.getAllHw();
		request.put("hwList", hwList);
		return "success";
	}
	
	public String editHw() {
		hw = iSysService.findHwById(hw.getId());
		return "success";
	}
	
	public String removeHw() {
		if (hwIdArr.length() == 0) {
			return null;
		}
		String hwId[] = hwIdArr.split(",");
		for (String id : hwId) {
			iSysService.removeHw(id);
		}
		return null;
	}
	
	public String saveHw() {
		hw.setUpdateTime(new Date());
		iSysService.saveHw(hw);
		return null;
	}
	
	public String addHw() {
		Date curDate = new Date();
		hw.setCreateTime(curDate);
		hw.setUpdateTime(curDate);
		iSysService.saveHw(hw);
		return null;
	}

	public String getAllPurview() {
		List<SysPurview> purviewList = iSysService.getAllPurview();
		request.put("purviewList", purviewList);
		
		List<SysStaffPurview> staffPurList = iSysService.getAllStaffPur();
		request.put("staffPurList", staffPurList);
		
		List<SysStaffRegCode> staffRegCodeList = iSysService.getAllStaffRegCodeList();
		request.put("staffRegCodeList", staffRegCodeList);
		
		request.put("tabId", tabId);
		
		return "success";
	}
	
	private JSONArray getSubPur(BigInteger parentId) {
		JSONArray jsonArr = null;
		List<SysPurview> purList = sysPurDao.findByParentId(parentId);
		if (purList == null || purList.size() == 0) {
			return null;
		}
		jsonArr = new JSONArray();
		for (SysPurview pur : purList) {
			JSONObject obj = new JSONObject();
			obj.put("selfId", pur.getId());
			obj.put("name", pur.getName());
			obj.put("isParent", true);
			obj.put("parentId", parentId);
			JSONArray childArr = getSubPur(new BigInteger(pur.getId()));
			if (childArr != null) {
				obj.put("children", childArr);
			}
			jsonArr.add(obj);
		}
		
		return jsonArr;
	}
	
	public String getPurByStaff() {
		List<SysStaffPurview> staffPurList = staffPurDao.findByStaff(selfId);
		if (staffPurList != null) {
			JSONArray jsonArr = new JSONArray();
			for (SysStaffPurview staffPur : staffPurList) {
				jsonArr.add(staffPur.getPurviewId());
			}
			
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			try {
				PrintWriter out = response.getWriter();
				out.print(jsonArr.toString());
				out.flush();
				out.close();
			} catch (Exception e) {
				MiscUtils.getLogger().info(e.toString());
			}
		}
		
		return null;
	}
	
	public String getAllPur() {
		
		if (selfId == null) {
			selfId = BigInteger.ZERO;
		}
		JSONArray jsonArr = new JSONArray();
		List<SysPurview> purList = sysPurDao.findByParentId(BigInteger.ZERO);
		if (purList != null) {
			for (SysPurview pur : purList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("selfId", pur.getId());
				jsonObj.put("isParent", true);
				jsonObj.put("parentId", pur.getParentId());
				jsonObj.put("name", pur.getName());
				
				JSONArray jsonChildren = getSubPur(new BigInteger(pur.getId()));
				if (jsonChildren != null) {
					jsonObj.put("children", jsonChildren);
				}
				jsonArr.add(jsonObj);
			}
		}
		
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		try {
			PrintWriter out = response.getWriter();
			out.print(jsonArr.toString());
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	public String editPurview() {
		purview = iSysService.findPurviewById(purview.getId());
		return "success";
	}
	
	public String removePurview() {
		if (purIdArr.length() == 0) {
			return null;
		}
		String[] purId = purIdArr.split(",");
		for (String id : purId) {
			iSysService.removePurview(id);
		}
		return null;
	}
	
	public String savePurview() {
		purview.setUpdateTime(new Date());
		iSysService.savePurview(purview);
		return null;
	}
	
	public String addPurview() {
		Date curDate = new Date();
		purview.setCreateTime(curDate);
		purview.setUpdateTime(curDate);
		iSysService.savePurview(purview);
		return null;
	}
	
	public String addStaffPur() {
		Date curDate = new Date();
		staffPur.setCreateTime(curDate);
		staffPur.setUpdateTime(curDate);
		iSysService.saveStaffPur(staffPur);
		return null;
	}
	
	public String editStaffPur() {
		staffPur = iSysService.findStaffPurById(staffPur.getId());
		return "success";
	}
	
	public String saveStaffPur() {
		String[] staffId = staffIdArr.split(",");
		String[] purId = purIdArr.split(",");
		SysStaff curStaff = (SysStaff)session.get("user");
		if (curStaff == null) {
			return null;
		}
		Date date = new Date();
		for (String id : staffId) {
			staffPurDao.removeAllPurviewByStaff(new BigInteger(id));
			for (String purviewId : purId) {
				SysStaffPurview staffPurview = staffPurDao.findByStaffAndPurviewId(
						new BigInteger(id), new BigInteger(purviewId), true);
				if (staffPurview == null) {
					staffPurview = new SysStaffPurview();
					staffPurview.setCfgStaffId(new BigInteger(curStaff.getStaffId()));
					staffPurview.setCreateTime(date);
					staffPurview.setPurviewId(new BigInteger(purviewId));
					staffPurview.setStaffId(new BigInteger(id));
					staffPurview.setUpdateTime(date);
					staffPurDao.persist(staffPurview);
				} else {
					staffPurview.setDeleteState((byte)0);
					staffPurview.setUpdateTime(date);
					staffPurview.setCfgStaffId(new BigInteger(curStaff.getStaffId()));
					staffPurDao.merge(staffPurview);
				}
			}
		}
		
		return null;
	}
	
	
	
	public String removeStaffPur() {
		if (staffPurIdArr.length() == 0) {
			return null;
		}
		String[] staffPurId = staffPurIdArr.split(",");
		for (String id : staffPurId) {
			iSysService.removeStaffPur(id);
		}
		return null;
	}
		
	public String addStaffRegCode() {
		return null;
	}
	
	public String editStaffRegCode() {
		return "success";
	}
	
	public String saveStaffRegCode() {
		return null;
	}
	
	public String removeStaffRegCode() {
		return null;
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		this.session = (SessionMap) arg0;
	}

}

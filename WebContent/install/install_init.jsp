<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.apache.commons.lang.BooleanUtils"%>
<%@page import="org.apache.commons.lang.exception.ExceptionUtils"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="net.shopxx.util.FreeMarkerUtils"%>
<%@page import="net.shopxx.util.JsonUtils"%>
<%@include file="common.jsp"%>
<%
	Boolean agreeAgreement = (Boolean) session.getAttribute("agreeAgreement");
	if (BooleanUtils.isNotTrue(agreeAgreement)) {
		response.sendRedirect("index.jsp");
		return;
	}
	
	String databaseType = (String) session.getAttribute("databaseType");
	String databaseHost = (String) session.getAttribute("databaseHost");
	String databasePort = (String) session.getAttribute("databasePort");
	String databaseUsername = (String) session.getAttribute("databaseUsername");
	String databasePassword = (String) session.getAttribute("databasePassword");
	String databaseName = (String) session.getAttribute("databaseName");
	String adminUsername = (String) session.getAttribute("adminUsername");
	String adminPassword = (String) session.getAttribute("adminPassword");
	
	boolean failed = false;
	String message = "";
	String stackTrace = "";
	
	if (StringUtils.isEmpty(databaseType)) {
		failed = true;
		message = "数据库类型不允许为空!";
	} else if (StringUtils.isEmpty(databaseHost)) {
		failed = true;
		message = "数据库主机不允许为空!";
	} else if (StringUtils.isEmpty(databasePort)) {
		failed = true;
		message = "数据库端口不允许为空!";
	} else if (StringUtils.isEmpty(databaseUsername)) {
		failed = true;
		message = "数据库用户名不允许为空!";
	} else if (StringUtils.isEmpty(databaseName)) {
		failed = true;
		message = "数据库名称不允许为空!";
	} else if (StringUtils.isEmpty(adminUsername)) {
		failed = true;
		message = "管理员用户名不允许为空!";
	} else if (adminUsername.length() < 2 || adminUsername.length() > 20) {
		failed = true;
		message = "管理员用户名长度必须在2-20之间!";
	} else if (StringUtils.isEmpty(adminPassword)) {
		failed = true;
		message = "管理员密码不允许为空!";
	} else if (adminPassword.length() < 4 || adminPassword.length() > 40) {
		failed = true;
		message = "管理员密码长度必须在4-20之间!";
	}
	
	Map<String, Object> data = new HashMap<String, Object>();
	data.put("failed", failed);
	data.put("message", message);
	data.put("stackTrace", stackTrace.replaceAll("\\r?\\n", "</br>"));
	JsonUtils.writeValue(response.getWriter(), data);
%>
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
	String importDemo = (String) session.getAttribute("importDemo");
	
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
	} else if (StringUtils.isEmpty(importDemo)) {
		failed = true;
		message = "初始化DEMO数据参数错误!";
	}
	
	String jdbcUrl = null;
	File sqlFile = null;
	
	
	
	Map<String, Object> data = new HashMap<String, Object>();
	data.put("failed", failed);
	data.put("message", message);
	data.put("stackTrace", stackTrace.replaceAll("\\r?\\n", "</br>"));
	JsonUtils.writeValue(response.getWriter(), data);
%>
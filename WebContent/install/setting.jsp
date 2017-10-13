<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.BooleanUtils"%>
<%@include file="common.jsp"%>
<%
	Boolean agreeAgreement = (Boolean) session.getAttribute("agreeAgreement");
	if (BooleanUtils.isNotTrue(agreeAgreement)) {
		response.sendRedirect("index.jsp");
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>系统配置 - Powered By SHOP++</title>
<meta name="author" content="SHOP++ Team" />
<meta name="copyright" content="SHOP++" />
<link href="css/install.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
$().ready( function() {

	var $settingForm = $("#settingForm");
	var $databaseType = $("#databaseType");
	var $databaseHost = $("#databaseHost");
	var $databasePort = $("#databasePort");
	var $databaseUsername = $("#databaseUsername");
	var $databaseName = $("#databaseName");
	var $adminUsername = $("#adminUsername");
	var $adminPassword = $("#adminPassword");
	var $reAdminPassword = $("#reAdminPassword");
	var $createDatabase = $("#createDatabase");
	var $previous = $("#previous");
	
	$databaseType.change( function() {
		if ($databaseType.val() == "mysql") {
			$databasePort.val("3306");
			$createDatabase.prop("disabled", false).prop("checked", true);
		} else if ($databaseType.val() == "sqlserver") {
			$databasePort.val("1433");
			$createDatabase.prop("disabled", true).prop("checked", false);
		} else if ($databaseType.val() == "oracle") {
			$databasePort.val("1521");
			$createDatabase.prop("disabled", true).prop("checked", false);
		}
	});
	
	$settingForm.submit( function() {
		if ($databaseType.val() == "") {
			alert("请选择数据库类型!");
			$databaseType.focus();
			return false;
		}
		if ($.trim($databaseHost.val()) == "") {
			alert("请填写数据库主机!");
			$databaseHost.focus();
			return false;
		}
		if ($.trim($databasePort.val()) == "") {
			alert("请填写数据库端口!");
			$databasePort.focus();
			return false;
		}
		if ($.trim($databaseUsername.val()) == "") {
			alert("请填写数据库用户名!");
			$databaseUsername.focus();
			return false;
		}
		if ($.trim($databaseName.val()) == "") {
			alert("请填写数据库名称!");
			$databaseName.focus();
			return false;
		}
		if ($.trim($adminUsername.val()) == "") {
			alert("请填写管理员用户名!");
			$adminUsername.focus();
			return false;
		}
		if ($.trim($adminUsername.val()).length < 2 || $.trim($adminUsername.val()).length > 20) {
			alert("管理员用户名长度必须在2-20之间!");
			$adminUsername.focus();
			return false;
		}
		if ($.trim($adminPassword.val()) == "") {
			alert("请填写管理员密码!");
			$adminPassword.focus();
			return false;
		}
		if ($.trim($adminPassword.val()).length < 4 || $.trim($adminPassword.val()).length > 20) {
			alert("管理员密码长度必须在4-20之间!");
			$adminPassword.focus();
			return false;
		}
		if ($.trim($reAdminPassword.val()) != $.trim($adminPassword.val())) {
			alert("两次管理员密码输入不正确!");
			$reAdminPassword.focus();
			return false;
		}
	});
	
	$previous.click( function() {
		location.href = "check.jsp?agreeAgreement=true";
	});

});
</script>
</head>
<body>
	<div class="header">
		<div class="title">SHOP++ 安装程序 - 系统配置</div>
		<div class="banner"></div>
	</div>
	<div class="body">
		<form id="settingForm" action="install.jsp" method="post">
			<div class="bodyLeft">
				<ul class="step">
					<li>许可协议</li>
					<li>环境检测</li>
					<li class="current">系统配置</li>
					<li>系统安装</li>
					<li>完成安装</li>
				</ul>
			</div>
			<div class="bodyRight">
				<table>
					<tr>
						<th colspan="2">数据库设置</th>
					</tr>
					<tr>
						<td width="120">数据库类型:</td>
						<td>
							<select id="databaseType" name="databaseType">
								<option value="">请选择...</option>
								<option value="mysql">MySQL</option>
								<option value="sqlserver" selected>SQL Server</option>
								<option value="oracle">Oracle</option>
							</select>
							<span class="requireField">*</span>
						</td>
					</tr>
					<tr>
						<td>数据库主机:</td>
						<td>
							<input type="text" id="databaseHost" name="databaseHost" class="text"  maxlength="200" value="101.200.125.58" />
							<span class="requireField">*</span>
						</td>
					</tr>
					<tr>
						<td>数据库端口:</td>
						<td>
							<input type="text" id="databasePort" name="databasePort" class="text"  maxlength="200" value="1433"/>
							<span class="requireField">*</span>
						</td>
					</tr>
					<tr>
						<td>数据库用户名:</td>
						<td>
							<input type="text" id="databaseUsername" name="databaseUsername" class="text" maxlength="200" value="web"/>
							<span class="requireField">*</span>
						</td>
					</tr>
					<tr>
						<td>数据库密码:</td>
						<td>
							<input type="password" id="databasePassword" name="databasePassword" class="text" maxlength="200" autocomplete="off" value="fangliguo"/>
						</td>
					</tr>
					<tr>
						<td>数据库名称:</td>
						<td>
							<input type="text" id="databaseName" name="databaseName" class="text" value="truckdata2016a" maxlength="200" />
							<span class="requireField">*</span>
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<th colspan="2">管理员设置</th>
					</tr>
					<tr>
						<td width="120">用户名:</td>
						<td>
							<input type="text" id="adminUsername" name="adminUsername" class="text" value="admin" maxlength="20" />
							<span class="requireField">*</span>
						</td>
					</tr>
					<tr>
						<td>密码:</td>
						<td>
							<input type="password" id="adminPassword" name="adminPassword" class="text" maxlength="20" autocomplete="off" value="admin"/>
							<span class="requireField">*</span>
						</td>
					</tr>
					<tr>
						<td>重复密码:</td>
						<td>
							<input type="password" id="reAdminPassword" name="reAdminPassword" class="text" maxlength="20" autocomplete="off" value="admin"/>
							<span class="requireField">*</span>
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<th colspan="2">其它设置</th>
					</tr>
					<tr>
						<td width="120">区域设置:</td>
						<td>
							<select id="locale" name="locale">
								<option value="zh_CN" selected="selected">中文(简体, 中国)</option>
								<option value="zh_TW">中文(繁体, 台湾)</option>
								<option value="en_US">英文(美国)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td width="120">自动创建数据库:</td>
						<td>
							<input type="checkbox" id="createDatabase" name="createDatabase" value="true" />
						</td>
					</tr>
					<tr>
						<td>初始化DEMO数据:</td>
						<td>
							<input type="checkbox" id="importDemo" name="importDemo" value="true" checked="checked" />
						</td>
					</tr>
				</table>
			</div>
			<div class="buttonArea">
				<input type="button" id="previous" class="button" value="上 一 步" />&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="submit" class="button" value="立即安装" />
			</div>
		</form>
	</div>
	<div class="footer">
		<p class="copyright">Copyright © 2005-2017 shopxx.net All Rights Reserved.</p>
	</div>
</body>
</html>
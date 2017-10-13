<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${message("admin.orderRefunds.list")} - Powered By SHOP++</title>
<meta name="author" content="SHOP++ Team" />
<meta name="copyright" content="SHOP++" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/list.js"></script>
<script type="text/javascript">
$().ready(function() {

	[@flash_message /]

});
</script>
</head>
<body>
	<div class="breadcrumb">
		<a href="${base}/admin/index">${message("admin.breadcrumb.home")}</a> &raquo; ${message("admin.orderRefunds.list")} <span>(${message("admin.page.total", page.total)})</span>
	</div>
	<form id="listForm" action="list" method="get">
		<div class="bar">
			<div class="buttonGroup">
				<a href="javascript:;" id="deleteButton" class="iconButton disabled">
					<span class="deleteIcon">&nbsp;</span>${message("admin.common.delete")}
				</a>
				<a href="javascript:;" id="refreshButton" class="iconButton">
					<span class="refreshIcon">&nbsp;</span>${message("admin.common.refresh")}
				</a>
				<div id="pageSizeMenu" class="dropdownMenu">
					<a href="javascript:;" class="button">
						${message("admin.page.pageSize")}<span class="arrow">&nbsp;</span>
					</a>
					<ul>
						<li[#if page.pageSize == 10] class="current"[/#if] val="10">10</li>
						<li[#if page.pageSize == 20] class="current"[/#if] val="20">20</li>
						<li[#if page.pageSize == 50] class="current"[/#if] val="50">50</li>
						<li[#if page.pageSize == 100] class="current"[/#if] val="100">100</li>
					</ul>
				</div>
			</div>
			<div id="searchPropertyMenu" class="dropdownMenu">
				<div class="search">
					<span class="arrow">&nbsp;</span>
					<input type="text" id="searchValue" name="searchValue" value="${page.searchValue}" maxlength="200" />
					<button type="submit">&nbsp;</button>
				</div>
				<ul>
					<li[#if page.searchProperty == "sn"] class="current"[/#if] val="sn">${message("OrderRefunds.sn")}</li>
					<li[#if page.searchProperty == "account"] class="current"[/#if] val="account">${message("OrderRefunds.account")}</li>
					<li[#if page.searchProperty == "payee"] class="current"[/#if] val="payee">${message("OrderRefunds.payee")}</li>
				</ul>
			</div>
		</div>
		<table id="listTable" class="list">
			<tr>
				<th class="check">
					<input type="checkbox" id="selectAll" />
				</th>
				<th>
					<a href="javascript:;" class="sort" name="sn">${message("OrderRefunds.sn")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="method">${message("OrderRefunds.method")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="paymentMethod">${message("OrderRefunds.paymentMethod")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="amount">${message("OrderRefunds.amount")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="payee">${message("OrderRefunds.payee")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="order">${message("OrderRefunds.order")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="createdDate">${message("admin.common.createdDate")}</a>
				</th>
				<th>
					<span>${message("admin.common.action")}</span>
				</th>
			</tr>
			[#list page.content as refunds]
				<tr>
					<td>
						<input type="checkbox" name="ids" value="${refunds.id}" />
					</td>
					<td>
						${refunds.sn}
					</td>
					<td>
						${message("OrderRefunds.Method." + refunds.method)}
					</td>
					<td>
						${refunds.paymentMethod}
					</td>
					<td>
						${currency(refunds.amount, true)}
					</td>
					<td>
						${refunds.payee}
					</td>
					<td>
						${refunds.order.sn}
					</td>
					<td>
						<span title="${refunds.createdDate?string("yyyy-MM-dd HH:mm:ss")}">${refunds.createdDate}</span>
					</td>
					<td>
						<a href="view?id=${refunds.id}">[${message("admin.common.view")}]</a>
					</td>
				</tr>
			[/#list]
		</table>
		[@pagination pageNumber = page.pageNumber totalPages = page.totalPages]
			[#include "/admin/include/pagination.ftl"]
		[/@pagination]
	</form>
</body>
</html>
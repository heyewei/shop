<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${message("admin.memberAttribute.edit")} - Powered By SHOP++</title>
<meta name="author" content="SHOP++ Team" />
<meta name="copyright" content="SHOP++" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $addOptionButton = $("#addOptionButton");
	var $optionTable = $("#optionTable");
	
	[@flash_message /]
	
	// 增加可选项
	$addOptionButton.click(function() {
		$optionTable.append(
			[@compress single_line = true]
				'<tr>
					<td>
						<input type="text" name="options" class="text options" maxlength="200" \/>
					<\/td>
					<td>
						<a href="javascript:;" class="remove">[${message("admin.common.delete")}]<\/a>
					<\/td>
				<\/tr>'
			[/@compress]
		);
	});
	
	// 删除可选项
	$optionTable.on("click", "a.remove", function() {
		if ($optionTable.find("tr").size() <= 2) {
			$.message("warn", "${message("admin.common.deleteAllNotAllowed")}");
			return false;
		}
		$(this).closest("tr").remove();
	});
	
	$.validator.addClassRules({
		options: {
			required: true
		}
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			type: "required",
			name: "required",
			pattern: {
				remote: {
					url: "check_pattern",
					cache: false
				}
			},
			order: "digits"
		},
		messages: {
			pattern: {
				remote: "${message("admin.memberAttribute.syntaxError")}"
			}
		}
	});

});
</script>
</head>
<body>
	<div class="breadcrumb">
		${message("admin.memberAttribute.edit")}
	</div>
	<form id="inputForm" action="update" method="post">
		<input type="hidden" name="id" value="${memberAttribute.id}" />
		<table class="input">
			<tr>
				<th>
					${message("MemberAttribute.type")}:
				</th>
				<td>
					${message("MemberAttribute.Type." + memberAttribute.type)}
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("MemberAttribute.name")}:
				</th>
				<td>
					<input type="text" name="name" class="text" value="${memberAttribute.name}" maxlength="200" />
				</td>
			</tr>
			[#if memberAttribute.type != "select" && memberAttribute.type != "checkbox"]
				<tr>
					<th>
						${message("MemberAttribute.pattern")}:
					</th>
					<td>
						<input type="text" id="pattern" name="pattern" class="text" value="${memberAttribute.pattern}" maxlength="200" />
					</td>
				</tr>
			[/#if]
			<tr>
				<th>
					${message("admin.common.order")}:
				</th>
				<td>
					<input type="text" name="order" class="text" value="${memberAttribute.order}" maxlength="9" />
				</td>
			</tr>
			<tr>
				<th>
					${message("admin.common.setting")}:
				</th>
				<td>
					<label>
						<input type="checkbox" name="isEnabled" value="true"[#if memberAttribute.isEnabled] checked="checked"[/#if] />${message("MemberAttribute.isEnabled")}
						<input type="hidden" name="_isEnabled" value="false" />
					</label>
					<label>
						<input type="checkbox" name="isRequired" value="true"[#if memberAttribute.isRequired] checked="checked"[/#if] />${message("MemberAttribute.isRequired")}
						<input type="hidden" name="_isRequired" value="false" />
					</label>
				</td>
			</tr>
			[#if memberAttribute.type?? && (memberAttribute.type == "select" || memberAttribute.type == "checkbox")]
				<tr>
					<th>
						&nbsp;
					</th>
					<td>
						<a href="javascript:;" id="addOptionButton" class="button">${message("admin.memberAttribute.addOption")}</a>
					</td>
				</tr>
				<tr>
					<th>
						&nbsp;
					</th>
					<td>
						<table id="optionTable" class="item">
							<tr>
								<th>
									${message("MemberAttribute.options")}
								</th>
								<th>
									${message("admin.common.action")}
								</th>
							</tr>
							[#list memberAttribute.options as option]
								<tr>
									<td>
										<input type="text" name="options" class="text options" value="${option}" maxlength="200" />
									</td>
									<td>
										<a href="javascript:;" class="remove">[${message("admin.common.delete")}]</a>
									</td>
								</tr>
							[/#list]
						</table>
					</td>
				</tr>
			[/#if]
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<input type="submit" class="button" value="${message("admin.common.submit")}" />
					<input type="button" class="button" value="${message("admin.common.back")}" onclick="history.back(); return false;" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
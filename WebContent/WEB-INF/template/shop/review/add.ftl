<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${product.name} ${message("shop.review.title")}[#if showPowered] - Powered By SHOP++[/#if]</title>
<meta name="author" content="SHOP++ Team" />
<meta name="copyright" content="SHOP++" />
<link href="${base}/resources/shop/css/animate.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/product.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/review.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.rating.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $reviewForm = $("#reviewForm");
	var $score = $("input.score");
	var $tips = $("#tips");
	var $content = $("#content");
	var $captcha = $("#captcha");
	var $submit = $("input:submit");
	
	// 评分
	$score.rating({
		callback: function(value, link) {
			$tips.text(message("${message("shop.review.tips")}", value));
		}
	});
	
	// 验证码图片
	$captcha.captchaImage();
	
	// 表单验证
	$reviewForm.validate({
		rules: {
			content: {
				required: true,
				maxlength: 200
			},
			captcha: "required"
		},
		submitHandler: function(form) {
			$.ajax({
				url: $reviewForm.attr("action"),
				type: "POST",
				data: $reviewForm.serialize(),
				dataType: "json",
				cache: false,
				beforeSend: function() {
					$submit.prop("disabled", true);
				},
				success: function() {
					setTimeout(function() {
						$submit.prop("disabled", false);
						location.href = "../detail/${product.id}";
					}, 3000);
				},
				error: function(xhr, textStatus, errorThrown) {
					setTimeout(function() {
						$submit.prop("disabled", false);
					}, 3000);
					$captcha.captchaImage("refresh", true);
				}
			});
		}
	});

});
</script>
</head>
<body>
	[#include "/shop/include/header.ftl" /]
	<div class="container review">
		<div class="row">
			<div class="span2">
				[#include "/shop/include/hot_product_category.ftl" /]
				[#include "/shop/include/hot_brand.ftl" /]
				[#include "/shop/include/hot_product.ftl" /]
				[#include "/shop/include/hot_promotion.ftl" /]
			</div>
			<div class="span10">
				<div class="breadcrumb">
					<ul>
						<li>
							<a href="${base}/">${message("shop.breadcrumb.home")}</a>
						</li>
						<li>
							<a href="${base}${product.path}">${abbreviate(product.name, 30)}</a>
						</li>
						<li>${message("shop.review.title")}</li>
					</ul>
				</div>
				<table class="info">
					<tr>
						<th rowspan="3">
							<img src="${product.thumbnail!setting.defaultThumbnailProductImage}" alt="${product.name}" />
						</th>
						<td>
							<a href="${base}${product.path}">${abbreviate(product.name, 50, "...")}</a>
						</td>
					</tr>
					<tr>
						<td>
							${message("Product.price")}: <strong>${currency(product.price, true, true)}</strong>
						</td>
					</tr>
					<tr>
						<td>
							[#if product.scoreCount > 0]
								<div>${message("Product.score")}: </div>
								<div class="score${(product.score * 2)?string("0")}"></div>
								<div>${product.score?string("0.0")}</div>
							[#else]
								[#if setting.isShowMarketPrice]
									${message("Product.marketPrice")}:
									<del>${currency(product.marketPrice, true, true)}</del>
								[/#if]
							[/#if]
						</td>
					</tr>
				</table>
				<form id="reviewForm" action="${base}/review/save" method="post">
					<input type="hidden" name="productId" value="${product.id}" />
					<div class="add">
						<table>
							<tr>
								<th>
									${message("Review.score")}:
								</th>
								<td>
									<input type="radio" name="score" class="score" value="1" title="${message("shop.review.score1")}" />
									<input type="radio" name="score" class="score" value="2" title="${message("shop.review.score2")}" />
									<input type="radio" name="score" class="score" value="3" title="${message("shop.review.score3")}" />
									<input type="radio" name="score" class="score" value="4" title="${message("shop.review.score4")}" />
									<input type="radio" name="score" class="score" value="5" title="${message("shop.review.score5")}" checked="checked" />
									<strong id="tips" class="tips">${message("shop.review.tips", 5)}</strong>
								</td>
							</tr>
							<tr>
								<th>
									${message("Review.content")}:
								</th>
								<td>
									<textarea id="content" name="content" class="text"></textarea>
								</td>
							</tr>
							[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("review")]
								<tr>
									<th>
										${message("shop.captcha.name")}:
									</th>
									<td>
										<span class="fieldSet">
											<input type="text" id="captcha" name="captcha" class="text captcha" maxlength="4" autocomplete="off" />
										</span>
									</td>
								</tr>
							[/#if]
							<tr>
								<th>
									&nbsp;
								</th>
								<td>
									<input type="submit" class="button" value="${message("shop.review.submit")}" />
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>
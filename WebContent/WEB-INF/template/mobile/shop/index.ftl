<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	[@seo type = "index"]
		<title>${seo.resolveTitle()}[#if showPowered] - Powered By SHOP++[/#if]</title>
		[#if seo.resolveKeywords()?has_content]
			<meta name="keywords" content="${seo.resolveKeywords()}">
		[/#if]
		[#if seo.resolveDescription()?has_content]
			<meta name="description" content="${seo.resolveDescription()}">
		[/#if]
	[/@seo]
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/mobile/shop/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/animate.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/common.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/index.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/mobile/shop/js/html5shiv.js"></script>
		<script src="${base}/resources/mobile/shop/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/mobile/shop/js/jquery.js"></script>
	<script src="${base}/resources/mobile/shop/js/jquery.lazyload.js"></script>
	<script src="${base}/resources/mobile/shop/js/bootstrap.js"></script>
	<script src="${base}/resources/mobile/shop/js/velocity.js"></script>
	<script src="${base}/resources/mobile/shop/js/velocity.ui.js"></script>
	<script src="${base}/resources/mobile/shop/js/underscore.js"></script>
	<script src="${base}/resources/mobile/shop/js/hammer.js"></script>
	<script src="${base}/resources/mobile/shop/js/common.js"></script>
	<script type="text/javascript">
	$().ready(function() {
		
		var $searchIcon = $("#searchIcon");
		var $searchPlaceholder = $("#searchPlaceholder");
		var $search = $("#search");
		var $searchSlideUp = $("#searchSlideUp");
		var $searchForm = $("#searchForm");
		var $keyword = $("#keyword");
		var $login = $("#login");
		var $member = $("#member");
		var $masthead = $("#masthead");
		var $productImage = $("div.products img");
		
		// 登录/会员中心
		if (getCookie("currentMemberUsername") != null) {
			$member.show();
		} else {
			$login.show();
		}
		
		// 搜索
		$searchIcon.add($searchPlaceholder).click(function() {
			$search.velocity("transition.slideDownBigIn");
		});
		
		// 搜索
		$searchSlideUp.click(function() {
			$search.velocity("transition.slideUpBigOut");
		});
		
		// 搜索
		$searchForm.submit(function() {
			if ($.trim($keyword.val()) == "") {
				return false;
			}
		});
		
		// 广告
		new Hammer($masthead.get(0)).on("swipeleft", function() {
			$masthead.carousel("next");
		}).on("swiperight", function() {
			$masthead.carousel("prev");
		});
		
		// 商品图片
		$productImage.lazyload({
			threshold: 100,
			effect: "fadeIn"
		});
	
	});
	</script>
</head>
<body class="index">
	<header>
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-2 text-center">
					<span id="searchIcon" class="glyphicon glyphicon-th-large"></span>
				</div>
				<div class="col-xs-8">
					<div id="searchPlaceholder" class="search-placeholder">
						${message("shop.index.keyword")}<span class="glyphicon glyphicon-search"></span>
					</div>
				</div>
				<div class="col-xs-2 text-center">
					<a id="login" class="login" href="${base}/member/login">${message("shop.index.login")}</a>
					<a id="member" class="member" href="${base}/member/index">
						<span class="fa fa-user-o"></span>
					</a>
				</div>
			</div>
			<div id="search" class="search">
				<div class="row">
					<div class="col-xs-1 text-center">
						<span id="searchSlideUp" class="glyphicon glyphicon-menu-up"></span>
					</div>
					<div class="col-xs-11">
						<form id="searchForm" action="${base}/product/search" method="get">
							<div class="input-group">
								<input id="keyword" name="keyword" class="form-control" type="text" placeholder="${message("shop.index.keyword")}">
								<span class="input-group-btn">
									<button class="btn btn-default" type="submit">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</form>
					</div>
				</div>
				[#if setting.hotSearches?has_content]
					<dl class="hot-search">
						<dt>
							<span class="glyphicon glyphicon-star-empty"></span>${message("shop.index.hotSearch")}
						</dt>
						[#list setting.hotSearches as hotSearch]
							<dd>
								<a href="${base}/product/search?keyword=${hotSearch?url}">${hotSearch}</a>
							</dd>
						[/#list]
					</dl>
				[/#if]
			</div>
		</div>
	</header>
	<main>
		<div class="container-fluid">
			<div id="masthead" class="masthead carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li class="active" data-target="#masthead" data-slide-to="0"></li>
					<li data-target="#masthead" data-slide-to="1"></li>
					<li data-target="#masthead" data-slide-to="2"></li>
				</ol>
				<ul class="carousel-inner">
					<li class="item active">
						<a href="#">
							<img src="${base}/upload/image/ad1.jpg" alt="荣耀">
						</a>
					</li>
				</ul>
			</div>
			<nav>
				<div class="row">
					<div class="col-xs-3 text-center">
						<a href="${base}/product/list/1">
							<img src="${base}/upload/image/index_nav_1.png" alt="积分乐园">
							配件
						</a>
					</div>
					<div class="col-xs-3 text-center">
						<a href="${base}/product/list/2">
							<img src="${base}/upload/image/index_nav_2.png" alt="充值中心">
							快消品
						</a>
					</div>
					<div class="col-xs-3 text-center">
						<a href="${base}/product/list/3">
							<img src="${base}/upload/image/index_nav_3.png" alt="办公电器">
							轮胎
						</a>
					</div>
					<div class="col-xs-3 text-center">
						<a href="${base}/product/list/4">
							<img src="${base}/upload/image/index_nav_4.png" alt="平板来袭">
							工具
						</a>
					</div>
					<div class="col-xs-3 text-center">
						<a href="${base}/product/list/5">
							<img src="${base}/upload/image/index_nav_5.png" alt="手机专场">
							新车
						</a>
					</div>
					<div class="col-xs-3 text-center">
						<a href="${base}/product/list/6">
							<img src="${base}/upload/image/index_nav_6.png" alt="心随乐动">
							保险
						</a>
					</div>
					<div class="col-xs-3 text-center">
						<a href="${base}/product/list/7">
							<img src="${base}/upload/image/index_nav_7.png" alt="心随乐动">
							积分商城
						</a>
					</div>
					<div class="col-xs-3 text-center">
						<a href="${base}/product/list/8">
							<img src="${base}/upload/image/index_nav_8.png" alt="心随乐动">
							精品商城
						</a>
					</div>
				</div>
			</nav>
			
			[@product_category_root_list count = 3]
				[#list productCategories as productCategory]
					<div class="products panel panel-flat panel-condensed">
						<div class="panel-heading orange">${productCategory.name}</div>
						<div class="panel-body">
							<div class="row">
								[@product_list productCategoryId = productCategory.id count = 6]
									[#list products as product]
										[#assign defaultSku = product.defaultSku /]
										<div class="col-xs-4">
											<div class="thumbnail thumbnail-flat thumbnail-condensed">
												<a href="${base}${product.path}">
													<img class="img-responsive center-block" src="${base}/upload/image/blank.gif" alt="${product.name}" data-original="${product.image!setting.defaultThumbnailProductImage}">
													<h4 class="text-overflow">${product.name}</h4>
													<p class="text-overflow text-muted small">${product.caption}</p>
												</a>
												[#if product.type == "general"]
													<strong class="red">${currency(defaultSku.price, true)}</strong>
												[#elseif product.type == "exchange"]
													<span class="small">${message("Sku.exchangePoint")}:</span>
													<strong class="red">${defaultSku.exchangePoint}</strong>
												[/#if]
											</div>
										</div>
									[/#list]
								[/@product_list]
							</div>
						</div>
					</div>
				[/#list]
			[/@product_category_root_list]
		</div>
	</main>
	<footer class="footer-fixed">
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-3 text-center active">
					<a href="${base}/">
					<span class="glyphicon glyphicon-home"></span>
					${message("shop.common.index")}</a>
				</div>
				<div class="col-xs-3 text-center">
					<a href="${base}/product_category">
					<span class="glyphicon glyphicon-th-list"></span>
					${message("shop.common.productCategory")}</a>
				</div>
				<div class="col-xs-3 text-center">
					<a href="${base}/cart/list">
					<span class="glyphicon glyphicon-shopping-cart"></span>
					${message("shop.common.cart")}</a>
				</div>
				<div class="col-xs-3 text-center">
					<a href="${base}/member/index">
					<span class="glyphicon glyphicon-user"></span>
					${message("shop.common.member")}</a>
				</div>
			</div>
		</div>
	</footer>
</body>
</html>
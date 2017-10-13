/*
 * Copyright 2005-2017 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package net.shopxx.controller.admin;

import java.math.BigDecimal;
import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.shopxx.Message;
import net.shopxx.Pageable;
import net.shopxx.entity.BaseEntity;
import net.shopxx.entity.Business;
import net.shopxx.entity.BusinessAttribute;
import net.shopxx.service.BusinessAttributeService;
import net.shopxx.service.BusinessService;
import net.shopxx.service.UserService;

/**
 * Controller - 商家
 * 
 * @author SHOP++ Team
 * @version 5.0
 */
@Controller("adminBusinessController")
@RequestMapping("/admin/business")
public class BusinessController extends BaseController {

	@Inject
	private BusinessService businessService;
	@Inject
	private UserService userService;
	@Inject
	private BusinessAttributeService businessAttributeService;

	/**
	 * 检查用户名是否存在
	 */
	@GetMapping("/check_username")
	public @ResponseBody boolean checkUsername(String username) {
		return StringUtils.isNotEmpty(username) && !businessService.usernameExists(username);
	}

	/**
	 * 检查E-mail是否存在
	 */
	@GetMapping("/check_email")
	public @ResponseBody boolean checkEmail(Long id, String email) {
		return StringUtils.isNotEmpty(email) && businessService.emailUnique(id, email);
	}

	/**
	 * 检查手机是否存在
	 */
	@GetMapping("/check_mobile")
	public @ResponseBody boolean checkMobile(Long id, String mobile) {
		return StringUtils.isNotEmpty(mobile) && businessService.mobileUnique(id, mobile);
	}

	/**
	 * 查看
	 */
	@GetMapping("/view")
	public String view(Long id, ModelMap model) {
		model.addAttribute("businessAttributes", businessAttributeService.findList(true, true));
		model.addAttribute("business", businessService.find(id));
		return "admin/business/view";
	}

	/**
	 * 添加
	 */
	@GetMapping("/add")
	public String add(ModelMap model) {
		model.addAttribute("business", businessService.findAll());
		model.addAttribute("businessAttributes", businessAttributeService.findList(true, true));
		return "admin/business/add";
	}

	/**
	 * 保存
	 */
	@PostMapping("/save")
	public String save(Business business, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		if (!isValid(Business.class, BaseEntity.Save.class)) {
			return ERROR_VIEW;
		}
		if (businessService.usernameExists(business.getUsername())) {
			return ERROR_VIEW;
		}
		if (businessService.emailExists(business.getEmail())) {
			return ERROR_VIEW;
		}
		if (!StringUtils.isNotEmpty(business.getMobile()) && businessService.mobileExists(business.getMobile())) {
			return ERROR_VIEW;
		}

		business.removeAttributeValue();
		for (BusinessAttribute businessAttribute : businessAttributeService.findList(true, true)) {
			String[] values = request.getParameterValues("businessAttribute_" + businessAttribute.getId());
			if (!businessAttributeService.isValid(businessAttribute, values)) {
				return ERROR_VIEW;
			}
			Object memberAttributeValue = businessAttributeService.toBusinessAttributeValue(businessAttribute, values);
			business.setAttributeValue(businessAttribute, memberAttributeValue);
		}

		business.setBalance(BigDecimal.ZERO);
		business.setFrozenFund(BigDecimal.ZERO);
		business.setIsLocked(false);
		business.setLockDate(null);
		business.setLastLoginIp(request.getRemoteAddr());
		business.setLastLoginDate(new Date());
		business.setStore(null);
		business.setCashes(null);
		business.setBusinessDepositLogs(null);

		userService.register(business);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list";
	}

	/**
	 * 编辑
	 */
	@GetMapping("/edit")
	public String edit(Long id, ModelMap model) {
		model.addAttribute("businessAttributes", businessAttributeService.findList(true, true));
		model.addAttribute("business", businessService.find(id));
		return "admin/business/edit";
	}

	/**
	 * 更新
	 */
	@PostMapping("/update")
	public String update(Business business, Long id, Long businessRankId, Boolean unlock, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		if (!isValid(business)) {
			return ERROR_VIEW;
		}
		if (!businessService.emailUnique(id, business.getEmail())) {
			return ERROR_VIEW;
		}
		if (StringUtils.isNotEmpty(business.getMobile()) && !businessService.mobileUnique(id, business.getMobile())) {
			return ERROR_VIEW;
		}
		business.removeAttributeValue();
		for (BusinessAttribute businessAttribute : businessAttributeService.findList(true, true)) {
			String[] values = request.getParameterValues("businessAttribute_" + businessAttribute.getId());
			if (!businessAttributeService.isValid(businessAttribute, values)) {
				return ERROR_VIEW;
			}
			Object businessAttributeValue = businessAttributeService.toBusinessAttributeValue(businessAttribute, values);
			business.setAttributeValue(businessAttribute, businessAttributeValue);
		}
		Business pbusiness = businessService.find(id);
		if (pbusiness == null) {
			return ERROR_VIEW;
		}
		if (BooleanUtils.isTrue(pbusiness.getIsLocked()) && BooleanUtils.isTrue(unlock)) {
			userService.unlock(business);
			businessService.update(business, "username", "encodedPassword", "balance", "frozenFund", "businessDepositLogs", "cashes", "lastLoginIp", "lastLoginDate");
		} else {
			businessService.update(business, "username", "encodedPassword", "balance", "frozenFund", "businessDepositLogs", "cashes", "isLocked", "lockDate", "lastLoginIp", "lastLoginDate");
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list";
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Pageable pageable, ModelMap model) {
		model.addAttribute("business", businessService.findAll());
		model.addAttribute("businessAttributes", businessAttributeService.findAll());
		model.addAttribute("page", businessService.findPage(pageable));
		return "admin/business/list";
	}

	/**
	 * 删除
	 */
	@PostMapping("/delete")
	public @ResponseBody Message delete(Long[] ids) {
		if (ids != null) {
			for (Long id : ids) {
				Business business = businessService.find(id);
				if (business != null && (business.getBalance().compareTo(BigDecimal.ZERO) > 0 || business.getStore() != null)) {
					return Message.error("admin.business.deleteExistDepositNotAllowed", business.getUsername());
				}
			}
			businessService.delete(ids);
		}
		return SUCCESS_MESSAGE;
	}

}
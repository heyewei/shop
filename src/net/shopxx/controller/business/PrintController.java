/*
 * Copyright 2005-2017 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package net.shopxx.controller.business;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import net.shopxx.entity.DeliveryCenter;
import net.shopxx.entity.DeliveryTemplate;
import net.shopxx.entity.Order;
import net.shopxx.entity.Store;
import net.shopxx.exception.UnauthorizedException;
import net.shopxx.security.CurrentStore;
import net.shopxx.service.DeliveryCenterService;
import net.shopxx.service.DeliveryTemplateService;
import net.shopxx.service.OrderService;

/**
 * Controller - 打印
 * 
 * @author SHOP++ Team
 * @version 5.0
 */
@Controller("businessPrintController")
@RequestMapping("/business/print")
public class PrintController extends BaseController {

	@Inject
	private OrderService orderService;
	@Inject
	private DeliveryTemplateService deliveryTemplateService;
	@Inject
	private DeliveryCenterService deliveryCenterService;

	/**
	 * 添加属性
	 */
	@ModelAttribute
	public void populateModel(Long orderId, Long deliveryTemplateId, Long deliveryCenterId, @CurrentStore Store currentStore, ModelMap model) {
		Order order = orderService.find(orderId);
		if (order != null && !currentStore.equals(order.getStore())) {
			throw new UnauthorizedException();
		}
		model.addAttribute("order", order);

		DeliveryTemplate deliveryTemplate = deliveryTemplateService.find(deliveryTemplateId);
		if (deliveryTemplate != null && !currentStore.equals(deliveryTemplate.getStore())) {
			throw new UnauthorizedException();
		}
		model.addAttribute("deliveryTemplate", deliveryTemplate);

		DeliveryCenter deliveryCenter = deliveryCenterService.find(deliveryCenterId);
		if (deliveryCenter != null && !currentStore.equals(deliveryCenter.getStore())) {
			throw new UnauthorizedException();
		}
		model.addAttribute("deliveryCenter", deliveryCenter);
	}

	/**
	 * 订单打印
	 */
	@GetMapping("/order")
	public String order(@ModelAttribute(binding = false) Order order, ModelMap model) {
		if (order == null) {
			return UNPROCESSABLE_ENTITY_VIEW;
		}

		model.addAttribute("order", order);
		return "business/print/order";
	}

	/**
	 * 购物单打印
	 */
	@GetMapping("/product")
	public String product(@ModelAttribute(binding = false) Order order, ModelMap model) {
		if (order == null) {
			return UNPROCESSABLE_ENTITY_VIEW;
		}

		model.addAttribute("order", order);
		return "business/print/product";
	}

	/**
	 * 发货单打印
	 */
	@GetMapping("/shipping")
	public String shipping(@ModelAttribute(binding = false) Order order, ModelMap model) {
		if (order == null) {
			return UNPROCESSABLE_ENTITY_VIEW;
		}

		model.addAttribute("order", order);
		return "business/print/shipping";
	}

	/**
	 * 快递单打印
	 */
	@GetMapping("/delivery")
	public String delivery(@ModelAttribute(binding = false) Order order, @ModelAttribute(binding = false) DeliveryTemplate deliveryTemplate, @ModelAttribute(binding = false) DeliveryCenter deliveryCenter, @CurrentStore Store currentStore, ModelMap model) {
		if (order == null) {
			return UNPROCESSABLE_ENTITY_VIEW;
		}
		if (deliveryTemplate == null) {
			deliveryTemplate = deliveryTemplateService.findDefault(currentStore);
		}
		if (deliveryCenter == null) {
			deliveryCenter = deliveryCenterService.findDefault(currentStore);
		}

		model.addAttribute("deliveryTemplates", deliveryTemplateService.findList(currentStore));
		model.addAttribute("deliveryCenters", deliveryCenterService.findAll(currentStore));
		model.addAttribute("order", order);
		model.addAttribute("deliveryTemplate", deliveryTemplate);
		model.addAttribute("deliveryCenter", deliveryCenter);
		if (deliveryTemplate != null) {
			model.addAttribute("content", deliveryTemplateService.resolveContent(deliveryTemplate, currentStore, deliveryCenter, order));
		}
		return "business/print/delivery";
	}

}
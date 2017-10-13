/*
 * Copyright 2005-2017 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package net.shopxx.service;

import java.util.List;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.entity.BusinessAttribute;

/**
 * Service - 商家注册项
 * 
 * @author SHOP++ Team
 * @version 5.0
 */
public interface BusinessAttributeService extends BaseService<BusinessAttribute, Long> {

	/**
	 * 查找未使用的对象属性序号
	 * 
	 * @return 未使用的对象属性序号，若无可用序号则返回null
	 */
	Integer findUnusedPropertyIndex();

	/**
	 * 查找 商家注册项
	 * 
	 * @param isEnabled
	 *            是否启用
	 * @param count
	 *            数量
	 * @param filters
	 *            筛选
	 * @param orders
	 *            排序
	 * @param useCache
	 *            是否使用缓存
	 * @return 会员注册项
	 */
	List<BusinessAttribute> findList(Boolean isEnabled, Integer count, List<Filter> filters, List<Order> orders, boolean useCache);

	/**
	 * 查找商家注册项
	 * 
	 * @param isEnabled
	 *            是否启用
	 * @param useCache
	 *            是否使用缓存
	 * @return 会员注册项
	 */
	List<BusinessAttribute> findList(Boolean isEnabled, boolean useCache);

	/**
	 * 商家注册项值验证
	 * 
	 * @param businessAttribute
	 *            商家注册项
	 * @param values
	 *            值
	 * @return 是否验证通过
	 */
	boolean isValid(BusinessAttribute businessAttribute, String[] values);

	/**
	 * 转换为商家注册项值
	 * 
	 * @param businessAttribute
	 *            商家注册项
	 * @param values
	 *            值
	 * @return 会员注册项值
	 */
	Object toBusinessAttributeValue(BusinessAttribute businessAttribute, String[] values);

}
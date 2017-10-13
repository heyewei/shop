/*
 * Copyright 2005-2017 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package net.shopxx.service;

import java.math.BigDecimal;

import net.shopxx.entity.MemberRank;

/**
 * Service - 会员等级
 * 
 * @author SHOP++ Team
 * @version 5.0
 */
public interface MemberRankService extends BaseService<MemberRank, Long> {

	/**
	 * 判断消费金额是否存在
	 * 
	 * @param amount
	 *            消费金额
	 * @return 消费金额是否存在
	 */
	boolean amountExists(BigDecimal amount);

	/**
	 * 判断消费金额是否唯一
	 * 
	 * @param id
	 *            ID
	 * @param amount
	 *            消费金额
	 * @return 消费金额是否唯一
	 */
	boolean amountUnique(Long id, BigDecimal amount);

	/**
	 * 查找默认会员等级
	 * 
	 * @return 默认会员等级，若不存在则返回null
	 */
	MemberRank findDefault();

	/**
	 * 根据消费金额查找符合此条件的最高会员等级
	 * 
	 * @param amount
	 *            消费金额
	 * @return 会员等级，不包含特殊会员等级，若不存在则返回null
	 */
	MemberRank findByAmount(BigDecimal amount);

}
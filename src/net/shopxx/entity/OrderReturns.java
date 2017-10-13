/*
 * Copyright 2005-2017 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package net.shopxx.entity;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.Transient;
import javax.validation.Valid;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.apache.commons.lang.StringUtils;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * Entity - 订单退货
 * 
 * @author SHOP++ Team
 * @version 5.0
 */
@Entity
public class OrderReturns extends BaseEntity<Long> {

	private static final long serialVersionUID = -8019074120457087212L;

	/**
	 * 编号
	 */
	@Column(nullable = false, updatable = false, unique = true)
	private String sn;

	/**
	 * 配送方式
	 */
	@Column(updatable = false)
	private String shippingMethod;

	/**
	 * 物流公司
	 */
	@Column(updatable = false)
	private String deliveryCorp;

	/**
	 * 运单号
	 */
	@Length(max = 200)
	@Column(updatable = false)
	private String trackingNo;

	/**
	 * 物流费用
	 */
	@Min(0)
	@Digits(integer = 12, fraction = 3)
	@Column(updatable = false, precision = 21, scale = 6)
	private BigDecimal freight;

	/**
	 * 发货人
	 */
	@Length(max = 200)
	@Column(updatable = false)
	private String shipper;

	/**
	 * 地区
	 */
	@Column(updatable = false)
	private String area;

	/**
	 * 地址
	 */
	@Length(max = 200)
	@Column(updatable = false)
	private String address;

	/**
	 * 邮编
	 */
	@Length(max = 200)
	@Pattern(regexp = "^\\d{6}$")
	@Column(updatable = false)
	private String zipCode;

	/**
	 * 电话
	 */
	@Length(max = 200)
	@Pattern(regexp = "^\\d{3,4}-?\\d{7,9}$")
	@Column(updatable = false)
	private String phone;

	/**
	 * 备注
	 */
	@Length(max = 200)
	@Column(updatable = false)
	private String memo;

	/**
	 * 订单
	 */
	@NotNull
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "orders", nullable = false, updatable = false)
	private Order order;

	/**
	 * 订单退货项
	 */
	@Valid
	@NotEmpty
	@OneToMany(mappedBy = "orderReturns", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<OrderReturnsItem> orderReturnsItems = new ArrayList<>();

	/**
	 * 获取编号
	 * 
	 * @return 编号
	 */
	public String getSn() {
		return sn;
	}

	/**
	 * 设置编号
	 * 
	 * @param sn
	 *            编号
	 */
	public void setSn(String sn) {
		this.sn = sn;
	}

	/**
	 * 获取配送方式
	 * 
	 * @return 配送方式
	 */
	public String getShippingMethod() {
		return shippingMethod;
	}

	/**
	 * 设置配送方式
	 * 
	 * @param shippingMethod
	 *            配送方式
	 */
	public void setShippingMethod(String shippingMethod) {
		this.shippingMethod = shippingMethod;
	}

	/**
	 * 获取物流公司
	 * 
	 * @return 物流公司
	 */
	public String getDeliveryCorp() {
		return deliveryCorp;
	}

	/**
	 * 设置物流公司
	 * 
	 * @param deliveryCorp
	 *            物流公司
	 */
	public void setDeliveryCorp(String deliveryCorp) {
		this.deliveryCorp = deliveryCorp;
	}

	/**
	 * 获取运单号
	 * 
	 * @return 运单号
	 */
	public String getTrackingNo() {
		return trackingNo;
	}

	/**
	 * 设置运单号
	 * 
	 * @param trackingNo
	 *            运单号
	 */
	public void setTrackingNo(String trackingNo) {
		this.trackingNo = trackingNo;
	}

	/**
	 * 获取物流费用
	 * 
	 * @return 物流费用
	 */
	public BigDecimal getFreight() {
		return freight;
	}

	/**
	 * 设置物流费用
	 * 
	 * @param freight
	 *            物流费用
	 */
	public void setFreight(BigDecimal freight) {
		this.freight = freight;
	}

	/**
	 * 获取发货人
	 * 
	 * @return 发货人
	 */
	public String getShipper() {
		return shipper;
	}

	/**
	 * 设置发货人
	 * 
	 * @param shipper
	 *            发货人
	 */
	public void setShipper(String shipper) {
		this.shipper = shipper;
	}

	/**
	 * 获取地区
	 * 
	 * @return 地区
	 */
	public String getArea() {
		return area;
	}

	/**
	 * 设置地区
	 * 
	 * @param area
	 *            地区
	 */
	public void setArea(String area) {
		this.area = area;
	}

	/**
	 * 获取地址
	 * 
	 * @return 地址
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * 设置地址
	 * 
	 * @param address
	 *            地址
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * 获取邮编
	 * 
	 * @return 邮编
	 */
	public String getZipCode() {
		return zipCode;
	}

	/**
	 * 设置邮编
	 * 
	 * @param zipCode
	 *            邮编
	 */
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	/**
	 * 获取电话
	 * 
	 * @return 电话
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * 设置电话
	 * 
	 * @param phone
	 *            电话
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * 获取备注
	 * 
	 * @return 备注
	 */
	public String getMemo() {
		return memo;
	}

	/**
	 * 设置备注
	 * 
	 * @param memo
	 *            备注
	 */
	public void setMemo(String memo) {
		this.memo = memo;
	}

	/**
	 * 获取订单
	 * 
	 * @return 订单
	 */
	public Order getOrder() {
		return order;
	}

	/**
	 * 设置订单
	 * 
	 * @param order
	 *            订单
	 */
	public void setOrder(Order order) {
		this.order = order;
	}

	/**
	 * 获取订单退货项
	 * 
	 * @return 订单退货项
	 */
	public List<OrderReturnsItem> getOrderReturnsItems() {
		return orderReturnsItems;
	}

	/**
	 * 设置订单退货项
	 * 
	 * @param orderReturnsItems
	 *            订单退货项
	 */
	public void setOrderReturnsItems(List<OrderReturnsItem> orderReturnsItems) {
		this.orderReturnsItems = orderReturnsItems;
	}

	/**
	 * 获取数量
	 * 
	 * @return 数量
	 */
	@Transient
	public int getQuantity() {
		int quantity = 0;
		if (getOrderReturnsItems() != null) {
			for (OrderReturnsItem orderReturnsItem : getOrderReturnsItems()) {
				if (orderReturnsItem != null && orderReturnsItem.getQuantity() != null) {
					quantity += orderReturnsItem.getQuantity();
				}
			}
		}
		return quantity;
	}

	/**
	 * 设置配送方式
	 * 
	 * @param shippingMethod
	 *            配送方式
	 */
	@Transient
	public void setShippingMethod(ShippingMethod shippingMethod) {
		setShippingMethod(shippingMethod != null ? shippingMethod.getName() : null);
	}

	/**
	 * 设置物流公司
	 * 
	 * @param deliveryCorp
	 *            物流公司
	 */
	@Transient
	public void setDeliveryCorp(DeliveryCorp deliveryCorp) {
		setDeliveryCorp(deliveryCorp != null ? deliveryCorp.getName() : null);
	}

	/**
	 * 设置地区
	 * 
	 * @param area
	 *            地区
	 */
	@Transient
	public void setArea(Area area) {
		setArea(area != null ? area.getFullName() : null);
	}

	/**
	 * 持久化前处理
	 */
	@PrePersist
	public void prePersist() {
		setSn(StringUtils.lowerCase(getSn()));
	}

}
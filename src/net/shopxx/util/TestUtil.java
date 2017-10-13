package net.shopxx.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class TestUtil {

	public static void main(String[] args) {
		String url = "http://app.sxdkcls.com/shop/member/register/submit";
		// Stringurl="http://127.0.0.1:8080/member/register/submit";
		Map<String, String> failMap = new HashMap<String, String>();
		
		String sql = "select mobilephone,password from truck_baseuser ";
		//sql += "where mobilephone = '18910651313'";
		System.out.println(sql);
		// notin(selectmobilephonefromtruck_baseusergroupbymobilephonehavingcount(*)>1)";
		String[][] data = new DBCommon().select(sql);
		try {
			// 一次读入一行，直到读入null为文件结束
			for (int i = 0; i < data.length; i++) {
				try {
					String mobile = data[i][0].trim();
					String password = data[i][1];
					if(password!=null&&password.length()<4){
						password = "1234";
					}
					System.out.println(i + "行：获取baseuser中的数据" + mobile + ","
							+ password);

					String username = mobile + "sxd";
					String email = mobile + "@139.com";

					Map<String, Object> map = new HashMap<>();
					map.put("username", username);
					map.put("password", password.trim());
					map.put("email", email);
					map.put("mobile", mobile);

					System.out.println(i + "行：请求内容：" + map.toString());
					String result = WebUtils.post(url, map);
					System.out.println(i + "行：请求结果：" + result);

					if (!result.contains("恭喜您，账号注册成功")) {
						failMap.put(mobile, result);
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			System.out.println("失败结果：============================="+failMap.keySet().size());
			System.out.println(failMap.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}

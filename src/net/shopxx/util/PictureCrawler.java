package net.shopxx.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.shiro.util.StringUtils;

public class PictureCrawler {
	public static void main(String[] args) {
		getPicture("http://pic.dicts.cn/mydictimage/d210cc97-a726-4836-86ac-24aa66899120/f7ddfe0c-d063-4d82-a835-e302e75668ff/f2ebadb8-2a6c-4978-b6a1-83a77e2ac840.jpg");
	}

	public static void getPicture(String url) {
		try {
			String sql = "select imgc from truck_selleruser ";
			String[][] data = new DBCommon().select(sql);
			for (int i = 0; i < data.length; i++) {
				if(data[i][0]==null){
					continue;
				}
				if(data[i][0]!=null){
					if(data[i][0].contains("ic_launcher")||data[i][0].equals("null")||data[i][0].equals("seller_img_1499160636777_c.jpg")){
						continue;
					}
					
				}
				URL uri = new URL(
						"http://app.sxdkcls.com:8080/Truck//upload/image/"
								+ data[i][0]);
				
				HttpURLConnection urlcon2 = (HttpURLConnection) uri
						.openConnection();
				String message = urlcon2.getHeaderField(0);
				if (StringUtils.hasText(message)
						&& message.startsWith("HTTP/1.1 404")) {
					//System.out.println("不存在");
				} else {
					System.out.println("存在"+data[i][0]);
					InputStream in = uri.openStream();
					FileOutputStream fo = new FileOutputStream(new File(
							"e:/image/" + data[i][0]));
					byte[] buf = new byte[1024 * 10000];
					int length = 0;
					//System.out.println("开始下载:" + url);
					while ((length = in.read(buf, 0, buf.length)) != -1) {
						fo.write(buf, 0, length);
					}
					in.close();
					fo.close();
					
				}

			}
			System.out.println("下载完成");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

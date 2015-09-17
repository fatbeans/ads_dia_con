package utility;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


/**
 * 
 * @author LeiYun
 * 2015年8月14日
 */
public class dateTime {

	/**
	 * 转换为时间
	 * @author LeiYun
	 * 2015年8月14日
	 * @param format
	 * @param val
	 * @return
	 */
	public static Date converTo(String format, String val) {
		Date date = null;
		try {
 
			SimpleDateFormat formatObj = new java.text.SimpleDateFormat(format);
			date = formatObj.parse(val);;
		} catch (java.text.ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	

	/**
	 * 
	 * @author LeiYun
	 * 2015年9月14日
	 * @param format
	 * @param val
	 * @return
	 * @throws ParseException
	 */
	public static long converToLong(String format,Date val) throws ParseException {
		SimpleDateFormat formatter=new SimpleDateFormat(format);
		String time=formatter.format(val);  
		return Long.parseLong(time);
	}
	//public static addYear()
}

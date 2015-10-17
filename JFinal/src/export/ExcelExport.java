package export;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.kit.PathKit;
import dao.UserDetailsDao;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;

/**
 * Created by xinxin on 2015/7/27.
 */
public class ExcelExport {
    private static final String root_Dir = PathKit.getWebRootPath();
    private static final String exportDir = "export/";
    private static final String extension = ".xlsx";


    public static String exportExcelFile(JSONArray list, String filePostfix, String[] header, String[] key) throws
            Exception {
        String realFileName = root_Dir + "/" + exportDir + filePostfix + extension;
        String webFileName = "/" + exportDir + filePostfix + extension;
        File file = new File(realFileName);
        if (!file.exists()) {

            createExcelFile(file, list, header, key);
        }
        return webFileName;
    }

    public static String checkFileExists(String filePostfix) {
        String realFileName = root_Dir + "/" + exportDir + filePostfix + extension;
        String webFileName = "/" + exportDir + filePostfix + extension;
        File file = new File(realFileName);
        if (!file.exists()) {

            return null;
        }
        return webFileName;
    }

//    private static void createExcelFile(File file, List<UserDetailsDao> list, String[] header,
//                                        String[] key) {
//
//        // 先创建工作簿对象
//        SXSSFWorkbook workbook2007 = new SXSSFWorkbook(100);
//        // 创建工作表对象并命名
//        Sheet sheet = workbook2007.createSheet("信令详单");
//        Row headrow = sheet.createRow(0);
//
//
//        for (int i = 0; i < header.length; i++) {
//            Cell headnameCell = headrow.createCell(i);
//            headnameCell.setCellValue(header[i]);
//        }
//
//        // 遍历集合对象创建行和单元格
//        for (int i = 0; i < list.size(); i++) {
//            // 取出Student对象
//            UserDetailsDao item = list.get(i);
//            // 创建行
//            Row row = sheet.createRow(i + 1);
//            // 开始创建单元格并赋值
//            for (int j = 0; j < item.getAttrNames().length; j++) {
//                Cell nameCell = row.createCell(j);
//                String var = item.get(key[j]) == null ? "" : item.get(key[j])
//                        .toString();
//                nameCell.setCellValue(var);
//            }
//        }
//        // 生成文件
//
//
//        FileOutputStream fos = null;
//        try {
//            if (!file.getParentFile().exists()) {
//                file.getParentFile().mkdirs();
//            }
//
//            if (!file.exists()) {
//                file.createNewFile();
//            }
//            fos = new FileOutputStream(file);
//            workbook2007.write(fos);
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (fos != null) {
//                try {
//                    fos.close();
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//    }


    public static void main(String[] args) throws Exception {
        String[] header = new String[]{"年", "性", "名"};
        String[] key = new String[]{"age", "sex", "name"};

        JSONArray array = new JSONArray();

        array.add(JSONObject.parse("{\"age\":\"12\",\"sex\":\"男\",\"name\":\"阿拉\"}"));
        array.add(JSONObject.parse("{\"age\":\"12\",\"sex\":\"男\",\"name\":\"阿拉\"}"));
        array.add(JSONObject.parse("{\"age\":\"12\",\"sex\":\"男\",\"name\":\"阿拉\"}"));
        array.add(JSONObject.parse("{\"age\":\"12\",\"sex\":\"男\",\"name\":\"阿拉\"}"));
        array.add(JSONObject.parse("{\"age\":\"12\",\"sex\":\"男\",\"name\":\"阿拉\"}"));
        array.add(JSONObject.parse("{\"age\":\"12\",\"sex\":\"男\",\"name\":\"阿拉\"}"));
        array.add(JSONObject.parse("{\"age\":\"12\",\"sex\":\"男\",\"name\":\"阿拉\"}"));
        array.add(JSONObject.parse("{\"age\":\"12\",\"sex\":\"男\",\"name\":\"阿拉\"}"));
        array.add(JSONObject.parse("{\"age\":\"12\",\"sex\":\"男\",\"name\":\"阿拉\"}"));
        array.add(JSONObject.parse("{\"sex\":\"男\",\"name\":\"阿拉\"}"));

        File file = new File("g:/生成测试.xlsx");
        createExcelFile(file, array, header, key);
    }


    public static void createExcelFile(File file, JSONArray list, String[] header,
                                       String[] key) throws Exception {

        if (header.length != key.length) {
            throw (new Exception("header与key的长度不一致"));
        }
        // 先创建工作簿对象
        SXSSFWorkbook workbook2007 = new SXSSFWorkbook(100);
        // 创建工作表对象并命名
        Sheet sheet = workbook2007.createSheet("sheet1");
        Row headrow = sheet.createRow(0);


        for (int i = 0; i < header.length; i++) {
            Cell headnameCell = headrow.createCell(i);
            headnameCell.setCellValue(header[i]);
        }

        // 遍历集合对象创建行和单元格
        for (int i = 0; i < list.size(); i++) {
            // 取出Student对象
            JSONObject jsonObject = list.getJSONObject(i);
            // 创建行
            Row row = sheet.createRow(i + 1);
            // 开始创建单元格并赋值
            for (int j = 0; j < header.length; j++) {
                Cell nameCell = row.createCell(j);
                String var = jsonObject.get(key[j]) == null ? "" : jsonObject.getString(key[j]);
                nameCell.setCellValue(var);
            }
        }
        // 生成文件


        FileOutputStream fos = null;
        try {
            if (!file.getParentFile().exists()) {
                file.getParentFile().mkdirs();
            }

            if (!file.exists()) {
                file.createNewFile();
            }
            fos = new FileOutputStream(file);
            workbook2007.write(fos);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (fos != null) {
                try {
                    fos.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

}

/**
 * FileName: ImageUtil
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/2 18:25
 * Description: 图片上传工具类
 */
package com.qst.goldenarches.utils;

import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class ImageUtil {

    /**
     * 上传图片
     * @param request
     * @param pictureFile
     * @throws IOException
     */
    public static String upload(HttpServletRequest request, MultipartFile pictureFile) {
        //图片相对路径
        String imgName=null;
        if(!pictureFile.isEmpty()){
            // 使用UUID给图片重命名，并去掉四个“-”
            String imageName = UUID.randomUUID().toString().replaceAll("-", "");
            // 获取文件的扩展名
            String ext = FilenameUtils.getExtension(pictureFile.getOriginalFilename());
            // 设置图片上传路径
            String path=getRealPath(request);
            //文件夹不存在则创建
            File fdir = new File(path);
            if (!fdir.exists()) {
                fdir.mkdirs();
            }
            // 以绝对路径保存重名命后的图片
            try {
                pictureFile.transferTo(new File(path + imageName + "." + ext));
            } catch (IOException e) {
                e.printStackTrace();
                return null;
            }
            // 装配图片地址
            imgName = imageName + "." + ext;
        }
        return imgName;
    }

    public static void dropPic(HttpServletRequest request,String imgName) {
        //取出文件的绝对路径，然后用File方法删除相应文件。
        String absolutePath =getRealPath(request)+imgName;
        System.out.println("ImageUtil dropPic  absolutePath"+absolutePath);
        File file = new File(absolutePath);
        if (file.exists()) {
            file.delete();
        }
    }

    private static String getRealPath(HttpServletRequest request){
        String rootPath =request.getSession().getServletContext().getRealPath(File.separator);
        String relatPath = File.separator+"img"+ File.separator+"product"+ File.separator;
        return rootPath+relatPath;
    }
}

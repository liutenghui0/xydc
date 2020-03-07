package com.byh.biyesheji.controller;

import com.byh.biyesheji.pojo.Product;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * @description:
 * @author:刘腾辉
 * @create:2020/2/23 20:38
 */
@Controller
public class UploadController {

    /**
     * 文件上传
     */
    @ResponseBody
    @RequestMapping(value = "/product/upload",method = RequestMethod.POST)
    public Map<String,Object> upload(Product product,MultipartFile dropzFile, HttpServletRequest request){
        Map<String,Object> result = new HashMap<>();
        return result;
    }
}

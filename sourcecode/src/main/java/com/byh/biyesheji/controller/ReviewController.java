package com.byh.biyesheji.controller;

import com.byh.biyesheji.pojo.Review;
import com.byh.biyesheji.service.ProductService;
import com.byh.biyesheji.service.ReviewService;
import com.byh.biyesheji.util.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

/**
 * 评论模块controller
 */
@Controller
@RequestMapping("/review")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;
    @Autowired
    private ProductService productService;

    /**
     * 评论显示
     * @param model
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());//分页查询
        List<Review> list= reviewService.list();
        int total = (int) new PageInfo<>(list).getTotal();//总条数
        int currentPage = (int) new PageInfo<>(list).getPageNum();
        page.setTotal(total);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totals",list.size());
        model.addAttribute("list",list);
        model.addAttribute("total", total);
        return "pinglunpage/pinglun";
    }

    @RequestMapping("/del")
    public String del(int id, RedirectAttributes redirectAttributes){
        reviewService.del(id);
        redirectAttributes.addFlashAttribute("delSuccess", 200);
        return "redirect:list";
    }

    @ResponseBody
    @RequestMapping("/delMulti")
    public int delMulti(String ids){
        String[] reviewId = ids.split(",");
        reviewService.MultiDel(reviewId);
        int success = 200;
        return success;
    }
}

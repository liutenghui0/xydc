package com.byh.biyesheji.controller;

import com.byh.biyesheji.pojo.Category;
import com.byh.biyesheji.service.CategoryService;
import com.byh.biyesheji.util.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

/**
 * 商品分类模块controller
 */
@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @RequestMapping("/list")
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());//分页查询
        List<Category> list = categoryService.list();
        int total = (int) new PageInfo<>(list).getTotal();//总条数
        int currentPage = (int) new PageInfo<>(list).getPageNum();
        page.setTotal(total);
        model.addAttribute("list",list);
        model.addAttribute("size",list.size());
        model.addAttribute("total",total);
        model.addAttribute("page", page);
        model.addAttribute("currentPage", currentPage);
        return "productmodule/category-list";
    }


    @ResponseBody
    @RequestMapping("/addCategory")
    public int add(@RequestParam(value = "name")String name,RedirectAttributes redirectAttributes){
        Category category = new Category();
        category.setName(name);
        categoryService.save(category);
//        redirectAttributes.addFlashAttribute("addF", 100);
        int addF = 100;
        return addF;
    }

    @RequestMapping("/delCategory")
    public String del(@RequestParam(value = "id")int id, RedirectAttributes redirectAttributes){
        boolean flag = categoryService.del_info(id);
        if(flag == true){
            redirectAttributes.addFlashAttribute("flag",200);
        }else{
            redirectAttributes.addFlashAttribute("flag",500);
        }
        return "redirect:list";
    }

    @RequestMapping("/editCategory")
    public String edit(@RequestParam(value = "id")int id,Model model){
        Category category = categoryService.get(id);
        model.addAttribute("category",category);
        return "productmodule/category-edit";
    }

    @RequestMapping("/updateCategory")
    public String update(Category category,Model model){
        categoryService.update(category);
        return "redirect:list";
    }
}

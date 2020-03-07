package com.byh.biyesheji.controller;

import com.byh.biyesheji.pojo.Customer;
import com.byh.biyesheji.service.CustomerService;
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
 * 用户模块controller
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {
    @Autowired
    private CustomerService customerService;

    /**
     * 用户数据展示
     * @param model
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public String list(Model model, Page page)
    {
        PageHelper.offsetPage(page.getStart(),page.getCount());//分页查询
        List<Customer> list= customerService.list();
        int total = (int) new PageInfo<>(list).getTotal();//总条数
        int pageName = (int) new PageInfo<>(list).getPageNum();
        page.setTotal(total);
        model.addAttribute("list",list);
        model.addAttribute("totals",total);
        model.addAttribute("currentPage", pageName);//记录当前页
        return "cstpage/cst-list";
    }
    /**
     * 设置会员
     * @param id
     * @return
     */
    @RequestMapping("/shezhihuiyuan")
    @ResponseBody
    public String shezhihuiyuan(int id){
        customerService.shezhihuiyuan(id);
        return "success";
    }

    @RequestMapping("/del")
    public String del(int id, RedirectAttributes redirectAttributes)
    {
        customerService.del(id);
        redirectAttributes.addFlashAttribute("delSuccess", 200);
        return "redirect:list";
    }

    @ResponseBody
    @RequestMapping("/delMulti")
    public int delMulti(String ids){
        String[] productid = ids.split(",");
        customerService.MultiDel(productid);
        int successDel = 200;
        return successDel;
    }

    /**
     * 搜索
     * @param name
     * @param model
     * @param page
     * @return
     */
    @RequestMapping("/search")
    public String search(String name,Model model,Page page){
        if(name == null || name.equals("")){
            return "redirect:list";
        }else{
            Customer customer = new Customer();
            customer.setName(name);
            List<Customer> customerList = customerService.search(customer);
            PageHelper.offsetPage(page.getStart(),page.getCount());//分页查询
            int total = (int) new PageInfo<>(customerList).getTotal();//总条数
            int pageName = (int) new PageInfo<>(customerList).getPageNum();
            page.setTotal(total);
            model.addAttribute("totals",total);
            model.addAttribute("currentPage", pageName);//记录当前页
            model.addAttribute("list", customerList);
            return "cstpage/cst-list";
        }
    }
}
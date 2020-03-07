package com.byh.biyesheji.controller;


import com.byh.biyesheji.pojo.Order;
import com.byh.biyesheji.service.OrderItemService;
import com.byh.biyesheji.service.OrderService;
import com.byh.biyesheji.service.impl.OrderItemServiceImpl;
import com.byh.biyesheji.util.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * 订单模块controller
 */
@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    OrderItemServiceImpl orderItemServiceImpl;

    /**
     * 所有订单
     * @param model
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Order> os= orderService.list();
        int total = (int) new PageInfo<>(os).getTotal();//总数据
        int currentPage = (int) new PageInfo<>(os).getPageNum();
        page.setTotal(total);
        //为订单添加订单项数据
        orderItemService.fill(os);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("os", os);
        model.addAttribute("page", page);
        model.addAttribute("totals", total);
        model.addAttribute("total", total);
        return "ordermodule/order-list";
    }

    /**
     * 订单发货
     * @param o
     * @return
     */
    @RequestMapping("/orderDelivery")
    public String delivery(Order o){
        o.setStatus(2);
        orderService.update(o);
        return "redirect:list";
    }

    /**
     * 查看当前订单的订单项
     * @param oid
     * @param model
     * @return
     */
    @RequestMapping("/seeOrderItem")
    public String seeOrderItem(int oid,Model model){
        Order o = orderService.get(oid);
        orderItemService.fill(o);
        model.addAttribute("orderItems",o.getOrderItems());
        model.addAttribute("total",o.getOrderItems().size());
        model.addAttribute("totalPrice",o.getTotal());
        model.addAttribute("address", o.getAddress());
        String code = o.getCode();
        String year = code.substring(0, 4);
        String mouth = code.substring(4, 6);
        String day = code.substring(6, 8);
        String h = code.substring(8, 10);
        String s = code.substring(10, 12);
        String m = code.substring(12, 14);
        String oderTime = year+"-"+mouth+"-"+day+"  "+h+":"+s+":"+m;
        model.addAttribute("oderTime", oderTime);
        return "ordermodule/orderItem-list";
    }

}

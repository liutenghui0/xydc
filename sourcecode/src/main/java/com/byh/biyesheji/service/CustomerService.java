package com.byh.biyesheji.service;

import com.byh.biyesheji.pojo.Customer;

import java.util.List;

public interface CustomerService extends CrudService<Customer>{

    /**
     * 返回登陆的用户
     * @param customer
     * @return
     */
    public Customer foreLogin(Customer customer);

    /**
     * 设置会员
     * @param id
     */
    public void shezhihuiyuan(int id);


    /**
     * 批量删除
     */
    public void MultiDel(String[] ids);

    public List<Customer> search(Customer customer);
}

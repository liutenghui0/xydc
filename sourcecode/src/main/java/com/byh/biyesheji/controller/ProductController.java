package com.byh.biyesheji.controller;

import com.byh.biyesheji.pojo.Category;
import com.byh.biyesheji.pojo.Product;
import com.byh.biyesheji.pojo.ProductVO;
import com.byh.biyesheji.pojo.User;
import com.byh.biyesheji.service.CategoryService;
import com.byh.biyesheji.service.ProductService;
import com.byh.biyesheji.service.UserService;
import com.byh.biyesheji.util.Page;
import com.byh.biyesheji.util.UploadUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * 商品模块controller
 */
@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;
    @Autowired
    private UserService userService;
    @Autowired
    private CategoryService categoryService;

    @RequestMapping("/list")
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());//分页查询
        List<Product> list= productService.list();
        int total = (int) new PageInfo<>(list).getTotal();//总条数
        int currentPage = (int) new PageInfo<>(list).getPageNum();
        page.setTotal(total);
        model.addAttribute("list",list);
        model.addAttribute("total",total);
        model.addAttribute("page", page);
        model.addAttribute("currentPage", currentPage);
        return "productmodule/product-list";
    }


    /**
     * 上线商品
     * @param name
     * @return
     */
    @RequestMapping("/enableStatus")
    @ResponseBody
    public String enableStatus(@RequestParam(value = "name") String name){
        return productService.enableStatus(name);
    }

    /**
     * 下线商品
     * @param name
     * @return
     */
    @RequestMapping("/stopStatus")
    @ResponseBody
    public String stopStatus(@RequestParam(value = "name") String name){
        return productService.stopStatus(name);
    }

    @RequestMapping("/productAddUI")
    public String addUI(Model model){
        List<Category> categoryList = categoryService.list();
        List<User> userList = userService.list();
        model.addAttribute("categoryList",categoryList);
        model.addAttribute("userList",userList);
        return "productmodule/product-add";
    }

    /**
     * 添加商品
     * @param product
     * @param session
     * @param upload
     * @param redirectAttributes
     * @return
     * @throws IOException
     */
    @RequestMapping("/addProduct")
    public String add(Product product, HttpSession session, UploadUtil upload,RedirectAttributes redirectAttributes) throws IOException {
        productService.save(product);
        if (upload != null) {
            String imageName = product.getId()+".jpg";
            File file = new File(session.getServletContext().getRealPath("/images/product"),imageName);
            System.out.println(session.getServletContext().getRealPath("/images/product"));
            file.getParentFile().mkdirs();
            upload.getImage().transferTo(file);
            System.out.println("["+product.getId()+","+"images/product/"+imageName+"]");
            ProductVO vo = new ProductVO();//封装图片id和url
            vo.setId(product.getId());
            vo.setImageUrl("images/product/"+imageName);
            productService.setImageURL(vo);
            redirectAttributes.addFlashAttribute("addSuccess", 200);
            System.out.println(productService.get(product.getId()));
        }
        return "redirect:list";
    }

    @RequestMapping("/deleteProduct")
    public String del(@RequestParam(value = "id")int id, HttpSession session, RedirectAttributes redirectAttributes){
        productService.del(id);
        String imageName = id+".jpg";
        File file = new File(session.getServletContext().getRealPath("/images/product"),imageName);
        file.delete();
        redirectAttributes.addFlashAttribute("delSuccess", 200);
        return "redirect:list";
    }

    /**
     * 编辑商品
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/editProduct")
    public String editUI(@RequestParam(value = "id")int id,Model model){
        //获得要修改商品的信息
        Product product = productService.get(id);
        model.addAttribute("product",product);
        System.out.println(product);
        int cid = product.getCid();
        List<Category> categoryList = categoryService.list();
        List<User> userList = userService.list();
        //通过商品id 返回所属分类
        Category categoryByid = productService.getCategoryByCid(cid);
        model.addAttribute("crrentCategory",categoryByid);
        //通过id返回所属商家
        User userById = userService.getUserByPid(id);
        model.addAttribute("crrentUser",userById);
        model.addAttribute("categoryList",categoryList);
        model.addAttribute("userList",userList);
        return "productmodule/product-edit";
    }

    /**
     * 查看商品详细信息
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/detailed",method = RequestMethod.GET)
    public String productDetailed(@RequestParam(value="id")int id,Model model){
        //获得要商品的信息
        Product product = productService.get(id);
        model.addAttribute("product",product);
        int cid = product.getCid();
        System.out.println(product);

        List<Category> categoryList = categoryService.list();
        List<User> userList = userService.list();
        //通过商品id 返回所属分类
        Category categoryByid = productService.getCategoryByCid(cid);

        model.addAttribute("currenCategory",categoryByid);
        //通过id返回所属商家
        User userById = userService.getUserByPid(id);
        model.addAttribute("crrentUser",userById);

        model.addAttribute("categoryList",categoryList);
        model.addAttribute("userList",userList);
        return "productmodule/product-detailed";
    }

    @RequestMapping("/updateProduct")
    public String update(Product product, HttpSession session, UploadUtil upload) throws IOException {
        productService.update(product);
        if(upload!=null){

            String imageName = product.getId()+".jpg";

            File file = new File(session.getServletContext().getRealPath("/images/product"),imageName);

            file.getParentFile().mkdirs();
            upload.getImage().transferTo(file);

            ProductVO vo = new ProductVO();
            vo.setId(product.getId());
            vo.setImageUrl("images/product/"+imageName);

            productService.setImageURL(vo);

        }

        return "redirect:list";
    }

    @ResponseBody
    @RequestMapping("/delMulti")
    public int MultiDel(String ids){
        String[] productId = ids.split(",");
        productService.MultiDel(productId);
        int successDel = 200;
        return successDel;
    }


    @RequestMapping("/search")
    public String search(String name,Model model,Page page){
        if(name == null || name.equals("")){
            return "redirect:list";
        }else{
            Product product = new Product();
            product.setName(name);
            PageHelper.offsetPage(page.getStart(),page.getCount());//分页查询
            List<Product> productList = productService.search(product);
            for (Product p:productList) {
                Category category = categoryService.get(p.getCid());
                p.setCategory(category);
                User user = userService.get(p.getBid());
                p.setUser(user);
            }
            int total = (int) new PageInfo<>(productList).getTotal();//总条数
            int currentPage = (int) new PageInfo<>(productList).getPageNum();
            page.setTotal(total);
            model.addAttribute("list",productList);
            model.addAttribute("total",total);
            model.addAttribute("page", page);
            model.addAttribute("currentPage", currentPage);
            return "productmodule/product-list";
        }
    }

}

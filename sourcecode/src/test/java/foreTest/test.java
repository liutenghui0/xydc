package foreTest;

import com.byh.biyesheji.pojo.Product;
import com.byh.biyesheji.service.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * @description: 前台测试类
 * @author:刘腾辉
 * @create:2020/2/29 13:57
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring/spring-shiro.xml","classpath:/mybatis/mybatis.xml","classpath:/spring/spring-mybatis.xml"})
public class test {
    @Autowired
    private ForeService foreService;
    @Autowired
    private ProductService productService;
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private OrderItemService orderItemService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private ZiXunService ziXunService;

    @Test
    public void category(){
//        List<Category> categoryList = foreService.listToThree();
//        List<Category> category_List = categoryService.list();
//        System.out.println(categoryList.toString());
//        List<Product> ps = productService.findByCid(1);
//        if(ps.size()>2){
//            List<Product> ps1 = new ArrayList<>();
//            for(int i=0;i<ps.size();i++){
//                ps1.add(ps.get(i));
//            }
//        }
        List<Product> fivePro = foreService.getFivePro();
        System.out.println(fivePro);
    }
}

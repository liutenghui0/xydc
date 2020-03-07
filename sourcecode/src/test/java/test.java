import com.byh.biyesheji.dao.CustomerMapper;
import com.byh.biyesheji.dao.ProductMapper;
import com.byh.biyesheji.dao.ReviewMapper;
import com.byh.biyesheji.pojo.Customer;
import com.byh.biyesheji.pojo.Product;
import com.byh.biyesheji.pojo.Review;
import com.byh.biyesheji.service.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * @description:
 * @author:刘腾辉
 * @create:2020/2/26 14:09
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring/spring-shiro.xml","classpath:/mybatis/mybatis.xml","classpath:/spring/spring-mybatis.xml"})
public class test {
    @Autowired
    ReviewMapper reviewMapper;
    @Autowired
    ProductMapper productMapper;
    @Autowired
    CustomerMapper customerMapper ;
    @Autowired
    ReviewService reviewService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    OrderService orderService;
    @Autowired
    CustomerService customerService;
    @Autowired
    ProductService productService;



    @Test
     public void testReview(){
//        List<Review> list = reviewService.getReviewListByPid(4);
        //Product product = productMapper.selectByPrimaryKey(4);
        //List<Order> os= orderService.list();
        List<Review> reviews = reviewMapper.selectByExample(null);
        for (Review review:reviews){
            Customer customer = customerMapper.selectByPrimaryKey(review.getCstid());
            Product product = productMapper.selectByPrimaryKey(review.getPid());
            review.setCustomer(customer);
            review.setProduct(product);
        }
        System.out.println(reviews.toString());
    }

    @Test
    public void testSearch(){
//        Customer customer = new Customer();
//        customer.setName("lth");
//        List<Customer> customerList =  customerService.search(customer);

        Product product = new Product();
        product.setName("");
        List<Product> productList = productService.findByName("小");
        System.out.println(productList.size());
    }
}

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../../include/publicMeta.jsp"%>
<%@include file="../../include/publicHeader.jsp"%>
<%@include file="../../include/publicMenu.jsp"%>

<section class="Hui-article-box">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span>
        商品管理
        <span class="c-gray en">&gt;</span>
        商品列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="/product/list" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a> </nav>
    <div class="Hui-article radius">
        <article class="cl pd-20 radius">
            <c:if test="${delSuccess == 200}">
                <div class = "Huialert Huialert-success"> <i class = "Hui-iconfont" > &#xe6a6; </i>删除成功！</div>
            </c:if>
            <c:if test="${addSuccess == 200}">
                <div class = "Huialert Huialert-success"> <i class = "Hui-iconfont" > &#xe6a6; </i>添加成功！</div>
            </c:if>

            <div class="clearfix">
                <form action="/product/search" method="post" >
                    <input type="text" placeholder="请输入商品名" class="input-text ac_input" name="name" value="" id="search_text" autocomplete="off" style="width:300px">
                    <button type="submit" class="btn btn-default" id="search_button">搜索</button>
                </form>
            </div>

            <div class="cl pd-5 bg-1 bk-gray mt-20">
                <span class="l">
                    <a href="javascript:;" onclick="admin_add('添加商品','productAddUI','800','500')" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加商品
                    </a>
                    <button id="MultiDel" onclick="MultiDel('/product/delMulti')" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe609;</i>批量删除</button>
                </span>
                <span class="r">共有数据：<strong>${total}</strong> 条，当前：第<strong>${currentPage}</strong>页</span>
            </div>
            <table class="table table-border radius table-hover table-bg" id="mytable">
                <thead>
                <tr>
                    <th scope="col" colspan="12">商品列表</th>
                </tr>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="check" value=""></th>
                    <th width="">ID</th>
                    <th width="">商品名</th>
                    <th width="">单价</th>
                    <th width="">人气</th>
                    <th width="">销量</th>
                    <th width="">商品描述</th>
                    <th width="">分类</th>
                    <th width="">所属商家</th>
                    <th width="">参考图片</th>
                    <th width="">是否已上线</th>
                    <th width="100">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="product">
                    <tr class="text-c">
                        <td><input type="checkbox" id="subCheck" value="${product.id}" name="subCheck"></td>
                        <td>${product.id}</td>
                        <td>${product.name}</td>
                        <td>${product.price}</td>
                        <td>${product.zan}</td>
                        <td>${product.number}</td>
                        <td>${fn:substring(product.miaoshu, 0, 5)}...</td>
                        <td>${product.category.name}</td>
                        <td>${product.user.name}</td>
                        <td>
                            <img src="${pageContext.request.contextPath}/${product.imageurl}" width="100px" height="50px">
                            
                        </td>
                        <td class="td-status">
                            <c:if test="${product.status==1}">
                                <span class="label label-success radius">已上线</span>
                            </c:if>
                            <c:if test="${product.status==0}">
                                <span class="label radius">已下线</span>
                            </c:if>

                        </td>
                        <c:if test="${subject.hasRole('admin')}">
                            <td class="td-manage" >
                                <a title="详细" class="ml-5" style="text-decoration: none;" href="javascript:;" onclick="product_detailed('商品详细','detailed?id=${product.id}','1','800','500')">
                                    <i class="Hui-iconfont">
                                        &#xe695;
                                    </i>
                                </a>
                                &nbsp;
                                <c:if test="${product.status==0}">
                                    <a title="启用" style="text-decoration:none" onclick="start(this,'${product.name}')" href="javascript:;">
                                        <i class="Hui-iconfont">
                                            &#xe631;
                                        </i>
                                    </a>
                                </c:if>
                                <c:if test="${product.status==1}">
                                    <a title="停用" style="text-decoration:none" onclick="stop(this,'${product.name}')" href="javascript:;">
                                        <i class="Hui-iconfont">
                                            &#xe615;
                                        </i>
                                    </a>
                                </c:if>
                                <a title="编辑" href="javascript:;" onclick="admin_edit('商品编辑','editProduct?id=${product.id}','1','800','500')" class="ml-5" style="text-decoration:none">
                                    <i class="Hui-iconfont">&#xe6df;</i>
                                </a>
                                <a deleteLink="true" title="删除" href="/product/deleteProduct?id=${product.id}"  class="ml-5" style="text-decoration:none">
                                    <i class="Hui-iconfont">&#xe6e2;</i>
                                </a>
                            </td>
                        </c:if>
                        <c:if test="${!subject.hasRole('admin')}">
                            <td>无操作权限</td>
                        </c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </article>
        <article class="cl pd-20">
            <%@include file="../adminPage.jsp"%>
        </article>
    </div>
</section>


<%@include file="../../include/publicFooter.jsp"%>

<script type="text/javascript">
    /*
        参数解释：
        title	标题
        url		请求的url
        id		需要操作的数据id
        w		弹出层宽度（缺省调默认值）
        h		弹出层高度（缺省调默认值）
    */
    $(function(){
        $("a").click(function(){
            var deleteLink = $(this).attr("deleteLink");
            console.log(deleteLink);
            if("true"==deleteLink){
                var confirmDelete = confirm("确认要删除");
                if(confirmDelete)
                    return true;
                return false;

            }
        });
    })


    function admin_add(title,url,w,h){
        layer_show(title,url,w,h);
    }


    function admin_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }

    function product_detailed(title,url,id,w,h) {
        layer_show(title,url,w,h);
    }

    /*自定义*/
    function start(obj,name) {
        layer.confirm('确认要上线吗？',function(){
            $.get(
                "enableStatus",
                {"name":name},
                function (result) {
                    if("success"==result){
                        // location.reload();
                        $(obj).parents("tr").find(".td-manage").prepend('<a onclick="start(this,\'${product.name}\')" href="javascript:;" title="下线" style="text-decoration:none"></a>');
                        $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已上线</span>');
                        //$(obj).remove();
                        layer.msg('已启用!', {icon: 6,time:1000});
                        location.reload();
                    }
                }
            );
        });
    }
    function stop(obj,name) {
        layer.confirm('确认要下线吗？',function(){
            $.get(
                "stopStatus",
                {"name":name},
                function (result) {
                    if("success"==result){
                        // location.reload();
                        $(obj).parents("tr").find(".td-manage").prepend('<a onclick="start(this,\'${product.name}\')" href="javascript:;" title="上线" style="text-decoration:none"></a>');
                        $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已下线</span>');
                        //$(obj).remove();
                        layer.msg('已下线!', {icon: 6,time:1000});
                        location.reload();
                    }
                }
            );
        });
    }

    function MultiDel(url) {
        var ckeckNum = $("input[name='subCheck']:checked").length;
        var checkList = new Array();
        if (ckeckNum === 0){
            alert("至少选择一项...");
            return false;
        }
        if (confirm("确定删除所选项？")){
            //console.log("success");
            $("input[name='subCheck']:checked").each(function () {
                checkList.push($(this).val());
            });
        }else{
            return  false;
        }
        //console.log(ckeckNum);
        console.log(checkList);

        $.ajax({
            "url":url,
            "type":"POST",
            "data":{"ids":checkList.toString()},
            "dataType":"JSON",
            "success":function (data) {
                if (data == 200){
                    location.reload();
                    alert("删除成功！")
                } else{
                    alert("删除失败！")
                }
            }
        });
    }


</script>

</body>
</html>

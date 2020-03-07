<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../../include/publicMeta.jsp"%>
<%@include file="../../include/publicHeader.jsp"%>
<%@include file="../../include/publicMenu.jsp"%>

<section class="Hui-article-box">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span>
        评论管理
        <span class="c-gray en">&gt;</span>
        评论列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="/review/list" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a> </nav>
    <div class="Hui-article">
        <article class="cl pd-20">
            <c:if test="${delSuccess == 200}">
                <div class = "Huialert Huialert-success"> <i class = "Hui-iconfont" > &#xe6a6; </i>删除成功！</div>
            </c:if>

<%--            <div class="clearfix">--%>
<%--                <form action="#" method="post" >--%>
<%--                    <input type="text" placeholder="请输入用户名" class="input-text ac_input" name="name" value="" id="search_text" autocomplete="off" style="width:300px">--%>
<%--                    <button type="submit" class="btn btn-default" id="search_button">搜索</button>--%>
<%--                </form>--%>
<%--            </div>--%>

            <div class="cl pd-5 bg-1 bk-gray mt-20">
                <button id="MultiDel" onclick="MultiDel('/review/delMulti')" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe609;</i>批量删除</button>
                <span class="r">共有数据：<strong>${total}</strong> 条，当前：第<strong>${currentPage}</strong>页</span>
            </div>
            <table class="table table-border table-bordered table-bg" id="mytable">
                <thead>
                <tr>
                    <th scope="col" colspan="10">评论列表</th>
                </tr>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="" value=""></th>
                    <th width="">ID</th>
                    <th>用户名</th>
                    <th>评论商品</th>
                    <th>评论内容</th>
                    <th>评论时间</th>
                    <th>用户等级</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="review">
                    <tr class="text-c">
                        <td><input type="checkbox" value="${review.id}<" name="subCheck"></td>
                        <td>${review.id}</td>
                        <td>${review.customer.name}</td>
                        <td>${review.product.name}</td>
                        <td>${review.content}</td>
                        <td><fmt:formatDate value="${review.createtime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                        <td>
                            <c:if test="${review.customer.status==1}">会员</c:if>
                            <c:if test="${review.customer.status==0}">普通用户</c:if>
                        </td>
                        <td>
                            <a deleteLink="true" title="删除" href="/review/del?id=${review.id}"
                               class="ml-5" style="text-decoration:none">
                                <span class="label label-danger radius">删除</span>
                            </a>
                        </td>
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


    /**
     * 批删
     * @param url
     * @returns {boolean}
     * @constructor
     */
    function MultiDel(url) {
        var checkNum = $("input[name='subCheck']:checked").length;
        var checkList = new Array();
        if (checkNum === 0){
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

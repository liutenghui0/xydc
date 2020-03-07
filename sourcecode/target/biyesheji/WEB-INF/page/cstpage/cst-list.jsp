<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: baiyuhong
  Date: 2018/10/4
  Time: 21:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../../include/publicMeta.jsp"%>
<%@include file="../../include/publicHeader.jsp"%>
<%@include file="../../include/publicMenu.jsp"%>

<section class="Hui-article-box">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span>
        用户管理
        <span class="c-gray en">&gt;</span>
        用户列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="/customer/list" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a>
    </nav>

        <article class="cl pd-20">
            <c:if test="${delSuccess == 200}">
                <div class = "Huialert Huialert-success"> <i class = "Hui-iconfont" > &#xe6a6; </i>删除成功！</div>
            </c:if>

            <div class="clearfix">
                <form action="/customer/search" method="post" >
                    <input type="text" placeholder="请输入用户名" class="input-text ac_input" name="name" value="" id="search_text" autocomplete="off" style="width:300px">
                    <button type="submit" class="btn btn-default" id="search_button">搜索</button>
                </form>
            </div>


            <div class="cl pd-5 bk-gray mt-20" style="background-color: #f7fcff">
                <button id="MultiDel" onclick="MultiDel('/customer/delMulti')" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe609;</i>批量删除</button>
                <span class="r">共有数据：<strong>${totals}</strong> 条，当前：第<strong>${currentPage}</strong>页</span>
            </div>
            <table class="table table-border radius table-hover table-bg" id="mytable">
                <thead>
                <tr>
                    <th scope="col" colspan="10">订单表</th>
                </tr>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" id="ckeck"  name="ckeck" value=""></th>
                    <th width="">ID</th>
                    <th>用户名</th>
                    <th>密码</th>
                    <th>地址</th>
                    <th>手机</th>
                    <th>用户等级</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="cst">
                    <tr class="text-c">
                        <td><input type="checkbox" id="subCkeck"  value="${cst.id}" name="subCkeck"></td>
                        <td>${cst.id}</td>
                        <td>${cst.name}</td>
                        <td>${cst.password}</td>
                        <td>${cst.address}</td>
                        <td>${cst.phone}</td>
                        <td>
                            <c:if test="${cst.status==1}">会员</c:if>
                            <c:if test="${cst.status==0}">普通用户</c:if>
                        </td>
                        <td>
                            <a title="设为会员" href="javascript:;"
                               onclick="shezhihuiyuan(this,${cst.id},${cst.status})"
                               class="ml-5" style="text-decoration:none">
                                <span class="label label-success radius">设为会员</span>
                            </a>
                            <a deleteLink="true" title="删除" href="/customer/del?id=${cst.id}"
                               class="ml-5" style="text-decoration:none;">
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
<%--    <div class="row">--%>
<%--        <div class="col-sm-12">--%>
<%--            <div style="margin-left: 50px;margin-right: 20px;">--%>
<%--                <table id="dt" class="table table-hover table-bg">--%>
<%--                    <thead>--%>
<%--                         <tr>--%>
<%--                             <td>ID</td>--%>
<%--                             <td>姓名</td>--%>
<%--                         </tr>--%>
<%--                    </thead>--%>
<%--                    <tbody>--%>
<%--            &lt;%&ndash;        <c:forEach items="" var="">&ndash;%&gt;--%>
<%--            &lt;%&ndash;            <tr>&ndash;%&gt;--%>
<%--            &lt;%&ndash;                &ndash;%&gt;--%>
<%--            &lt;%&ndash;            </tr>&ndash;%&gt;--%>
<%--            &lt;%&ndash;        </c:forEach>&ndash;%&gt;--%>
<%--                        <tr>--%>
<%--                            <td>1</td>--%>
<%--                            <td>a</td>--%>
<%--                        </tr>--%>
<%--                        <tr>--%>
<%--                            <td>2</td>--%>
<%--                            <td>b</td>--%>
<%--                        </tr>--%>
<%--                    </tbody>--%>
<%--                </table>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
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

    /*自定义*/
    function shezhihuiyuan(obj,id,status) {
        if(status==1){
            layer.confirm("该用户已经是会员等级了!");
            return false;
        }
        layer.confirm('确认设为会员吗？',function(){
            $.get(
                "shezhihuiyuan",
                {"id":id},
                function (result) {
                    if("success"==result){
                        layer.msg('已设为会员!', {icon: 6,time:3000});
                        location.reload();
                    }
                }
            );
        });
    }

    /**
     * 批量删除
     * @param url
     * @returns {boolean}
     * @constructor
     */
    function MultiDel(url) {
        var ckeckNum = $("input[name='subCkeck']:checked").length;
        var checkList = new Array();
        if (ckeckNum === 0){
            alert("至少选择一项...");
            return false;
        }
        if (confirm("确定删除所选项？")){
            //console.log("success");
            $("input[name='subCkeck']:checked").each(function () {
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

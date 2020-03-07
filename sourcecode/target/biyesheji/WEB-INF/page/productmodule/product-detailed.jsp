<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../../include/publicMeta.jsp"%>

<article class="cl pd-20">
    <form action="#" method="post" enctype="multipart/form-data" class="form form-horizontal" id="form-admin-add"  target="_parent">
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">商品名称：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input disabled type="text" class="input-text" value="${product.name}" placeholder="" id="name" name="name">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">商品单价：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input disabled type="text" class="input-text" autocomplete="off" value="${product.price}" placeholder="" id="price" name="price">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">人气：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input disabled type="text" class="input-text" autocomplete="off" value="${product.zan}" placeholder="" id="zan" name="zan">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">销量：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input disabled type="text" class="input-text" autocomplete="off" value="${product.number}" placeholder="" id="number" name="number">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">描述：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <textarea style="font-size: 16px;" disabled data-height="20"  cols="65" rows="6">${product.miaoshu}</textarea>
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red"></span>商品图片：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <img src="${pageContext.request.contextPath}/${product.imageurl}" width="100px" height="50px">
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">分类：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" disabled class="input-text" autocomplete="off" value="${currenCategory.name}" />
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">商家：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input disabled type="text" class="input-text" autocomplete="off" value="${crrentUser.name}">
            </div>
        </div>
    </form>
</article>
<%@include file="../../include/publicFooter.jsp"%>

<script type="text/javascript">
    $(function(){
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });


    });
</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>
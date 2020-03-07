<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>校园点餐后台登录</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="/static/bower_components/bootstrap/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/static/bower_components/font-awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="/static/bower_components/Ionicons/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="/static/plugins/iCheck/square/blue.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <a href="#">欢迎登录后台</a>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg"></p>

        ${error}
        <form action="/login" method="post">
            <div class="form-group has-feedback">
                <input name="name" id="name" placeholder="用户名" class="form-control">
                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" name="password" id="password" class="form-control" placeholder="密码">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="row">
                <div class="col-xs-8">
<%--                    <div class="checkbox icheck">--%>
<%--                        <label>--%>
<%--                            <input type="checkbox"> 记住我--%>
<%--                        </label>--%>
<%--                    </div>--%>
                </div>
                <!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">登录</button>
                </div>
                <!-- /.col -->
            </div>
        </form>

        <!-- /.social-auth-links -->

    </div>
    <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 3 -->
<script src="/static/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="/static/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="/static/plugins/iCheck/icheck.min.js"></script>
<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' /* optional */
        });
    });
</script>
</body>


<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: baiyuhong--%>
<%--  Date: 2018/9/29--%>
<%--  Time: 15:42--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<%--<html xmlns="http://www.w3.org/1999/xhtml">--%>
<%--<head>--%>
<%--    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />--%>
<%--    <title>校园点餐后台登陆</title>--%>

<%--    <style type="text/css">--%>
<%--        *{padding:0px;margin:0px;}--%>
<%--        body{font-family:Arial, Helvetica, sans-serif;background:url(../../images/grass.jpg);font-size:12px;}--%>
<%--        img{border:0;}--%>
<%--        .lg{width:468px;height:468px;margin:100px auto;background:url(../../images/login_bg.png) no-repeat;}--%>
<%--        .lg_top{ height:200px;width:468px;}--%>
<%--        .lg_main{width:400px;height:180px;margin:0 25px;}--%>
<%--        .lg_m_1{width:290px;height:100px;padding:60px 55px 20px 55px;}--%>
<%--        .ur{height:37px;line-height:37px;border:0;color:#666;width:236px;margin:4px 28px;background:url(../../images/user.png) no-repeat;padding-left:10px;font-size:12px;font-family:Arial, Helvetica, sans-serif;}--%>
<%--        .pw{height:37px;line-height:37px;border:0;color:#666;width:236px;margin:4px 28px;background:url(../../images/password.png) no-repeat;padding-left:10px;font-size:12px;font-family:Arial, Helvetica, sans-serif;}--%>
<%--        .bn{width:330px;height:72px;background:url(../../images/enter.png) no-repeat;border:0;display:block;font-size:18px;color:#FFF;font-family:Arial, Helvetica, sans-serif;font-weight:bolder;cursor:pointer;}--%>
<%--        .lg_foot{height:80px;width:330px;padding: 6px 68px 0 68px;}--%>
<%--    </style>--%>

<%--</head>--%>

<%--<body>--%>

<%--<div class="lg">--%>
<%--    <form action="/login" method="POST">--%>
<%--        <div class="lg_top"></div>--%>
<%--        <div class="lg_main">--%>
<%--            <div class="lg_m_1">--%>
<%--                ${error}--%>
<%--                <input name="name" id="name" placeholder="用户名" value="" class="ur" />--%>
<%--                <input name="password" id="password" placeholder="密码" type="password" value="" class="pw" />--%>

<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="lg_foot">--%>
<%--            <input type="submit" value="登录" class="bn" /></div>--%>
<%--    </form>--%>
<%--</div>--%>

<%--</body>--%>
<%--</html>--%>


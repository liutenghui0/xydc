/**
 * 函数对象
  */

var validation = function () {
    /**
     * 初始化jquery validation
     * 私有部分
      */
    var validationInit = function () {
        $.validator.addMethod("mobile",function (value,element) {
            var length = value.length;
            var mobile = /^1[3456789]\d{9}$/;
            return this.optional(element) || (length == 11 && mobile.test(value));
        },"手机格式错误");

        $("#inputForm").validate({
            errorElement: 'span',
            errorClass: 'help-block',

            errorPlacement:function (error,element) {
                element.parent().parent().attr("class","form-group has-error");
                error.insertAfter(element);
            }
        });
    };

    /**
     * 公有部分
     */
    return{
        init:function () {
            validationInit();
        }
    }
 }();

$(document).ready(function () {
    validation.init();
});
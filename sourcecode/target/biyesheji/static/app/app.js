var App = function () {

    var check_all ;
    var check_box ;

    var CheckBox = function () {

        //激活
        $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass   : 'iradio_minimal-blue'
        });

        //获取控制checkbox
        check_all = $('input[type="checkbox"].minimal.check_all');

        //获取全部
        check_box = $('input[type="checkbox"].minimal');
    };

    var checkAll = function () {
        check_all.on("ifClicked",function (e) {
            //返回未选中
            if (e.target.checked){
                check_box.iCheck("uncheck");
            }
            //选中状态
            else{
                check_box.iCheck("check");
            }
        });
    };
    return {
        init:function () {
            CheckBox();
            checkAll();
        },
        getCheckBox:function () {
            return check_box;
        }
    }
}();

$(document).ready(function () {
    App.init();
});
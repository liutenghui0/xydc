<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
    #menu{float: right}
    #menu li {
        display: inline;
        width: 50px;
        height: 40px;

        margin-left: 8px;
    }
</style>
<div class="hui-list" style="margin-top:22px;">
    <ul id="menu">
        <li <c:if test="${!page.hasPreviouse}">class="disabled"</c:if>>
            <a  href="?start=0" style="text-decoration-line: none;" class="button button-primary button-pill button-small">
                <span aria-hidden="true">首页</span>
            </a>
        </li>

        <c:forEach begin="0" end="${page.totalPage-1}" varStatus="status">
            <li <c:if test="${status.index*page.count==page.start}">class="disabled"</c:if>>
                <a style="text-decoration-line: none;" href="?start=${status.index*page.count}"
                        <c:if test="${status.index*page.count==page.start}">class="current button button-circle button-action button-small"</c:if>
                >${status.count}</a>
            </li>
        </c:forEach>

        <li <c:if test="${!page.hasNext}">class="disabled"</c:if>>
            <a href="?start=${page.last}" style="text-decoration-line: none;" class="button button-primary button-pill button-small">
                <span aria-hidden="true">末页</span>
            </a>
        </li>
    </ul>
</div>
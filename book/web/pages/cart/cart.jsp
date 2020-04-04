<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>购物车</title>
    <%--静态包含：base 、cass样式、jquery引入
    --%>
    <%@include file="/pages/common/head.jsp" %>

    <script type="text/javascript">
        $(function () {
            //删除购物项
            $("a.deleteItem").click(function () {
                var text = $(this).parent().parent().find("td:first").text();
                return confirm("你确认要要删除【" + text + "】吗！！！");
            });

            //清空购物车
            $("a#clearCart").click(function () {
                return confirm("确定要清空购物车吗！！！");
            });

            //修改数量
            $(".updateCount").change(function () {
                //获取商品名称
                var name = $(this).parent().parent().find("td:first").text();
                //获取商品的数量
                var count = $(this).val();
                //获取商品的ID
                var id = $(this).attr("bookID");
                if(confirm("确定要修改【"+name+"】吗？")){
                    location.href="${pageScope.basePath}cartServlet?action=updateCount&count="+count+"&id="+id;
                }else {
                    // defaultValue 属性是表单项Dom 对象的属性。它表示默认的value 属性值。
                    this.value=this.defaultValue;
                }
            });
        });

    </script>

</head>
<body>

<div id="header">
    <img class="logo_img" alt="" src="static/img/logo.gif">
    <span class="wel_word">购物车</span>
    <%--登录成功--%>
    <%@ include file="/pages/common/login_success_menu.jsp" %>
</div>

<div id="main">

    <table>
        <tr>
            <td>商品名称</td>
            <td>数量</td>
            <td>单价</td>
            <td>金额</td>
            <td>操作</td>
        </tr>
        <%--如果为空--%>
        <c:if test="${empty sessionScope.cart.items}">
            <tr>
                <td colspan="5"><a href="index.jsp">亲，请赶快去买买买吧！！！</a></td>
            </tr>
        </c:if>
        <%--如果不为空--%>
        <c:if test="${not empty sessionScope.cart.items}">
            <c:forEach items="${sessionScope.cart.items}" var="entry">
                <tr>
                    <td>${entry.value.name}</td>
                    <td>
                        <input type="text" bookID="${entry.value.id}" style="width: 80px" class="updateCount"
                               value="${entry.value.count}">
                    </td>
                    <td>${entry.value.price}</td>
                    <td>${entry.value.totalPrice}</td>
                    <td><a class="deleteItem" href="cartServlet?action=deleteItem&id=${entry.value.id}">删除</a></td>
                </tr>
            </c:forEach>
        </c:if>
    </table>
    <%--如果不为空--%>
    <c:if test="${not empty sessionScope.cart.items}">
        <div class="cart_info">
            <span class="cart_span">购物车中共有<span class="b_count">${sessionScope.cart.totalCount}</span>件商品</span>
            <span class="cart_span">总金额<span class="b_price">${sessionScope.cart.totalPrice}</span>元</span>
            <span class="cart_span"><a id="clearCart" href="cartServlet?action=clearCart">清空购物车</a></span>
            <span class="cart_span"><a href="orderServlet?action=createOrder">去结账</a></span>
        </div>
    </c:if>
</div>

<%--静态包含底部信息--%>
<%@include file="/pages/common/footer.jsp" %>
</body>
</html>
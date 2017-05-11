<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../include/taglib.jsp" %>
<%@ include file="../../../include/resource.jsp" %>
<%@ include file="../../../include/skin_default.jsp" %>
</head>
<body>
<!--top start-->
<c:import url="../../../include/top.jsp"/>
<!--top end-->
<!--main start-->
<div class="main clearfix">
<!--left start-->
<div class="left" id="wrapper-250">
    <%--<c:import url="../../../include/menu.jsp"/>--%>
</div>
<div class="right clearfix">
<!--bread_crumbs start-->
<%--<c:import url="../../../include/navigation.jsp"/>--%>
<!--bread_crumbs end-->
<!--bt start-->
<!--bt end-->
<!--tit start-->
<!--tit start-->
<form:form action="save.htm" method="post" modelAttribute="bean" id="form">
    <c:import url="../../../include/pageParams.jsp"/>


    <a href="javascript:void(0);" class="table_head">>>长宁区科技创新券A券申请信息<span onclick="movePanel('panel1')"></span></a>
    <table border="0" cellspacing="0" cellpadding="0" class="table_list t_hs">
        <tr>
            <%--<td class="td1"><b>用户编号</b></td>--%>
            <%--<td class="td2">--%>
                <%--&lt;%&ndash;<form:input path="id" cssClass="input_txt w_209"/>&ndash;%&gt;--%>
            <%--</td>--%>
            <td class="td1"><b>用户账号</b></td>
            <td class="td2" colspan="3">
                <form:input path="account" cssClass="input_txt w_209"/>
            </td>
        </tr>
        <tr>
            <td class="td1"><b>真实名称</b></td>
            <td class="td2">
                <form:input path="real_name" cssClass="input_txt w_209"/>
            </td>
            <td class="td1"><b>密码</b></td>
            <td class="td2">
                <form:input path="pwd" cssClass="input_txt w_209"/>
            </td>
        </tr>
        <tr>
            <td class="td1"><b>邮箱</b></td>
            <td class="td2">
                <form:input path="mail" cssClass="input_txt w_209"/>
            </td>
            <td class="td1"><b>逻辑位</b></td>
            <td class="td2">
                <form:radiobutton path="flag" value="1"/>1
                <form:radiobutton path="flag" value="0"/>0
            </td>
        </tr>


    </table>

    <div class="an">
        <button type="button" onclick="doSubmit();" class="ico_tmpSave">
            保存</button>
        <button type="button" onclick="doBack();" class="ico_return">
            返回</button>
    </div>
    </form:form>
</div>
</div>
<!--right end-->
<!--main end-->
<!--footer start-->
<c:import url="../../../include/footer.jsp"/>
<!--footer end-->
<script>
    function doBack() {
        window.location.href="list.htm";
    }

</script>
</body>
</html>
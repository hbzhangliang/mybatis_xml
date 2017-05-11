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
    <!--left end-->
    <!--right start-->
    <div class="right clearfix">
        <!--bread_crumbs start-->
        <%--<c:import url="../../../include/navigation.jsp"/>--%>
        <!--bread_crumbs end-->
        <div class="an">
            <gw:bizSearch fields="用户账号" path="account" opts="add,del"/>
        </div>
        <!--bt end-->
        <%--<gw:pagination mode="biz"/>--%>
        <!--table start-->
        <table class="table_01">
            <tr>
                <th width="5%"><input type="checkbox" id="selectAll" title="选择"/></th>
                <%--<th class="orderBy">用户编号</th>--%>
                <th width="15%" class="orderBy">用户账号</th>
                <th width="15%" class="orderBy">用户真实名</th>
                <th width="10%" class="orderBy">用户密码</th>
                <th width="10%" class="orderBy">Email</th>
                <th width="10%" class="orderBy">逻辑删除位</th>
                <th width="18%"><a>操作</a></th>
            </tr>
            <c:forEach items="${list}" var="bean" varStatus="i">
                <tr id="tr_${bean.id}">
                    <td><input class="chk" type="checkbox" id="chk_${bean.id}"/></td>
                    <%--<td>${bean.id}</td>--%>
                    <td>${bean.account}</td>
                    <td>${bean.real_name}</td>
                    <td>${bean.pwd}</td>
                    <td>${bean.mail}</td>
                    <td>${bean.flag}</td>
                    <td>
                        <gw:operation mode="biz" opt="e,v,d"/>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <!--table end-->
        <!--right end-->
    </div>
</div>
<!--main end-->
<!--footer start-->
<c:import url="../../../include/footer.jsp"/>
<!--footer end-->
</body>
</html>

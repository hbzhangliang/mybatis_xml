<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ include file="../include/resource.jsp" %>
<%@ include file="../include/skin_default.jsp" %>
</head>
<body>
<!--top start-->
<div class="head auto">
</div>
<!--top start-->
<div class="main auto clearfix">
  <!--tit start-->
  <div class="tit" style="margin: 5px; padding: 10px;">
    <div class="tit_l">
      <div class="tit_l_tit"><fmt:message key="sys.title.sysError"/></div>
    </div>
    <span style="font-size: 14px;">
      <span><fmt:message key="sys.title.pageNotFound"/> </span>
      <font color="red">
        <span id="totalSecond">3</span>
      </font>
      <fmt:message key="sys.title.jumpBackToLogin"/>
    </span>
  </div>
</div>
</body>
</html>

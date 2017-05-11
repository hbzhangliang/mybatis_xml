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
      <div class="tit_l_tit"><fmt:message key="sys.title.sysHint"/></div>
    </div>
    <span style="font-size: 14px;"><span><fmt:message key="sys.title.timeout"/></span>
      <font color="red">
        <span id="totalSecond">3</span>
      </font><fmt:message key="sys.title.jumpBackToLogin"/> </span>
  </div>
  <script language="javascript" type="text/javascript">
    <!--
    var second = $('#totalSecond').html();
    setInterval("redirect()", 1000);  //每1秒钟调用redirect()方法一次

    function redirect() {
      if (second < 0) {
        window.location.href = '${base}/welcome.htm';
      } else {
        $('#totalSecond').html(second--);
      }
    }
    -->
  </script>
</div>
</body>
</html>

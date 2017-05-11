<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="gw" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
.floatPannel{
	background-color:#0066FF;
	width:120px;
	height:auto;
	left:1px;
	top:1px;
	position:absolute;
	z-index:10
}
</style>
<div class="head">
  <div class="banner auto">
    <ul class="user">
      <li class="t1"></li>
      <li class="t2">欢迎&nbsp;&nbsp;&nbsp;&nbsp;${currentUser.real_name}</li>
      <li class="t3"><gw:a onclick="logout();" cssClass="db"/></li>
    </ul>
    <div class="date l"></div>
    <dl class="r">
    </dl>
  </div>
</div>
<script>
  var today = new Date();
  var info = "今天是：";
  var x = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
  info += today.getFullYear() + "年" + (today.getMonth() + 1) + "月" + today.getDate() + "日   " + x[today.getDay()];
  $('.date').html(info);
  

</script>
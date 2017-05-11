<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="gw" tagdir="/WEB-INF/tags" %>
<!-- navigation start -->
<div class="tit">
  <gw:a text=">>"/>
  <a href="${base}/sys/module/${crtModule.code}.htm">${crtModule.name}</a>
  <gw:a text=">"/>
  <a href="${base}/${crtMenu.parent.code}.htm">${crtMenu.parent.name}</a>
  <gw:a text=">"/>
  <a href="${base}${crtMenu.url}">${crtMenu.name}</a>
</div>
<!-- navigation end -->


<%--
  Created by IntelliJ IDEA.
  User: li_hongyu
  Date: 2014/12/8
  Time: 13:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Accordion Menu -->
<ul class="accordion">
  <c:forEach items="${menuTree}" var="menu">
    <li id="m_${menu.id}"><a href="${base}/${menu.code}.htm"><em></em>${menu.name}</a>
      <ul class="sub-menu">
        <span></span>
        <c:forEach items="${menu.children}" var="submenu">
          <li id="m_${submenu.id}"><a href="${base}/${submenu.code}.htm">${submenu.name}</a></li>
        </c:forEach>
      </ul>
    </li>
  </c:forEach>
</ul>
<script>
  $.each($('.accordion').find('li a'), function () {
    if ($(this).parent().attr('id').indexOf('${crtMenu.id}') > 0)
      $(this).addClass('sel');
    if ($(this).parent().attr('id').indexOf('${crtMenu.parent.id}') > 0) {
      $(this).addClass('active').next().show();
    } else {
      $(this).next().hide();
    }
  });
</script>

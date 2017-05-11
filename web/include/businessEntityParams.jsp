<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<form:hidden path="flag"/>
<form:hidden path="updater.id" value="${currentUser.id}"/>
<form:hidden path="updateTime"/>

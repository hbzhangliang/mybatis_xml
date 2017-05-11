<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<form:hidden path="flag"/>
<form:hidden path="createTime"/>
<form:hidden path="creator.id"/>
<form:hidden path="modify.id" value="${currentUser.id}"/>


<%@ tag language="java" body-content="empty" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="category" rtexprvalue="true" type="java.util.List" %>
<%@ attribute name="lookupsCode" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="booleanValue" type="java.lang.Boolean" %>
<%@ attribute name="mode" %>
<c:choose>
  <c:when test="${mode=='YESNO'}"><c:if test="${booleanValue}">是</c:if><c:if test="${!booleanValue}">否</c:if></c:when>
  <c:otherwise><c:forEach items="${category}" var="item"><c:if test="${item.lCode == lookupsCode}">${item.lName}</c:if></c:forEach></c:otherwise>
</c:choose>

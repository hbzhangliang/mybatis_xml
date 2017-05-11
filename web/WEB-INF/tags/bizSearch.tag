<%@ tag language="java" body-content="empty" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="fields" type="java.lang.String" description="下拉框中的值" %>
<%@ attribute name="path" type="java.lang.String" description="下拉框所对应的查询字段" %>
<%@ attribute name="opts" type="java.lang.String" description="要进行的操作" %>
<%@ attribute name="excludeOpts" type="java.lang.Boolean" description="是否自定义操作" %>
<%@ attribute name="act" type="java.lang.String" description="搜索提交的action" %>
<form:form action="${act==null?'list':act}.htm" method="post" modelAttribute="queryBean" id="searchForm">
  <form:hidden path="pm.page"/>
  <form:hidden path="pm.totalRows"/>
  <form:hidden path="pm.pageSize"/>
  <form:hidden path="pm.totalPage"/>
  <form:hidden path="id"/>
  <form:hidden path="op"/>
  <form:hidden path="orderBy"/>
  <div id="searchBar" class="searchBar">
    <table border="0" cellspacing="0" cellpadding="0" class="table_list t_hs">
      <c:forEach items="${fn:split(fields, ',')}" varStatus="i" step="2">
        <tr>
          <td width="12%" class="td1"><b>${fn:split(fields, ',')[i.index]}</b></td>
          <td width="38%" class="td2" <c:if test="${fn:length(fn:split(fields, ',')[i.index+1])==0}">
            colspan="3"
          </c:if>>
            <c:if test="${!fn:contains(fn:split(path, ',')[i.index],'Date')}">
            <form:input path="params[${fn:split(path, ',')[i.index]}]" cssClass="input_txt w_209"/></td>
          </c:if>
          <c:if test="${fn:contains(fn:split(path, ',')[i.index],'Date')}">
            <form:input path="params[${fn:split(path, ',')[i.index]}1]" cssClass="input_txt w_92"/>到
            <form:input path="params[${fn:split(path, ',')[i.index]}2]" cssClass="input_txt w_92"/>
            </td>
          </c:if>
          <c:if test="${fn:length(fn:split(fields, ',')[i.index+1])>0 }">
            <td width="12%" class="td1"><b>${fn:split(fields, ',')[i.index+1]}</b></td>
            <td class="td2">
            <c:if test="${!fn:contains((fn:split(path, ',')[i.index+1]),'Date')}">
              <form:input path="params[${fn:split(path, ',')[i.index+1]}]" cssClass="input_txt w_209"/></td>
            </c:if>
            <c:if test="${fn:contains((fn:split(path, ',')[i.index+1]),'Date')}">
              <form:input path="params[${fn:split(path, ',')[i.index+1]}1]" cssClass="input_txt w_92"/>到
              <form:input path="params[${fn:split(path, ',')[i.index+1]}2]" cssClass="input_txt w_92"/>
              </td>
            </c:if>
            </td>
          </c:if>
        </tr>
      </c:forEach>
      <tr>
        <td class="td1"></td>
        <td class="td2" colspan="3">
          <button onclick="$('#searchForm').submit();" type="button" class="ico_search">搜索</button>
        </td>
      </tr>
    </table>
  </div>
</form:form>
<c:if test="${excludeOpts==null or !excludeOpts}">
  <c:forEach items="${fn:split(opts, ',')}" var="opt">
    <c:if test="${opt eq 'add'}">
      <button onclick="doInput(null);" type="button" class="ico_add">添加</button>
    </c:if>
    <c:if test="${opt eq 'del'}">
      <button onclick="doMultiDel();" type="button" class="ico_del">删除</button>
    </c:if>
  </c:forEach>
</c:if>

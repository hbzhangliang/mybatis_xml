<%@ tag language="java" body-content="empty" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ attribute name="mode" required="true" rtexprvalue="true" type="java.lang.String" %>
<c:if test="${mode eq 'sys'}">
  <div class="page">
    <a href="javascript:void(0)" onclick="doPage('first')">首页</a>
    <a href="javascript:void(0)" onclick="doPage('prev')">上一页</a>
    共<label id="totalRows">${queryBean.pm.totalRows}</label>条记录 当前
    <input type="text" value="${queryBean.pm.page}" maxlength="3" id="pageNo" onchange="doPage('current')"/>/${queryBean.pm.totalPage}
    <a href="javascript:void(0)" onclick="doPage('next')">下一页</a>
    <a href="javascript:void(0)" onclick="doPage('last')">末页</a>
  </div>
</c:if>
<c:if test="${mode eq 'biz'}">
  <div class="page clearfix cl">
    <span></span>
    <div class="l">
      共<label id="totalRows">${queryBean.pm.totalRows}</label>条记录<b>|</b>
      分<label id="totalPage">${queryBean.pm.totalPage}</label>页<b>|</b>
      每页<label id="pageSize">${queryBean.pm.pageSize}</label>条记录<b>|</b>
      当前第<label id="page">${queryBean.pm.page}</label>页
      <a href="javascript:void(0)" onclick="doPage('first')">首页</a>
      <a href="javascript:void(0)" onclick="doPage('prev')">前页</a>
      <a href="javascript:void(0)" onclick="doPage('next')">后页</a>
      <a href="javascript:void(0)" onclick="doPage('last')">尾页</a>
      转到第<input type="text" value="${queryBean.pm.page}" maxlength="3" id="pageNo"/>页
    </div>
    <a href="javascript:void(0);" onclick="doPage('current')" class="go l">GO</a>
  </div>
</c:if>
<script>
  function doPage(opt) {
    if (opt == 'first') {
      if ($("[id='pm.page']").val() != 1) {
        $("[id='pm.page']").val(1);
        $('#searchForm').submit();
      }
    } else if (opt == 'last') {
      if ($("[id='pm.page']").val() != $("[id='pm.totalPage']").val()) {
        $("[id='pm.page']").val($("[id='pm.totalPage']").val());
        $('#searchForm').submit();
      }
    } else if (opt == 'current') {
      if ($('#pageNo').val() != null && $('#pageNo').val() != "" && $('#pageNo').val() != '0')
        if (Number($("#pageNo").val()) <= Number($("[id='pm.totalPage']").val())) {
          $("[id='pm.page']").val($("#pageNo").val());
          $('#searchForm').submit();
        }
    } else if (opt == 'next') {
      if (Number($("[id='pm.page']").val()) + 1 <= Number($("[id='pm.totalPage']").val())) {
        $("[id='pm.page']").val(Number($("[id='pm.page']").val()) + 1);
        $('#searchForm').submit();
      }
    } else if (opt == 'prev') {
      if ($("[id='pm.page']").val() > 1) {
        $("[id='pm.page']").val(Number($("[id='pm.page']").val()) - 1);
        $('#searchForm').submit();
      }
    }
  }
</script>


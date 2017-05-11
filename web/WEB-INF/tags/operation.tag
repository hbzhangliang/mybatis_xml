<%@ tag language="java" body-content="empty" isELIgnored="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="opt" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="mode" type="java.lang.String" %>
<%@ attribute name="act" type="java.lang.String" %>
<div class="opt"></div>
<script>
  var optArray = '${opt}'.split(',');
  var optContent = "";
  var act = '${act}';
  <c:choose>
  <c:when test="${mode eq 'biz'}">
  $.each(optArray, function (idx, val) {
    if (val == 'e') {
      optContent += "<a href=\'javascript:void(0)\' onclick=\'doInput(this)\'>编辑</a>";
    } else if (val == 'd') {
      optContent += "<a class=\'req\' href=\'javascript:void(0)\' onclick=\'doDel(this)\'>删除</a>";
    } else if (val == 'v') {
      optContent += "<a href=\'javascript:void(0)\' onclick=\'doView(this)\'>查看</a>";
    } else if (val == 'a') {
      optContent += "<a href=\'javascript:void(0)\' onclick=\'doAudit(this)\'>审核</a>";
    }else if (val == 'h') {
      optContent += "<a href=\'javascript:void(0)\' onclick=\'doAuditAndConfig(this)\'>审核</a>";
    }else if (val == 'z') {
      optContent += "<a href=\'javascript:void(0)\' onclick=\'doMidExam(this)\'>申请中评</a>";
    } else if (val == 'y') {
      optContent += "<a href=\'javascript:void(0)\' onclick=\'doAccept(this)\'>申请验收</a>";
    }
    else if (val == 's') {
      optContent += "<a href=\'javascript:void(0)\' onclick=\'doSend(this)\'>提交</a>";
    } else if (val == 'p') {
      optContent += "<a href=\'javascript:void(0)\' onclick=\'doPrint(this)\'>打印</a>";
    } else if (val == 'u') {
      optContent += "<div class=\"opt_usr l\"/>";
    }
    $('.opt').html(optContent);
  });
  </c:when>
  <c:otherwise>
  $.each(optArray, function (idx, val) {
    if (val == 'e') {
      optContent += "<div onclick=\"doInput(this)\" class=\"opt_edt l\" title=\"编辑\"></div>";
    } else if (val == 'd') {
      optContent += "<div onclick=\"doDel(this)\" class=\"opt_del l\" title=\"删除\"></div>";
    } else if (val == 'v') {
      optContent += "<div onclick=\"doView(this)\" class=\"opt_view l\" title=\"查看\"/>";
    } else if (val == 'c') {
      optContent += "<div class=\"opt_fun l\"/>";
    } else if (val == 'u') {
      optContent += "<div class=\"opt_usr l\"/>";
    }
    $('.opt').html(optContent);
  });
  </c:otherwise>
  </c:choose>
</script>

<%@ tag language="java" body-content="empty" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ attribute name="opt" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="id" rtexprvalue="true" type="java.lang.String" %>
<div id="${id}" class="tc"></div>
<script>
  var optArray = '${opt}'.split(',');
  var _id = '${id}';
  var optContent = "";
  $.each(optArray, function (idx, val) {
    if (val == 'b') {
      optContent += "<div class='opt_bck r' onclick=\"window.location.href=\'${base}/sys.htm\'\" title=\'" + '<fmt:message key="sys.title.return"/>' + "\'/>";
    } else if (val == 'n') {
      optContent += "<div class='opt_add r' onclick=\"window.location.href=\'input.htm\'\" title=\'" + '<fmt:message key="sys.title.new"/>' + "\'/>";
    } else if (val == 'ok') {
      optContent += "<div class='opt_ok r' onclick=\"form.submit();\" title=\'" + '<fmt:message key="sys.title.submit"/>' + "\'/>";
    } else if (val == 'rt') {
      optContent += "<div class='opt_bck r' onclick=\"history.back();\" title=\'" + '<fmt:message key="sys.title.return"/>' + "\'/>";
    } else if (val == 's') {
      optContent += "<div class='opt_view r' onclick=\"$('#searchForm').submit();\" title=\'" + '<fmt:message key="sys.title.search"/>' + "\'/>";
    } else if (val == 'r') {
      optContent += "<div class='opt_reset r' onclick=\"resetQuery();\" title=\'" + '<fmt:message key="sys.title.reset"/>' + "\'/>";
    } else if (val == 'c') {
      optContent += "<div class='opt_fun r'/>";
    }
  });
  $("[id='" + _id + "']").html(optContent);
</script>

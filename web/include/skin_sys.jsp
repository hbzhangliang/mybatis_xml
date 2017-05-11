<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- skin for website -->
<link rel="stylesheet" href="${resources}/skin/sys/css/layout.css"/>
<title><fmt:message key="portal.title"/></title>
<script>
  $(document).ready(function () {
    $(".tablelist tbody tr:odd").addClass("odd");
    $(".tablelist tbody tr").hover(
        function () {
          $(this).addClass("highlight");
        },
        function () {
          $(this).removeClass("highlight");
        });
  });
</script>

<%@ tag language="java" body-content="empty" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ attribute name="onclick" type="java.lang.String" description="点击事件" %>
<%@ attribute name="text" type="java.lang.String" description="显示文字" rtexprvalue="true" %>
<%@ attribute name="cssClass" type="java.lang.String" description="cssClass" %>
<%@ attribute name="style" type="java.lang.String" rtexprvalue="true" description="自定义样式" %>
<%@ attribute name="disabled" type="java.lang.Boolean" description="是否禁用" %>
<a href="javascript:void(0);" onclick="${disabled?'':onclick}" class="${disabled?'disabled':cssClass}" style="${style}">${text}</a>

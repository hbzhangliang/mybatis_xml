<%@ tag language="java" body-content="empty" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ attribute name="objectId" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="category" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="rename" type="java.lang.Boolean" %>
<%@ attribute name="group" type="java.lang.String" %>
<%@ attribute name="operation" type="java.lang.String" description="v表示只查看" %>
<form:hidden path="tmpParams[fid]"/>
<c:if test="${operation==null or (operation eq '') or (operation eq 'add') or (operation eq 'draft')}">
    <script src="${base}/web-resources/resources/js/ajaxfileupload.js"></script>
    <script>
        <c:if test="${objectId!=null and !(objectId eq '')}" >
        $.post('${base}/sys/attr/getAttrCate.htm', {id: '${objectId}',category:'${category}'}, function (data) {
            if (data.length > 0)
                $.each(data, function (idx, obj) {
                    $('#tmpParamsfid').val($('#tmpParamsfid').val() + obj.id + ',');
                    var content = $("#fileList").html();
                    var fileInfo = '<a href=\"${base}/sys/attr/download.htm?id=' + obj.id + '\">' + obj.displayName + '</a>';
                    <c:if test="${!((bean.op eq 'v') or fn:indexOf(bean.op,'view') >=0 )}">
                    fileInfo += '<span onclick=\"ajDelAttr(this,\'' + obj.id + '\')\">[删除]</span>';
                    </c:if>
                    $('#fileList').html(content + fileInfo);
                });
            else {
                $('#fileList').html('无附件');
            }
        }, 'json');
        </c:if>

        function doUpload() {
            $("#loading").show();
            var fileName = $("#upload").val();
            $("#fileName").val(fileName.substring(fileName.lastIndexOf("\\") + 1));
            var suffix=fileName.substring(fileName.lastIndexOf("."));
            $.ajaxFileUpload({
                        url: '${base}/sys/attr/ajaxUp.htm',
                        secureuri: false,
                        fileElementId: 'upload',
                        dataType: 'json',
                        <c:if test="${rename}">
                        data: {'displayName': $('#displayName').val(),'category':'${category}'},
                        </c:if>
                        success: function (data) {
                            data=data.responseText;
                            $('#result').html(data);
                            addFileElm(data,suffix);
                        },
                        error: function (data) {
                            data=data.responseText;
                            $('#result').html(data);
                            addFileElm(data,suffix);
                        }
                    }
            );
            $("#loading").hide();
            return false;
        }

        function addFileElm(id,suffix) {
            $('#tmpParamsfid').val($('#tmpParamsfid').val() + id + ',');
            var content = $("#fileList").html();
            var displayName=$("#displayName").val().length==0?$("#fileName").val():$("#displayName").val()+suffix;
            //$('#fileList').html(content + '<a href=\"${base}/sys/attr/download.htm?id=' + id + '\">' + $("#displayName").val()
            $('#fileList').html(content + '<a href=\"${base}/sys/attr/download.htm?id=' + id + '\">' + displayName
                    + '</a><span onclick=\"ajDelAttr(this,\'' + id + '\')\">[删除]</span>');
        }

        function ajDelAttr(obj, id) {
            $('#tmpParamsfid').val($('#tmpParamsfid').val().replace(id, ""));
            $.post('${base}/sys/attr/ajDel.htm', {"id": id}, function () {
                $(obj).prev().remove();
                $(obj).remove();
            });
        }
    </script>
    <div class="uploadFile">
        <input type="file" id="upload" name="upload" onchange="doUpload()"/>
        <input type="hidden" id="fileName"/>

        <div id="fileList">
        </div>
        <div style="display: none;" id="loading">
            <img src="${base}/page/sys/attr/loading.gif"/></div>
        <span id="result" style="display: none"></span>
    </div>
</c:if>
<c:if test="${operation eq 'v'}">
    <script>
        <c:if test="${objectId!=null and !(objectId eq '')}" >
        $.post('${base}/sys/attr/getAttrCate.htm', {id: "${objectId}",category:'${category}'}, function (data) {
            if (data.length > 0) {
                $.each(data, function (idx, obj) {
                    $('#tmpParamsfid').val($('#tmpParamsfid').val() + obj.id + ',');
                    var content = $("#fileList").html();
                    $('#fileList').html(content + '<a href=\"${base}/sys/attr/download.htm?id=' + obj.id + '\">[' + obj.displayName + ']</a>');
                });
            } else {
                $('#fileList').html('无附件');
            }
        }, 'json');
        </c:if>
    </script>
    <!--   <div id="fileList"> -->
    <!--   </div> -->
</c:if>
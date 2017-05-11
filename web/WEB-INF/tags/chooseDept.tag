<%@ tag language="java" body-content="empty" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ attribute name="renderLabel" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="renderKey" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="multiCheck" rtexprvalue="true" type="java.lang.Boolean" %>
<div class="bt_sel"><span onclick="showDeptWin()">选</span></div>
<div id="deptSelector" style="display:none;">
  <label for="keywords">部门：</label><input type="text" id="keywords" size="10" class="w_input"/>
  <button type="button" onclick="search()" class="w_bt">查找</button>
  <br/>
  <span id="spanSelected">当前选中部门：</span><br/><br/>
  <ul class="s1" id="deptTree"></ul>
  <div style="text-align:center;padding: 5px 5px 10px;">
    <a href="javascript:void(0)" class="easyui-linkbutton" icon="icon-ok" onclick="doSelect()"></a>
    <a href="javascript:void(0)" onclick="closeDeptWin();" class="easyui-linkbutton" icon="icon-cancel"></a>
  </div>
</div>
<script>
  showDeptWin = function () {
    var $win = $('#deptSelector').window({
      title: '部门选择',
      width: 400,
      height: 450,
      top: '15%',
      left: '35%',
      shadow: true,
      modal: true,
      iconCls: 'icon-add',
      closed: true,
      minimizable: false,
      maximizable: false,
      collapsible: false
    });
    $win.window('open');
    loadDept();
    $('#deptSelector').show();
  }

  loadDept = function () {
    $('#spanSelected').html("当前选中部门：");
    $('#deptTree').tree({
      url: base + '/sys/depart/getCacheAjaxRoot.htm',
      checkbox: ${multiCheck},
      cascadeCheck: false,
      onBeforeExpand: function () {
        $('#deptTree').tree('options').url = base + "/sys/depart/getCacheAjaxChild.htm";
      },
      <c:if test="${!multiCheck}">
      onClick: function (node) {
        if (node.level >= '3') {
          $('#spanSelected').html("当前选中部门：" + node.text);
        }
      }
      </c:if>
      <c:if test="${multiCheck}">
      onCheck: function (node, checked) {
        alert(node.checked);
        if (checked) {
          var deptSelected = node.text;
          var orgContent = $('#spanSelected').html();
          $('#spanSelected').html(orgContent + deptSelected + ",");
        } else {
          $('#spanSelected').html().replace(node.text + ',', '');
        }
      }
      </c:if>
    });
  }

  search = function () {
    if ($('#keywords').val() != null && $('#keywords').val() != '')
      $('#deptTree').tree({
        url: base + '/sys/depart/ajaxSearch.htm?keyword=' + $('#keywords').val(),
        onClick: function (node) {
          $(this).tree('toggle', node.target);
          if (node.level >= '3') {
            $('#spanSelected').html("当前选中部门：" + node.text);
          } else {
            msg('请选择合适的部门');
          }
        }
      });
  }

  closeDeptWin = function () {
    $('#deptSelector').window('close');
  }

  doSelect = function () {
    var names = '';
    var ids = '';
    <c:if test="${!multiCheck}">
    if ($('#deptTree').tree('getSelected').level <= '2') {
      msg('<fmt:message key="sys.title.chooseCorrectDept/>"/>');
      return;
    }
    else {
      ids = $('#deptTree').tree('getSelected').id;
      names = $('#deptTree').tree('getSelected').text;
    }
    </c:if>
    <c:if test="${multiCheck}">
    var selected = $('#deptTree').tree('getChecked');
    for (var i = 0; i < selected.length; i++) {
      if (names != '')
        names += ',';
      if (ids != '')
        ids += ',';
      names += selected[i].text;
      ids += selected[i].id;
    }
    </c:if>
    $("#" + '${renderLabel}').val(names);
    $("#" + '${renderKey}').val(ids);
    closeDeptWin();
  }
</script>
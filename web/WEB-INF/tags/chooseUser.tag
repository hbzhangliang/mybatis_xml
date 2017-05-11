<%@ tag language="java" body-content="empty" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="renderToUserName" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="renderToUserCode" type="java.lang.String" %>
<%@ attribute name="renderToDept" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="renderToUserId" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="multiCheck" type="java.lang.Boolean" %>
<%@ attribute name="callBack" type="java.lang.String" %>
<%@ attribute name="scope" type="java.lang.String" required="true" %>
<div class="bt_sel"><span onclick="showUserWin()">选</span></div>
<div id="userSelector" style="display:none;background:#eefaff;">
  <!--search start-->
  <ul class="sp_search">
    <li><label for="loginId">用户标识</label><input type="text" id="loginId"/></li>
    <li><label for="realName">用户名称</label><input type="text" id="realName"/></li>
    <li><a href="javascript:void(0);" class="sp_search_cx" onclick="searchUser();"></a></li>
  </ul>
  <!--search end-->
  <!--cont start-->
  <div class="clearfix sp_cont l">
    <!--树结构 start-->
    <div class="l" style="width:170px; height:312px; overflow:scroll; background:#f7f7ff;">
      <ul class="s1" id="deptTree1"></ul>
    </div>
    <!--树结构 end-->
    <!--右侧 start-->
    <div class="l">
      <!--选人 start-->
      <ul class="l">
        <li>
          <ul id="searchResult" class="sel_p"></ul>
        </li>
        <li class="bt_mid">
          <a href="javascript:void(0);" class="bt_mid_xz" onclick="moveUser('right')"></a>
          <a href="javascript:void(0);" class="bt_mid_sc" onclick="moveUser('left')"></a>
          <a href="javascript:void(0);" class="bt_mid_qx" onclick="moveUser('all')"></a>
          <a href="javascript:void(0);" class="bt_mid_qs" onclick="moveUser('back')"></a>
        </li>
        <li>
          <ul id="userResult" class="sel_p"></ul>
        </li>
        <%-- <li class="bt_arr">
           <a href="javascript:void(0);" class="bt_arr_s"></a>
           <a href="javascript:void(0);" class="bt_arr_x"></a>
         </li>--%>
      </ul>
      <!--选人 end-->
      <!--确认按钮 start-->
      <div class="bt_b cl ">
        <ul>
          <li><a href="javascript:void(0);" class="bt_b cl_qd" onclick="doUserSelect()"></a></li>
          <li><a href="javascript:void(0);" class="bt_b cl_qx" onclick="closeUserWin();"></a></li>
        </ul>
      </div>
      <!--确认按钮 end-->
    </div>
    <!--右侧 end-->
  </div>
  <!--cont end-->
</div>
<script>
  var multiChk = Boolean(${multiCheck});

  loadDept4User = function () {
    $('#deptTree1').tree({
      url: base + '/sys/depart/getCacheAjaxRoot.htm',
      queryParams: {scope: '${scope}'},
      checkbox: false,
      cascadeCheck: false,
      onBeforeExpand: function () {
        $('#deptTree1').tree('options').url = base + "/sys/depart/getCacheAjaxChild.htm";
      },
      onClick: function (node) {
        if (node.level == '3' || node.level == '4') {
          $.post('${base}/sys/user/getCacheUserByDept.htm', {deptId: node.id}, function (data) {
            var content = '';
            $.each(data, function (idx, obj) {
              content += '<li><a href=\"javascript:void(0)\" id =\"' + obj.id + '\" onclick=\"selectUser(this)\"\">' + obj.realName + '</a></li>';
            });
            $('#searchResult').html(content);
          }, 'json');
        }
      }
    });
  }

  showUserWin = function () {
    var $win = $('#userSelector').window({
      title: '人员选择',
      width: 700,
      height: 450,
      top: '15%',
      left: '25%',
      shadow: true,
      modal: true,
      iconCls: 'icon-add',
      closed: true,
      minimizable: false,
      maximizable: false,
      collapsible: false
    });
    $win.window('open');
    loadDept4User();
    $('#userSelector').show();
  }

  selectUser = function (obj) {
    if ($(obj).attr('class') == 'sel') {
      $(obj).removeClass('sel');
    } else {
      $(obj).addClass('sel');
    }
  }

  closeUserWin = function () {
    $('#userSelector').window('close');
  }

  doUserSelect = function () {
    if (multiChk) {
      if ($('#userResult').find('li').length == 0) {
        msg('请选择用户');
        return;
      }
      else {
        var names = '';
        var ids = '';
        $.each($('#userResult').find('li a'), function (idx, obj) {
          names += $(obj).html() + ',';
          ids += $(obj).attr('id') + ','
        });
        $('#' + '${renderToUserId}').val(ids);
        $('#' + '${renderToUserName}').val(names);
      }
    } else {
      if ($('#userResult').find('li').length != 1) {
        msg('请选择1个用户');
        return;
      }
      else {
        $('#' + '${renderToUserId}').val($('#userResult').find('li a').attr('id'));
        $('#' + '${renderToUserName}').val($('#userResult').find('li a').html());
      }
    }
    closeUserWin();
    <c:if test="${callBack !=null and callBack!=''}">
    ${callBack};
    </c:if>
  }


  searchUser = function () {
    $.post('${base}/sys/user/ajSearchUser.htm', {
      loginId: $('#loginId').val(),
      realName: $('#realName').val(),
      scope: '${scope}'
    }, function (data) {
      var content = '';
      $.each(data, function (idx, obj) {
        content += '<li><a href=\"javascript:void(0)\" id =\"' + obj.id + '\" onclick=\"selectUser(this)\"\">' + obj.realName + '</a></li>';
      });
      $('#searchResult').html(content);
    }, 'json');
  }

  moveUser = function (mode) {
    if (mode == 'right')
      $('#userResult').append($('#searchResult').find("a[class='sel']").parent()).find("a[class='sel']").removeClass('sel');
    else if (mode == 'left')
      $('#searchResult').append($('#userResult').find("a[class='sel']").parent()).find("a[class='sel']").removeClass('sel');
    else if (mode == 'all')
      $('#userResult').append($('#searchResult').find("li"));
    else
      $('#searchResult').append($('#userResult').find("li"));
  }
</script>

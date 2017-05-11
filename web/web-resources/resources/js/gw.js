var msgRq = "<span class='req'>需填写</span>";
var msgNumber = "<span class='req'>请输入少于两位的小数</span>";
var msgInt = "<span class='req'>请填写整数</span>";

msg = function (msg) {
  $.messager.alert({
    title: '系统信息',
    msg: msg
  });
}

$('input,select,textarea').bind("focus", function () {
  if ($(this).next().attr('class') == 'required')
    $(this).next().remove();
});

$(document).ready(function () {
  //如果搜索框里有值，显示搜索区域
  $('.searchField').find('input').each(function (idx, obj) {
    if ($(obj).val() != '' && $(obj).val() != null) {
      $('#searchBar').find('select').prop('selectedIndex', idx);
      $(obj).show();
      $('#searchBar').show();
      $('#showSearchBar').html('<span></span>隐藏搜索栏');
    }
  });
  //全选框动作
  $('#selectAll').bind('change', function () {
    $('.table_01').find('tr[id^=tr_]').find('input').prop('checked', $(this).prop('checked'));
  });
  //自动绑定日期框
  $("input[name*='Date'][type!='hidden']").bind('click', WdatePicker);
  //查看操作各功能按钮禁用
  if ($('#op').val() != null) {
    if ($('#op').val() == 'v' || $('#op').val().indexOf('view') >= 0) {
      $('input,select,textarea').attr("disabled", "true");
      $("[onclick='doSubmit();']").hide();
      $("[onclick='form.submit();']").hide();
      $("[onclick='doLocalSubmit();']").hide();
      $("[onclick='doAppend();']").hide();
      $("[onclick='doSend();']").hide();
      $("[onclick='doAudit();']").hide();
      $("button[class='ico_send']").hide();
      $("button[class='ico_tmpSave']").hide();
      $(".uploadFile input").hide();
      $('.addtable').hide();
      $('#content').find('div').hide();
    }
  }
  //检查重复项
  if (typeof(checkDupl) != 'undefined') {
    if (checkDupl != null && checkDupl.length > 0) {
      for (var key in checkDupl) {
        $(checkDupl[key]).bind('blur', function () {
          if ($(this).val() != null && $(this).val() != '')
            checkDuplicated($(this), $(this).attr('id'), $(this).val());
        });
      }
    }
  }
  //排序部分自动处理
  if (typeof(orderByList) != 'undefined') {
    if (orderByList != null && orderByList.length > 0) {
      $.each($('.orderBy'), function (idx, obj) {
        $(obj).html($(obj).html() + '<span class="orderBy"></span>').bind('click', function () {
          var org = $('#orderBy').val();
          if (org.indexOf(orderByList[idx]) >= 0) {
            if (org.indexOf('desc') > 0) {
              $('#orderBy').val(orderByList[idx]);
            } else {
              $('#orderBy').val(orderByList[idx] + " desc");
            }
          } else {
            $('#orderBy').val(orderByList[idx]);
          }
          $('#searchForm').submit();
        })
      })
    }
    for (var key in orderByList) {
      if ($('#orderBy').val().indexOf(orderByList[key]) >= 0) {
        if ($('#orderBy').val().indexOf("desc") > 0) {
          //$('.orderBy').eq(key).html($('.orderBy').eq(key).html() + '<span class=\'desc\'></span>');
          $('.table_01 th').find('span').eq(key).attr('class', 'desc');
        } else {
          //$('.orderBy').eq(key).html($('.orderBy').eq(key).html() + '<span class=\'asc\'></span>');
          $('.table_01 th').find('span').eq(key).attr('class', 'asc');
        }
      }
    }
  }
});

if (typeof(numberFields) != 'undefined') {
  if (numberFields != null && numberFields.length > 0) {
    for (var key in numberFields) {
      $(numberFields[key]).bind('blur', function () {
        if ($(this).val().length > 0) {
          if (!$(this).val().match(/^[0-9]+[/.]?[0-9]{0,2}$/)) {
            $(this).after(msgNumber);
          } else {
            if ($(this).next().attr('class') == 'req')
              $(this).next().remove();
          }
        }
      });
    }
  }
}

if (typeof(intFields) != 'undefined') {
  if (intFields != null && intFields.length > 0) {
    for (var key in intFields) {
      $(intFields[key]).bind('blur', function () {
        if ($(this).val().length > 0) {
          if (!$(this).val().match(/^[0-9]+$/)) {
            $(this).after(msgInt);
          } else {
            if ($(this).next().attr('class') == 'req')
              $(this).next().remove();
          }
        }
      });
    }
  }
}

bindCheck = function () {
  $('tr').bind('click', function () {
    $(this).find('input').attr('checked', 'checked');
  });
}


ajDel = function (id, callback) {
  $.messager.confirm('系统信息', '确认要删除吗？', function (r) {
    if (r) {
      $.post('ajDel.htm', {"id": id}, function (msg) {
        if (msg.split(',')[0] == '1')
          $('#tr_' + id).remove();
        $.messager.show({
          title: '系统信息',
          msg: msg.split(',')[1],
          timeout: 3000,
          showType: 'fade'
        });
      });
      if (callback != null)
        callback();
    }
  });
}

resetQuery = function (str) {
  $('.form input').each(function () {
    $(this).val("");
  });
  if (str == null)
    window.location.href = 'list.htm';
  else
    window.location.href = str;
}

function checkField() {
  var flag = 0;
  if (typeof(requiredList) != 'undefined') {
    if (requiredList != null && requiredList.length > 0) {
      $("form span").each(function () {
        if ($(this).attr('class') == 'req') {
          $(this).remove();
        }
      });
      for (var key in requiredList) {
        if ($(requiredList[key]).val().length == 0) {
          $(requiredList[key]).after(msgRq);
          flag = 1;
        }
      }
    }
  }
  if (typeof(numberFields) != 'undefined') {
    if (numberFields != null && numberFields.length > 0) {
      for (var key in numberFields) {
        var _field = $(numberFields[key]);
        if (_field.length > 0) {
          if (!_field.val().match(/^[0-9]+[/.]?[0-9]{0,2}$/)) {
            _field.after(msgNumber);
            flag = 1;
          } else {
            if (_field.next().attr('class') == 'req')
              _field.next().remove();
          }
        }
      }
    }
  }
  if (typeof(intFields) != 'undefined') {
    if (intFields != null && intFields.length > 0) {
      for (var key in intFields) {
        var _field = $(intFields[key]);
        if (_field.val().length > 0) {
          if (!_field.val().match(/^[0-9]+$/)) {
            _field.after(msgInt);
            flag = 1;
          } else {
            if (_field.next().attr('class') == 'req')
              _field.next().remove();
          }
        }
      }
    }
  }
  return flag;
}

doSubmit = function (formId) {
  if (checkField() == 0) {
    if (formId == null)
      $('#form').submit();
    else
      $('#' + formId).submit();
  }
}

doAppend = function () {
  if (checkField() == 0) {
    $('#op').val('append');
    $('#form').submit();
  }
}

logout = function () {
  $.messager.defaults = { ok: "注销", cancel: "取消",width:'320px',height:'150px'};
  $.messager.confirm('系统提示', '确认要注销吗？', function (r) {
    if (r) {
      window.location.href = base + '/logout.htm';
    }
  });
}

/**
 * 检查是否重复
 * @param obj 要检查的表单元素
 * @param key 表单元素的id（类的字段名）
 * @param value 表单元素的值
 */
checkDuplicated = function (obj, key, value) {
  $.post('checkDuplicated.htm', {key: key, value: value}, function (data) {
    if (data != 'ok') {
      var title = $(obj).parent().prev().html();
      msg('该' + title + '已被占用，请换一个');
      $(obj).focus();
    }
  });
}

doInput = function (obj, op) {
  var _id
  if (obj != null)
    _id = $(obj).parent().parent().parent().attr('id').substr(3);
  else {
    _id = null;
  }
  $('#id').val(_id);
  if (op != null && op != '')
    $('#op').val(op);
  $('#searchForm').attr('action', 'input.htm').submit();
}

doDel = function (obj) {
  var _id = $(obj).parent().parent().parent().attr('id').substr(3);
  ajDel(_id, null);
}

/**
 * 操作按钮中的查看
 * @param obj
 * @param act
 */
doView = function (obj, act) {
  var _id = $(obj).parent().parent().parent().attr('id').substr(3);
  $('#id').val(_id);
  $('#op').val('v');
  $('#searchForm').attr('action', act == null ? 'input.htm' : act + '.htm').submit();
}

/**
 * 列表中的查看
 * @param obj
 */
doTitleView = function (obj) {
  var _id = $(obj).parent().parent().attr('id').substr(3);
  $('#id').val(_id);
  $('#op').val('v');
  $('#searchForm').attr('action', 'input.htm').submit();
}

doAudit = function (obj, act) {
  var _id = $(obj).parent().parent().parent().attr('id').substr(3);
  $('#id').val(_id);
  $('#form').attr('action', act == null ? 'doAudit.htm' : act + '.htm').submit();
}

showSearchBar = function (obj) {
  $(obj).html($('#searchBar').css('display') == 'none' ? '隐藏搜索栏' : '显示搜索栏');
  $('#searchBar').slideToggle();
  $('#btnArea').slideDown();
}

changeSearchField = function (sel) {
  $('.searchField').find('input').each(function (idx, obj) {
    if (idx == $(sel).prop('selectedIndex')) {
      $(obj).show();
    }
    else {
      $(obj).val('');
      $(obj).hide();
    }
  });
}

movePanel = function (cls) {
  $('#' + cls).slideToggle();
}

setSelectValue = function (renderTo, obj) {
  if ($(obj).find('option:selected').length > 0) {
    var str = $(obj).find('option:selected').text();
  }
  else {
    var str = $(obj).find('option:first').text();
  }
  if ($(obj).val() != '')
    $('#' + renderTo).val(str);
}

doMultiDel = function () {
  $.messager.confirm('系统信息', '确认要批量删除吗？', function (r) {
    if (r) {
      var ids = '';
      $.each($('.table_01').find("tr[id^='tr_']").find("input[type='checkbox']:checked"), function (idx, obj) {
        ids += $(obj).attr('id').substr(4) + ',';
      });
      if (ids.length > 0 && ids.indexOf(','))
        $.post('ajDel.htm', {id: ids}, function () {
          location.href = location.href;
        })
      else
        msg('请选择要删除的信息');
    }
  });
}

reloadPage = function () {
  location.href = location.href;
}

ajaxUpdate = function (id, fieldName, fieldValue) {
  $.messager.confirm('系统信息', '确认要批量更新数据吗？', function (r) {
    if (r)
      $.post('ajaxUpdate.htm', {id: id, fieldName: fieldName, fieldValue: fieldValue}, function (data) {
        if (data.success)
          reloadPage();
      }, 'json');
  });
}


function RepNumber(obj) {
  var reg = /^[\d]+$/g;
  if (!reg.test(obj.value)) {
    var txt = obj.value;
    if (!txt.match(/^[0-9]+[/.]?[0-9]{0,2}$/)) {
      $(obj).val("");
    }
  }
}

function RegInt(obj){
  var reg = /^[\d]+$/g;
  if (!reg.test(obj.value)) {
    var txt = obj.value;
    if (!txt.match(/^[0-9]+$/)) {
      $(obj).val("");
    }
  }
}

//根据status 判断页面的状态
function changePageStatus(strstatus,pagename,ismidExm){
  //var ismidExm="${bean.batch.isHasMidExm}";

  if("true"==ismidExm){
    flowWithMidExm(strstatus,pagename);
  }
  else{
    flowWithoutMidExm(strstatus,pagename);
  }
}

function flowWithoutMidExm(strstatus,pagename){
  var strStatus1="pjstore,pjmodifyfortrial,pjmodifyforset";   //暂存，修改后初审，修改后立项  修改前面所有的页面
  var strStatus2="pjtrial,pjpasstrial,pjmidassess,pjaccept,pjpassaccept,pjterminate"; //待初审 已通过初审 待中评  待验收 已验收 结束   不能修改页面
  var strStatus3="pjsetup,pjmodifyforacp";   //已立项 调整好验收  修改验收页面
  if(strStatus1.indexOf(strstatus)>-1){

  }
  else if(strStatus2.indexOf(strstatus)>-1) {
    $('input,select,textarea').attr("disabled", "true");
    $("[onclick='doSubmit();']").hide();
    $("[onclick='form.submit();']").hide();
    $("[onclick='doLocalSubmit();']").hide();
    $("[onclick='doAppend();']").hide();
    $("[onclick='doSend();']").hide();
    $("[onclick='doAudit();']").hide();
    $("button[class='ico_send']").hide();
    $("button[class='ico_tmpSave']").hide();
    $(".uploadFile input").hide();
    $('.addtable').hide();
    $('#content').find('div').hide();
  }
  else if(strStatus3.indexOf(strstatus)>-1) {
    if("acceptApply"!=pagename){
      $('input,select,textarea').attr("disabled", "true");
      $("[onclick='doSubmit();']").hide();
      $("[onclick='form.submit();']").hide();
      $("[onclick='doLocalSubmit();']").hide();
      $("[onclick='doAppend();']").hide();
      $("[onclick='doSend();']").hide();
      $("[onclick='doAudit();']").hide();
      $("button[class='ico_send']").hide();
      $("button[class='ico_tmpSave']").hide();
      $(".uploadFile input").hide();
      $('.addtable').hide();
      $('#content').find('div').hide();
    }
  }

}

function flowWithMidExm(strstatus,pagename){
  var strStatus1="pjstore,pjmodifyfortrial,pjmodifyforset";   //暂存，修改后初审，修改后立项  修改前面所有的页面
  var strStatus2="pjtrial,pjpasstrial,pjmidassess,pjaccept,pjpassaccept,pjterminate"; //待初审 已通过初审 待中评  待验收 已验收 结束   不能修改页面
  var strStatus3="pjsetup,pjmodifyforcheck";   //已立项 调整好中评  修改中期评估页面
  var strStatus4="pjpassmidcheck,pjmodifyforacp"; //已通过中期评估  调整后验收    修改验收页面

  if(strStatus1.indexOf(strstatus)>-1){

  }
  else if(strStatus2.indexOf(strstatus)>-1) {
    $('input,select,textarea').attr("disabled", "true");
    $("[onclick='doSubmit();']").hide();
    $("[onclick='form.submit();']").hide();
    $("[onclick='doLocalSubmit();']").hide();
    $("[onclick='doAppend();']").hide();
    $("[onclick='doSend();']").hide();
    $("[onclick='doAudit();']").hide();
    $("button[class='ico_send']").hide();
    $("button[class='ico_tmpSave']").hide();
    $(".uploadFile input").hide();
    $('.addtable').hide();
    $('#content').find('div').hide();
  }
  else if(strStatus3.indexOf(strstatus)>-1) {
    if("midExam"!=pagename){
      $('input,select,textarea').attr("disabled", "true");
      $("[onclick='doSubmit();']").hide();
      $("[onclick='form.submit();']").hide();
      $("[onclick='doLocalSubmit();']").hide();
      $("[onclick='doAppend();']").hide();
      $("[onclick='doSend();']").hide();
      $("[onclick='doAudit();']").hide();
      $("button[class='ico_send']").hide();
      $("button[class='ico_tmpSave']").hide();
      $(".uploadFile input").hide();
      $('.addtable').hide();
      $('#content').find('div').hide();
    }
  }
  else{
    if("acceptApply"!=pagename){
      $('input,select,textarea').attr("disabled", "true");
      $("[onclick='doSubmit();']").hide();
      $("[onclick='form.submit();']").hide();
      $("[onclick='doLocalSubmit();']").hide();
      $("[onclick='doAppend();']").hide();
      $("[onclick='doSend();']").hide();
      $("[onclick='doAudit();']").hide();
      $("button[class='ico_send']").hide();
      $("button[class='ico_tmpSave']").hide();
      $(".uploadFile input").hide();
      $('.addtable').hide();
      $('#content').find('div').hide();
    }

  }
}


<%@ tag language="java" body-content="empty" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="param_Type" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="param_Pid" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="renderBankId" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="renderBankName" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="renderBankAccount" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="renderUserName" rtexprvalue="true" type="java.lang.String" %>
<div class="an"><button type="button" onclick="showBankWin()" class="ico_add">
          选择银行账户</button></div>
<style type="text/css">
  .table_01 input{
  	width:90%;
  }
</style>
<div id="bankSelector" style="display:none;background:#eefaff;">
<div style="width: 96%">
<table style="margin-top:10px;" id="banktable" class="table_01">
	<tr>
  		<th  class='hidePannel'>编号</th>
  		<th width="5%">选择</th>
  		<th width="10%">开户银行</th>
        <th width="10%">账户名</th>
        <th width="20%">银行账号</th>
        <th width="15%">操作</th>
    </tr>
</table>
</div>
<div class="an">
<button  type="button" onclick="bank_add()" class="ico_add">
          新增</button>
          <button  type="button" onclick="bank_choose()" class="ico_audit">
         确定</button>
</div>
</div>

<script>
showBankWin = function () {
    var $win = $('#bankSelector').window({
      title: '选择银行账户',
      width: 600,
      height: 400,
      top: '20%',
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
    $('#bankSelector').show();
    loadBanks("${param_Type}","${param_Pid}");
  }
	
   var bankAccount={
		   id:'',
		   corpId:'',
		   providerId:'',
		   bankname:'',
		   username:'',
		   account:''
   };
   
   function loadBanks(type,pid){
	   var bankid=$("#"+"${renderBankId}").text();
	   
	   $("#banktable").find("tr:not(:first)").remove();
	   $.get(base + '/kcfw/BankAccount/getBanks.htm',{type:type,pid:pid},function (data) {
		   var str="";
		   $.each(data,function(ind,obj){
			   str+="<tr>";
			   str+="<td class='hidePannel'>"+obj.id+"</td>";
			   if(bankid==obj.id){
				   str+="<td><input type='radio' checked='checked' name='banksel'/></td>";
			   }
			   else{
			   		str+="<td><input type='radio' name='banksel'/></td>";
			   }
			   str+="<td>"+obj.bankname+"</td>";
			   str+="<td>"+obj.username+"</td>";
			   str+="<td>"+obj.account+"</td>";
			   str+="<td><div><a href='#' onclick='bank_modify(this)'>修改</a><a href='#' onclick='bank_del(this)'>删除</a></div></td>";
			   str+="</tr>";
		   });
		   $("#banktable").append(str);
	   },'json');
   }
   
   function bank_modify(item){
	   bankAccount={
			   id:$(item).closest('tr').find('td').eq(0).text(),
			   corpId:'',
			   providerId:'',
			   bankname:$(item).closest('tr').find('td').eq(2).text(),
			   username:$(item).closest('tr').find('td').eq(3).text(),
			   account:$(item).closest('tr').find('td').eq(4).text()
	   };
	   $(item).closest('tr').remove();
	   bankInfoAdd();
   }
   
   function bank_del(item){
	   var pid=$(item).closest('tr').find('td').eq(0).text();
	   $.post(base + '/kcfw/BankAccount/delBank.htm',{id:pid},function (data) {
		   $(item).closest('tr').remove();
	   });
	   
   }
   
   function bank_add(){
	   bankAccount={
			   id:'',
			   corpId:'',
			   providerId:'',
			   bankname:'',
			   username:'',
			   account:''
	   };
	   bankInfoAdd();
   }
   
   function bankInfoAdd(){
	   var str="<tr>"
		   str+="<td class='hidePannel'>"+bankAccount.id+"</td>";
		   str+="<td><input type='radio' name='banksel'/></td>";
		   str+="<td><input type='text' value='"+bankAccount.bankname+"'></input></td>";
		   str+="<td><input type='text' value='"+bankAccount.username+"'></input></td>";
		   str+="<td><input type='text' value='"+bankAccount.account+"'></input></td>";
		   str+="<td><div><a href='#' onclick='bank_ok(this)'>确定</a><a href='#' onclick='bank_cancel(this)'>取消</a></div></td>";
		   str+="</tr>";
		   $("#banktable").append(str);
   }
   
   function bank_choose(){
	   var item=$("input[name=banksel]:checked").closest('tr');
	   if(item.length==0){
		   msg('请选择银行账号');
		   return;
	   }
	   $("#"+"${renderBankId}").text($(item).find('td').eq(0).text());
	   $("#"+"${renderBankName}").text($(item).find('td').eq(2).text());
	   $("#"+"${renderBankAccount}").text($(item).find('td').eq(4).text());
	   $("#"+"${renderUserName}").text($(item).find('td').eq(3).text());
	   $('#bankSelector').window('close');
   }
   
   function bank_ok(item){
	   
	   if("${param_Type}"=="corp"){
		   bankAccount.corpId="${param_Pid}";
	   }
	   else{
		   bankAccount.providerId="${param_Pid}";
	   }
	   bankAccount.bankname=$(item).closest('tr').find('input').eq(1).val();
	   bankAccount.username=$(item).closest('tr').find('input').eq(2).val();
	   bankAccount.account=$(item).closest('tr').find('input').eq(3).val();
	   if(!checkBankComplete()){
		   return;
	   }
	   $.post(base + '/kcfw/BankAccount/saveBank.htm',bankAccount,function (data) {
		   loadBanks("${param_Type}","${param_Pid}");
	   });
   }
   
   function checkBankComplete(){
	   var reg=/^[0-9]{16,19}$/;
	   if(bankAccount.bankname.length==0||bankAccount.username==0||bankAccount.account==0){
		   msg('请填写完整信息');
		   return false;
	   }
	   if(!reg.test(bankAccount.account)){
		   msg('请填写规范的银行账号');
		   return false;
	   }
	   return true;
   }
   
   
   
   function bank_cancel(item){
	   loadBanks("${param_Type}","${param_Pid}");
   }
   
</script>
$(document).ready(function() {	
	$('.tabtit li').click(function(){
			  $(this).addClass("sel").siblings().removeClass("sel");
			  $(".tabcontent > div").eq($(".tabtit li").index(this)).show().siblings().hide();
		 });
});
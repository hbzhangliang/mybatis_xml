$(document).ready(function() {	
	
	$(".tabtit li").click(function(){
		  $(this).addClass("tab_on").siblings().removeClass("tab_on");
		  $(".column>div>div").eq($(".tabti li").index(this)).show().siblings().hide();
	 });
	


});

$(function(){
	$(".sbubar span.cur_1").next(".subMenu").show();
	$(".sbubar span").click(function(event){
	  $(".sbubar>span").removeClass("cur_1");	 
	  $(this).toggleClass("cur_1");
		var that = $(this).next(".subMenu")
		if(that[0]){
		 that.slideToggle().siblings(".subMenu").slideUp();
	   //$(".subMenu").prev().addClass("cur_1");
		}
		else{
		 $(".subMenu").slideUp();
		 $(".subMenu").prev().removeClass("cur_1");
		}
		
	   });
	  $(".subMenu b.cur_2").next(".subMenu_cont").show();
	 $(".subMenu b").click(function(event){
		$(".subMenu>b").removeClass("cur_2");	 
	 	$(this).toggleClass("cur_2");
		var that = $(this).next(".subMenu_cont")
		if(that[0]){
		 that.slideToggle().siblings(".subMenu_cont").slideUp();
		}
		else{
		 $(".subMenu_cont").slideUp();
		 $(".subMenu_cont").prev().removeClass("cur_2");
		};
		
	   });
	 
	  $(".subMenu_cont p.cur_3").next(".subnav").show();
	  $(".subMenu_cont p").click(function(event){
		$(".subMenu_cont>p").removeClass("cur_3");	 
	 	$(this).toggleClass("cur_3");
			var that = $(this).next(".subnav")
			if(that[0]){
		 	that.slideToggle().siblings(".subnav").slideUp();
			}
		else{
		 	$(".subnav").slideUp();
		 	$(".subnav").prev().removeClass("cur_3");
		};
		
	   });
});	
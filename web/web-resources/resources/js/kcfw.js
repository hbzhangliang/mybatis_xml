$(function(){

    $(".table_01").find("tr td").mouseenter(function(){
        if($(this).hasClass("enlarge")) {
             $(this).addClass("tdshow").css({"overflow":"visible"});
            //$(this).css({"overflow":"visible","font-weight":"bolder","color":"blue"});
        }
    }).mouseleave(function(){
        if($(this).hasClass("enlarge")) {
            $(this).removeClass("tdshow").css({"overflow":"hidden"});
        }
    });

});
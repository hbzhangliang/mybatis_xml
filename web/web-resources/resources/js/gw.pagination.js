$(document).ready(function(){
    var prev = {start: 0, stop: 0};
    var cont = $('#content').find('tr');
    var sizePerPage = 10;

    $('.page').paging(cont.length, {
        perpage: sizePerPage,
        lapping: 0,
        format: '[< c! >]',
        page: 1,
        onSelect: function (page) {
            var data = this.slice;
            cont.slice(prev[0], prev[1]).css('display', 'none');
            cont.slice(data[0], data[1]).fadeIn("slow");
            prev = data;
            return true;
        },
        onFormat: function (type) {
            switch (type) {
                case 'block': // n and c
                    return '当前' + this.value + '/' + Math.ceil(cont.length / sizePerPage);
                case 'next': // >
                    return '<a href="javascript:void(0);">下一页</a>';
                case 'prev': // <
                    return '<a href="javascript:void(0);">上一页</a>';
                case 'first': // [
                    return '<a href="javascript:void(0);">首页</a>';
                case 'last': // ]
                    return '<a href="javascript:void(0);">末页</a>';
            }
        }
    });
});
$(Document).ready(function () {
    function goPage(pageNo) {


        var submitObj = new Object();

        submitObj.pageIndex= pageNo;
        submitObj.searchWrd= $("#searchWrd").val();

        $.ajax({
            url: "/list",
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            data:JSON.stringify(submitObj),
            dataType : "json",
            progress: true
        })
            .done(function(data) {

                var  result = new Array;
                result = data.resultList;
                var searchVO = data.searchVO;
                var realEnd = searchVO.realEnd;
                var startDate = searchVO.startDate;
                var startButtonDate = startDate - 1;
                var endDate = searchVO.endDate;
                var endButtonDate = endDate + 1;
                var pageIndex = searchVO.pageIndex;
                var resultCnt = data.resultCnt;
                var totalPageCnt = data.totalPageCnt;
                var recordCountPerPage = searchVO.recordCountPerPage;


                var ii = (resultCnt - (pageIndex - 1) * recordCountPerPage);

                var content = '';
                var content2 = '';

                $.each(result, function(key, value) {

                    content +=    '<tr class="memList">';
                    content +=    '<td class="t_c">' + ii + '</td>';
                    content +=    '<td class="t_c">' + value.me_sido + '</td>';
                    content +=    '<td>' + value.me_gugun + '<button type="button" class="btnInfo fr"></button></td>';
                    content +=    '<td class="t_c">' + value.me_biz_name + '</td>';
                    content +=    '<td class="t_c">' +  value.me_name  +'</td>';
                    content +=    '<td class="t_c">' +  value.me_biz_tel + '</td>';
                    content +=    '</tr>';
                    ii--;
                });

                $(".listData").html(content);

                content2 = '<input type="hidden" id="pageIndex" name="pageIndex" value="1">';
                content2 +=    '<ol class="pagination" id="pagination">';

                if(searchVO.prev){
                    content2 +=    '<li class="prev_end"><a href="javascript:void(0);" onclick="goPage(1); return false;" ></a></li>';
                    content2 +=    '<li class="prev"><a href="javascript:void(0);"  onclick="goPage(' + startButtonDate + '); return false;" ></a></li>';
                }

                for (var num=startDate; num<=endDate; num++) {
                    if (num == pageIndex) {
                        content2 +=    '<li><a href="javascript:void(0);" onclick="goPage(' + num + '); return false;" title="' + num + '"  class="num on">' + num + '</a></li>';
                    } else {
                        content2 +=    '<li><a href="javascript:void(0);" onclick="goPage(' + num + '); return false;" title="' + num + '" class="num">' + num + '</a></li>';
                    }
                }

                if(searchVO.next){
                    content2 +=    '<li class="next"><a href="javascript:void(0);"  onclick="goPage(' + endButtonDate + '); return false;" ></a></li>';
                    content2 +=    '<li class="next_end"><a href="javascript:void(0);" onclick="goPage(' + searchVO.realEnd +'); return false;"></a></li>';
                }

                content2 +=    '</ol>';
                content2 +=    '</div>';

                $(".board-list-paging").html(content2);

            })
            .fail(function(e) {
                alert("검색에 실패하였습니다.");
            })
            .always(function() {

            });
    }
})
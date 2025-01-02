// $(document).ready(function () {
//     let submitObj = {
//         pageIndex: 1,
//         pageUnit: 10
//     };
//
//     function loadPostList() {
//         console.log("loadPostList called with submitObj:", submitObj);
//
//         $.ajax({
//             url: "/post/list/json",
//             type: "GET",
//             data: submitObj,
//             dataType: "json",
//             success: function (data) {
//                 console.log("Response from server:", data);
//                 updatePostList(data.postList);
//                 updatePagination(data.pagination);
//             },
//             error: function (xhr, status, error) {
//                 alert("데이터 로딩 중 오류가 발생했습니다.");
//                 console.error("Error occurred:", error);
//                 console.error("Response status:", status);
//                 console.error("XHR object:", xhr);
//             }
//         });
//     }
//
//     function updatePostList(postList) { /* ... */ }
//     function updatePagination(pagination) { /* ... */ }
//
//     function goPage(pageNum) {
//         submitObj.pageIndex = pageNum;
//         console.log("goPage called with pageNum:", pageNum);
//         loadPostList();
//     }
//
//     loadPostList();
// });

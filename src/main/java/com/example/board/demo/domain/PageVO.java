package com.example.board.demo.domain;

public class PageVO {

    private Integer pageIndex = 1;              // 현재 페이지
    private Integer pageUnit = 10;             // 페이지 갯수
    private Integer pageSize = 10;             // 페이지 사이즈
    private Integer firstIndex = 1;            // firstIndex
    private Integer recordCountPerPage = 10;   // recordCountPerPage
    private Integer totCnt = 0;                // 총 갯수
    private Integer startDate = 0;             // 시작 데이터
    private Integer endDate = 0;               // 종료 데이터
    private Integer realEnd = 0;               // 페이징 마지막 숫자

    private boolean prev, next;                // 이전, 다음 버튼

    // Getter & Setter
    public Integer getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(Integer pageIndex) {
        this.pageIndex = pageIndex;
    }

    public Integer getPageUnit() {
        return pageUnit;
    }

    public void setPageUnit(Integer pageUnit) {
        this.pageUnit = pageUnit;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getFirstIndex() {
        return firstIndex;
    }

    public void setFirstIndex(Integer firstIndex) {
        this.firstIndex = firstIndex;
    }

    public Integer getRecordCountPerPage() {
        return recordCountPerPage;
    }

    public void setRecordCountPerPage(Integer recordCountPerPage) {
        this.recordCountPerPage = recordCountPerPage;
    }

    public boolean isPrev() {
        return prev;
    }

    public void setPrev(boolean prev) {
        this.prev = prev;
    }

    public boolean isNext() {
        return next;
    }

    public void setNext(boolean next) {
        this.next = next;
    }

    public Integer getTotCnt() {
        return totCnt;
    }

    public void setTotCnt(Integer totCnt) {
        this.totCnt = totCnt;
    }

    public Integer getStartDate() {
        return startDate;
    }

    public void setStartDate(Integer startDate) {
        this.startDate = startDate;
    }

    public Integer getEndDate() {
        return endDate;
    }

    public void setEndDate(Integer endDate) {
        this.endDate = endDate;
    }

    public Integer getRealEnd() {
        return realEnd;
    }

    public void setRealEnd(Integer realEnd) {
        this.realEnd = realEnd;
    }
}

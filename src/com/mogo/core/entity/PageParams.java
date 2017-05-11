package com.mogo.core.entity;


import org.springframework.stereotype.Component;

/**
 * Created by li_hongyu on 14-8-6.
 */
@Component("pm")
public class PageParams {

  //页码
  private Integer page = 1;

  //每页记录数
  private Integer pageSize = 10;

  //总记录数
  private Integer totalRows = 0;

  //总页数
  private Integer totalPage = 1;

  public PageParams() {
  }

  public Integer getPage() {
    return page > getTotalPage() ? 1 : page;
  }

  public void setPage(Integer page) {
    this.page = page;
  }

  public Integer getPageSize() {
    return pageSize;
  }

  public void setPageSize(Integer pageSize) {
    this.pageSize = pageSize;
  }

  public Integer getTotalRows() {
    return totalRows;
  }

  public void setTotalRows(Integer totalRows) {
    this.totalRows = totalRows;
  }

  public Integer getTotalPage() {
    return (totalRows - 1) / pageSize + 1;
  }

  public void setTotalPage(Integer totalPage) {
    this.totalPage = totalPage;
  }

  public Integer getStart(Integer page) {
    return (page - 1) * getPageSize() + 1;
  }

  public Integer getEnd(int totalRow, Integer page) {
    if (totalRow > 0)
      return ((page - 1) * getPageSize() + getPageSize()) < totalRow
          ? ((page - 1) * getPageSize() + getPageSize())
          : totalRow;
    else
      return 0;
  }
}

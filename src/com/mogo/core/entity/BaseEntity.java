package com.mogo.core.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.annotation.Resource;
import javax.persistence.Transient;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by admin on 2016/7/6.
 */
public class BaseEntity {
    @Resource//分页参数
    @Transient
    @JsonIgnore
    private PageParams pm = new PageParams();

    @Transient//查询参数
    @JsonIgnore
    private Map<String, String> params = new HashMap<String, String>();

    @Transient//临时传值参数
    @JsonIgnore
    private Map<String, String> tmpParams = new HashMap<String, String>();

    @Transient
    @JsonIgnore
    private String op;//操作

    @Transient
    @JsonIgnore
    private String orderBy;//排序
    @Transient
    @JsonIgnore
    private String fid;//多附件Ids

    public PageParams getPm() {
        return pm;
    }

    public void setPm(PageParams pm) {
        this.pm = pm;
    }

    public Map<String, String> getParams() {
        return params;
    }

    public void setParams(Map<String, String> params) {
        this.params = params;
    }

    public Map<String, String> getTmpParams() {
        return tmpParams;
    }

    public void setTmpParams(Map<String, String> tmpParams) {
        this.tmpParams = tmpParams;
    }

    public String getOp() {
        return op;
    }

    public void setOp(String op) {
        this.op = op;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

    public String getFid() {
        return fid;
    }

    public void setFid(String fid) {
        this.fid = fid;
    }
}

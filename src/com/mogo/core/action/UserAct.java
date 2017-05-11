package com.mogo.core.action;

import com.mogo.core.entity.User;
import com.mogo.core.manager.UserMng;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.UUID;

/**
 * Created by admin on 2016/7/6.
 */

@Controller
@RequestMapping("/user")
public class UserAct {
    @Resource
    private UserMng userMng;


    @RequestMapping("/list")
    public ModelAndView userlist(User queryBean) {
        return new ModelAndView("core/user/list")
                .addObject("queryBean",queryBean)
                .addObject("currentUser",userMng.getUserList("001"))
                .addObject("list",userMng.getAllUserList());
    }


    @RequestMapping("/input")
    public ModelAndView userinput(User queryBean) {
        try{
            if(StringUtils.isEmpty(queryBean.getId())){
                queryBean=(User)queryBean.getClass().newInstance();
                queryBean.setParams(queryBean.getParams());
                queryBean.setPm(queryBean.getPm());
                queryBean.setOp(queryBean.getOp());
            }
            else{
                queryBean=userMng.getUserList(queryBean.getId());
            }
            return new ModelAndView("core/user/input")
                    .addObject("bean", queryBean);
        }
        catch (Exception e){
            return null;
        }

    }

    @RequestMapping("/save")
    public ModelAndView usersave(User queryBean){
        if(StringUtils.isEmpty(queryBean.getId())){
            queryBean.setId( UUID.randomUUID().toString().replace("-",""));
            userMng.insertUser(queryBean);
        }
        else{
            userMng.updateUser(queryBean);
        }

        return new ModelAndView("redirect:list.htm");
    }

    @RequestMapping("ajDel")
    @ResponseBody
    public String userajDel(String id){
        try {
            for(String pid:id.split(",")){
                userMng.delUser(pid);
            }
            return "1,删除成功";
        }
        catch (Exception e){
            e.printStackTrace();
            return "0,删除出现错误";
        }
    }





}

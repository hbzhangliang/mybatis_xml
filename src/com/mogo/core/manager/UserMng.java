package com.mogo.core.manager;

import com.mogo.core.entity.User;

import java.util.List;

/**
 * Created by admin on 2016/7/6.
 */
public interface UserMng {
    User getUserList(String id);

    List<User> getAllUserList();

    int insertUser(User user);


    int updateUser(User user);

    int delUser(String id);
}

package com.mogo.core.manager.impl;

import Util.MyBatisUtil;
import com.mogo.core.entity.User;
import com.mogo.core.manager.UserMng;
//import com.mogo.core.mapper.UserMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

/**
 * Created by admin on 2016/7/6.
 */


@Service
public class UserMngImpl implements UserMng{
//    @Autowired
//    private UserMapper userMapper;




    @Override
    public User getUserList(String id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        String statement = "com.mogo.core.mapper.UserXml.getUserList";
        //session.close();
        return session.selectOne(statement,id);
    }

    @Override
    public List<User> getAllUserList(){

        SqlSession session = MyBatisUtil.getSqlSession();
        String statement = "com.mogo.core.mapper.UserXml.getAllUserList";
        //session.close();
        return session.selectList(statement);
    }

    @Override
    public int insertUser(User user){

        SqlSession session = MyBatisUtil.getSqlSession();
        String statement = "com.mogo.core.mapper.UserXml.add";
        int rows = session.insert(statement, user);
        //提交
        session.commit();
        System.out.println(rows);
        session.close();
        return rows;
    }

    @Override
    public  int updateUser(User user){
        SqlSession session = MyBatisUtil.getSqlSession();
        String statement = "com.mogo.core.mapper.UserXml.update";
        session.update(statement, user);
        session.commit();
        session.close();
        return 1;
    }

    @Override
    public int delUser(String id){
        SqlSession session = MyBatisUtil.getSqlSession();
        String statement = "com.mogo.core.mapper.UserXml.deleteById";
        session.delete(statement, id);
        session.commit();
        session.close();
        return 1;
    }
}

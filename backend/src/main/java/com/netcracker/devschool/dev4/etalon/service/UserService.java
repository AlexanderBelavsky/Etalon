package com.netcracker.devschool.dev4.etalon.service;

import com.netcracker.devschool.dev4.etalon.entity.User;
import com.netcracker.devschool.dev4.etalon.entity.User_role;

import java.util.List;


public interface UserService {
    User_role create(User user, User_role userRoles);

    public void deleteUserById(int id);

    public User delete(long id) throws Exception;

    public List<User> findAll();

    public User update(User user) throws Exception;

    public User findById(long id);

    public int getIdByName(String name);

    void deleteUserByUsername(String username);
}

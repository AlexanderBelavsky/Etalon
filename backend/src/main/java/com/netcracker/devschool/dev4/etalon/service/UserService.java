package com.netcracker.devschool.dev4.etalon.service;

import com.netcracker.devschool.dev4.etalon.entity.User;

import java.util.List;


public interface UserService {
    public User create(User user);

    public User delete(long id) throws Exception;

    public List<User> findAll();

    public User update(User user) throws Exception;

    public User findById(long id);

    public int getIdByName(String name);
}

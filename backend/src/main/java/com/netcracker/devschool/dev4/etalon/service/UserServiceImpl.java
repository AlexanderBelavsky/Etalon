package com.netcracker.devschool.dev4.etalon.service;

import java.util.List;

import javax.annotation.Resource;

import com.netcracker.devschool.dev4.etalon.entity.User_role;
import com.netcracker.devschool.dev4.etalon.repository.User_roleRepository;
import org.omg.CosNaming.NamingContextPackage.NotFound;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.netcracker.devschool.dev4.etalon.entity.User;
import com.netcracker.devschool.dev4.etalon.repository.UserRepository;

@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserRepository userRepository;


    @Resource
    private User_roleRepository userRolesRepository;

    @Override
    @Transactional
    public User_role create(User user, User_role userRoles) {

        userRepository.save(user);
        return userRolesRepository.save(userRoles);
    }

    @Override
    public void deleteUserById(int id) {
        User_role deletedUser = userRolesRepository.findOne(id);

        userRolesRepository.delete(deletedUser);
        userRepository.deleteUserByUsername(deletedUser.getUsername());
    }


    @Override
    @Transactional
    public User delete(long id) throws Exception {
        User deletedUser = userRepository.findOne((int) id);

        if (deletedUser == null)
            throw new Exception("Not found");

        userRepository.delete(deletedUser);
        return deletedUser;
    }

    @Override
    @Transactional
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    @Transactional
    public User update(User user) throws Exception {
        return null;
    }

    @Override
    @Transactional
    public User findById(long id) {
        return userRepository.findOne((int) id);
    }

    @Override
    public int getIdByName(String name) {
        return userRolesRepository.findByUsername(name).getUser_role_id();
    }

    @Override
    public void deleteUserByUsername(String username) {
        userRepository.deleteUserByUsername(username);
    }
}



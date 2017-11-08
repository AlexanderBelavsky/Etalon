package com.netcracker.devschool.dev4.etalon.repository;

import com.netcracker.devschool.dev4.etalon.entity.User_role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface User_roleRepository extends JpaRepository<User_role, Integer> {
    @Query("select b from User_role b where b.username = :username")
    User_role findByUsername(@Param("username") String name);
}

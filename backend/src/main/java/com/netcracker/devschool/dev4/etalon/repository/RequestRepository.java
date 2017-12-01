package com.netcracker.devschool.dev4.etalon.repository;

import com.netcracker.devschool.dev4.etalon.entity.Requests;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface RequestRepository extends JpaRepository<Requests, Integer>{
    @Query("delete from Requests a where a.idRequest = :id and a.idStudent = :sid")
    @Modifying
    void remove(@Param("id") int id, @Param("sid") int sid);
}


package com.netcracker.devschool.dev4.etalon.repository;

import com.netcracker.devschool.dev4.etalon.entity.Practice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PracticeRepository extends JpaRepository<Practice, Integer> {
    @Query("select l from Practice l where l.idhead_of_practice = :idhead_of_practice")
    List<Practice> findByHopId(@Param("idhead_of_practice") int idhead_of_practice);

    @Query("select l from Practice l where l.idrequest in (select s from Requests s where s.idStudent = :id)")
    List<Practice> findByStudentId(@Param("id") int id);
}


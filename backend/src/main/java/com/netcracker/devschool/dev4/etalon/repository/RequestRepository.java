package com.netcracker.devschool.dev4.etalon.repository;

import com.netcracker.devschool.dev4.etalon.entity.Practice;
import com.netcracker.devschool.dev4.etalon.entity.Requests;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface RequestRepository extends JpaRepository<Requests, Integer>{
    @Query("delete from Requests a where a.idRequest = :id and a.idStudent = :sid")
    @Modifying
    void remove(@Param("id") int id, @Param("sid") int sid);

    @Query("select c from Practice c where c.idrequest in(select b.idRequest from Requests b where b.idStudent =:idStudent )")
    List<Practice> findAllPracticeForStudent(@Param("idStudent") int idStudent);

    @Transactional
    @Query("delete from Requests b where b.idStudent = :sid")
    @Modifying
    void deleteBySid(@Param("sid") int sid);


    @Transactional
    @Modifying
    @Query("delete from Requests a where a.idRequest = :idRequest")
    void deleteRequestsByIdRequest(@Param("idRequest") int idRequest);
}


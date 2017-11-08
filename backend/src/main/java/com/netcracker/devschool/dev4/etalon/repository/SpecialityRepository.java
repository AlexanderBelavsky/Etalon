package com.netcracker.devschool.dev4.etalon.repository;

import com.netcracker.devschool.dev4.etalon.entity.Speciality;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SpecialityRepository extends JpaRepository<Speciality, Integer> {
    @Query("select s from Speciality s where s.idFaculty = :facultyid")
    List<Speciality> findByFacultyId(@Param("facultyid") int facultyId);
}

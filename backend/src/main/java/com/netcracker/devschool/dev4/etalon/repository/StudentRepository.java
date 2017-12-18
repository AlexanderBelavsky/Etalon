package com.netcracker.devschool.dev4.etalon.repository;
import com.netcracker.devschool.dev4.etalon.entity.Student;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;

public interface StudentRepository extends JpaRepository<Student, Integer> {
    @Query("select l from Student l where l.id in (select p.idStudent from Requests " +
            "p where p.idRequest = :id) and concat(l.first_name, l.last_name, l.group_number, l.av_score, " +
            "(select f.faculty_name from Faculty f where f.idFaculty = l.idFaculty), (select s.speciality_name from " +
            "Speciality s where s.idSpeciality = l.idSpeciality)) like concat('%', :skey, '%') ")
    Page<Student> findWithPracticeId(@Param("id") int id, @Param("skey") String key, Pageable page);

    @Query("select l from Student l where concat(l.first_name, l.last_name, l.group_number, l.av_score, " +
            "(select f.faculty_name from Faculty f where f.idFaculty = l.idFaculty), (select s.speciality_name from " +
            "Speciality s where s.idSpeciality = l.idSpeciality)) like concat('%', :skey, '%') ")
    Page<Student> findWithoutPracticeId(@Param("skey") String key,  Pageable page);

    @Query("select l from Student l where l.idFaculty = :fid and l.idSpeciality = :sid and l.av_score >= :minavg and " +
            "l.form_of_Education = :budget and not exists (select p from Practice p where p.idrequest in (select a.idRequest from Requests a where " +
            "a.idStudent = l.idStudent) and ((:start between p.start and p.finish) or (:endd between p.start and p.finish)))")
    Page<Student> findForRequest(@Param("fid") int fid, @Param("sid") int sid,
                                 @Param("start") Date start,
                                 @Param("endd") Date end,
                                 @Param("budget") String budget,
                                 @Param("minavg") double minavg, Pageable page);

    @Query("select a from Student a where a.idFaculty = :fid")
    List<Student> findStudentByIdFaculty(@Param("fid") int fid);

    @Query("select a from Student a where a.idSpeciality = :sid")
    List<Student> findStudentByIdSpeciality(@Param("sid") int sid);
}

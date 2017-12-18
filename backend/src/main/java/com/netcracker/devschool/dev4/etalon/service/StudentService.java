package com.netcracker.devschool.dev4.etalon.service;

import com.netcracker.devschool.dev4.etalon.entity.Student;
import org.springframework.data.domain.Page;

import java.util.Date;
import java.util.List;

public interface StudentService {
    public Student create(Student student);

    public Student delete(int idStudent) throws Exception;

    public void deleteStudentById(int id);

    public List<Student> findAll();

    public Student update(Student student);

    public Student findById(int idStudent);

    Page<Student> findByParams(int practiceId, String searchKey, String sortBy, String order, int start, int length);

    Page<Student> findForRequest(int facultyId, int specialityId, Date startdate, Date enddate, String isbudget, double minAvg, String sortBy, String order, int start, int length);

    public List<Student> findStudentByIdFaculty(int fid);

    public List<Student> findStudentByIdSpeciality(int sid);
}

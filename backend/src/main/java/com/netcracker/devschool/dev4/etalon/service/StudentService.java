package com.netcracker.devschool.dev4.etalon.service;

import com.netcracker.devschool.dev4.etalon.entity.Student;

import java.util.List;

public interface StudentService {
    public Student create(Student student);

    public Student delete(int idStudent) throws Exception;

    public List<Student> findAll();

    public Student update(Student student) throws Exception;

    public Student findById(int idStudent);
}

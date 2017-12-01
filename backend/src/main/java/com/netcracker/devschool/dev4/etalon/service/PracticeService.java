package com.netcracker.devschool.dev4.etalon.service;

import com.netcracker.devschool.dev4.etalon.entity.Practice;
import com.netcracker.devschool.dev4.etalon.entity.Requests;
import com.netcracker.devschool.dev4.etalon.entity.Student;

import java.util.List;

public interface PracticeService {
    Practice create(Practice practice);

    public void deletePracticeById(int id);

    Practice findById(int id);

    Practice delete(int id) throws Exception;

    Practice update(Practice practice);

    List<Practice> findAll();

    List<Practice> findByHopId(int id);

    List<Practice> findByStudentId(int id);

    public Student removeFromPractice(int id, int studentId);

    Requests assign(int id, int studentId);
}

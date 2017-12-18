package com.netcracker.devschool.dev4.etalon.service;

import com.netcracker.devschool.dev4.etalon.entity.Student;
import com.netcracker.devschool.dev4.etalon.repository.StudentRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {

    @Resource
    private StudentRepository studentRepository;

    @Override
    @Transactional
    public Student create(Student student) {
        Student createdStudent = student;
        return studentRepository.save(createdStudent);
    }

    @Override
    @Transactional
    public Student delete(int idStudent) throws Exception {
        Student deletedStudent = studentRepository.findOne(idStudent);

        if (deletedStudent == null)
            throw new Exception("Not found");

        studentRepository.delete(deletedStudent);
        return deletedStudent;
    }

    @Override
    @Transactional
    public List<Student> findAll() {
        return studentRepository.findAll();
    }

    @Override
    @Transactional
    public Student update(Student student) throws Exception {
        Student updated = studentRepository.findOne(student.getIdStudent());
        updated.setFirst_name(student.getFirst_name());
        updated.setLast_name(student.getLast_name());
        updated.setImageurl(student.getImageurl());
        updated.setIdFaculty(student.getIdFaculty());
        updated.setIdSpeciality(student.getIdSpeciality());
        updated.setGroup_number(student.getGroup_number());
        updated.setAv_score(student.getAv_score());
        updated.setForm_of_Education(student.getForm_of_Education());
        return updated; //TODO:
    }

    @Override
    public Student findById(int idStudent) {
        return studentRepository.findOne(idStudent);
    }

    @Override
    public List<Student> findStudentByIdFaculty(int fid){
        return studentRepository.findStudentByIdFaculty(fid);
    }

    @Override
    public List<Student> findStudentByIdSpeciality(int sid){
        return studentRepository.findStudentByIdSpeciality(sid);
    }

    @Override
    public Page<Student> findByParams(int practiceId, String searchKey, String sortBy, String order, int start, int length) {
        PageRequest pageR = new PageRequest(start/length, length, Sort.Direction.fromString(order), sortBy);
        Page<Student> result;
        if (practiceId!=-1) {
            result = studentRepository.findWithPracticeId(practiceId, searchKey, pageR);
        }
        else {
            result = studentRepository.findWithoutPracticeId(searchKey, pageR);
        }
        return result;
    }

    @Override
    public Page<Student> findForRequest(int facultyId, int specialityId, Date startdate, Date enddate, String isbudget, double minAvg, String sortBy, String order, int start, int length) {
        PageRequest pageR = new PageRequest(start / length, length, Sort.Direction.fromString(order), sortBy);
        Page<Student> result = studentRepository.findForRequest(facultyId, specialityId, startdate, enddate, isbudget, minAvg, pageR);
        return result;
    }
}


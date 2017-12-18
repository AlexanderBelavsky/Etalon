package com.netcracker.devschool.dev4.etalon.service;

import com.netcracker.devschool.dev4.etalon.entity.Faculty;
import com.netcracker.devschool.dev4.etalon.entity.Student;
import com.netcracker.devschool.dev4.etalon.repository.FacultyRepository;
import com.netcracker.devschool.dev4.etalon.repository.SpecialityRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.swing.*;
import java.util.List;

@Service
public class FacultyServiceImpl  implements FacultyService {
    @Resource
    private FacultyRepository facultyRepository;

    @Resource
    private SpecialityRepository specialityRepository;

    @Resource
    private StudentService studentService;

    @Override
    public Faculty create(Faculty faculty) {
        return facultyRepository.save(faculty);
    }

    @Override
    public void deleteFacultyById(int id){
        List<Student> students = studentService.findStudentByIdFaculty(id);
        if (students.isEmpty()) {
            specialityRepository.deleteSpecialityByFaculty(id);
            facultyRepository.delete(id);
        } else {
            JOptionPane.showMessageDialog(null, "Переведите всех студентов на другой факультет!");
        }
    }

    @Override
    public Faculty delete(int idFaculty) throws Exception {
        if (facultyRepository.exists(idFaculty)) {
            Faculty deleted = facultyRepository.findOne(idFaculty);
            facultyRepository.delete(idFaculty);
            return deleted;
        } else {
            throw new Exception("Not found");
        }
    }

    @Override
    public List<Faculty> findAll() {
        return facultyRepository.findAll();
    }

    @Override
    public Faculty update(Faculty faculty) throws Exception {
        if (facultyRepository.exists(faculty.getIdFaculty())) {
            Faculty updated = facultyRepository.findOne(faculty.getIdFaculty());
            updated.setFaculty_name(faculty.getFaculty_name());
            return updated;
        }
        return null;
    }

    @Override
    public Faculty findById(int idFaculty) {
        return facultyRepository.findOne(idFaculty);
    }
}


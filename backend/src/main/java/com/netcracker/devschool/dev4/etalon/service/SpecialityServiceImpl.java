package com.netcracker.devschool.dev4.etalon.service;

import com.netcracker.devschool.dev4.etalon.entity.Speciality;
import com.netcracker.devschool.dev4.etalon.entity.Student;
import com.netcracker.devschool.dev4.etalon.repository.SpecialityRepository;
import com.netcracker.devschool.dev4.etalon.repository.StudentRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.swing.*;
import java.util.List;

@Service
public class SpecialityServiceImpl implements SpecialityService {
    @Resource
    private SpecialityRepository specialityRepository;

    @Resource
    private StudentRepository studentRepository;

    @Override
    public Speciality create(Speciality speciality) {
        return specialityRepository.save(speciality);
    }

    @Override
    public void deleteSpecialityById(int id){
        List<Student> students = studentRepository.findStudentByIdSpeciality(id);
        if (students.isEmpty()) {
            specialityRepository.delete(id);
        } else {
            JOptionPane.showMessageDialog(null, "Переведите всех студентов с этой специальности на другой факультет или специальность!");
        }
    }

    @Override
    public Speciality delete(int idSpeciality) throws Exception {
        if (specialityRepository.exists(idSpeciality)) {
            Speciality deleted = specialityRepository.findOne(idSpeciality);
            specialityRepository.delete(idSpeciality);
            return deleted;
        } else {
            throw new Exception("Not found");
        }
    }

    @Override
    public List<Speciality> findAll() {
        return specialityRepository.findAll();
    }

    @Override
    public Speciality update(Speciality speciality) throws Exception {
        if (specialityRepository.exists(speciality.getIdSpeciality())) {
            Speciality updated = specialityRepository.findOne(speciality.getIdSpeciality());
            updated.setSpeciality_name(speciality.getSpeciality_name());
            updated.setIdFaculty(speciality.getIdFaculty());
            return updated;
        }
        return null;
    }

    @Override
    public Speciality findById(int idSpeciality) {
        return specialityRepository.findOne(idSpeciality);
    }

    @Override
    public List<Speciality> findByFacultyId(int idSpeciality) {
        return specialityRepository.findByFacultyId(idSpeciality);
    }
}

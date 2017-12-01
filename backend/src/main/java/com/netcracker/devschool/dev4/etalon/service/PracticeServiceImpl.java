package com.netcracker.devschool.dev4.etalon.service;

import com.netcracker.devschool.dev4.etalon.entity.Practice;
import com.netcracker.devschool.dev4.etalon.entity.Requests;
import com.netcracker.devschool.dev4.etalon.entity.Student;
import com.netcracker.devschool.dev4.etalon.repository.PracticeRepository;
import com.netcracker.devschool.dev4.etalon.repository.RequestRepository;
import com.netcracker.devschool.dev4.etalon.repository.StudentRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class PracticeServiceImpl implements PracticeService {

    @Resource
    private PracticeRepository practiceRepository;

    @Resource
    private RequestRepository requestRepository;
    @Resource
    private StudentRepository studentRepository;


    @Override
    @Transactional
    public Practice create(Practice practice) {
        return practiceRepository.save(practice);
    }

    @Override
    @Transactional
    public Practice findById(int id) {
        return practiceRepository.findOne(id);
    }

    @Override
    public void deletePracticeById(int id){
        practiceRepository.delete(id);
    }

    @Override
    @Transactional
    public Practice delete(int id) throws Exception {
        Practice deletedPractice = practiceRepository.findOne(id);

        if (deletedPractice != null) throw new Exception("Not found");

        practiceRepository.delete(id);
        return null;
    }

    @Override
    @Transactional
    public Practice update(Practice practice) {
        Practice updated = practiceRepository.findOne(practice.getIdrequest());
        updated.setName_of_practice(practice.getName_of_practice());
        updated.setIdhead_of_practice(practice.getIdhead_of_practice());
        updated.setIdFaculty(practice.getIdFaculty());
        updated.setIdSpeciality(practice.getIdSpeciality());
        updated.setMinAvg(practice.getMinAvg());
        // updated.setStart(practice.getStart());
        //updated.setEnd(practice.getEnd());
        return updated;
    }

    @Override
    @Transactional
    public List<Practice> findAll() {
        return practiceRepository.findAll();
    }

    @Override
    @Transactional
    public List<Practice> findByHopId(int id) {
       return practiceRepository.findByHopId(id);
    }

    @Override
    @Transactional
    public List<Practice> findByStudentId(int id) {
        return practiceRepository.findByStudentId(id);
    }

    @Override
    @Transactional
    public Student removeFromPractice(int id, int studentId) {
        requestRepository.remove(id, studentId);
        return studentRepository.findOne(studentId);
    }


    @Override
    @Transactional
    public Requests assign(int id, int studentId) {
        Requests assignment = new Requests();
        assignment.setIdRequest(id);
        assignment.setIdStudent(studentId);
        return requestRepository.save(assignment);
    }
}
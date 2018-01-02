package com.netcracker.devschool.dev4.etalon.service;

import com.netcracker.devschool.dev4.etalon.entity.Head_of_practice;
import com.netcracker.devschool.dev4.etalon.entity.Practice;
import com.netcracker.devschool.dev4.etalon.repository.Head_of_practiceRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class Head_of_practiceServiceImpl implements Head_of_practiceService {
    @Resource
    private Head_of_practiceRepository headOfPracticeRepository;

    @Resource
    private PracticeService practiceService;


    @Override
    public Head_of_practice create(Head_of_practice headOfPractice) {
        return headOfPracticeRepository.save(headOfPractice);
    }

    @Override
    public void deleteHead_of_practiceById(int id){
        List<Practice> practices = practiceService.findByHopId(id);
        if(practices.isEmpty()){
            headOfPracticeRepository.delete(id);
        }else {
            for (Practice item: practices
                    ){
                practiceService.deletePracticeById(item.getIdrequest());
            }
            headOfPracticeRepository.delete(id);
        }
    }

    @Override
    public Head_of_practice delete(int idhead_of_practice) throws Exception {
        Head_of_practice deleted = headOfPracticeRepository.findOne(idhead_of_practice);
        if (deleted == null) throw new Exception("Not found");
        headOfPracticeRepository.delete(idhead_of_practice);
        return deleted;
    }

    @Override
    public List<Head_of_practice> findAll() {
        return headOfPracticeRepository.findAll();
    }

    @Override
    public Head_of_practice update(Head_of_practice headOfPractice){
        Head_of_practice updated = headOfPracticeRepository.findOne(headOfPractice.getIdhead_of_practice());
        updated.setFirst_name(headOfPractice.getFirst_name());
        updated.setLast_name(headOfPractice.getLast_name());
        updated.setCompany(headOfPractice.getCompany());
        updated.setDepartment(headOfPractice.getDepartment());
        updated.setImageurl(headOfPractice.getImageurl());
        return updated;  //TODO
    }

    @Override
    public Head_of_practice findById(int idhead_of_practice) {
        return headOfPracticeRepository.findOne(idhead_of_practice);
    }
}

package com.netcracker.etalon.controllers;

import com.netcracker.devschool.dev4.etalon.entity.Practice;
import com.netcracker.devschool.dev4.etalon.service.PracticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

@Controller
@RequestMapping(value = "/practice")
public class PracticeController {
    @Autowired
    private PracticeService practiceService;

    @RequestMapping(value = "/addRequest", method = RequestMethod.POST)
    @ResponseBody
    @PreAuthorize("hasAnyAuthority('ROLE_HOP', 'ROLE_ADMIN')")
    private Practice addPractice(@RequestParam(value = "name_of_practice") String name_of_practice,
                                 @RequestParam(value = "idhead_of_practice") int idhead_of_practice,
                                 @RequestParam(value = "company") String company,
                                 @RequestParam(value = "department") String department,
                                 @RequestParam(value = "faculty") String faculty,
                                 @RequestParam(value = "speciality") String speciality,
                                 @RequestParam(value = "start") Date start,
                                 @RequestParam(value = "finish") Date finish,
                                 @RequestParam(value = "minAvg") String minAvg) {
        //todo validation
        Practice practice = new Practice();
        practice.setName_of_practice(name_of_practice);
        practice.setCompany(company);
        practice.setDepartment(department);
        practice.setIdFaculty(Integer.parseInt(faculty));
        practice.setIdSpeciality(Integer.parseInt(speciality));
        practice.setMinAvg(Double.parseDouble(minAvg));
        practice.setStart(start);
        practice.setFinish(finish);
        practice.setIdhead_of_practice(idhead_of_practice);
        return practiceService.create(practice);
    }


}

package com.netcracker.etalon.controllers;

import com.netcracker.devschool.dev4.etalon.entity.Head_of_practice;
import com.netcracker.devschool.dev4.etalon.service.Head_of_practiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;

@Controller
@RequestMapping(value = "/hops")
public class Head_of_practiceController {
    @Autowired
    private Head_of_practiceService head_of_practiceService;

    @RequestMapping(value = "/edit/{idhead_of_practice}", method = RequestMethod.POST)
    @ResponseBody
    public Head_of_practice editHead_of_practice(@PathVariable String idhead_of_practice,
                                                 @RequestParam(value = "first_name", required = false) String first_name,
                                                 @RequestParam(value = "last_name", required = false) String last_name,
                                                 @RequestParam(value = "company", required = false) String company,
                                                 @RequestParam(value = "department", required = false) String department
                                                 ) {
        String msg = "";
        Head_of_practice head_of_practice = head_of_practiceService.findById(Integer.parseInt(idhead_of_practice));
        try {
            if (!Objects.equals(first_name, "") && first_name != null) head_of_practice.setFirst_name(first_name);
            if (!Objects.equals(last_name, "") && last_name != null) head_of_practice.setLast_name(last_name);
            if (!Objects.equals(company, "") && company != null) head_of_practice.setCompany(company);
            if (!Objects.equals(department, "") && department != null) head_of_practice.setDepartment(department);
            head_of_practiceService.update(head_of_practice);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return head_of_practice;
    }
    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Head_of_practice getHead_of_practice(@PathVariable int id) {
        return head_of_practiceService.findById(id);
    }
}

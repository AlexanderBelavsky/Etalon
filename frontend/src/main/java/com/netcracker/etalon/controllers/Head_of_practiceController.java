package com.netcracker.etalon.controllers;

import com.netcracker.devschool.dev4.etalon.entity.Head_of_practice;
import com.netcracker.etalon.form.HopEdit;
import com.netcracker.devschool.dev4.etalon.service.Head_of_practiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
@RequestMapping(value = "/hops")
public class Head_of_practiceController {
    @Autowired
    private Head_of_practiceService head_of_practiceService;

    @RequestMapping(value = "/edit/{idhead_of_practice}", method = RequestMethod.POST)
    @ResponseBody
    public Object editHead_of_practice(@PathVariable String idhead_of_practice,
                                       @Valid @ModelAttribute("HopEdit") HopEdit headOfPracticeForm, BindingResult result) {

        if (result.hasErrors()) {
            return result.getAllErrors();
        } else {
            Head_of_practice updated = head_of_practiceService.findById(Integer.parseInt(idhead_of_practice));
            updated.setFirst_name(headOfPracticeForm.getFirst_name());
            updated.setLast_name(headOfPracticeForm.getLast_name());
            updated.setCompany(headOfPracticeForm.getCompany());
            updated.setDepartment(headOfPracticeForm.getDepartment());
            head_of_practiceService.update(updated);
            return headOfPracticeForm;
        }
    }
    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Head_of_practice getHead_of_practice(@PathVariable int id) {
        return head_of_practiceService.findById(id);
    }
}

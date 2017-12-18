package com.netcracker.etalon.controllers;


import com.netcracker.devschool.dev4.etalon.entity.*;
import com.netcracker.devschool.dev4.etalon.service.*;
import com.netcracker.etalon.beans.SpecialityViewModel;
import com.netcracker.etalon.converters.SpecialityConverter;
import com.netcracker.etalon.converters.TableData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {

    @Autowired
    FacultyService facultyService;

    @Autowired
    SpecialityService specialityService;

    @Autowired
    UserService userService;

    @Autowired
    Head_of_practiceService head_of_practiceService;

    @Autowired
    PracticeService practiceService;

    @Autowired
    StudentService studentService;

    @Autowired
    SpecialityConverter specialityConverter;

    @RequestMapping(value = "/addFaculty", method = RequestMethod.POST)
    @ResponseBody
    @PreAuthorize("hasAnyAuthority('ROLE_HOP', 'ROLE_ADMIN')")
    private Faculty addFaculty(@RequestParam(value = "faculty_name") String faculty_name
    ) {
        //todo validation
        Faculty faculty = new Faculty();
        faculty.setFaculty_name(faculty_name);
        return facultyService.create(faculty);
    }

    @RequestMapping(value = "/addSpeciality", method = RequestMethod.POST)
    @ResponseBody
    @PreAuthorize("hasAnyAuthority('ROLE_HOP', 'ROLE_ADMIN')")
    private Speciality addSpeciality(@RequestParam(value = "speciality_name") String speciality_name,
                                     @RequestParam(value = "idFaculty") int idFaculty
    ) {
        //todo validation
        Speciality speciality = new Speciality();
        speciality.setSpeciality_name(speciality_name);
        speciality.setIdFaculty(idFaculty);
        return specialityService.create(speciality);
    }

    @RequestMapping(value = "/deleteFaculty/{id}")
    private String deleteFaculty(@PathVariable(value = "id") int id
    ) {
        facultyService.deleteFacultyById(id);


        return "redirect:/admin";
    }

    @RequestMapping(value = "/deleteSpeciality/{id}")
    private String deleteSpeciality(@PathVariable(value = "id") int id
    ) {
        specialityService.deleteSpecialityById(id);


        return "redirect:/admin";
    }


    @RequestMapping(value = "/addHOP", method = RequestMethod.POST)
    @ResponseBody
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN')")
    public Head_of_practice addHOP(@RequestParam(value = "username") String username,
                                   @RequestParam(value = "password") String password,
                                   @RequestParam(value = "last_name") String last_name,
                                   @RequestParam(value = "first_name") String first_name,
                                   @RequestParam(value = "company") String company,
                                   @RequestParam(value = "department") String department) {
        User user = new User();
        user.setUsername(username);
        password = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);
        user.setPassword(password);
        user.setEnabled(1);
        User_role userRoles = new User_role();
        userRoles.setUsername(username);
        userRoles.setRole("ROLE_HOP");
        int id = userService.create(user, userRoles).getUser_role_id();
        Head_of_practice hop = new Head_of_practice();
        hop.setIdhead_of_practice(id);
        hop.setFirst_name(first_name);
        hop.setLast_name(last_name);
        hop.setCompany(company);
        hop.setDepartment(department);
        return head_of_practiceService.create(hop);
    }

    @RequestMapping(value = "/addStudent", method = RequestMethod.POST)
    @ResponseBody
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN')")
    public Student addStudent(@RequestParam(value = "username") String username,
                              @RequestParam(value = "password") String password
    ) {
        User user = new User();
        user.setUsername(username);
        password = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);
        user.setPassword(password);
        user.setEnabled(1);
        User_role userRoles = new User_role();
        userRoles.setUsername(username);
        userRoles.setRole("ROLE_STUDENT");
        int id = userService.create(user, userRoles).getUser_role_id();
        Student student = new Student();
        student.setIdStudent(id);
        student.setFirst_name("");
        student.setLast_name("");
        student.setIdFaculty(1);
        student.setIdSpeciality(1);
        student.setAv_score(10);
        student.setGroup_number(100000);
        student.setForm_of_Education("");
        return studentService.create(student);
    }

    @RequestMapping(value = "/deleteHOP/{id}")
    private String deleteHOP(@PathVariable(value = "id") int id
    ) {
        head_of_practiceService.deleteHead_of_practiceById(id);
        userService.deleteUserById(id);
        return "redirect:/admin";


    }

    @RequestMapping(value = "/delstud/{id}", method = RequestMethod.GET)
    @ResponseBody
    public String DeleteStudent(@PathVariable(value = "id") String id
    ) {

        userService.deleteUserById(Integer.parseInt(id));
        studentService.deleteStudentById(Integer.parseInt(id));
        return "12";


    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String listAllTables(Model model) {

        model.addAttribute("listSpecialities", new ArrayList<SpecialityViewModel>(specialityConverter.convert(specialityService.findAll())));

        return "/admin";
    }

    @RequestMapping(value = "/removeAllStudent", method = RequestMethod.GET)
    @ResponseBody
    public String removeAllStudent(@RequestParam(value = "students[]" , required = false) String[] students) {
        for (String item : students) {
            int sid = Integer.parseInt(item.substring(2));
            if (studentService.findById(sid) != null)
                userService.deleteUserById(sid);
            studentService.deleteStudentById(sid);
        }
        return "12";
    }
}

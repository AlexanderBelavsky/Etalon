package com.netcracker.etalon.controllers;

import com.netcracker.devschool.dev4.etalon.entity.*;
import com.netcracker.devschool.dev4.etalon.form.HeadOfPracticeForm;
import com.netcracker.devschool.dev4.etalon.service.*;
import com.netcracker.etalon.beans.RequestsViewModel;
import com.netcracker.etalon.converters.RequestConverter;
import com.netcracker.etalon.converters.StudentsConverter;
import com.netcracker.etalon.converters.TableData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "/practice")
public class PracticeController {
    @Autowired
    private PracticeService practiceService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private FacultyService facultyService;

    @Autowired
    private SpecialityService specialityService;

    @Autowired
    private UserService userService;

    @Autowired
    private Head_of_practiceService headOfPracticeService;

    @Autowired
    private RequestConverter requestConverter;

    @RequestMapping(value = "/tableForPractice/{id}", method = RequestMethod.GET)
    @ResponseBody
    public TableData returnTable(@PathVariable String id,
                                 @RequestParam(value = "start") String start,
                                 @RequestParam(value = "length") String length,
                                 @RequestParam(value = "draw") String draw,
                                 @RequestParam(value = "search[value]", required = false) String key,
                                 @RequestParam(value = "order[0][column]") String order,
                                 @RequestParam(value = "order[0][dir]") String orderDir) {
        if (key == null) key = "";
        TableData result = new TableData();
        Page<Student> page = studentService.findByParams(Integer.parseInt(id), key, result.getColumnNameForTables(Integer.parseInt(order) - 1), orderDir, Integer.parseInt(start), Integer.parseInt(length));
        List<Student> list = page.getContent();
        result.setRecordsTotal((int) page.getTotalElements() - page.getNumberOfElements());
        result.setRecordsFiltered((int) page.getTotalElements() - page.getNumberOfElements());
        result.setDraw(Integer.parseInt(draw));
        StudentsConverter converter = new StudentsConverter();
        for (Student item : list
                ) {
            result.addData(converter.studentToStringArrayAdvanced(item, facultyService.findById(item.getIdFaculty()).getFaculty_name(),
                    specialityService.findById(item.getIdSpeciality()).getSpeciality_name(), true, true, false));
        }
        return result;
    }


    @RequestMapping(value = "/tableForRequest/{facultyId}/{specialityId}", method = RequestMethod.GET)
    @ResponseBody
    public TableData tableForRequest(@PathVariable(value = "facultyId") String facultyId,
                                     @PathVariable(value = "specialityId") String specialityId,
                                     @RequestParam(value = "minavg") String minAvg,
                                     @RequestParam(value = "startd") Date startd,
                                     @RequestParam(value = "finish") Date finish,
                                     @RequestParam(value = "budget") String budget,
                                     @RequestParam(value = "start") String start,
                                     @RequestParam(value = "length") String length,
                                     @RequestParam(value = "draw") String draw,
                                     @RequestParam(value = "order[0][column]") String order,
                                     @RequestParam(value = "order[0][dir]") String orderDir
    ) {
        TableData result = new TableData();
        // List<Student> list = studentService.findAll();
        double avg = Double.parseDouble(minAvg);

        Page<Student> page = studentService.findForRequest(Integer.parseInt(facultyId), Integer.parseInt(specialityId), startd, finish, budget, avg, result.getColumnNameForTables(Integer.parseInt(order) - 1), orderDir, Integer.parseInt(start), Integer.parseInt(length));
        List<Student> list = page.getContent();
        result.setRecordsTotal((int) page.getTotalElements() - page.getNumberOfElements());
        result.setRecordsFiltered((int) page.getTotalElements() - page.getNumberOfElements());
        result.setDraw(Integer.parseInt(draw));
        StudentsConverter converter = new StudentsConverter();
        for (Student item : list
                ) {
            result.addData(converter.studentToStringArrayAdvanced(item, facultyService.findById(item.getIdFaculty()).getFaculty_name(),
                    specialityService.findById(item.getIdSpeciality()).getSpeciality_name(), true, false, false));
        }
        return result;
    }

    @RequestMapping(value = "/addRequestAdmin", method = RequestMethod.POST)
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
                                 @RequestParam(value = "minAvg") String minAvg,
                                 @RequestParam(value = "checked[]", required = false) String[] checked) {
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
        if (start.compareTo(finish) < 0) {
            practice.setIdhead_of_practice(idhead_of_practice);
        } else {
            finish = start;
            practice.setFinish(finish);
            practice.setIdhead_of_practice(idhead_of_practice);
        }
        Practice result = practiceService.create(practice);
        for (String item : checked) {
            int sid = Integer.parseInt(item.substring(2));
            practiceService.assign(result.getIdrequest(), sid);
        }

        return result;
    }

    @RequestMapping(value = "/addRequestHOP/{id}", method = RequestMethod.POST)
    @ResponseBody
    private Practice addRequestHOP(@PathVariable(value = "id") String id,
                                   @RequestParam(value = "name_of_practice") String name_of_practice,
                                   @RequestParam(value = "company") String company,
                                   @RequestParam(value = "department") String department,
                                   @RequestParam(value = "faculty") String faculty,
                                   @RequestParam(value = "speciality") String speciality,
                                   @RequestParam(value = "start") Date start,
                                   @RequestParam(value = "finish") Date finish,
                                   @RequestParam(value = "minAvg") String minAvg,
                                   @RequestParam(value = "checked[]", required = false) String[] checked) {
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
        if (start.compareTo(finish) < 0) {
            practice.setIdhead_of_practice(Integer.parseInt(id));
        } else {
            finish = start;
            practice.setFinish(finish);
            practice.setIdhead_of_practice(Integer.parseInt(id));
        }
        Practice result = practiceService.create(practice);
        for (String item : checked) {
            int sid = Integer.parseInt(item.substring(2));
            practiceService.assign(result.getIdrequest(), sid);
        }
        return result;
    }

    @RequestMapping(value = "/remove/{id}/{studid}", method = RequestMethod.GET)
    @ResponseBody
    public Student removeFromPractice(@PathVariable(value = "id") String id,
                                      @PathVariable(value = "studid") String studid) {
        if (studentService.findById(Integer.parseInt(studid)) != null)
            return practiceService.removeFromPractice(Integer.parseInt(id), Integer.parseInt(studid));
        return null;
    }

    @RequestMapping(value = "/removeAll/{id}", method = RequestMethod.POST)
    @ResponseBody
    public List<Student> removeAll(@PathVariable(value = "id") String id,
                                   @RequestParam(value = "students[]") String[] students) {
        List<Student> result = new ArrayList<>();
        for (String item : students) {
            int sid = Integer.parseInt(item.substring(2));
            if (studentService.findById(sid) != null)
                result.add(practiceService.removeFromPractice(Integer.parseInt(id), sid));
        }
        return result;
    }





    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ResponseBody
    public List<Practice> getAll() {
        return practiceService.findAll();
    }

    @RequestMapping(value = "/getPracticeByHop/{id}", method = RequestMethod.GET)
    @ResponseBody
    public List<Practice> getPracticeByHop(@PathVariable(value = "id") int id) {
        List<Practice> list = practiceService.findByHopId(id);
        return list;
    }

    @RequestMapping(value = "/addHOP", method = RequestMethod.POST)
    @ResponseBody
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Object createHOP(@Valid @ModelAttribute("headOfPracticeForm") HeadOfPracticeForm headOfPracticeForm, BindingResult result) {
        if (result.hasErrors()) {
            return result.getAllErrors();
        } else {
            User user = new User();
            user.setUsername(headOfPracticeForm.getUsername());
            String password = headOfPracticeForm.getPassword();
            password = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);
            user.setPassword(password);
            user.setEnabled(1);
            User_role userRoles = new User_role();
            userRoles.setUsername(headOfPracticeForm.getUsername());
            userRoles.setRole("ROLE_HOP");
            int id = userService.create(user, userRoles).getUser_role_id();
            Head_of_practice head_of_practice = new Head_of_practice();
            head_of_practice.setIdhead_of_practice(id);
            head_of_practice.setCompany(headOfPracticeForm.getCompany());
            head_of_practice.setFirst_name(headOfPracticeForm.getFirst_name());
            head_of_practice.setLast_name(headOfPracticeForm.getLast_name());
            head_of_practice.setImageurl("hop_default_avatar.png");
            head_of_practice.setDepartment(headOfPracticeForm.getDepartment());
            return headOfPracticeService.create(head_of_practice);
        }
    }

    @RequestMapping(value = "/delpract/{id}", method = RequestMethod.GET)
    @ResponseBody
    @PreAuthorize("hasAnyAuthority('ROLE_HOP', 'ROLE_ADMIN')")
    public String DeleteStudent(@PathVariable(value = "id") String id
    ) {

        practiceService.deletePracticeById(Integer.parseInt(id));
        return "12";


    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ResponseBody
    public RequestsViewModel getById(@PathVariable String id) {
        return requestConverter.convertone(practiceService.findById(Integer.parseInt(id)));
    }
}

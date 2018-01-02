package com.netcracker.etalon.controllers;

import com.netcracker.devschool.dev4.etalon.entity.Student;
import com.netcracker.etalon.form.StudentEdit;
import com.netcracker.devschool.dev4.etalon.service.FacultyService;
import com.netcracker.devschool.dev4.etalon.service.SpecialityService;
import com.netcracker.devschool.dev4.etalon.service.StudentService;
import com.netcracker.etalon.converters.StudentsConverter;
import com.netcracker.etalon.converters.TableData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequestMapping(value = "/students")
public class StudentController {
    @Autowired
    private StudentService studentService;

    @Autowired
    private SpecialityService specialityService;

    @Autowired
    private FacultyService facultyService;

    //Save the uploaded file to this folder


    @RequestMapping(value = "/edit/{idStudent}", method = RequestMethod.POST)
    @ResponseBody
    public Object editStudent(@PathVariable String idStudent,
                              @Valid @ModelAttribute("studentEdit") StudentEdit student, BindingResult result
    ) {
        if (result.hasErrors()) {
            return result.getAllErrors();
        } else {
            Student updated = studentService.findById(Integer.parseInt(idStudent));
            updated.setFirst_name(student.getFirst_name());
            updated.setLast_name(student.getLast_name());
            updated.setIdFaculty(student.getFaculty());
            updated.setIdSpeciality(student.getSpeciality());
            updated.setGroup_number(student.getGroup_number());
            updated.setAv_score(student.getAv_score());
            if (student.getForm_of_Education() != null) updated.setForm_of_Education("Бесплатная");
            else updated.setForm_of_Education("Платная");
            studentService.update(updated);
            return student;
        }
    }

    @RequestMapping(value = "/imageUpload/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Student singleFileUpload(@PathVariable int id,
                                    @RequestParam(value = "file", required = false) MultipartFile file) {
        if ((file != null) && (!file.isEmpty())) {
            try {

                // Get the file and save it somewhere

                byte[] bytes = file.getBytes();
                String UPLOADED_FOLDER = "C:/Users/Shaleshka/Desktop/NCJavaProject/images/";
                Path path = Paths.get(UPLOADED_FOLDER + file.getOriginalFilename());
                Files.write(path, bytes);

                Student student = studentService.findById(id);
                student.setImageurl(file.getOriginalFilename());
                studentService.update(student);
                return student;

            } catch (IOException e) {
                return null;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        } else return null;
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Student getStudent(@PathVariable int id) {
        return studentService.findById(id);
    }

    @RequestMapping(value = "/tableAllStudents", method = RequestMethod.GET)
    @ResponseBody
    private TableData returnTable(
            @RequestParam(value = "start") String start,
            @RequestParam(value = "length") String length,
            @RequestParam(value = "draw") String draw,
            @RequestParam(value = "search[value]", required = false) String key,
            @RequestParam(value = "order[0][column]") String order,
            @RequestParam(value = "order[0][dir]") String orderDir) {
        if (key==null) key="";
        TableData result = new TableData();
        Page<Student> page = studentService.findByParams(-1, key, result.getColumnNameForTables(Integer.parseInt(order)), orderDir, Integer.parseInt(start), Integer.parseInt(length));
        List<Student> list = page.getContent();
        result.setRecordsTotal((int) page.getTotalElements() - page.getNumberOfElements());
        result.setRecordsFiltered((int) page.getTotalElements() - page.getNumberOfElements());
        result.setDraw(Integer.parseInt(draw));
        StudentsConverter converter = new StudentsConverter();
        for (Student item: list
                ) {

            result.addData(converter.studentToStringArrayAdvanced(item, facultyService.findById(item.getIdFaculty()).getFaculty_name(),
                    specialityService.findById(item.getIdSpeciality()).getSpeciality_name(), true, true, true));
        }
        return result;
    }
}

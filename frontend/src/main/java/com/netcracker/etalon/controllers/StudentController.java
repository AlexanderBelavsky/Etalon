package com.netcracker.etalon.controllers;

import com.netcracker.devschool.dev4.etalon.entity.Student;
import com.netcracker.devschool.dev4.etalon.form.StudentEdit;
import com.netcracker.devschool.dev4.etalon.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Objects;

@Controller
@RequestMapping(value = "/students")
public class StudentController {
    @Autowired
    private StudentService studentService;

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
}

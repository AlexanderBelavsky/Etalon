package com.netcracker.etalon.controllers;

import com.netcracker.devschool.dev4.etalon.entity.Student;
import com.netcracker.devschool.dev4.etalon.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
    public Student editStudent(@PathVariable String idStudent,
                               @RequestParam(value = "first_name", required = false) String first_name,
                               @RequestParam(value = "last_name", required = false) String last_name,
                               @RequestParam(value = "faculty", required = false) String faculty,
                               @RequestParam(value = "speciality", required = false) String speciality,
                               @RequestParam(value = "group_number", required = false) String group_number,
                               @RequestParam(value = "form_of_Education", required = false) String form_of_Education,
                               @RequestParam(value = "av_score", required = false) String av_score
    ) {
        String msg = "";
        Student student = studentService.findById(Integer.parseInt(idStudent));
        try {
            if (!Objects.equals(first_name, "") && first_name != null) student.setFirst_name(first_name);
            if (!Objects.equals(last_name, "") && last_name != null) student.setLast_name(last_name);
            if (!Objects.equals(faculty, "") && faculty != null) student.setIdFaculty(Integer.parseInt(faculty));
            if (!Objects.equals(speciality, "") && speciality != null)
                student.setIdSpeciality(Integer.parseInt(speciality));
            if (!Objects.equals(group_number, "") && group_number != null) student.setGroup_number(Integer.parseInt(group_number));
            if (!Objects.equals(form_of_Education, "") && form_of_Education != null) student.setForm_of_Education(form_of_Education);
            if (!Objects.equals(av_score, "") && av_score != null) student.setAv_score(Double.parseDouble(av_score));
            studentService.update(student);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return student;
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

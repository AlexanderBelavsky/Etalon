package com.netcracker.etalon.controllers;


import com.netcracker.devschool.dev4.etalon.entity.Faculty;
import com.netcracker.devschool.dev4.etalon.entity.Speciality;
import com.netcracker.devschool.dev4.etalon.service.FacultyService;
import com.netcracker.devschool.dev4.etalon.service.SpecialityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {

    @Autowired
    FacultyService facultyService;

    @Autowired
    SpecialityService specialityService;

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


}

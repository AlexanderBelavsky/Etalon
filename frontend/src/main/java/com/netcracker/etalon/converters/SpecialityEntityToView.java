package com.netcracker.etalon.converters;

import com.netcracker.devschool.dev4.etalon.entity.Speciality;
import com.netcracker.devschool.dev4.etalon.service.FacultyService;
import com.netcracker.etalon.beans.SpecialityViewModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;


@Component
public class SpecialityEntityToView implements SpecialityConverter {

    @Autowired
    FacultyService facultyService;

    @Override
    public List<SpecialityViewModel> convert(List<Speciality> specialityEntity){

        List<SpecialityViewModel> specialityViewModels = new ArrayList<>();


        for (Speciality speciality : specialityEntity) {
            SpecialityViewModel specialityViewModel = new SpecialityViewModel();
            specialityViewModel.setNameFaculty(facultyService.findById(speciality.getIdFaculty()).getFaculty_name());
            specialityViewModel.setSpeciality_name(speciality.getSpeciality_name());
            specialityViewModel.setIdSpec(Integer.toString(speciality.getIdSpeciality()));
            specialityViewModels.add(specialityViewModel);
        }
        return specialityViewModels;
    }



}

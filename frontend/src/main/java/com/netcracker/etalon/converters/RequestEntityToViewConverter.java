package com.netcracker.etalon.converters;

import com.netcracker.devschool.dev4.etalon.entity.Practice;
import com.netcracker.devschool.dev4.etalon.service.FacultyService;
import com.netcracker.devschool.dev4.etalon.service.Head_of_practiceService;
import com.netcracker.devschool.dev4.etalon.service.SpecialityService;
import com.netcracker.etalon.beans.RequestsViewModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@Component
public class RequestEntityToViewConverter implements RequestConverter {

    @Autowired
    FacultyService facultyService;

    @Autowired
    SpecialityService specialityService;

    @Autowired
    Head_of_practiceService head_of_practiceService;

    private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());

    @Override
    public List<RequestsViewModel> convert(List<Practice> practiceEntities) {

        List<RequestsViewModel> requestsViewModels = new ArrayList<>();


        for (Practice practiceEntity : practiceEntities) {
            RequestsViewModel requestsViewModel = new RequestsViewModel();
            requestsViewModel.setCompany(practiceEntity.getCompany());
            requestsViewModel.setDepartment(practiceEntity.getDepartment());
            requestsViewModel.setStart(simpleDateFormat.format(practiceEntity.getStart()));
            requestsViewModel.setFinish(simpleDateFormat.format(practiceEntity.getFinish()));
            requestsViewModel.setIdRequest(Integer.toString(practiceEntity.getIdrequest()));
            requestsViewModel.setMinAvg(Double.toString(practiceEntity.getMinAvg()));
            requestsViewModel.setName_of_practice(practiceEntity.getName_of_practice());
            requestsViewModel.setNameSpec(specialityService.findById(practiceEntity.getIdSpeciality()).getSpeciality_name());
            requestsViewModel.setNameFaculty(facultyService.findById(practiceEntity.getIdFaculty()).getFaculty_name());
            requestsViewModel.setHop_First_name(head_of_practiceService.findById(practiceEntity.getIdhead_of_practice()).getFirst_name());
            requestsViewModel.setHop_Last_name(head_of_practiceService.findById(practiceEntity.getIdhead_of_practice()).getLast_name());
            requestsViewModels.add(requestsViewModel);
        }

        return requestsViewModels;
    }

    @Override
    public RequestsViewModel convertone(Practice practiceEntity) {

        RequestsViewModel requestsViewModel = new RequestsViewModel();



            requestsViewModel.setCompany(practiceEntity.getCompany());
            requestsViewModel.setDepartment(practiceEntity.getDepartment());
            requestsViewModel.setStart(simpleDateFormat.format(practiceEntity.getStart()));
            requestsViewModel.setFinish(simpleDateFormat.format(practiceEntity.getFinish()));
            requestsViewModel.setIdRequest(Integer.toString(practiceEntity.getIdrequest()));
            requestsViewModel.setMinAvg(Double.toString(practiceEntity.getMinAvg()));
            requestsViewModel.setName_of_practice(practiceEntity.getName_of_practice());
            requestsViewModel.setNameSpec(specialityService.findById(practiceEntity.getIdSpeciality()).getSpeciality_name());
            requestsViewModel.setNameFaculty(facultyService.findById(practiceEntity.getIdFaculty()).getFaculty_name());
            requestsViewModel.setHop_First_name(head_of_practiceService.findById(practiceEntity.getIdhead_of_practice()).getFirst_name());
            requestsViewModel.setHop_Last_name(head_of_practiceService.findById(practiceEntity.getIdhead_of_practice()).getLast_name());


        return requestsViewModel;
    }

}

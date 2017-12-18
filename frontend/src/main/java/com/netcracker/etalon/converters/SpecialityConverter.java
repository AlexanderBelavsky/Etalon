package com.netcracker.etalon.converters;

import com.netcracker.devschool.dev4.etalon.entity.Speciality;
import com.netcracker.etalon.beans.SpecialityViewModel;

import java.util.List;

public interface SpecialityConverter {
    List<SpecialityViewModel> convert(List<Speciality> specialityEntity);
}

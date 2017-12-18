package com.netcracker.etalon.converters;

import com.netcracker.devschool.dev4.etalon.entity.Practice;
import com.netcracker.etalon.beans.RequestsViewModel;

import java.util.List;

public interface RequestConverter {

    List<RequestsViewModel> convert(List<Practice> practiceEntities);
    RequestsViewModel convertone(Practice practiceEntities);
}

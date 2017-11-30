package com.netcracker.devschool.dev4.etalon.service;


import com.netcracker.devschool.dev4.etalon.entity.Faculty;

import java.util.List;

public interface FacultyService {
    public Faculty create(Faculty faculty);

    public Faculty delete(int idFaculty) throws Exception;

    public void deleteFacultyById(int id);

    public List<Faculty> findAll();

    public Faculty update(Faculty faculty) throws Exception;

    public Faculty findById(int idFaculty);
}

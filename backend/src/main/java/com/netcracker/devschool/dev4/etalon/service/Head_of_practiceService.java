package com.netcracker.devschool.dev4.etalon.service;

import com.netcracker.devschool.dev4.etalon.entity.Head_of_practice;

import java.util.List;

public interface Head_of_practiceService {
    public Head_of_practice create(Head_of_practice headOfPractice);

    public Head_of_practice delete(int idhead_of_practice) throws Exception;

    public void deleteHead_of_practiceById(int id);

    public List<Head_of_practice> findAll();

    public Head_of_practice update(Head_of_practice headOfPractice);

    public Head_of_practice findById(int idhead_of_practice);

}

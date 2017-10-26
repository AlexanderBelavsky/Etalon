package com.netcracker.devschool.dev4.etalon.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "practice")
public class Practice {
    @Id
    private int idpractice;
    private int idrequest;
    private String name_of_practice;
    private long idhead_of_practice;
    private String company;
    private String department;
    private String data;

    public int getIdpractice() {
        return idpractice;
    }

    public void setIdpractice(int idpractice) {
        this.idpractice = idpractice;
    }

    public int getIdrequest() {
        return idrequest;
    }

    public void setIdrequest(int idrequest) {
        this.idrequest = idrequest;
    }

    public String getName_of_practice() {
        return name_of_practice;
    }

    public void setName_of_practice(String name_of_practice) {
        this.name_of_practice = name_of_practice;
    }

    public long getIdhead_of_practice() {
        return idhead_of_practice;
    }

    public void setIdhead_of_practice(long idhead_of_practice) {
        this.idhead_of_practice = idhead_of_practice;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}


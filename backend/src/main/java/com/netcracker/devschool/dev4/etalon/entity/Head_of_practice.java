package com.netcracker.devschool.dev4.etalon.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "head_of_practic")
public class Head_of_practice {
    @Id
    private int idhead_of_practice;
    private String first_name;
    private String last_name;
    private String company;
    private String department;
    private String imageurl;

    public int getIdhead_of_practice() {
        return idhead_of_practice;
    }

    public void setIdhead_of_practice(int idhead_of_practice) {
        this.idhead_of_practice = idhead_of_practice;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
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

    public String getImageurl() {
        return imageurl;
    }

    public void setImageurl(String imageurl) {
        this.imageurl = imageurl;
    }
}


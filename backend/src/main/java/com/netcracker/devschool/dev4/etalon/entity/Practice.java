package com.netcracker.devschool.dev4.etalon.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "practice")
public class Practice {
    @Id
    @GeneratedValue
    private int idrequest;
    private String name_of_practice;
    private int idhead_of_practice;
    private double minAvg;
    private String company;
    private String department;
    private int idFaculty;
    private int idSpeciality;
    private Date start;
    private Date finish;

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

    public int getIdhead_of_practice() {
        return idhead_of_practice;
    }

    public void setIdhead_of_practice(int idhead_of_practice) {
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

    public double getMinAvg() {
        return minAvg;
    }

    public void setMinAvg(double minAvg) {
        this.minAvg = minAvg;
    }

    public int getIdFaculty() {
        return idFaculty;
    }

    public void setIdFaculty(int idFaculty) {
        this.idFaculty = idFaculty;
    }

    public int getIdSpeciality() {
        return idSpeciality;
    }

    public void setIdSpeciality(int idSpeciality) {
        this.idSpeciality = idSpeciality;
    }

    public Date getStart() {
        return start;
    }

    public void setStart(Date start) {
        this.start = start;
    }

    public Date getFinish() {
        return finish;
    }

    public void setFinish(Date finish) {
        this.finish = finish;
    }
}


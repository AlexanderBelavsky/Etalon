package com.netcracker.devschool.dev4.etalon.form;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class StudentEdit {

    /*@NotNull(message = "Электронная почта не может отсутствовать")
    @Size(min = 2, max = 45, message = "Электронная почта должна быть не короче двух и не длиннее 45 символов")
    private String email;

    @NotNull(message = "Пароль не может отсутствовать")
    @Size(min = 6, message = "Пароль должен быть длиннее 6 символов")
    private String password;*/

    @NotNull(message = "Имя не может отсутствовать")
    @Size(min = 2, max = 45, message = "Имя должно быть не короче двух и не длиннее 45 символов")
    private String first_name;

    @NotNull(message = "Фамилия не может отсутствовать")
    @Size(min = 2, max = 45, message = "Фамилия должна быть не короче двух и не длиннее 45 символов")
    private String last_name;

    @NotNull(message = "Факультет не может отсутствовать")
    @Min(value = 1, message = "Идентификатор факультета меньше нуля")
    private Integer faculty;

    @NotNull(message = "Специальность не может отсутствовать")
    @Min(value = 1, message = "Идентификатор специальности меньше нуля")
    private Integer speciality;

    @NotNull(message = "Группа не может отсутствовать")
    @Min(value = 100000, message = "Группа должна быть шестизначным числом")
    @Max(value = 999999, message = "Группа должна быть шестизначным числом")
    private Integer group_number;

    private String form_of_Education;

    @NotNull(message = "Средний балл не может отсутствовать")
    @Min(value = 4, message = "Средний балл не может быть меньше 4")
    @Max(value = 10, message = "Средний балл не может быть больше 10")
    private Double av_score;

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

    public Integer getFaculty() {
        return faculty;
    }

    public void setFaculty(Integer faculty) {
        this.faculty = faculty;
    }

    public Integer getSpeciality() {
        return speciality;
    }

    public void setSpeciality(Integer speciality) {
        this.speciality = speciality;
    }

    public Integer getGroup_number() {
        return group_number;
    }

    public void setGroup_number(Integer group_number) {
        this.group_number = group_number;
    }

    public String getForm_of_Education() {
        return form_of_Education;
    }

    public void setForm_of_Education(String form_of_Education) {
        this.form_of_Education = form_of_Education;
    }

    public Double getAv_score() {
        return av_score;
    }

    public void setAv_score(Double av_score) {
        this.av_score = av_score;
    }

    /*public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }*/
}

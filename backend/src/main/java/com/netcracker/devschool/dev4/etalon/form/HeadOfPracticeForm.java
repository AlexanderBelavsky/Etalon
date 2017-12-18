package com.netcracker.devschool.dev4.etalon.form;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class HeadOfPracticeForm {


    @NotNull(message = "Электронная почта не может отсутствовать")
    @Size(min = 2, max = 45, message = "Электронная почта должна быть не короче двух и не длиннее 45 символов")
    private String username;

    @NotNull(message = "Пароль не может отсутствовать")
    @Size(min = 6, message = "Пароль должен быть длиннее 6 символов")
    private String password;

    @NotNull(message = "Название компании не может отсутствовать")
    @Size(min = 2, max = 45, message = "Название компании должно быть не короче двух и не длиннее 45 символов")
    private String company;



    @NotNull(message = "Название компании не может отсутствовать")
    @Size(min = 2, max = 45, message = "Название компании должно быть не короче двух и не длиннее 45 символов")
    private String department;

    @NotNull(message = "Имя не может отсутствовать")
    @Size(min = 2, max = 45, message = "Имя должно быть не короче двух и не длиннее 45 символов")
    private String first_name;

    @NotNull(message = "Фамилия не может отсутствовать")
    @Size(min = 2, max = 45, message = "Фамилия должна быть не короче двух и не длиннее 45 символов")
    private String last_name;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
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

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }
}

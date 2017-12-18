package com.netcracker.etalon.converters;

import com.netcracker.devschool.dev4.etalon.entity.Student;

public class StudentsConverter {

    public String[] studentToStringArray(Student student, String faculty_name, String speciality_name) {
        String[] result = new String[6];
        result[0] = student.getFirst_name();
        result[1] = student.getLast_name();
        result[2] = faculty_name;
        result[3] = speciality_name;
        result[4] = String.valueOf(student.getGroup_number());
        result[5] = String.valueOf(student.getAv_score());
        return result;
    }

    public String[] studentToStringArrayAdvanced(Student student, String faculty_name, String speciality_name, boolean chekbox, boolean deleteButton, boolean editButton) {
        int i = 0, offset = 0;
        if (chekbox) {
            i++;
            offset++;
        }
        if (deleteButton) i++;
        if (editButton) i++;
        String[] result = new String[6 + i];
        System.arraycopy(studentToStringArray(student, faculty_name, speciality_name), 0, result, offset, 6);
        if (chekbox) {
            result[0] = "<label>\n" +
                    "                                            <input name=\"isBudget\" class=\"" + i + "table_cb" + "\" id=\"cb" + student.getIdStudent() + "\" type=\"checkbox\">\n" +
                    "                                            \n" +
                    "                                        </label>\n";
        }
        i = offset + 6;
        if (editButton) {
            result[i] = "<button type=\"button\" class=\"btn btn-primary\" onclick=\"editStudent(" + student.getIdStudent() + ")\">\n" +
                    "                                                            Редактировать\n" +
                    "                                                        </button>";
            i++;
        }
        if (deleteButton) {
            result[i] = "<button type=\"button\" class=\"btn btn-danger\" onclick=\"delStudent(" + student.getIdStudent() + ")\">\n" +
                    "                                                            Удалить\n" +
                    "                                                        </button>";
        }
        return result;
    }

}

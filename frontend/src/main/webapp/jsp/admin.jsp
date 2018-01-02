<%--
  Created by IntelliJ IDEA.
  User: BigPc
  Date: 17.10.2017
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page session="true" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/jsp/blocks/header1.jsp"/>

    <script>


        var oTable;
        var studentsTable;
        var selected = [];
        var prtables = [];

        var prselected = [];

        function appendPractice(index, value) {
            $('#practices').append('<div id="prdiv'+value.idrequest+'" class="panel box box-primary">\n' +
                '                                        <div class="box-header with-border">\n' +
                '                                            <h4 class="box-title">\n' +
                '                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse_' + value.idrequest + '">\n' +
                '                                                    ' + value.name_of_practice + '\n' +
                '                                                </a>\n' +
                '                                            </h4>\n' +
                '                                        </div>\n' +
                '                                        <div id="collapse_' + value.idrequest + '" class="panel-collapse collapse">\n' +
                '                                            <div class="box">\n' +
                '                                                <div class="box-header">\n' +
                '                                                    <h3 class="box-title">Студенты</h3>\n' +
                '                                                </div>\n' +
                '                                                <!-- /.box-header -->\n' +
                '                                                <div class="box-body"><div class="panel">\n' +
                '<button type="button" id="delBut_' + value.idrequest + '" class="btn btn-danger disabled" onclick="delChecked(' + value.idrequest + ')">\n' +
                '                                                            Удалить выделеных\n' +
                '                                                        </button>' +
                '<button type="button" class="btn btn-primary pull-right" onclick="delPract(' + value.idrequest + ')">\n' +
                '                                                            Удалить практику\n' +
                '                                                        </button>' +
                '<button type="button" class="btn btn-primary pull-right" onclick="information(' + value.idrequest + ')">\n' +
                '                                                            Информация\n' +
                '                                                        </button></div>' +
                '                                                    <table id="practice_' + value.idrequest + '" class="table table-bordered table-striped">\n' +
                '                                                        <thead>\n' +
                '                                                        <tr>\n' +
                '                                                            <th> <input type="checkbox" class="selectall"> </th>\n' +
                '                                                            <th>Имя</th>\n' +
                '                                                            <th>Фамилия</th>\n' +
                '                                                            <th>Факультет</th>\n' +
                '                                                            <th>Специальность</th>\n' +
                '                                                            <th>Группа</th>\n' +
                '                                                            <th>Средний балл</th>\n' +
                '                                                            <th>Удалить</th>\n' +
                '                                                        </tr>\n' +
                '                                                        </thead>\n' +
                '                                                        <tbody>\n' +
                '                                                        </tbody>\n' +
                '                                                    </table>\n' +
                '                                                </div>\n' +
                '                                                <!-- /.box-body -->\n' +
                '                                            </div>\n' +
                '                                            <!-- /.box -->\n' +
                '\n' +
                '                                        </div>\n' +
                '                                    </div>');
            prselected[value.idrequest] = [];
            prtables[value.idrequest] = $('#practice_' + value.idrequest).DataTable({
                "processing": true,
                "serverSide": true,
                'autoWidth': false,
                "ajax": "practice/tableForPractice/" + value.idrequest,
                "rowCallback": function (row, data) {
                    var button = $(row).find('td:nth-child(8) > button');
                    var str = button.attr('onclick');
                    button.attr('onclick', str.substr(0, str.length - 1) + ", " + value.idrequest + ")");
                },
                "drawCallback": function () {
                    var cb = $('#practice_' + value.idrequest).find('input[type="checkbox"]');
                    cb.iCheck({
                        checkboxClass: 'icheckbox_square-purple',
                        radioClass: 'iradio_square-purple',
                        increaseArea: '20%' // optional
                    });
                    cb.on('ifChanged', function () {
                        var id = this.id;
                        var index = $.inArray(id, prselected[value.idrequest]);

                        if (index === -1) {
                            prselected[value.idrequest].push(id);
                        } else {
                            prselected[value.idrequest].splice(index, 1);
                        }

                        if (prselected[value.idrequest].length > 0) {
                            $('#delBut_' + value.idrequest).attr('class', 'btn btn-danger');
                        }
                        else {
                            $('#delBut_' + value.idrequest).attr('class', 'btn btn-danger disabled');
                        }
                    });
                    if ($.inArray(cb.attr('id'), prselected[value.idrequest]) !== -1) {
                        cb.iCheck('check');
                    }
                }
            });




        }

        function adminPageInit() {
            $.ajax({
                url: 'practice/getAll',
                dataType: 'json',
                success: function (data) {
                    $.each(data, function (index, value) {
                        appendPractice(index, value)
                    });
                }
            });
            $('#faculties').on('change', function () {
                refreshSpecialities(this.value, 0);
            });
            refreshSpecialities(1, 0);
            /* $('#tstudents').DataTable({
                 "processing": true,
                 "serverSide": true,
                 'autoWidth': false,
                 "ajax": "students/tableAllStudents"
             });*/
            $('#tfaculty').DataTable({
                //"processing": true,
                //"serverSide": true,
                //'autoWidth': false,
                'paging': true,
                'lengthChange': true,
                'searching': true,
                'ordering': true,
                'info': true,
                'autoWidth': false
                //"ajax": "admin/tableAllFaculty"
            });
            $('#tgroups').DataTable({
                'paging': true,
                'lengthChange': true,
                'searching': true,
                'ordering': true,
                'info': true,
                'autoWidth': false
            });
            $('#thops').DataTable({
                'paging': true,
                'lengthChange': true,
                'searching': true,
                'ordering': true,
                'info': true,
                'autoWidth': false
            });
            $('#admin_edit').ajaxForm({
                dataType: 'json',
                success: function (data) {
                    if (data[0] != null) {
                        $('#success').css('display', 'none');
                        $('#error').css('display', 'block');
                        $('#error').find('h4').html("<i class=\"icon fa fa-ban\"></i> " + data[0].defaultMessage);
                    }else {
                        $('#user_avatar').attr("src", "images/" + data.imageUrl);
                        $('#user_name').html(data.first_name + " " + data.last_name);
                        //that's a trick to avoid requests to a faculty table for a name (that'll mean either additional
                        // request from here, or returing something else than student from controller)
                        // we will do such request to fill our select below
                        //(not implemented yet)
                        $('#faculty').text($("#faculties option[value='" + data.idFaculty + "']").text());
                        $('#error').css('display', 'none');
                        $('#success').css('display', 'block');
                    }
                }
            });

            $('#student_edit1').ajaxForm({
                dataType: 'json',
                success: function (data) {
                    if (data[0] != null) {
                        $('#success').css('display', 'none');
                        $('#error').css('display', 'block');
                        $('#error').find('h4').html("<i class=\"icon fa fa-ban\"></i> " + data[0].defaultMessage);
                    } else {
                        $('#error').css('display', 'none');
                        $('#success').css('display', 'block');
                        studentsTable.draw();
                    }
                },
                error: function (xhr, textStatus, errorThrown) {
                    $('#error').css('display', 'block');
                    $('#error').find('h4').text("<i class=\"icon fa fa-ban\"></i> Неизвестная ошибка");
                }
            });
            $('#faculty_edit').ajaxForm({
                dataType: 'json',
                success: function (data) {
                    if (data) {
                        $('#faculty').text($("#faculties option[value='" + data.idFaculty + "']").text());
                        $('#success').css('display', 'block');
                    } else {
                        $('#error').css('display', 'block');
                    }
                }
            });
            $('#speciality_edit').ajaxForm({
                dataType: 'json',
                success: function (data) {
                    if (data) {
                        $('#faculty').text($("#faculties option[value='" + data.idFaculty + "']").text());
                        $('#success').css('display', 'block');
                    } else {
                        $('#error').css('display', 'block');
                    }
                }
            });
            $('#request').ajaxForm({
                dataType: 'json',
                data: {
                    "checked[]": selected
                },
                success: function (data) {
                    if (data) {
                        appendPractice(0, data);
                        $('#success').css('display', 'block');
                    } else {
                        $('#error').css('display', 'block');
                    }
                },
                error: function (xhr, textStatus, errorThrown) {
                    alert(xhr + " " + textStatus + " " + errorThrown);
                }
            });
            $('#add_Request').ajaxForm({
                dataType: 'json',
                success: function (data) {
                    if (data) {
                        $('#faculty').text($("#faculties option[value='" + data.idFaculty + "']").text());
                        $('#success').css('display', 'block');
                    } else {
                        $('#error').css('display', 'block');
                    }
                }
            });


            studentsTable = $('#tstudents').DataTable({
                "processing": true,
                "serverSide": true,
                'autoWidth': false,
                "ajax": "students/tableAllStudents",
                "rowCallback": function (row, data) {
                    var cb = $(row).find('td:nth-child(1) > label > input[type="checkbox"]');
                    if ($.inArray(cb.attr('id'), selected) !== -1) {
                        cb.iCheck('check');
                    }
                },
                "drawCallback": function () {
                    $('#tstudents').find('input[type="checkbox"]').not('.selectall').iCheck({
                        checkboxClass: 'icheckbox_square-purple',
                        radioClass: 'iradio_square-purple',
                        increaseArea: '20%' // optional
                    });
                    $('.selectall').iCheck({
                        checkboxClass: 'icheckbox_square-purple',
                        radioClass: 'iradio_square-purple',
                        increaseArea: '20%' // optional
                    });
                    $('.selectall').on('ifChecked', function () {
                        $('#tstudents').find('input[type="checkbox"]').not('.selectall').iCheck('check');
                    });
                    $('.selectall').on('ifUnchecked', function () {
                        $('#tstudents').find('input[type="checkbox"]').not('.selectall').iCheck('uncheck');
                    });
                    $('#tstudents').find('input[type="checkbox"]').not('.selectall').on('ifChanged', function () {
                        var id = this.id;
                        var index = $.inArray(id, selected);

                        if (index === -1) {
                            selected.push(id);
                        } else {
                            selected.splice(index, 1);
                        }
                        if ($('#tstudents').find('input[type="checkbox"]').not('.selectall').length === $('#tstudents').find('input[type="checkbox"]:checked').not('.selectall').length) {
                            $('.selectall').prop('checked', true).iCheck('update');
                        }
                        else {
                            $('.selectall').prop('checked', false).iCheck('update');
                        }
                        if (selected.length > 0) {
                            $('#delBut_0').attr('class', 'btn btn-danger');

                        }
                        else {
                            $('#delBut_0').attr('class', 'btn btn-danger disabled');

                        }
                    });
                    if ($('#tstudents').find('input[type="checkbox"]').not('.selectall').length === $('#tstudents').find('input[type="checkbox"]:checked').not('.selectall').length) {
                        $('.selectall').prop('checked', true).iCheck('update');
                    }
                    else {
                        $('.selectall').prop('checked', false).iCheck('update');
                    }
                    $('#delBut_0').attr('class', 'btn btn-danger disabled');

                }
            });


            $.validate({
                lang: 'ru'
            });
        }

        function refreshSpecialities(id, val) {
            $.ajax({
                url: 'university/getSpecialitiesByFacultyId/' + id,
                dataType: 'json',
                success: function (data) {
                    $('#specs').find('option').remove();
                    var options = "";
                    $.each(data, function (index, value) {
                        options += '<option value="' + value.idSpeciality + '">' + value.speciality_name + '</option>';
                    });
                    $('#specs').html(options);
                    if (val) {
                        $('#specs').val(val);
                    }
                }
            });
        }

        function delStudent(id) {
            $.ajax({
                url: 'practice/delstud/' + id + "?${_csrf.parameterName}=${_csrf.token}",
                success: function () {
                    prtables[id].draw();
                }
            })
        }

        function fillForm(id) {
            $.ajax({
                url: 'students/get/' + id,
                dataType: 'json',
                success: function (data) {
                    $('#faculties').val(data.idFaculty);
                    refreshSpecialities(data.idFaculty, data.idSpeciality);
                    $('input[name=fname]').val(data.first_name);
                    $('input[name=lname]').val(data.last_name);
                    $('input[name=group]').val(data.group_number);
                    $('input[name=form_of_Education]').val(data.form_of_Education);
                    $('input[name=avgScore]').val(data.av_score);
                    $('#student_edit').attr('action', '/students/edit/' + id + '?${_csrf.parameterName}=${_csrf.token}');
                    $('#student_edit').ajaxForm({
                        dataType: 'json',
                        success: function (data) {
                            if (data[0] != null) {
                                $('#success').css('display', 'none');
                                $('#error').css('display', 'block');
                                $('#error').find('h4').html("<i class=\"icon fa fa-ban\"></i> " + data[0].defaultMessage);
                            } else {
                                $('#error').css('display', 'none');
                                $('#success').css('display', 'block');
                                studentsTable.draw();
                            }
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            $('#error').css('display', 'block');
                            $('#error').find('h4').text("<i class=\"icon fa fa-ban\"></i> Неизвестная ошибка");
                        }
                    });

                }
            });
        }

        function editStudent(id) {
            fillForm(id);
            $('#edit-student').modal('show');
        }

        function delStudent(stid, id) {
            if (arguments.length == 1)
                deleteStudent(stid); else $.ajax({
                url: 'practice/remove/' + id + '/' + stid + "?${_csrf.parameterName}=${_csrf.token}",
                success: function () {
                    prtables[id].draw();
                }
            })
        }

        function delChecked(id) {
            $.ajax({
                url: 'practice/removeAll/' + id + "?${_csrf.parameterName}=${_csrf.token}",
                method: 'post',
                data: {
                    "students[]": prselected[id]
                },
                success: function (data) {
                    prtables[id].draw();
                    prselected[id] = [];
                    $('#delBut_' + value.id).attr('class', 'btn btn-danger disabled');
                }
            })
        }

        function delCheckedStudent() {
            $.ajax({
                url: '/admin/removeAllStudent' ,
                method: 'get',
                data: {
                    "students[]": selected
                },
                success: function (data) {
                    studentsTable.draw();
                    /* prtables[id].draw();
                     prselected[id] = [];
                     $('#delBut_0').attr('class', 'btn btn-danger disabled');*/
                }
            })
        }

        function deleteStudent(id) {
            $.ajax({
                url: "/admin/delstud/" + id + "?${_csrf.parameterName}=${_csrf.token}",
                method: "get",
                success: function () {
                    studentsTable.draw();
                },
                error: function () {
                    studentsTable.draw();
                }
            })
        }


        function delPract(id) {
            $.ajax({
                url: "/practice/delpract/" + id + "?${_csrf.parameterName}=${_csrf.token}",
                method: "get",
                success: function () {
                    $('#prdiv'+id).remove();
                }
            })
        }

        function information(id) {
            $.ajax({
                url: 'practice/get/' + id + "?${_csrf.parameterName}=${_csrf.token}",
                success: function (data) {
                    var modal = $('#info');
                    modal.find('#p_name').text("Название практики: " + data.name_of_practice);
                    modal.find('#p_company').text("Компания: " + data.company);
                    modal.find('#p_department').text("Отдел: " + data.department);
                    modal.find('#p_hop').text("Руководитель: " + data.hop_First_name + " " + data.hop_Last_name);
                    modal.find('#p_faculty').text("Факультет: " + data.nameFaculty);
                    modal.find('#p_speciality').text("Специальность: " + data.nameSpec);
                    modal.find('#p_minavg').text("Мин. ср. балл: " + data.minAvg);
                    modal.find('#p_daterange').text("Дата: " + data.start + " - " + data.finish);
                    modal.modal();
                }
            })
        }

    </script>

</head>
<body onload="adminPageInit()">
<div class="col-md-12">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title" align="center">Страница администратора</h3>

                </div>
                <div class="panel-body">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#home" data-toggle="tab" aria-expanded="false">Таблицы</a>
                        </li>
                        <li class=""><a href="#profile" data-toggle="tab" aria-expanded="false">Факультеты и
                            специальности</a>
                        </li>
                        <li class=""><a href="#messages" data-toggle="tab" aria-expanded="true">Заявки</a>
                        </li>
                        <li class="">
                            <a href="/logout">
                                <button class="btn btn-primary w-md">Выйти</button>
                            </a>
                        </li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content ">
                        <div class="tab-pane fade active in" id="home">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title" align="center">Таблица Всех студентов</h3>

                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-md-12 col-sm-12 col-xs-12">
                                                    <table id="tstudents"
                                                           class="table table-striped table-bordered">
                                                        <thead>
                                                        <tr>
                                                            <th>
                                                                <input type="checkbox" class="selectall">
                                                            </th>
                                                            <th>Имя</th>
                                                            <th>Фамилия</th>
                                                            <th>Факультет</th>
                                                            <th>Специальность</th>
                                                            <th>Группа</th>
                                                            <th>Средний балл</th>
                                                            <th>Редактирование</th>
                                                            <th>Удаление</th>
                                                        </tr>
                                                        </thead>

                                                        <tbody>
                                                        </tbody>
                                                    </table>

                                                </div>

                                                <div class="panel-body">
                                                    <button type="button" id="delBut_0" class="btn btn-danger " onclick="delCheckedStudent()">
                                                        Удалить выделеных
                                                    </button>
                                                    <a href="#myModal1" class="btn btn-primary" data-toggle="modal">Создать</a>
                                                    <!-- HTML-код модального окна-->
                                                    <div id="myModal1" class="modal fade">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <!-- Заголовок модального окна -->
                                                                <div class="modal-header">
                                                                    <button type="button" class="close"
                                                                            data-dismiss="modal" aria-hidden="true">×
                                                                    </button>
                                                                    <h4 class="modal-title">Создать нового студента</h4>
                                                                </div>
                                                                <!-- Основное содержимое модального окна -->
                                                                <div class="modal-body">
                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <div class="panel panel-default">
                                                                                <div class="panel-heading">
                                                                                    <h3 class="panel-title"
                                                                                        align="center">Создание
                                                                                        студента</h3>
                                                                                </div>
                                                                                <div class="panel-body">
                                                                                    <form class="form-horizontal"
                                                                                          role="form"
                                                                                          action="admin/addStudent"
                                                                                          id="student_edit1"
                                                                                          method="post">
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Логин</label>
                                                                                            <div class="col-md-10">
                                                                                                <input type="text"
                                                                                                       class="form-control"
                                                                                                       placeholder="Логин"
                                                                                                       name="username">
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Пароль</label>
                                                                                            <div class="col-md-10">
                                                                                                <input type="password"
                                                                                                       class="form-control"
                                                                                                       placeholder="Пароль"
                                                                                                       name="password">
                                                                                            </div>
                                                                                        </div>

                                                                                        <input type="hidden"
                                                                                               name="${_csrf.parameterName}"
                                                                                               value="${_csrf.token}"/>
                                                                                        <button type="submit"
                                                                                                class="btn btn-purple">
                                                                                            Применить
                                                                                        </button>
                                                                                    </form>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title" align="center">Таблица всех руководителей
                                                практики</h3>

                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-md-12 col-sm-12 col-xs-12">
                                                    <table id="thops"
                                                           class="table table-striped table-bordered">
                                                        <thead>
                                                        <tr>
                                                            <th>Имя</th>
                                                            <th>Фамилия</th>
                                                            <th>Предприятие</th>
                                                            <th>Отдел</th>
                                                            <th>Удаление</th>
                                                        </tr>
                                                        </thead>

                                                        <tbody>
                                                        <c:forEach items="${hops}" var="hop1">
                                                            <tr>
                                                                <td>${hop1.getFirst_name()}</td>
                                                                <td>${hop1.getLast_name()}</td>
                                                                <td>${hop1.getCompany()}</td>
                                                                <td>${hop1.getDepartment()}</td>
                                                                <th>
                                                                    <a href=" <c:url value='/admin/deleteHOP/${hop1.getIdhead_of_practice()}'/> ">
                                                                        <button
                                                                                type="button"
                                                                                class="btn btn-block btn-danger">
                                                                            Удалить
                                                                        </button>
                                                                    </a></th>
                                                            </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>

                                                </div>
                                                <div class="panel-body">
                                                    <a href="#myModal8" class="btn btn-primary" data-toggle="modal">Создать
                                                        руководителя практики</a>
                                                    <!-- HTML-код модального окна-->
                                                    <div id="myModal8" class="modal fade">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <!-- Заголовок модального окна -->
                                                                <div class="modal-header">
                                                                    <button type="button" class="close"
                                                                            data-dismiss="modal" aria-hidden="true">×
                                                                    </button>
                                                                    <h4 class="modal-title">Создание</h4>
                                                                </div>
                                                                <!-- Основное содержимое модального окна -->
                                                                <div class="modal-body">
                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <div class="panel panel-default">
                                                                                <div class="panel-heading">
                                                                                    <h3 class="panel-title"
                                                                                        align="center">Создание нового руководителя прктики</h3>
                                                                                </div>
                                                                                <div class="panel-body">
                                                                                    <form class="form-horizontal"
                                                                                          role="form"
                                                                                          action="practice/addHOP"
                                                                                          id="admin_edit"
                                                                                          method="post">
                                                                                        <div class="alert alert-success alert-dismissible" style="display: none">
                                                                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                                                                            <h4> Изменения приняты!</h4>
                                                                                        </div>

                                                                                        <div class="alert alert-danger alert-dismissible" style="display: none">
                                                                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                                                                            <h4><i class="icon fa fa-ban"></i> Ошибка!</h4>
                                                                                        </div>
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Логин</label>
                                                                                            <div class="col-md-10">
                                                                                                <input data-validation="length letternumeric" data-validation-length="2-45"
                                                                                                       type="text"
                                                                                                       class="form-control"
                                                                                                       placeholder="Логин"
                                                                                                       name="username">
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Пароль</label>
                                                                                            <div class="col-md-10">
                                                                                                <input data-validation="length letternumeric" data-validation-length="2-45"
                                                                                                       type="password"
                                                                                                       class="form-control"
                                                                                                       placeholder="Пароль"
                                                                                                       name="password">
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Имя</label>
                                                                                            <div class="col-md-10">
                                                                                                <input data-validation="length letternumeric" data-validation-length="2-45"
                                                                                                       type="text"
                                                                                                       class="form-control"
                                                                                                       placeholder="Имя"
                                                                                                       name="first_name">
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Фамилия</label>
                                                                                            <div class="col-md-10">
                                                                                                <input data-validation="length letternumeric" data-validation-length="2-45"
                                                                                                       type="text"
                                                                                                       class="form-control"
                                                                                                       placeholder="Фамилия"
                                                                                                       name="last_name">
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Комапания</label>
                                                                                            <div class="col-md-10">
                                                                                                <input data-validation="length letternumeric" data-validation-length="2-45"
                                                                                                       type="text"
                                                                                                       class="form-control"
                                                                                                       placeholder="Комапания"
                                                                                                       name="company">
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Отдел</label>
                                                                                            <div class="col-md-10">
                                                                                                <input data-validation="length letternumeric" data-validation-length="2-45"
                                                                                                       type="text"
                                                                                                       class="form-control"
                                                                                                       placeholder="Отдел"
                                                                                                       name="department">
                                                                                            </div>
                                                                                        </div>
                                                                                        <input type="hidden"
                                                                                               name="${_csrf.parameterName}"
                                                                                               value="${_csrf.token}"/>
                                                                                        <button type="submit"
                                                                                                class="btn btn-purple">
                                                                                            Применить
                                                                                        </button>
                                                                                    </form>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="tab-pane fade" id="profile">

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title" align="center">Факультеты</h3>

                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-md-12 col-sm-12 col-xs-12">
                                                    <table id="tfaculty"
                                                           class="table table-striped table-bordered">
                                                        <thead>
                                                        <tr>
                                                            <th>Название</th>
                                                            <th>Удалить</th>
                                                        </tr>
                                                        </thead>

                                                        <tbody>
                                                        <c:forEach items="${faculties}" var="item">
                                                            <tr>
                                                                <td>${item.getFaculty_name()}</td>
                                                                <td>
                                                                    <a href=" <c:url value='/admin/deleteFaculty/${item.getIdFaculty()}'/> ">
                                                                        <button
                                                                                type="button"
                                                                                class="btn btn-block btn-danger">
                                                                            Удалить
                                                                        </button>
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>

                                                </div>
                                                <div class="panel-body">

                                                    <a href="#myModal2" class="btn btn-primary" data-toggle="modal">Создать</a>
                                                    <!-- HTML-код модального окна-->
                                                    <div id="myModal2" class="modal fade">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <!-- Заголовок модального окна -->
                                                                <div class="modal-header">
                                                                    <button type="button" class="close"
                                                                            data-dismiss="modal" aria-hidden="true">×
                                                                    </button>
                                                                    <h4 class="modal-title">Новый факультет</h4>
                                                                </div>
                                                                <!-- Основное содержимое модального окна -->
                                                                <div class="modal-body">
                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <div class="panel panel-default">
                                                                                <div class="panel-heading">
                                                                                    <h3 class="panel-title"
                                                                                        align="center">Создание
                                                                                        факультета</h3>
                                                                                </div>
                                                                                <div class="panel-body">
                                                                                    <form class="form-horizontal"
                                                                                          role="form"
                                                                                          action="admin/addFaculty"
                                                                                          id="faculty_edit"
                                                                                          method="post"
                                                                                          accept-charset="windows1251">
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Название
                                                                                                факультета</label>
                                                                                            <div class="col-md-10">
                                                                                                <input type="text"
                                                                                                       class="form-control"
                                                                                                       placeholder="Название факультета"
                                                                                                       name="faculty_name">
                                                                                            </div>
                                                                                        </div>
                                                                                        <input type="hidden"
                                                                                               name="${_csrf.parameterName}"
                                                                                               value="${_csrf.token}"/>
                                                                                        <button type="submit"
                                                                                                class="btn btn-purple">
                                                                                            Применить
                                                                                        </button>
                                                                                    </form>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title" align="center">Специальность</h3>

                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-md-12 col-sm-12 col-xs-12">
                                                    <table id="tgroups"
                                                           class="table table-striped table-bordered">
                                                        <thead>
                                                        <tr>
                                                            <th>Название</th>
                                                            <th>Факультет</th>
                                                            <th>Удалить</th>
                                                        </tr>
                                                        </thead>

                                                        <tbody>
                                                        <c:forEach items="${listSpecialities}" var="spec">
                                                            <tr>
                                                                <td>${spec.getSpeciality_name()}</td>
                                                                <td>${spec.getNameFaculty()}</td>
                                                                <td>
                                                                    <a href=" <c:url value='/admin/deleteSpeciality/${spec.getIdSpec()}'/> ">
                                                                        <button
                                                                                type="button"
                                                                                class="btn btn-block btn-danger">
                                                                            Удалить
                                                                        </button>
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>

                                                </div>
                                                <div class="panel-body">

                                                    <a href="#myModal3" class="btn btn-primary" data-toggle="modal">Создать</a>
                                                    <!-- HTML-код модального окна-->
                                                    <div id="myModal3" class="modal fade">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <!-- Заголовок модального окна -->
                                                                <div class="modal-header">
                                                                    <button type="button" class="close"
                                                                            data-dismiss="modal" aria-hidden="true">×
                                                                    </button>
                                                                    <h4 class="modal-title">Новая специальность</h4>
                                                                </div>
                                                                <!-- Основное содержимое модального окна -->
                                                                <div class="modal-body">
                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <div class="panel panel-default">
                                                                                <div class="panel-heading">
                                                                                    <h3 class="panel-title"
                                                                                        align="center">Создание
                                                                                        специальности</h3>
                                                                                </div>
                                                                                <div class="panel-body">
                                                                                    <form class="form-horizontal"
                                                                                          action="admin/addSpeciality"
                                                                                          id="speciality_edit"
                                                                                          method="post"
                                                                                          accept-charset="windows1251"
                                                                                          role="form">
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Название
                                                                                                специальности</label>
                                                                                            <div class="col-md-10">
                                                                                                <input type="text"
                                                                                                       class="form-control"
                                                                                                       placeholder="Название"
                                                                                                       name="speciality_name">
                                                                                            </div>

                                                                                        </div>
                                                                                        <div class="form-group">
                                                                                            <label class="col-sm-2 control-label">Факультет</label>
                                                                                            <div class="col-sm-10">
                                                                                                <select id="fac"
                                                                                                        class="form-control"
                                                                                                        name="idFaculty">
                                                                                                    <c:forEach
                                                                                                            items="${faculties}"
                                                                                                            var="item">
                                                                                                        <option value="${item.getIdFaculty()}">${item.getFaculty_name()}</option>
                                                                                                    </c:forEach>
                                                                                                </select>
                                                                                            </div>
                                                                                        </div>
                                                                                        <input type="hidden"
                                                                                               name="${_csrf.parameterName}"
                                                                                               value="${_csrf.token}"/>

                                                                                        <button type="submit"
                                                                                                class="btn btn-purple">
                                                                                            Применить
                                                                                        </button>
                                                                                    </form>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="tab-pane fade " id="messages">

                            <div class="box box-solid">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Все заявки на практику</h3>
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="box-group" id="practices">
                                        <!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
                                    </div>
                                </div>
                                <!-- /.box-body -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>

<div class="modal fade" id="edit-student" data-vivaldi-spatnav-clickable="1" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span></button>
                <h4 class="modal-title">Редактирование студента</h4>
            </div>
            <div class="modal-body">
                <div id="success" class="alert alert-success alert-dismissible" style="display: none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <h4><i class="icon fa fa-check"></i> Изменения приняты!</h4>
                </div>

                <div id="error" class="alert alert-danger alert-dismissible" style="display: none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <h4><i class="icon fa fa-ban"></i> Ошибка!</h4>
                </div>
                <form id="student_edit"
                      action="" method="post"
                      role="form">
                    <div class="box-body">
                        <!-- text input -->
                        <div class="form-group">
                            <label>Имя</label>
                            <input data-validation="length letternumeric" data-validation-length="2-45"
                                   type="text" class="form-control" name="first_name"
                                   placeholder="Введите имя...">
                        </div>
                        <div class="form-group">
                            <label>Фамилия</label>
                            <input data-validation="length letternumeric" data-validation-length="2-45"
                                   type="text" class="form-control" name="last_name"
                                   placeholder="Введите фамилию...">
                        </div>

                        <div class="form-group">
                            <label for="faculties">Выберите факультет</label>
                            <select id="faculties" name="faculty" class="form-control">
                                <c:forEach items="${faculties}" var="item">
                                    <option value="${item.getIdFaculty()}">${item.getFaculty_name()}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="specs">Выберите специальность</label>
                            <select id="specs" name="speciality" class="form-control">

                            </select>
                        </div>

                        <div class="form-group">
                            <label>Группа</label>
                            <input data-validation="length number" data-validation-length="6"
                                   data-validation-error-msg="Группа должна быть шестизначным числом"
                                   type="number" class="form-control" placeholder="Группа" name="group_number">
                        </div>

                        <div class="form-group">
                            <label>Форма обучения </label>
                            <select class="form-control" name="form_of_Education">
                                <option>Платная</option>
                                <option>Бесплатная</option>
                            </select>

                        </div>

                        <div class="form-group">
                            <label>Средний балл</label>
                            <input data-validation="number" data-validation-allowing="range[4.0;10.0],float"
                                   data-validation-error-msg="Значение выходит за диапазон возможных оценок"
                                   type="number" class="form-control" placeholder="Балл" name="av_score">
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}"
                               value="${_csrf.token}"/>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Закрыть
                        </button>
                        <button type="submit" class="btn btn-primary">Сохранить</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<div class="modal modal-info fade" id="info">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Информация о практике</h4>
            </div>
            <div class="modal-body">
                <p id="p_name"></p>
                <p id="p_company"></p>
                <p id="p_department"></p>
                <p id="p_hop"></p>
                <p id="p_faculty"></p>
                <p id="p_speciality"></p>
                <p id="p_minavg"> </p>
                <p id="p_daterange"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline" data-dismiss="modal">Закрыть</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('#datatable').dataTable();
    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#table').dataTable();
    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#All_studenttable').dataTable();
    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#All_requesttable').dataTable();
    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#All_studenttable1').dataTable();
    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#All_requesttable1').dataTable();
    });
</script>
</body>
</html>

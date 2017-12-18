<%--
  Created by IntelliJ IDEA.
  User: BigPc
  Date: 14.10.2017
  Time: 19:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page session="true" %>
<html lang="ru">
<head>
    <title>Страница преподавателя</title>
    <jsp:include page="/jsp/blocks/header1.jsp"/>
    <script src="resources/js/libs/jquery.form-validator.min.js"></script>
    <script>
        var id = '${id}';
        var oTable;
        var selected = [];
        var prtables = [];

        var prselected = [];

        function appendPractice(index, value) {
            $('#practices').append('<div id="prdiv' + value.idrequest + '" class="panel box box-primary">\n' +
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
                '                                                            <th></th>\n' +
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
        $(function () {

            $('#fileupload').ajaxForm({
                success: function (data) {
                    $('#user_avatar').attr("src", "images/" + data.imageUrl);
                }
            });

            $('#faculties').on('change', function () {
                refreshSpecialities(this.value, 1);
            })

        });


        function fillForm() {
            $.ajax({
                url: 'hops/get/${id}',
                dataType: 'json',
                success: function (data) {
                    $('#user_avatar').attr("src", "images/" + data.imageUrl);
                    $('#user_name').html(data.first_name + " " + data.last_name);
                    $('#faculties').val(data.idFaculty);
                    refreshSpecialities(data.idFaculty, data.idSpeciality);
                    $('#faculty').text($("#faculties option[value='" + data.idFaculty + "']").text());
                    $('#company').text(data.company);
                    $('#department').text(data.department);
                    $('input[name=fname]').val(data.first_name);
                    $('input[name=lname]').val(data.last_name);
                    $('input[name=company]').val(data.company);
                    //if (data.isBudget) $('input[name=isBudget]').iCheck('toggle');
                    $('input[name=department]').val(data.department);

                }
            });
            $.ajax({
                url: 'practice/getPracticeByHop/${id}',
                dataType: 'json',
                success: function (data) {
                    $.each(data, function (index, value) {
                        appendPractice(index, value)
                    })
                }
            });

            $('#hops_edit').ajaxForm({
                dataType: 'json',
                success: function (data) {
                    if (data[0] != null) {
                        $('#success').css('display', 'none');
                        $('#error').css('display', 'block');
                        $('#error').find('h4').html("<i class=\"icon fa fa-ban\"></i> " + data[0].defaultMessage);
                    } else {
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
            $('#faculties').val(1);
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
            $.validate({
                lang: 'ru'
            });
            oTable = $('#tstudents').DataTable({
                "processing": true,
                "serverSide": true,
                'autoWidth': false,
                "ajax": "practice/tableForRequest/" + getFacultiesVal() + "/" +
                getSpecialityVal()
                + "?minavg=" + getMinAvgVal() + "&startd=" + getDate1() + "&finish=" + getDate2() + "&budget=" + getIsBudget(),
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
                    });
                    if ($('#tstudents').find('input[type="checkbox"]').not('.selectall').length === $('#tstudents').find('input[type="checkbox"]:checked').not('.selectall').length) {
                        $('.selectall').prop('checked', true).iCheck('update');
                    }
                    else {
                        $('.selectall').prop('checked', false).iCheck('update');
                    }

                }
            });

            $('#request').on('change', function () {
                oTable.ajax.url("practice/tableForRequest/" + getFacultiesVal() + "/" +
                    getSpecialityVal() + "?minavg=" + getMinAvgVal() + "&startd=" + getDate1() + "&finish=" + getDate2() + "&budget=" + getIsBudget());
                oTable.draw();
            });


        }

        function getFacultiesVal() {
            var result = $('#faculties').val();
            if (result === null) result = 1;
            return result;
        }

        function getSpecialityVal() {
            var result = $('#specs').val();
            if (result === null) result = 1;
            return result;
        }

        function getMinAvgVal() {
            var result = $('#mivavg').val();
            if (result === null || result === "" || result < 4 || result > 10) result = 4.0;
            return result;
        }

        function getIsBudget() {
            var result = $('#bud').val();
            if (result === null) result = 1;
            return result;
        }

        function getDate1() {
            return $('#datepicker').val();
        }

        function getDate2() {
            return $('#datepicker-multiple').val();
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

        function delStudent(stid, id) {
            $.ajax({
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

        function delPract(id) {
            $.ajax({
                url: "/practice/delpract/" + id + "?${_csrf.parameterName}=${_csrf.token}",
                method: "get",
                success: function () {
                    $('#prdiv' + id).remove();
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
<body onload="fillForm()" class="hold-transition login-page">
<aside class="left-panel">
    <img src="http://www.linko.co.il/wp-content/uploads/2015/05/businessman1-1.jpg" width="150"
         height="150" class="image_centre">
    <h5 id="user_name" align="center">${name}</h5>
    <h5 align="center">Статус: Преподователь</h5>
    <ul class="list-group list-group-unbordered">
        <li class="list-group-item">
            <!-- This also never changes for now -->
            <b>Университет</b> <a class="pull-right">БГУИР</a>
        </li>
        <li class="list-group-item">
            <b>Компания</b> <a class="pull-right" id="company"></a>
        </li>
        <li class="list-group-item">
            <b>Отдел</b> <a class="pull-right" id="department"></a>
        </li>
    </ul>
    <div class="form-group text-right">
        <div class="col-xs-17" align="center">
            <a href="/logout">
                <button class="btn btn-primary w-md">Выйти</button>
            </a>
        </div>
    </div>
</aside>
<!--Main Content -->

<section class="content">

    <!-- Page Content -->
    <div class="panel-body">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#home" data-toggle="tab" aria-expanded="false">Личные данные и практики</a>
            </li>
            <li class=""><a href="#profile" data-toggle="tab" aria-expanded="false">Создать практику</a>
        </ul>
        <div class="tab-content ">
            <div class="tab-pane fade active in" id="home">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title" align="center">Личные данные</h3>
                            </div>
                            <div class="box-header with-border">
                                <h3 class="box-title" align="center">Пожалуйста, заполните все поля</h3>
                            </div>

                            <div id="success" class="alert alert-success alert-dismissible" style="display: none">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                <h4> Изменения приняты!</h4>
                            </div>

                            <div id="error" class="alert alert-danger alert-dismissible" style="display: none">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                <h4><i class="icon fa fa-ban"></i> Ошибка!</h4>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal" id="hops_edit" role="form"
                                      action="/hops/edit/${id}?${_csrf.parameterName}=${_csrf.token}" method="post">
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Имя</label>
                                        <div class="col-md-10">
                                            <input data-validation="length letternumeric" data-validation-length="2-45"
                                                   type="text" class="form-control" placeholder="Имя" name="first_name">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Фамилия</label>
                                        <div class="col-md-10">
                                            <input data-validation="length letternumeric" data-validation-length="2-45"
                                                   type="text" class="form-control" placeholder="Фамилия"
                                                   name="last_name">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Название предприятие</label>
                                        <div class="col-md-10">
                                            <input data-validation="length letternumeric" data-validation-length="2-45"
                                                   type="text" class="form-control" placeholder="Предприятие"
                                                   name="company">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Название отдела</label>
                                        <div class="col-md-10">
                                            <input data-validation="length letternumeric" data-validation-length="2-45"
                                                   type="text" class="form-control" placeholder="Отдел"
                                                   name="department">
                                        </div>
                                    </div>
                                    <div class="panel-body">
                                        <input type="hidden" name="${_csrf.parameterName}"
                                               value="${_csrf.token}"/>
                                        <button type="submit" class="btn btn-purple">
                                            Применить
                                        </button>

                                    </div>
                                </form>
                            </div>
                            <!-- panel-body -->
                        </div>
                        <!-- panel -->
                    </div>
                    <!-- col -->
                </div>
                <div class="box-header with-border">
                    <h3 class="box-title">Все заявки на практику</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="box-group" id="practices">

                        <!-- collapsing boxes with tables -->
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="profile">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"
                                    align="center">Заявка
                                </h3>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal" id="request"
                                      action="/practice/addRequestHOP/${id}?${_csrf.parameterName}=${_csrf.token}"
                                      method="post" role="form">
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Название
                                            практики</label>
                                        <div class="col-md-10">
                                            <input type="text"
                                                   class="form-control"
                                                   placeholder="Названиме"
                                                   name="name_of_practice">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Название
                                            компании</label>
                                        <div class="col-md-10">
                                            <input type="text"
                                                   class="form-control"
                                                   placeholder="Компания"
                                                   name="company">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Название
                                            отдела</label>
                                        <div class="col-md-10">
                                            <input type="text"
                                                   class="form-control"
                                                   placeholder="Отдел"
                                                   name="department">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Факультет</label>
                                        <div class="col-sm-10">
                                            <select id="faculties" class="form-control"
                                                    name="faculty">
                                                <c:forEach items="${faculties}"
                                                           var="item">
                                                    <option value="${item.getIdFaculty()}">${item.getFaculty_name()}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Специальность</label>
                                        <div class="col-sm-10">
                                            <select id="specs" name="speciality"
                                                    class="form-control">

                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Форма обучения</label>
                                        <div class="col-sm-10">
                                            <select class="form-control" name="form_of_Education" id="bud">
                                                <option>Платная</option>
                                                <option>Бесплатная</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">
                                            Средний балл</label>
                                        <div class="col-sm-10">
                                            <select class="form-control" name="minAvg"
                                                    id="mivavg">
                                                <option>4</option>
                                                <option>5</option>
                                                <option>6</option>
                                                <option>7</option>
                                                <option>8</option>
                                                <option>9</option>
                                                <option>10</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <h4 align="center">Начало практики</h4>
                                        <div class="input-group">
                                            <input type="text" class="form-control"
                                                   placeholder="mm/dd/yyyy"
                                                   id="datepicker" name="start" value="01/01/2017">
                                            <span class="input-group-addon"><i
                                                    class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <h4 align="center">Конец практики</h4>
                                        <div class="input-group">
                                            <input type="text" class="form-control"
                                                   placeholder="mm/dd/yyyy"
                                                   id="datepicker-multiple"
                                                   name="finish" value="01/01/2017">
                                            <span class="input-group-addon"><i
                                                    class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </div>
                                    <input type="hidden" name="${_csrf.parameterName}"
                                           value="${_csrf.token}"/>
                                    <button type="submit"
                                            class="btn btn-purple">
                                        Применить
                                    </button>
                                </form>
                                <table id="tstudents" class="table table-bordered table-striped">
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
                                    </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>

                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Row -->
        </div>
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
                    <p id="p_minavg"></p>
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


    <!-- Page Content Ends -->

    <!-- Footer -->
    <footer class="footer">
        2017 © Admina By Belavsky
    </footer>
    <!-- End Footer -->

</section>

<script type="text/javascript">
    $(document).ready(function () {
        $('#datatable').dataTable();
    });
</script>

</body>
</html>

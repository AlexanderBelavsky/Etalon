<%--
  Created by IntelliJ IDEA.
  User: BigPc
  Date: 14.10.2017
  Time: 22:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page session="true" %>

<html lang="ru">
<head>
    <title>Страница студента</title>
    <jsp:include page="/jsp/blocks/header1.jsp"/>
    <script>
        $(function () {

            $('#fileupload').ajaxForm({
                success: function (data) {
                    $('#user_avatar').attr("src", "images/" + data.imageUrl);
                }
            });

            $('#faculties').on('change', function () {
                refreshSpecialities(this.value, 0);
            })

        });
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
        function fillForm() {
            $.ajax({
                url: 'students/get/${id}',
                dataType: 'json',
                success: function (data) {
                    $('#user_avatar').attr("src", "images/" + data.imageUrl);
                    $('#user_name').html(data.first_name + " " + data.last_name);
                    $('#faculties').val(data.idFaculty);
                    refreshSpecialities(data.idFaculty, data.idSpeciality);
                    $('#faculty').text($("#faculties option[value='" + data.idFaculty + "']").text());
                    $('#group').text(data.group_number);
                    $('#avgScore').text(data.av_score);
                    $('input[name=fname]').val(data.first_name);
                    $('input[name=lname]').val(data.last_name);
                    $('input[name=group]').val(data.group_number);
                    //if (data.isBudget) $('input[name=isBudget]').iCheck('toggle');
                    $('input[name=form_of_Education]').val(data.form_of_Education);
                    $('input[name=avgScore]').val(data.av_score);
                }
            });
            $('#student_edit').ajaxForm({
                dataType: 'json',
                success: function (data) {
                    if (data) {
                        $('#user_avatar').attr("src", "images/" + data.imageUrl);
                        $('#user_name').html(data.first_name + " " + data.last_name);
                        //that's a trick to avoid requests to a faculty table for a name (that'll mean either additional
                        // request from here, or returing something else than student from controller)
                        // we will do such request to fill our select below
                        //(not implemented yet)
                        $('#faculty').text($("#faculties option[value='" + data.idFaculty + "']").text());
                        $('#group').text(data.group_number);
                        $('#success').css('display', 'block');
                    } else {
                        $('#error').css('display', 'block');
                    }
                }
            });

        }
    </script>

</head>
<body onload="fillForm()" class="hold-transition login-page">
<aside class="left-panel">
    <img id="user_avatar" src="http://www.linko.co.il/wp-content/uploads/2015/05/businessman1-1.jpg" width="150"
         height="150" class="image_centre">
    <h5 id="user_name"  align="center">${name}</h5>
    <h5  align="center">Статус: Студент</h5>
    <ul class="list-group list-group-unbordered">
        <li class="list-group-item">
            <!-- This also never changes for now -->
            <b>Университет</b> <a class="pull-right">БГУИР</a>
        </li>
        <li class="list-group-item">
            <b>Факультет</b> <a class="pull-right" id="faculty"></a>
        </li>
        <li class="list-group-item">
            <b>Группа</b> <a class="pull-right" id="group"></a>
        </li>
    </ul>
    <div class="form-group text-right">
        <div class="col-xs-17" align="center" >
            <a href="/logout"><button class="btn btn-primary w-md">Выйти</button></a>
        </div>
    </div>
</aside>
<!--Main Content -->
<section class="content">

    <!-- Page Content -->

    <div class="wraper container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title" align="center">Личные данные</h3>
                    </div>

                    <div class="panel-body">
                        <form class="form-horizontal" id="student_edit" action="/students/edit/${id}?${_csrf.parameterName}=${_csrf.token}" method="post" role="form"
                              accept-charset="windows1251">
                            <div class="form-group">
                                <label class="col-md-2 control-label">Имя</label>
                                <div class="col-md-10">
                                    <input type="text" class="form-control" placeholder="Имя" name="first_name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">Фамилия</label>
                                <div class="col-md-10">
                                    <input type="text" class="form-control" placeholder="Фамилия" name="last_name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Факультет</label>
                                <div class="col-sm-10">
                                    <select id="faculties" class="form-control" name="faculty">
                                        <c:forEach items="${faculties}" var="item">
                                            <option value="${item.getIdFaculty()}">${item.getFaculty_name()}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Специальность</label>
                                <div class="col-sm-10">
                                    <select id="specs" name="speciality" class="form-control">

                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">Номер группы</label>
                                <div class="col-md-10">
                                    <input type="text" class="form-control" placeholder="Группа" name="group_number">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Форма обучения</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="form_of_Education">
                                        <option>Платная</option>
                                        <option>Бесплатная</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">Средний балл</label>
                                <div class="col-md-10">
                                    <input type="text" class="form-control" placeholder="Балл" name="av_score">
                                </div>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}"
                                   value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-purple">
                                Применить
                            </button>
                        </form>
                    </div>

                </div>
            </div>
        </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title" align="center">Практика</h3>
                                        </div>
                                        <div class="panel-body">
                                            <form class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Статус</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" readonly="" value="На практике">
                                                    </div>
                                                </div>
                                                <h4 align="center">Руководитель практики</h4>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Имя</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" readonly="" value="Костя">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Фамилия</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" readonly="" value="Новичёк">
                                                    </div>
                                                </div>
                                                <h4 align="center">Место проведения</h4>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Название предприятие</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" readonly="" value="Интеграл">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Название отдела</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" readonly="" value="Игры в фифа">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <h4 align="center">Начало практики</h4>
                                                    <div class="input-group">
                                                        <input type="text" class="form-control" placeholder="mm/dd/yyyy"
                                                               id="datepicker">
                                                        <span class="input-group-addon"><i
                                                                class="glyphicon glyphicon-calendar"></i></span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <h4 align="center">Конец практики</h4>
                                                    <div class="input-group">
                                                        <input type="text" class="form-control" placeholder="mm/dd/yyyy"
                                                               id="datepicker-multiple">
                                                        <span class="input-group-addon"><i
                                                                class="glyphicon glyphicon-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <!-- panel-body -->
                                    </div>
                                    <!-- panel -->
                                </div>
                                <!-- col -->
                            </div>


    </div>

    <!-- Page Content Ends -->

    <!-- Footer -->
    <footer class="footer">
        2017 © Admina By Belavsky
    </footer>
    <!-- End Footer -->

</section>

</body>
</html>

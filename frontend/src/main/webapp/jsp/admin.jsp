<%--
  Created by IntelliJ IDEA.
  User: BigPc
  Date: 17.10.2017
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/jsp/blocks/header1.jsp"/>
</head>
<body>
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
                        <li class=""><a href="#profile" data-toggle="tab" aria-expanded="false">Создать</a>
                        </li>
                        <li class=""><a href="#messages" data-toggle="tab" aria-expanded="true">Добавить заявку</a>
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
                                                    <table id="All_studenttable1"
                                                           class="table table-striped table-bordered">
                                                        <thead>
                                                        <tr>
                                                            <th>Имя</th>
                                                            <th>Фамилия</th>
                                                            <th>Компания</th>
                                                            <th>Отдел</th>
                                                            <th>Университет</th>
                                                            <th>Факультет</th>
                                                            <th>Средний балл</th>
                                                            <th>Статус</th>
                                                        </tr>
                                                        </thead>

                                                        <tbody>
                                                        <tr>
                                                            <td>Костя</td>
                                                            <td>Новичек</td>
                                                            <td>Бипал</td>
                                                            <td>Дев-апс</td>
                                                            <td>БГУИР</td>
                                                            <td>ФКП</td>
                                                            <td>-3</td>
                                                            <td>На практике</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Жекич</td>
                                                            <td>Мекич</td>
                                                            <td>свайопредприятие</td>
                                                            <td>Дев-апс2.0</td>
                                                            <td>БГУИР</td>
                                                            <td>ФКП</td>
                                                            <td>10.5</td>
                                                            <td>На практике</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Путин</td>
                                                            <td>Йло</td>
                                                            <td>Раша</td>
                                                            <td>Отдел ввода пвойск</td>
                                                            <td>БГУ</td>
                                                            <td>КСиС</td>
                                                            <td>14/88</td>
                                                            <td>Ожидание</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Костя</td>
                                                            <td>Новичек</td>
                                                            <td>Бипал</td>
                                                            <td>Дев-апс</td>
                                                            <td>БГУИР</td>
                                                            <td>ФКП</td>
                                                            <td>-3</td>
                                                            <td>На практике</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Костя</td>
                                                            <td>Новичек</td>
                                                            <td>Бипал</td>
                                                            <td>Дев-апс</td>
                                                            <td>БГУИР</td>
                                                            <td>ФКП</td>
                                                            <td>-3</td>
                                                            <td>Ожидание</td>
                                                        </tr>

                                                        </tbody>
                                                    </table>

                                                </div>
                                                <div class="panel-body">
                                                    <button type="submit" class="btn btn-purple">
                                                        Удалить
                                                    </button>
                                                    <a href="#myModal" class="btn btn-primary" data-toggle="modal">Зачислить</a>
                                                    <!-- HTML-код модального окна-->
                                                    <div id="myModal1" class="modal fade">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <!-- Заголовок модального окна -->
                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                    <h4 class="modal-title">Зачисление на практику</h4>
                                                                </div>
                                                                <!-- Основное содержимое модального окна -->
                                                                <div class="modal-body">
                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <div class="panel panel-default">
                                                                                <div class="panel-heading">
                                                                                    <h3 class="panel-title" align="center">Назначение на практику</h3>
                                                                                </div>
                                                                                <div class="panel-body">
                                                                                    <form class="form-horizontal" role="form">
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Название практики</label>
                                                                                            <div class="col-md-10">
                                                                                                <input type="text" class="form-control" placeholder="Названиме">
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Название компании</label>
                                                                                            <div class="col-md-10">
                                                                                                <input type="text" class="form-control" placeholder="Компания">
                                                                                            </div>
                                                                                        </div>

                                                                                        <button type="submit" class="btn btn-purple">
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
                                            <h3 class="panel-title" align="center">Таблица всех заявок</h3>
                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-md-12 col-sm-12 col-xs-12">
                                                    <table id="All_requesttable1"
                                                           class="table table-striped table-bordered">
                                                        <thead>
                                                        <tr>
                                                            <th>Название практики</th>
                                                            <th>Компания</th>
                                                            <th>Отдел</th>
                                                            <th>Университет</th>
                                                            <th>Факультет</th>
                                                            <th>Средний балл</th>
                                                            <th>Количество мест</th>
                                                            <th>Набрано</th>
                                                        </tr>
                                                        </thead>

                                                        <tbody>
                                                        <tr>
                                                            <td>Java dev1</td>
                                                            <td>Бипал</td>
                                                            <td>Дев-апс</td>
                                                            <td>БГУИР</td>
                                                            <td>ФКП</td>
                                                            <td>-3</td>
                                                            <td>10</td>
                                                            <td>8</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Java dev2</td>
                                                            <td>свайопредприятие</td>
                                                            <td>Дев-апс2.0</td>
                                                            <td>БГУИР</td>
                                                            <td>ФКП</td>
                                                            <td>10.5</td>
                                                            <td>5</td>
                                                            <td>5</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Java dev3</td>
                                                            <td>Раша</td>
                                                            <td>Отдел ввода пвойск</td>
                                                            <td>БГУ</td>
                                                            <td>КСиС</td>
                                                            <td>14/88</td>
                                                            <td>15</td>
                                                            <td>5</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Java dev4</td>
                                                            <td>Бипал</td>
                                                            <td>Дев-апс</td>
                                                            <td>БГУИР</td>
                                                            <td>ФКП</td>
                                                            <td>-3</td>
                                                            <td>20</td>
                                                            <td>15</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Java dev5</td>
                                                            <td>Бипал</td>
                                                            <td>Дев-апс</td>
                                                            <td>БГУИР</td>
                                                            <td>ФКП</td>
                                                            <td>-3</td>
                                                            <td>25</td>
                                                            <td>25</td>
                                                        </tr>

                                                        </tbody>
                                                    </table>

                                                </div>
                                                <div class="panel-body">
                                                    <a href="#myModal" class="btn btn-primary" data-toggle="modal">Зачислить</a>
                                                    <!-- HTML-код модального окна-->
                                                    <div id="myModal" class="modal fade">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <!-- Заголовок модального окна -->
                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                    <h4 class="modal-title">Зачисление на практику</h4>
                                                                </div>
                                                                <!-- Основное содержимое модального окна -->
                                                                <div class="modal-body">
                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <div class="panel panel-default">
                                                                                <div class="panel-heading">
                                                                                    <h3 class="panel-title" align="center">Данные студента для зачисления</h3>
                                                                                </div>
                                                                                <div class="panel-body">
                                                                                    <form class="form-horizontal" role="form">
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Фамилия</label>
                                                                                            <div class="col-md-10">
                                                                                                <input type="text" class="form-control" placeholder="Фамидия">
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="form-group">
                                                                                            <label class="col-md-2 control-label">Имя</label>
                                                                                            <div class="col-md-10">
                                                                                                <input type="text" class="form-control" placeholder="Имя">
                                                                                            </div>
                                                                                        </div>

                                                                                        <button type="submit" class="btn btn-purple">
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
                                <div class="col-sm-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title" align="center">Личные данные</h3>
                                        </div>
                                        <div class="panel-body">
                                            <form class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Имя</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" placeholder="Имя">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Фамилия</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" placeholder="Фамилия">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label">Университет</label>
                                                    <div class="col-sm-10">
                                                        <select class="form-control">
                                                            <option>БГУИР</option>
                                                            <option>БГУ</option>
                                                            <option>БНТУ</option>
                                                            <option>БГАТУ</option>
                                                            <option>БТУ</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label">Факультет</label>
                                                    <div class="col-sm-10">
                                                        <select class="form-control">
                                                            <option>ФКП</option>
                                                            <option>ФКСиС</option>
                                                            <option>ФИТУ</option>
                                                            <option>ФРЭ</option>
                                                            <option>ИЭФ</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Номер группы</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" placeholder="Группа">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label">Форма обучения</label>
                                                    <div class="col-sm-10">
                                                        <select class="form-control">
                                                            <option>Платная</option>
                                                            <option>Бесплатная</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Средний балл</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" placeholder="Балл">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <h4 align="center">Дата рождения</h4>
                                                    <div class="input-group">
                                                        <input type="text" class="form-control" placeholder="mm/dd/yyyy"
                                                               id="datepicker">
                                                        <span class="input-group-addon"><i
                                                                class="glyphicon glyphicon-calendar"></i></span>
                                                    </div>
                                                </div>
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
                                            <h3 class="panel-title" align="center">Создать университет</h3>
                                        </div>
                                        <div class="panel-body">
                                            <form class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Название университета</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" placeholder="Название">
                                                    </div>
                                                </div>

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
                                            <h3 class="panel-title" align="center">Создать факультет</h3>
                                        </div>
                                        <div class="panel-body">
                                            <form class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Название факультета</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" placeholder="Название">
                                                    </div>
                                                </div>
                                                <button type="submit" class="btn btn-purple">
                                                    Применить
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="tab-pane fade " id="messages">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title" align="center">Добавить заяку</h3>
                                        </div>
                                        <div class="panel-body">
                                            <form class="form-horizontal" role="form">
                                                <h4 align="center">Личные данные руководителя практики</h4>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Имя</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" placeholder="Имя">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Фамилия</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" placeholder="Фамилия">
                                                    </div>
                                                </div>
                                                <h4 align="center">Данные о практике</h4>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Название практики</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" placeholder="Название">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Название предприятие</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control"
                                                               placeholder="Предприятие">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Название отдела</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" placeholder="Отдел">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label">Университет</label>
                                                    <div class="col-sm-10">
                                                        <select class="form-control">
                                                            <option>БГУИР</option>
                                                            <option>БГУ</option>
                                                            <option>БНТУ</option>
                                                            <option>БГАТУ</option>
                                                            <option>БТУ</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label">Факультет</label>
                                                    <div class="col-sm-10">
                                                        <select class="form-control">
                                                            <option>ФКП</option>
                                                            <option>ФКСиС</option>
                                                            <option>ФИТУ</option>
                                                            <option>ФРЭ</option>
                                                            <option>ИЭФ</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label">Количество студентов</label>
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control"
                                                               placeholder="Количество">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label">Минимальный средний
                                                        балл</label>
                                                    <div class="col-sm-10">
                                                        <select class="form-control">
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
                                                <button type="submit" class="btn btn-purple">
                                                    Применить
                                                </button>

                                            </form>
                                        </div>
                                        <!-- panel-body -->
                                    </div>
                                    <!-- panel -->
                                </div>
                                <!-- col -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

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

<%--
  Created by IntelliJ IDEA.
  User: BigPc
  Date: 14.10.2017
  Time: 19:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Страница преподавателя</title>
    <jsp:include page="/jsp/blocks/header1.jsp"/>
</head>
<body>
<aside class="left-panel">
    <img src="http://www.linko.co.il/wp-content/uploads/2015/05/businessman1-1.jpg" width="150"
         height="150" class="image_centre">
    <h5 align="center">a.belavsky97@gmail.com</h5>
    <h5 align="center">Статус: Преподователь</h5>
    <div class="form-group text-right">
        <div class="col-xs-12" align="center">
            <a href="/logout">
                <button class="btn btn-primary w-md">Выйти</button>
            </a>
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
                                    <label class="col-md-2 control-label">Название практики</label>
                                    <div class="col-md-10">
                                        <input type="text" class="form-control" placeholder="Название">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Название предприятие</label>
                                    <div class="col-md-10">
                                        <input type="text" class="form-control" placeholder="Предприятие">
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
                                        <input type="text" class="form-control" placeholder="Количество">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">Минимальный средний балл</label>
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
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title" align="center">Таблица зачисленных на практику</h3>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <table id="datatable" class="table table-striped table-bordered">
                                        <thead>
                                        <tr>
                                            <th>Имя</th>
                                            <th>Фамилия</th>
                                            <th>Компания</th>
                                            <th>Отдел</th>
                                            <th>Университет</th>
                                            <th>Факультет</th>
                                            <th>Средний балл</th>
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
                                        </tr>
                                        <tr>
                                            <td>Жекич</td>
                                            <td>Мекич</td>
                                            <td>свайопредприятие</td>
                                            <td>Дев-апс2.0</td>
                                            <td>БГУИР</td>
                                            <td>ФКП</td>
                                            <td>10.5</td>
                                        </tr>
                                        <tr>
                                            <td>Путин</td>
                                            <td>Йло</td>
                                            <td>Раша</td>
                                            <td>Отдел ввода пвойск</td>
                                            <td>БГУ</td>
                                            <td>КСиС</td>
                                            <td>14/88</td>
                                        </tr>
                                        <tr>
                                            <td>Костя</td>
                                            <td>Новичек</td>
                                            <td>Бипал</td>
                                            <td>Дев-апс</td>
                                            <td>БГУИР</td>
                                            <td>ФКП</td>
                                            <td>-3</td>
                                        </tr>
                                        <tr>
                                            <td>Костя</td>
                                            <td>Новичек</td>
                                            <td>Бипал</td>
                                            <td>Дев-апс</td>
                                            <td>БГУИР</td>
                                            <td>ФКП</td>
                                            <td>-3</td>
                                        </tr>

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!-- End Row -->

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

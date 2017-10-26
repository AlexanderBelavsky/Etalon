<%--
  Created by IntelliJ IDEA.
  User: BigPc
  Date: 14.10.2017
  Time: 22:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Страница студента</title>
    <jsp:include page="/jsp/blocks/header1.jsp"/>
</head>
<body>
<aside class="left-panel">
    <img src="http://www.linko.co.il/wp-content/uploads/2015/05/businessman1-1.jpg" width="150"
         height="150" class="image_centre">
    <h5  align="center">a.belavsky97@gmail.com</h5>
    <h5  align="center">Статус: Студент</h5>
    <div class="form-group text-right">
        <div class="col-xs-12" align="center">
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

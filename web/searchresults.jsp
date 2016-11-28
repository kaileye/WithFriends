<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  User: Yida Yuan
  Date: 11/27/16
  Time: 5:21 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/wfcss.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/wfscript.js"></script>
        <title>WithFriends</title>
    </head>
    <body>
        <c:if test="${loggedin == false || empty loggedin}">
            <c:redirect url="index.jsp"></c:redirect>
        </c:if>
        <jsp:useBean id="USER" scope="session" class="wf.userbean.User" />
        <% session.setAttribute("user", USER); %>

        <sql:setDataSource var="wfdb" driver="com.mysql.jdbc.Driver"
           url="jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false"
           user="cse305"  password="cse305"/>
        <%@ include file="navigation.jsp" %>
        <c:if test="${alreadyfriends == true}">
            <div class="container">
                <div class="alert alert-warning alert-dismissable">
                    You are already friends with this user.
                </div>
            </div>
        </c:if>
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="text-center">Search Results</h4>
                        </div>
                        <div class="panel-body">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>Firstname</th>
                                    <th>Lastname</th>
                                    <th>Sex</th>
                                    <th>Email</th>
                                    <th>Friend Request</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="re" items="${sresults}">
                                    <tr>
                                        <td>${re.firstname}</td>
                                        <td>${re.lastname}</td>
                                        <td>${re.sex}</td>
                                        <td>${re.email}</td>
                                        <td>
                                            <button class="btn btn-default friendbt" type="button" value="${re.userId}">
                                                <span class="glyphicon glyphicon-envelope"></span>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="frienddialog" class="dialog" title="Friend Request">
            <form action="friendrequest" method="POST">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">
                            <input type="hidden" name="sr" value="searchresults.jsp">
                            <input type="hidden" name="receiverid" id="receiverid" value="">
                            <textarea class="form-control" rows="5" cols="60" style="resize:none" maxlength="2000" name="content" placeholder="Message" required="required"></textarea> <br />
                            <button type="submit" class="btn pull-right">Send</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <script>
            $("#frienddialog").dialog({
                autoOpen: false,
                width: "auto"
            });

            $(".friendbt").click(function () {
                $("#frienddialog").dialog("open");
                $("#receiverid").attr('value', $(this).val());
            });
        </script>
    </body>
</html>

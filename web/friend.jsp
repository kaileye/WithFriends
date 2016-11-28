<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
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
        <%@ include file="navigation.jsp" %>
        <sql:setDataSource var="wfdb" driver="com.mysql.jdbc.Driver"
            url="jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false"
            user="cse305"  password="cse305"/>
        <sql:query dataSource="${wfdb}" var="friends">
        SELECT U.UserId, U.FirstName, U.LastName, U.Telephone FROM users U, usersfriends F WHERE F.UserId=${USER.userId} AND F.FriendId = U.UserId ORDER BY U.FirstName;
        </sql:query>
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="text-center">Friend Requests</h4>
                        </div>
                        <div class="panel-body">
                            Not implemented
                        </div>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="text-center">Friends</h4>
                        </div>
                        <div class="panel-body">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Friend</th>
                                        <th>Phone Number</th>
                                        <th>Message</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="friend" items="${friends.rows}">
                                    <tr>
                                        <td>${friend.FirstName} ${friend.LastName}</td>
                                        <td>${friend.Telephone}</td>
                                        <td><button class="btn btn-default messagesender" type="button" val="${friend.UserId}"><span class="glyphicon glyphicon-envelope"></span></button></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="messagedialog" class="dialog" title="Send Message">
            <form action="sendmessage" method="POST">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">
                            <input type="hidden" name="pg" value="friend.jsp">
                            <input type="hidden" name="receiverid" id="receiverid" value="">
                            <input type="text" class="form-control" name="subject" placeholder="Subject" required="required"></input><br />
                            <textarea class="form-control" rows="5" cols="60" style="resize:none" maxlength="2000" name="content" placeholder="Message" required="required"></textarea> <br />
                            <button type="submit" class="btn pull-right">Send</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <script>
        $("#messagedialog").dialog({
            autoOpen: false,
            width: "auto"
        });
        
        
        $(".messagesender").click(function () {
            $("#messagedialog").dialog("open");
            $("#receiverid").val($(this).val());
        });

        </script>
    </body>
</html>


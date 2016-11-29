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
        <c:if test="${loggedin == false || empty loggedin}">
            <c:redirect url="index.jsp"></c:redirect>
        </c:if>
        <%@ include file="navigation.jsp" %>
        <sql:setDataSource var="wfdb" driver="com.mysql.jdbc.Driver"
            url="jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false"
            user="cse305"  password="cse305"/>
        <sql:query dataSource="${wfdb}" var="messages">
            SELECT M.MessageId, U.FirstName, U.LastName, M.Subject, M.SentDateTime, M.Content
            FROM Messages M, Users U
            WHERE U.UserId=M.SenderId AND M.ReceiverId=${USER.userId};
        </sql:query>
        
        <div class="container">
            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="text-center">Inbox</h4>
                    </div>
                    <div class="panel-body">
                        <c:forEach var="msg" items="${messages.rows}">
                            <form action="deletemessage" method="POST">
                                <div class="well">
                                    <input type="hidden" name="pg" value="message.jsp">
                                    <input type="hidden" name="msgid" value="${msg.MessageId}">
                                    <strong class="pull-left primary-font">${msg.FirstName} ${msg.LastName}</strong>
                                    <small class="pull-right text-muted">${msg.SentDateTime}</small><br />
                                    <span><i>${msg.Subject}</i></span><br>
                                    <span>${msg.Content}</span><br>
                                    <button type="submit" class="btn pull-right">Delete</button>
                                </div>
                            </form>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

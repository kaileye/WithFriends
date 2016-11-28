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
        
        <div class="container">
            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="text-center">Inbox</h4>
                    </div>
                    <div class="panel-body">
                        <div class="well">
                            <span><b>Sender</b></span> <br />
                            <span><i>Subject</i></span> <br />
                            <span>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus feugiat rutrum imperdiet. Suspendisse urna justo, feugiat quis lectus vitae, feugiat sollicitudin lacus. Cras laoreet condimentum facilisis. Aliquam vel imperdiet purus, non cursus nibh. Vestibulum consectetur eros sit amet dui lobortis pharetra vitae ultricies nunc. Suspendisse potenti. Donec id tincidunt magna, eget tempor lacus. Donec in auctor mi, quis vestibulum justo. Aliquam vitae pharetra risus, vitae luctus dui. Curabitur ultricies pellentesque nisl, in dapibus odio auctor sed.</span> <br /><br />
                            <button class="btn btn-default" type="button">Delete</button>
                        </div>
                        <div class="well">
                            <span><b>Sender</b></span> <br />
                            <span><i>Subject</i></span> <br />
                            <span>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus feugiat rutrum imperdiet. Suspendisse urna justo, feugiat quis lectus vitae, feugiat sollicitudin lacus. Cras laoreet condimentum facilisis. Aliquam vel imperdiet purus, non cursus nibh. Vestibulum consectetur eros sit amet dui lobortis pharetra vitae ultricies nunc. Suspendisse potenti. Donec id tincidunt magna, eget tempor lacus. Donec in auctor mi, quis vestibulum justo. Aliquam vitae pharetra risus, vitae luctus dui. Curabitur ultricies pellentesque nisl, in dapibus odio auctor sed.</span> <br /><br />
                            <button class="btn btn-default" type="button">Delete</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

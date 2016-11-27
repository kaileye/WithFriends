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
        
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <button class="btn btn-default groupcreater" type="button">Create Group</button>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="text-center">Groups</h4>
                        </div>
                        <div class="panel-body">
                            Not implemented
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="groupcreationdialog" title="Create Group">
            <form action="creategroup" method="POST">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">
                            <input type="hidden" name="pg" value="group.jsp">
                            <input type="text" class="form-control" name="groupname" placeholder="Group name" required="required"></input><br />
                            <select name="grouptype" required="required">
                                <option value="friends">Friends</option>
                                <option value="club">Club</option>
                                <option value="organization">Organization</option>
                                <option value="other">Other</option>
                            </select>
                            <button type="submit" class="btn pull-right">Create</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <script>
        $("#groupcreationdialog").dialog({
            autoOpen: false,
            width: "auto"
        });
        
        
        $(".groupcreater").click(function () {
            $("#groupcreationdialog").dialog("open");
        });

        </script>
    </body>
</html> 

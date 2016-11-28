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
        <sql:query dataSource="${wfdb}" var="groups">
            SELECT G.* FROM groups G, groupsmembers M WHERE G.GroupId = M.GroupId AND M.UserId = ${USER.userId};
        </sql:query>
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="text-center">Group Invites</h4>
                        </div>
                        <div class="panel-body">
                            Not implemented
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <button class="btn btn-block groupcreater" type="button">Create Group</button>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="text-center">Groups</h4>
                        </div>
                        <div class="panel-body">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Group</th>
                                        <th>Group Page</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="group" items="${groups.rows}">
                                    <tr>
                                        <td>${group.GroupName}</td>
                                        <td><a href="grouppage?group=${group.GroupId}" class="btn btn-default" type="button"><span class="glyphicon glyphicon-log-in"></span></a></td>
                                        <td>
                                            <c:if test="${group.OwnerId != USER.userId}">
                                                <button class="btn btn-default" type="submit" title="Leave group" form="leavegroup">Leave</span</button>
                                            </c:if>
                                            <c:if test="${group.OwnerId == USER.userId}">
                                                <button class="btn btn-default grouprenamer" type="submit" title="Rename group" value="${group.GroupId}">Rename</button>
                                                <button class="btn btn-default" type="submit" title="Delete group" form="deletegroup">Delete</span</button>
                                                <form action="deletegroup" method="POST" id="deletegroup">
                                                    <input type="hidden" name="pg" value="group.jsp">
                                                    <input type="hidden" name="groupid" value="${group.GroupId}">
                                                </form>
                                            </c:if>
                                            <form action="leavegroup" method="POST" id="leavegroup">
                                                <input type="hidden" name="pg" value="group.jsp">
                                                <input type="hidden" name="groupid" value="${group.GroupId}">
                                            </form>
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
        <div id="groupcreationdialog" class="dialog" title="Create Group">
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
        <div id="grouprenamedialog" class="dialog" title="Rename Group">
            <form action="renamegroup" method="POST">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">
                            <input type="hidden" name="pg" value="group.jsp">
                            <input type="hidden" name="groupid" class="groupid" value="">
                            <input type="text" class="form-control" name="groupname" placeholder="Group name" required="required"></input><br />
                            <button type="submit" class="btn pull-right">Rename</button>
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

        $("#grouprenamedialog").dialog({
            autoOpen: false,
            width: "auto"
        });
        
        
        $(".grouprenamer").click(function () {
            $("#grouprenamedialog").dialog("open");
            $(".groupid").val($(this).val());
        });
        </script>
    </body>
</html> 

<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
        
<html lang="en">
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
        <jsp:useBean id="USER" scope="session" class="wf.userbean.User" />
        <% session.setAttribute("user", USER); %>
        
        <sql:setDataSource var="wfdb" driver="com.mysql.jdbc.Driver"
            url="jdbc:mysql://localhost:3306/withfriends?autoReconnect=true&useSSL=false"
            user="cse305"  password="cse305"/>
        
        <c:if test="${loggedin == false || empty loggedin}">
            <br /><br />
            <div class="align-center">
                <img src="images/logo.png" height="20%" width="20%">
            </div>
            <form action="login" method="POST">
                <div class="container">
                    <div class="row">
                        <div class="form_bg">
                            <h2 class="text-center">Please sign in</h2>
                            <br/>
                            <div class="form-group">
                                <input type="email" class="form-control" id="uname" name="username" placeholder="Email">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" id="pwd" name="password" placeholder="Password">
                            </div>
                            <c:if test="${validlogin == false}">
                                <span id="loginInvalid" style="color:red; font-size:12px">The information you entered is incorrect</span>
                            </c:if>
                            <c:if test="${validlogin == true || empty validlogin}">
                                <br />
                            </c:if>
                            <div class="align-center">
                                <button type="submit" class="btn btn-default" id="login">Log In</button>
                            </div>
                            <a href="register.jsp">Register</a>
                        </div>
                    </div>
                </div>
            </form>
        </c:if>
        <c:if test="${loggedin == true}">
            <%@ include file="navigation.jsp" %>
            <div class="container">
                <div class="row">
                    <div class="col-sm-4" class="form-control custom-control">
                        <form action="post" method="POST">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="form-group">
                                        <input type="hidden" name="pg" value="index.jsp">
                                        <textarea class="form-control" rows="5" cols="60" style="resize:none" maxlength="2000" name="content" placeholder="What's on your mind?"></textarea> <br />
                                        <button type="submit" class="btn pull-right">Post</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-sm-8" class="form-control custom-control">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="text-center">News Feed</h4>
                            </div>
                            <div class="panel-body">
                                <sql:query dataSource="${wfdb}" var="posts">
                                SELECT DISTINCT P.* from posts P, usersfriends U WHERE P.posterId=${USER.userId} OR (U.UserId=${USER.userId} AND U.FriendId=P.PosterId) ORDER BY PostDateTime DESC LIMIT 30;
                                </sql:query>
                                <c:forEach var="post" items="${posts.rows}">
                                    <div class="well">
                                        <strong class="pull-left primary-font">${post.PosterName}</strong>
                                        <small class="pull-right text-muted">
                                            <span class="glyphicon glyphicon-time"></span>${post.PostDateTime}
                                                <c:if test="${post.PosterId == USER.userId}">
                                                    <span class="dropdown">
                                                        <span class="caret" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"></span>
                                                        <ul class="dropdown-menu">
                                                            <li><button class="btn btn-link postediter" type="button" style="color:black" value="${post.PostId}">Edit</button></li>
                                                            <form action="deletepost" method="POST">
                                                                <input type="hidden" name="post" value="${post.PostId}">
                                                                <input type="hidden" name="pg" value="index.jsp">
                                                                <li><button class="btn btn-link" type="submit" style="color:black">Delete</button></li>
                                                            </form>
                                                        </ul>
                                                    </span>
                                                </c:if>
                                        </small>
                                        <br />
                                        ${post.Content}
                                        <br />
                                        <div class="btn-group btn-group-xs" role="group">
                                            <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-thumbs-up"></span></button>
                                            <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-thumbs-down"></span></button>
                                            <button class="btn btn-default" type="button">0</button>
                                        </div>
                                        <br /><br />
                                        <form action="comment" method="POST">
                                            <div class="input-group">
                                                <input type="hidden" name="pg" value="index.jsp">
                                                <input type="hidden" name="post" value="${post.PostId}">
                                                <input type="text" name="comment" class="form-control input-sm chat-input" placeholder="Write your message here..." />
                                                <span class="input-group-btn">     
                                                    <button type="submit" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-comment"></span> Add Comment</button>
                                                </span> 
                                            </div>
                                        </form>
                                        <br />
                                        <sql:query dataSource="${wfdb}" var="comments">
                                        SELECT * from comments WHERE PostId=${post.PostId} ORDER BY PostDateTime LIMIT 30;
                                        </sql:query>
                                        <ul class="list-unstyled">
                                            <c:forEach var="comment" items="${comments.rows}">
                                                <strong class="pull-left primary-font">${comment.PosterName}</strong>
                                                <small class="pull-right text-muted">
                                                    <span class="glyphicon glyphicon-time"></span>${comment.PostDateTime}
                                                    <c:if test="${comment.PosterId == USER.userId}">
                                                        <span class="dropdown">
                                                            <span class="caret" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"></span>
                                                            <ul class="dropdown-menu">
                                                                <li><button class="btn btn-link commentediter" type="button" style="color:black" value="${comment.CommentId}">Edit</button></li>
                                                                <form action="deletecomment" method="POST">
                                                                    <input type="hidden" name="pg" value="index.jsp">
                                                                    <input type="hidden" name="comment" value="${comment.CommentId}">
                                                                    <li><button class="btn btn-link" type="submit" style="color:black">Delete</button></li>
                                                                </form>
                                                            </ul>
                                                        </span>
                                                    </c:if>
                                                </small>
                                                <br />
                                                <li>${comment.Content}</li>
                                                <div class="btn-group btn-group-xs" role="group">
                                                    <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-thumbs-up"></span></button>
                                                    <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-thumbs-down"></span></button>
                                                    <button class="btn btn-default" type="button">0</button>
                                                </div>
                                                <br /><br />
                                            </c:forEach>
                                        </ul><div class="clearer"></div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        
        <div id="postdialog" title="Edit Post">
            <form action="editpost" method="POST">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">
                            <input type="hidden" name="pg" value="index.jsp">
                            <input type="hidden" name="post" id="postid" value="">
                            <textarea class="form-control" rows="5" cols="60" style="resize:none" maxlength="2000" name="content"></textarea> <br />
                            <button type="submit" class="btn pull-right">Edit</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
      
        <div id="commentdialog" title="Edit Comment">
            <form action="editcomment" method="POST">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">
                            <input type="hidden" name="pg" value="index.jsp">
                            <input type="hidden" name="comment" id="commentid" value="">
                            <textarea class="form-control" rows="5" cols="60" style="resize:none" maxlength="2000" name="content"></textarea> <br />
                            <button type="submit" class="btn pull-right">Edit</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <script>
        $("#postdialog").dialog({
            autoOpen: false,
            width: "auto"
        });
        
        $("#commentdialog").dialog({
            autoOpen: false,
            width: "auto"
        });

        $(".postediter").click(function () {
            $("#postdialog").dialog("open");
            $("#postid").val($(this).val());
        });

        $(".commentediter").click(function () {
            $("#commentdialog").dialog("open");
            $("#commentid").val($(this).val());
        });
        </script>
    </body>
</html>
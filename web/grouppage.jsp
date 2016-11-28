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
        <sql:query dataSource="${wfdb}" var="groups">
            SELECT * FROM groups WHERE GroupId=${groupid};
        </sql:query>

        <c:if test="${member == false}">
            <div class="container">
                <div class="alert alert-danger">
                    You do not have permission to view this group page
                </div>
            </div>
        </c:if>
        <c:if test="${member == true}">
            <div class="container">
                <div class="row">
                    <div class="col-sm-4" class="form-control custom-control">
                        <form action="post" method="POST">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="form-group">
                                        <input type="hidden" name="pg" value="grouppage?group=${groupid}">
                                        <input type="hidden" name="pagetype" value="group">
                                        <input type="hidden" name="groupid" value="${groupid}">
                                        <textarea class="form-control" rows="5" cols="60" style="resize:none" maxlength="2000" name="content" placeholder="What's on your mind?" required="required"></textarea> <br />
                                        <button type="submit" class="btn pull-right">Post</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-sm-8" class="form-control custom-control">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="text-center">
                                    <c:forEach var="group" items="${groups.rows}">
                                      ${group.GroupName}
                                    </c:forEach>
                                </h4>
                            </div>
                            <div class="panel-body">
                                <sql:query dataSource="${wfdb}" var="posts">
                                SELECT * FROM posts WHERE PageId=${pageid} ORDER BY PostDateTime DESC LIMIT 30;
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
                                                                <input type="hidden" name="pg" value="grouppage?group=${groupid}">
                                                                <li><button class="btn btn-link" type="submit" style="color:black">Delete</button></li>
                                                            </form>
                                                        </ul>
                                                    </span>
                                                </c:if>
                                        </small>
                                        <br />
                                        ${post.Content}
                                        <br />
                                        <form action="likepost" method="POST">
                                            <div class="btn-group btn-group-xs" role="group">
                                                <input type="hidden" name="post" value="${post.PostId}">
                                                <input type="hidden" name="pg" value="grouppage?group=${groupid}">
                                                <c:if test="${plikes.rows.PostId eq post.PostId && plikes.rows.Opinion eq 'like'}">waoo</c:if>
                                                <button class="btn btn-default" type="submit" name="likepost" value="like"><span class="glyphicon glyphicon-thumbs-up"></span></button>
                                                <button class="btn btn-default" type="submit" name="likepost" value="unlike"><span class="glyphicon glyphicon-thumbs-down"></span></button>
                                                <button class="btn btn-default" type="button">${post.Likes}</button>
                                            </div>
                                        </form>
                                        <br /><br />
                                        <form action="comment" method="POST">
                                            <div class="input-group">
                                                <input type="hidden" name="pg" value="grouppage?group=${groupid}">
                                                <input type="hidden" name="post" value="${post.PostId}">
                                                <input type="text" name="comment" class="form-control input-sm chat-input" placeholder="Write your message here..." required="required"/>
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
                                                                    <input type="hidden" name="pg" value="grouppage?group=${groupid}">
                                                                    <input type="hidden" name="comment" value="${comment.CommentId}">
                                                                    <li><button class="btn btn-link" type="submit" style="color:black">Delete</button></li>
                                                                </form>
                                                            </ul>
                                                        </span>
                                                    </c:if>
                                                </small>
                                                <br />
                                                <li>${comment.Content}</li>
                                                <form action="likecomment" method="POST">
                                                    <div class="btn-group btn-group-xs" role="group">
                                                        <input type="hidden" name="comment" value="${comment.CommentId}">
                                                        <input type="hidden" name="pg" value="grouppage?group=${groupid}">
                                                        <button class="btn btn-default" type="submit" name="likecomment" value="like"><span class="glyphicon glyphicon-thumbs-up"></span></button>
                                                        <button class="btn btn-default" type="submit" name="likecomment" value="unlike"><span class="glyphicon glyphicon-thumbs-down"></span></button>
                                                        <button class="btn btn-default" type="button">${comment.Likes}</button>
                                                    </div>
                                                </form>
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
            
        <div id="postdialog" class="dialog" title="Edit Post">
            <form action="editpost" method="POST">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">
                            <input type="hidden" name="pg" value="grouppage?group=${groupid}">
                            <input type="hidden" name="post" id="postid" value="">
                            <textarea class="form-control" rows="5" cols="60" style="resize:none" maxlength="2000" name="content" required="required"></textarea> <br />
                            <button type="submit" class="btn pull-right">Edit</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
      
        <div id="commentdialog" class="dialog" title="Edit Comment">
            <form action="editcomment" method="POST">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">
                            <input type="hidden" name="pg" value="grouppage?group=${groupid}">
                            <input type="hidden" name="comment" id="commentid" value="">
                            <textarea class="form-control" rows="5" cols="60" style="resize:none" maxlength="2000" name="content" required="required"></textarea> <br />
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

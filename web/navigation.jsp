<nav class="navbar navbar-inverse navbar-static-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.jsp"><span class="glyphicon glyphicon-home"></span> WithFriends</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
            </ul> 
            <div class="col-sm-3 col-md-3">
                <form class="navbar-form" action="search">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Find friends" name="q">
                        <div class="input-group-btn">
                            <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                        </div>
                    </div>
                </form>
            </div>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="managers.jsp">Managers</a></li>
                <li><a href="friend.jsp">Friends</a></li>
                <li><a href="group.jsp">Groups</a></li>
                <li><a href="message.jsp">Messages</a><li>
                <li><a href="advertisement.jsp">Merchandise</a></li>
                <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-user"> ${USER.firstname} <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="logout">Log Out</a></li>
                        </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>WebBoard</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Web Board</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">Main</a></li>
				<li><a href="wb.jsp">Board</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
						접속하기<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li class="active"><a href="index.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
		<div class="container">
			<div class="col-lg-4">
				<div class="jumbotron" style="padding-top:20px;">
					<form method="post" action="joinAction.jsp">
						<h3 style="text-align:center;">Join</h3>
						<div class="form-group">
							<input type="text" class="form-control" name="userID" maxlength="20" placeholder="ID"/>
						</div>
						<div class="form-group">
							<input type="password" class="form-control" name="userPassword" maxlength="20" placeholder="Password"/>
						</div>
						<div class="form-group">
							<input type="text" class="form-control" name="userName" maxlength="20" placeholder="Name"/>
						</div>
						<div class="form-group" style="text-align:center;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary active">
									<input type="radio" name="userGender" autocomplete="off" value="Male" checked>Male
								</label>
								<label class="btn btn-primary active">
									<input type="radio" name="userGender" autocomplete="off" value="Female" checked>Female
								</label>
							</div>
						</div>
						<div class="form-group">
							<input type="email" class="form-control" placeholder="Email" name="userEmail" maxlength="20">
						</div>
						<input type="submit" class="btn btn-primary form-control" value="Join"/>
					</form>
				</div>
			</div>
		</div>
	</nav>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<!-- <script>location.href="login.jsp"</script> -->
</body>
</html>
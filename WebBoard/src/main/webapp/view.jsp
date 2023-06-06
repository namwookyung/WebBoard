<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="wb.Wb" %>
<%@ page import="wb.WbDAO" %>
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
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		
		// wbID를 초기화 시키고
		// 'wbID'라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
		int wbID = 0;
		if(request.getParameter("wbID") != null) {
			wbID = Integer.parseInt(request.getParameter("wbID"));
		}
		
		// 만약 넘어온 데이터가 없다면
		if(wbID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='wb.jsp'");
			script.println("</script>");
		}
		
		// 유효한 글이라면 구체적인 정보를 'wb' 라는 인스턴스에 담는다.
		Wb wb = new WbDAO().getWb(wbID);
	%>
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
				<li class="active"><a href="wb.jsp">Board</a></li>
			</ul>
			<%
				// 로그인 하지 않았을 때 보여지는 화면
				if(userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
						접속하기<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="index.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				// 로그인이 되어있는 상태에서 보여주는 화면
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
						회원 관리<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="logoutAction.jsp">로그아웃</a>
						</li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:20%;">글 제목</td>
						<td colspan="2">
							<%= wb.getWbTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
						</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= wb.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2">
							<%= wb.getWbDate().substring(0, 11) + wb.getWbDate().substring(11, 13) + "시"
							+ wb.getWbDate().substring(14, 16) + "분" %>
						</td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="height: 200px; text-align: left;">
							<%= wb.getWbContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
							.replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
						</td>
					</tr>
				</tbody>
			</table>
			<a href="wb.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(wb.getUserID())) {
			%>
				<a href="update.jsp?wbID=<%= wbID %>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')"
					href="deleteAction.jsp?wbID=<%= wbID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
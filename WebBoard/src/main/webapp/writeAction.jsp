<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="wb.WbDAO" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="wb" class="wb.Wb" scope="page" />
<jsp:setProperty name="wb" property="wbTitle" />
<jsp:setProperty name="wb" property="wbContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebBoard</title>
</head>
<body>
	<%
		// 현재 세션 상태 체크
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		
		// 로그인을 한 사람만 글을 작성할 수 있도록 함
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} else {
			// 입력되지 않은 사항 유무 체크
			if(wb.getWbTitle() == null || wb.getWbContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				// 정상적으로 입력되었다면 글 작성 로직 수행
				WbDAO wbDAO = new WbDAO();
				int result = wbDAO.write(wb.getWbTitle(), userID, wb.getWbContent());
				// 데이터베이스 오류인 경우
				if(result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 작성을 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				// 글 작성이 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기 성공')");
					script.println("location.href='wb.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>
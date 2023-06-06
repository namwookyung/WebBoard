<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="wb.WbDAO" %>
<%@ page import="wb.Wb" %>
<% request.setCharacterEncoding("utf-8"); %>
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
		}
		
		int wbID = 0;
		if(request.getParameter("wbID") != null) {
			wbID = Integer.parseInt(request.getParameter("wbID"));
		}
		if(wbID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='wb.jsp'");
			script.println("</script>");
		}
		// 해당 'wbID'에 대한 게시글을 가져온 다음 세션을 통하여 작성자 본인이 맞는지 체크함
		Wb wb = new WbDAO().getWb(wbID);
		if(!userID.equals(wb.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='wb.jsp'");
			script.println("</script>");
		} else {
			// 입력되지 않았거나 빈 값 유무 체크
			if(request.getParameter("wbTitle") == null || request.getParameter("wbContent") == null || request.getParameter("wbTitle").equals("") || request.getParameter("wbContent").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				// 정상적으로 입력이 되었다면 글 수정 로직을 수행함
				WbDAO wbDAO = new WbDAO();
				int result = wbDAO.update(wbID, request.getParameter("wbTitle"), request.getParameter("wbContent"));
				// 데이터베이스 오류인 경우
				if(result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정하기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				// 글 수정이 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동함
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정하기 성공')");
					script.println("location.href='wb.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>
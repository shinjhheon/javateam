<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="hbbs.hBbs" %>
<%@ page import="hbbs.hBbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="hbbs" class="hbbs.hBbs" scope="page" />
<jsp:setProperty name="hbbs" property="hbbsTitle" />
<jsp:setProperty name="hbbs" property="hbbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset-UTF-8"> 
<link rel="stylesheet" href="css/bootstrap.css">
<title>E-러닝 게시판 웹 사이트</title>
</head>
<body>
	<%
	// 현재 세션 상태를 체크한다.
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다.
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'Newlogin.jsp'");
		script.println("</script>");
	} else{
		// 입력이 안된 부분이 있는지 체크
		if (hbbs.getHbbsTitle() == null || hbbs.getHbbsContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			// 정장적으로 입력이 되었다면 글쓰기를 수행.
			hBbsDAO hbbsDAO = new hBbsDAO();
			int result = hbbsDAO.write(hbbs.getHbbsTitle(), userID, hbbs.getHbbsContent());
			// 데이터베이스 오류인 경우
			if (result == -1) {
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			// 글쓰기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='vvs.jsp'");
				script.println("</script>");
			}
		}
	}

	%>
</body>
</html>
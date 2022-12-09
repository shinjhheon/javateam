<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="hbbs.hBbsDAO" %>
<%@ page import="hbbs.hBbs" %>
<%@ page import="java.util.ArrayList" %>
<!doctype html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, 그리고 Bootstrap 기여자들">
    <meta name="generator" content="Hugo 0.104.2">
    <title>E-러닝 게시판</title>
    

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }
      
      .element.style {
}
		@media (max-width: 1780px)
		.mVisualWrap .topTxt {
		    padding: 60px 3vw;
		}
		.mVisualWrap .topTxt {
		    position: relative;
		    display: flex;
		    display: -ms-flex;
		    padding: 80px;
		    height: 500px;
		    float: right;
		    width: 36%;
		    color: #fff;
		    z-index: 1;
		}
    </style>

    
    <!-- Custom styles for this template -->
    <link href="css/dashboard.css" rel="stylesheet">
  </head>
  <body>
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		// bbsID를 초기화 시키고
		// bbsID라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다.
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));		
		}
		
		// 넘어온 데이터가 없다면.
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href= 'vvs.jsp'");
			script.println("</script>");
		}
		
		// 유효한 글이라면 구체적인 정보를 'bbs'라는 객체에 저장한다.
		hBbs hbbs = new hBbsDAO().gethbbs(bbsID);
	%>
<header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
  <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-6" href="main.jsp">E-러닝 게시판</a>
  <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <input class="form-control form-control-dark w-100 rounded-0 border-0" type="text" placeholder="Search" aria-label="Search">
  <div class="navbar-nav">
    <div class="nav-item text-nowrap">
    <%
				if(userID == null)	// 로그인 X
				{
			%>
			<%-- 드랍다운 메뉴 --%>
      <a class="nav-link px-3" href="Newlogin.jsp">Sign in</a>
			<%
				} else				// 로그인 O
				{
			%>
			<%-- 드랍다운 메뉴 --%>
      <a class="nav-link px-3" href="logoutAction.jsp">Log out</a>
			<% 		
				}
			%>
    </div>
  </div>
</header>

<div class="container-fluid">
  <div class="row">
    <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
    
      <div class="position-sticky pt-3 sidebar-sticky">
        <ul class="nav flex-column">
          <li class="nav-item">
            <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted text-uppercase">
          <span>학과 정보</span>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="vvs.jsp">
            <i class="bi-alarm"></i>
              <span data-feather="file" class="align-text-bottom"></span>
              공지사항
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">
            <i class="bi bi-alarm-fill"></i>
              <span data-feather="shopping-cart" class="align-text-bottom"></span>
              공모전 및 경진대회 안내
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">
            <i class="bi bi-bell"></i>
              <span data-feather="users" class="align-text-bottom"></span>
              학과 취업 공지사항
            </a>
          </li>
        </ul>

        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted text-uppercase">
          <span>Study Category</span>
          <a class="link-secondary" href="#" aria-label="Add a new report">
            <span data-feather="plus-circle" class="align-text-bottom"></span>
          </a>
        </h6>
        <ul class="nav flex-column mb-2">
          <li class="nav-item">
            <a class="nav-link" href="Javavvs.jsp">
            <i class="bi bi-file-earmark-text"></i>
              <span data-feather="file-text" class="align-text-bottom"></span>
              Java Language
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="cbbs.jsp">
            <i class="bi bi-file-earmark-text"></i>
              <span data-feather="file-text" class="align-text-bottom"></span>
              C# Language
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="jascbbs.jsp">
            <i class="bi bi-file-earmark-text"></i>
              <span data-feather="file-text" class="align-text-bottom"></span>
              JavaScript
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="htmlbbs.jsp">
            <i class="bi bi-file-earmark-text"></i>
              <span data-feather="file-text" class="align-text-bottom"></span>
              HTML+CSS
            </a>
          </li>
        </ul>
      </div>
    </nav>

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h2>Java Language</h2>
      </div>
      
<!-- 게시판 글보기 양식 영역 시작 -->
	<div class="container-fluid">
		<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글제목</td>
							<td colspan="2"><%= hbbs.getHbbsTitle().replaceAll(" ", "&nbsp;")
									.replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%= hbbs.getUserID() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%= hbbs.getHbbsDate().substring(0,11) + hbbs.getHbbsDate().substring(11,13) + "시" + hbbs.getHbbsDate().substring(14,16) + "분 "%></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="height: 200px; text-align: Left"><%= hbbs.getHbbsContent().replaceAll(" ", "&nbsp;")
							.replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%></td>
						</tr>
					</tbody>
				</table>

		</div>
	</div>
					<!-- 목록 버튼 생성 -->
				<a href="htmlbbs.jsp" class="btn btn-dark pull-right">목록</a>
				
				<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
				<%
					if(userID != null && userID.equals(hbbs.getUserID())){
				%>
					<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-dark pull-right">수정</a>
					<a href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-dark pull-right">삭제</a>
				<%
					}
				%>
				</main></div>
</div>


    

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" crossorigin="anonymous"></script>
  </body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>E-러닝 게시판 웹 사이트</title>
<link rel="canonical" href="https://getbootstrap.kr/docs/5.2/examples/dashboard/">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">


<link rel="apple-touch-icon" href="/docs/5.2/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.2/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.2/assets/img/favicons/safari-pinned-tab.svg" color="#712cf9">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#712cf9">
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
 <link href="css/dashboard.css" rel="stylesheet">
</head>
<body>
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1; // 기본은 1 페이지를 할당
		// 만약 파라미터로 넘어온 오브젝트 타입 'PageNumber'가 존재한다면
		// 'int'타입으로 캐스팅을 해주고 그 값을 'pageNumber' 변수에 저장한다.
		if(request.getParameter("pageNumber")!= null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
            <a class="nav-link" href="Contestvvs.jsp">
            <i class="bi bi-alarm-fill"></i>
              <span data-feather="shopping-cart" class="align-text-bottom"></span>
              공모전 및 경진대회 안내
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="jobvvs.jsp">
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
         <h2>공모전 및 경진대회 안내</h2>
      </div>
	<div class = "container-fluid">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO(); // 객체 생성
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<!--  게시글 제목을 누르면 해당 글을 볼 수 있도록 링크를 건다. -->
						<td><a href = "view.jsp?bbsID=<%= list.get(i).getBbsID() %>">
							<%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;")
									.replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13) + "시" + list.get(i).getBbsDate().substring(14,16) + "분 " %></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<!-- 페이징 처리 영역 -->
			<%
				if(pageNumber != 1){
			%>
				<a href="vvs.jsp?pageNumber=<%=pageNumber-1 %>"
					class="btn btn-succes btn-arraw-left">이전</a>
			<%
				}
			%>
			
			<% 
				if(bbsDAO.nextPage(pageNumber + 1)){
			%>
				<a href="vvs.jsp?pageNumber=<%=pageNumber + 1%>"
					class="btn btn-success btn-arraw-Left">다음</a>
			<%
				}
			%>
		</div>
		<!-- 글쓰기 버튼 생성 -->	
		<a href="write.jsp" class="btn btn-dark pull-right">글쓰기</a>
	</div>	
	<!-- 게시판 메인 페이지 영역 끝 -->
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https:code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>
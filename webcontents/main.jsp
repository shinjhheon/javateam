<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!doctype html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, 그리고 Bootstrap 기여자들">
    <meta name="generator" content="Hugo 0.104.2">
    <title>Dashboard Template · Bootstrap v5.2</title>

    <link rel="canonical" href="https://getbootstrap.kr/docs/5.2/examples/dashboard/">

    

    
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

    <!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.2/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.2/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.2/assets/img/favicons/safari-pinned-tab.svg" color="#712cf9">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#712cf9">


	<%
		String userID = null;	// 로그인을 안 한 사람이라면 null 값
		if (session.getAttribute("userID") != null)	// 로그인을 한 사람이라면 값 유지
		{
			userID = (String) session.getAttribute("userID");
		}
	%>


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
    
<header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
  <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-6" href="#">E-러닝 게시판</a>
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
              java Language
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
        <h2>E-러닝 게시판</h2>
      </div>
      <div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="https://computer.deu.ac.kr/_res/deu/computer/img/m_visual1.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="https://computer.deu.ac.kr/_res/deu/computer/img/m_visual2.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="https://computer.deu.ac.kr/_res/deu/computer/img/m_visual3.jpg" class="d-block w-100" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
</div>

					<h2>Section title</h2>
					<div class="table-responsive">
						<table class="table table-striped table-sm">
							<thead>
								<tr>
									<th scope="col">#</th>
									<th scope="col">Header</th>
									<th scope="col">Header</th>
									<th scope="col">Header</th>
									<th scope="col">Header</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1,001</td>
									<td>random</td>
									<td>data</td>
									<td>placeholder</td>
									<td>text</td>
								</tr>
								<tr>
									<td>1,002</td>
									<td>placeholder</td>
									<td>irrelevant</td>
									<td>visual</td>
									<td>layout</td>
								</tr>
								<tr>
									<td>1,003</td>
									<td>data</td>
									<td>rich</td>
									<td>dashboard</td>
									<td>tabular</td>
								</tr>
								<tr>
									<td>1,003</td>
									<td>information</td>
									<td>placeholder</td>
									<td>illustrative</td>
									<td>data</td>
								</tr>
								<tr>
									<td>1,004</td>
									<td>text</td>
									<td>random</td>
									<td>layout</td>
									<td>dashboard</td>
								</tr>
								<tr>
									<td>1,005</td>
									<td>dashboard</td>
									<td>irrelevant</td>
									<td>text</td>
									<td>placeholder</td>
								</tr>
								<tr>
									<td>1,006</td>
									<td>dashboard</td>
									<td>illustrative</td>
									<td>rich</td>
									<td>data</td>
								</tr>
								<tr>
									<td>1,007</td>
									<td>placeholder</td>
									<td>tabular</td>
									<td>information</td>
									<td>irrelevant</td>
								</tr>
								<tr>
									<td>1,008</td>
									<td>random</td>
									<td>data</td>
									<td>placeholder</td>
									<td>text</td>
								</tr>
								<tr>
									<td>1,009</td>
									<td>placeholder</td>
									<td>irrelevant</td>
									<td>visual</td>
									<td>layout</td>
								</tr>
								<tr>
									<td>1,010</td>
									<td>data</td>
									<td>rich</td>
									<td>dashboard</td>
									<td>tabular</td>
								</tr>
								<tr>
									<td>1,011</td>
									<td>information</td>
									<td>placeholder</td>
									<td>illustrative</td>
									<td>data</td>
								</tr>
								<tr>
									<td>1,012</td>
									<td>text</td>
									<td>placeholder</td>
									<td>layout</td>
									<td>dashboard</td>
								</tr>
								<tr>
									<td>1,013</td>
									<td>dashboard</td>
									<td>irrelevant</td>
									<td>text</td>
									<td>visual</td>
								</tr>
								<tr>
									<td>1,014</td>
									<td>dashboard</td>
									<td>illustrative</td>
									<td>rich</td>
									<td>data</td>
								</tr>
								<tr>
									<td>1,015</td>
									<td>random</td>
									<td>tabular</td>
									<td>information</td>
									<td>text</td>
								</tr>
							</tbody>
						</table>
					</div>
				</main></div>
</div>


    

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" crossorigin="anonymous"></script>
  </body>
</html>

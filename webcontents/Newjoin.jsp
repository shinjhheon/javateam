<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.io.PrintWriter" %>

<!doctype html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, 그리고 Bootstrap 기여자들">
    <meta name="generator" content="Hugo 0.104.2">
    <title>로그인 화면</title>

<link href="https://getbootstrap.kr/docs/5.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

    <!-- Favicons -->
<link rel="apple-touch-icon" href="https://getbootstrap.kr/docs/5.2/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="https://getbootstrap.kr/docs/5.2/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="https://getbootstrap.kr/docs/5.2/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="https://getbootstrap.kr/docs/5.2/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="https://getbootstrap.kr/docs/5.2/assets/img/favicons/safari-pinned-tab.svg" color="#712cf9">
<link rel="icon" href="https://getbootstrap.kr/docs/5.2/assets/img/favicons/favicon.ico">
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
    </style>
    

    <!-- Custom styles for this template -->
    <link href="css/signin.css" rel="stylesheet">
  </head>
    <body class="text-center">  
<main class="form-signin w-100 m-auto">
  <form method = "post" action="joinAction.jsp">
    <img class="mb-4" src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/NYCS-bull-trans-E.svg/113px-NYCS-bull-trans-E.svg.png" alt="" width="72" height="72">
    <h1 class="h3 mb-3 fw-normal">Please join us</h1>

    <div class="form-floating mb-3">
      <input type="text" class="form-control" id="floatingInput" placeholder="name@example.com" name="userID" maxlength="20">
      <label for="floatingInput">ID</label>
    </div>
    <div class="form-floating mb-3">
      <input type="text" class="form-control" id="floatingPassword" placeholder="Password" name="userPassword" maxlength="20">
      <label for="floatingPassword">Password</label>
    </div>
    
    <div class="form-floating mb-3">
      <input type="text" class="form-control" id="floatingPassword" placeholder="Password" name="userName" maxlength="20">
      <label for="floatingPassword">Name</label>
    </div>
    
    <div class="form-floating mb-3">
      <input type="text" class="form-control" id="floatingPassword" placeholder="Password" name="userEmail" maxlength="20">
      <label for="floatingPassword">Email address</label>
    </div>
    
    <button class="w-100 btn btn-lg btn-primary mb-3" type="submit">회원 가입</button>
    <button class="w-100 btn btn-lg btn-primary" type="button" onclick="location.href='main.jsp'">메인 화면</button>
    <p class="mt-5 mb-3 text-muted">&copy; E-러닝 게시판</p>
  </form>
</main>

    
  </body>
</html>

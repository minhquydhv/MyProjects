<%-- 
    Document   : test
    Created on : Aug 2, 2015, 4:16:08 PM
    Author     : quang quy

--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <!--begin css-->
        <link href="${pageContext.request.contextPath}/CSS/bannerStyle.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/CSS/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/CSS/menuStyle.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/CSS/navInforStyle.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/CSS/style.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/CSS/loginStyle.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/CSS/mailStyle.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/CSS/commonStyle.css" rel="stylesheet" type="text/css"/>
        <!--end css-->
        <!--begin js-->
        <script src="${pageContext.request.contextPath}/JS/dropdownMenu.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/JS/jquery-1.11.1.min.js" type="text/javascript"></script>
        <!--end js-->
    </head>
    <body>

        <%            response.setContentType("text/html;charset=UTF-8");
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            String username = (String) session.getAttribute("username");
            if (username == null) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            } else {
        %>
        <div class="wrapper">
            <div class="header">
                <div class="banner">
                    <%@include  file="modules/banner.jsp" %>
                </div>
                <!--end banner-->
            </div>
            <!--end header-->
            <div class="menu">
                <%@include file="modules/menu.jsp" %>
            </div>
            <!--end menu-->
            <div class="nav-infor">
                <%@include file="modules/nav-infor.jsp" %>
            </div>
            <!--end nav-infor-->
            <div class="content">
                <div class="primary">
                    <%@include  file="modules/content.jsp"%>
                </div>
                <!--end primary-->
            </div>
            <!--end content-->
            <div class="footer">
                <%@include  file="modules/footer.jsp"%>
            </div>
        </div>
        <!--end wrapper-->
        <%
            }
        %>
    </body>
</html>

<%-- 
    Document   : login page
    Created on : Aug 4, 2015, 8:29:20 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<link href="../CSS/loginStyle.css" rel="stylesheet" type="text/css"/>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        
    </head>
    <body>
        <div class="container">
            <div class="login">
                <h1>LOGIN TO KPI SYSTEM</h1>
                <form method="post" action="../kpi/checklogin">
                    <p><input type="text" name="username" value="" placeholder="Username"></p>
                    <p><input type="password" name="password" value="" placeholder="Password"></p>
                    <p class="remember_me">
                    <label>
                        <input type="checkbox" name="remember_me" id="remember_me">
                        Remember me on this computer
                    </label>
                    </p>
                    <p class="submit"><input type="submit" name="btAction" value="Login"></p>
                </form>
            </div>
            <div class="login-help">
                <p>Forgot your password? <a href="${pageContext.request.contextPath}/JSP/login.jsp">Click here to reset it</a>.</p>
            </div>
        </div>
    </body>
</html>

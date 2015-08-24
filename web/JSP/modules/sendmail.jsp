<%-- 
    Document   : sendmaill
    Created on : Aug 7, 2015, 8:06:49 AM
    Author     : quang quy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.DataServices"%>
<%@page import="java.sql.ResultSet"%>
<link href="${pageContext.request.contextPath}/CSS/mailStyle.css" rel="stylesheet" type="text/css"/>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<form action="../kpi/processSendMail" method="post">
    <%

        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

    %>
    <div class="sendMail">
        <div class="primary1"></div>
        <table border="1">
            <tr>
            <td colspan="2">
                <h1>Sending Mail...</h1>
            </td>
            </tr>
            <tr>
            <td>Email:</td>
            <td><input type="text" name="myEmail" value="minhquy0409@gmail.com"/></td>
            </tr>
            <tr>
            <td>Password:</td>
            <td><input type="password" name="myPass" value="27081993"/></td>
            </tr>
            <tr>
            <td> Recipients Email:</td>

            <td><input type="text" name="yourEmail" value="${requestScope.yourMail}" style="width:600px;"/></td>
            </tr>
            <tr>
            <td>Subject:</td>
            <td><input type="text" name="object" value="${requestScope.object}" style="width:600px;"/></td>
            </tr>
            <tr>
            <td>Content:</td>
            <td><textarea name="content" cols="100" rows="10">${requestScope.content}</textarea></td>
            </tr>
            <tr>
            <td></td>
            <td><input type="submit" name="btAction" value="Send"/>  </td>
            </tr>
        </table>
            <input type="hidden" value="${requestScope.username}" name="username"/>
            <input type="hidden" value="${requestScope.codeKPI}" name="codeKPI"/>
    </div>
</form>

<%-- 
    Document   : nav-infor
    Created on : Aug 2, 2015, 8:23:27 PM
    Author     : quang quy
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<link href="CSS/navInforStyle.css" rel="stylesheet" type="text/css"/>
<div class="nav-infor">
    <div class="getYear">
        <p>
            <%
                Calendar calendar = Calendar.getInstance();
                out.print("Year: " + calendar.get(Calendar.YEAR));
            %>
        </p>
    </div>
    <div class="getYear infor-login">
        <p>Hi ! <span style='color:#2b542c;font-weight: bold;font-style: italic;'> ${sessionScope.name }</span></p>
    </div>
</div>
<%-- 
    Document   : testconnectDB
    Created on : Aug 6, 2015, 8:11:18 AM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="models.DataServices"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            DataServices mydb = new DataServices();
            ResultSet rs = mydb.executeQuery("select count(*) as 'num' from tbl_part");
            int count = 0;
            while (rs.next()) {
                count = rs.getInt("num");
            }
            out.print(count);
        %>
    </body>
</html>

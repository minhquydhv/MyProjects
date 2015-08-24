<%-- 
    Document   : test
    Created on : Aug 4, 2015, 4:41:32 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">

            function changeFunc() {
                var selectBox = document.getElementById("selectBox");
                var selectedValue = selectBox.options[selectBox.selectedIndex].value;
                alert(selectedValue);
            }
        </script>
    </head>
    <body>
        <center>
            <select style="width: 200px;" id="selectBox" onchange="changeFunc();">
                <option value="1">chuối</option>
                <option value="2">kẹo</option>
            </select>

        </center>
    </body>
</html>

<%-- 
    Document   : Setting KPI Individual
    Created on : Aug 3, 2015, 3:23:21 PM
    Author     : Admin
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="objects.SettingKPIIndividual"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="models.DataServices"%>
<link href="${pageContext.request.contextPath}/CSS/commonStyle.css" rel="stylesheet" type="text/css"/>
<script src="${pageContext.request.contextPath}/JS/addTable.js" type="text/javascript"></script>

<div>

    <%
        DataServices mydb = new DataServices();
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("YY");
        String displayTime = dateFormat.format(date);
        String s1 = displayTime;
        ArrayList<SettingKPIIndividual> arr1 = (ArrayList) request.getAttribute("arr1");
    %>

    <script>
        function addRow(tableID) {

            var table = document.getElementById(tableID);

            var rowCount = table.rows.length;
            var row = table.insertRow(rowCount);

            var cell1 = row.insertCell(0);
            cell1.innerHTML = rowCount;

            var cell2 = row.insertCell(1);
            var element2 = document.createElement("input");
            element2.type = "text";
            element2.name = "jobField" + rowCount;
            cell2.appendChild(element2);


            var cell3 = row.insertCell(2);
            var element3 = document.createElement("input");
            element3.type = "text";
            element3.name = "currentStatus" + rowCount;
            cell3.appendChild(element3);

            var cell4 = row.insertCell(3);
            var element3 = document.createElement("input");
            element3.type = "text";
            element3.name = "kpiTarget" + rowCount;
            cell4.appendChild(element3);

            var cell5 = row.insertCell(4);
            var element3 = document.createElement("input");
            element3.type = "text";
            element3.name = "ratio" + rowCount;
            cell5.appendChild(element3);

            var cell6 = row.insertCell(5);

            /*var element3 = document.createElement("input");
             element3.type = "text";
             element3.name = "remark" + rowCount;
             cell6.appendChild(element3);
             */



            var cell7 = row.insertCell(6);
            var element1 = document.createElement("input");
            element1.type = "checkbox";
            element1.name = "delete";
            cell7.appendChild(element1);

        }

        function deleteRow(tableID) {
            try {
                var table = document.getElementById(tableID);
                var rowCount = table.rows.length;

                for (var i = 0; i < rowCount; i++) {
                    var row = table.rows[i];
                    var chkbox = row.cells[6].childNodes[0];
                    if (null !== chkbox && true === chkbox.checked) {
                        table.deleteRow(i);
                        rowCount--;
                        i--;
                    }
                }
            } catch (e) {
                alert(e);
            }
        }

    </script>
    <script>
        function test()
        {
            var table = document.getElementById("dataTable");
            var rowCount = table.rows.length;
            document.getElementById("num").value = rowCount;
            document.getElementById("username").value = '${sessionScope.username}';
        }

    </script>


    <%        int count = 0;
        String username1 = (String) session.getAttribute("username");
        String ma = s1 + username1;//chu y cai nay 
        ResultSet rs = mydb.executeQuery("select count(*) as 'num' from tbl_setting_kpi_individual where codeKPIIndividual like '" + ma + "%'");
        while (rs.next()) {
            count = rs.getInt("num");
        }
        String sSql1 = "select * from tbl_setting_kpi_individual where codeKPIIndividual like '" + ma + "%'";
        ResultSet rs1 = mydb.executeQuery(sSql1);
        ArrayList<SettingKPIIndividual> arrayList = new ArrayList();
        while (rs1.next()) {
            String codeKPIIndividual = rs1.getString("codeKPIIndividual");
            String jobField = rs1.getString("jobField");
            String currentStatus = rs1.getString("currentStatus");
            String kpiTarget = rs1.getString("kpiTarget");
            String ratio = rs1.getString("ratio");
            String remark = rs1.getString("remark");
            SettingKPIIndividual st = new SettingKPIIndividual(codeKPIIndividual, jobField, currentStatus, kpiTarget, ratio, remark);
            /*  out.print(st.getJobField() + "<br>");
             out.print(st.getCurrentStatus() + "<br>");
             out.print(st.getKpiTarget() + "<br>");
             out.print(st.getRatio() + "<br>");
             out.print(st.getRemark() + "<br>");
             */
            arrayList.add(st);
        }

    %>
    <input type="button" class="btn btn-info" value="Add Row" onclick="addRow('dataTable')" />
    <input type="button" class="btn btn-info" value="Delete Row" onclick="deleteRow('dataTable')" />


    <form action="../kpi/process" method="post">
        <table class="setting"  id="dataTable" border="1">
            <tr>
            <th>No.</th>
            <th>Job Field</th>
            <th>Current Status</th>
            <th>KPI target</th>
            <th>Ratio(%)</th>
            <th>Remark</th>
            <th>Delete</th>
            </tr>
            <%                if (arr1 != null) {

                    for (int k = 0; k < arr1.size(); k++) {
            %>
            <tr>
            <td><%=k + 1%></td>
            <td><input type="text" name="jobField<%=k + 1%>" value="<%=arr1.get(k).getJobField()%>"></td>
            <td><input type="text" name="currentStatus<%=k + 1%>" value="<%=arr1.get(k).getCurrentStatus()%>"></td>
            <td><input type="text" name="kpiTarget<%=k + 1%>" value="<%=arr1.get(k).getKpiTarget()%>"></td>
            <td><input type="text" name="ratio<%=k + 1%>" value="<%=arr1.get(k).getRatio()%>"></td>
            <td><%=arr1.get(k).getRemark()%></td>
            <td><input type="checkbox" name="delete" ></td>
            </tr>

            <%
                }
            } else {
                if (count > 0) {
                    int j = 0;
                    for (int i = 1; i <= count; i++) {
                        SettingKPIIndividual st1 = arrayList.get(j);
            %>
            <tr>
            <td><%=i%></td>
            <td><input type="text" name="jobField<%=i%>" value="<%=st1.getJobField()%>"></td>
            <td><input type="text" name="currentStatus<%=i%>" value="<%=st1.getCurrentStatus()%>"></td>
            <td><input type="text" name="kpiTarget<%=i%>" value="<%=st1.getKpiTarget()%>"></td>
            <td><input type="text" name="ratio<%=i%>" value="<%=st1.getRatio()%>"></td>
            <td><%=st1.getRemark()%></td>
            <td><input type="checkbox" name="delete" ></td>
            </tr>
            <%
                            j++;
                        }
                    }
                }
            %>
        </table>
        <input id="num" type="hidden" name="numRows" />
        <input id="username" type="hidden" name="uname" />

        <div class="mess">${requestScope.mess1}</div>


        <div class="confirmed">Confirmed</div>
        <center>
            <%
                String queryteamName = "select *from tbl_staff a, tbl_team b where a.teamID=b.teamID and a.staffID='" + username1 + "'";
                String teamName = "";
                ResultSet rsQueryTeamName = mydb.executeQuery(queryteamName);
                while (rsQueryTeamName.next()) {
                    teamName = rsQueryTeamName.getString("teamName");
                }
                String queryRole = "select *from tbl_staff a,tbl_decentralization  b where a.staffID=b.staffID and a.staffID='" + username1 + "'";
                ArrayList arrRoleID = new ArrayList();
                ResultSet rsQueryRoleID = mydb.executeQuery(queryRole);
                while (rsQueryRoleID.next()) {
                    arrRoleID.add(rsQueryRoleID.getString("roleID"));
                }
                int kt1 = 0;
                for (int i = 0; i < arrRoleID.size(); i++) {
                    if (arrRoleID.get(i).equals("03")) {
                        kt1 = 1;
                        break;
                    }
                }
                if ((kt1 == 0) && (teamName.equals("Sales"))) {
            %>
            <table class="comment" border="1">
                <tr>
                <th>Team Leader</th>
                <th>H.O.D</th>
                <th>D.G.Director</th>
                <th>G.Director</th>
                </tr>
                <%String queryComment = "select *from tbl_comment_kpi_individual where codeCommentIndividual ='" + ma + "'";
                    int s = 0;
                    ResultSet rsQueryComment = mydb.executeQuery(queryComment);

                    while (rsQueryComment.next()) {
                        s++;
                %>
                <tr>

                <td><textarea id="hide1" ><%=rsQueryComment.getString("commentTeamLeader") == null ? "" : rsQueryComment.getString("commentTeamLeader")%></textarea></td>
                <td><textarea id="hide1" ><%=rsQueryComment.getString("commentHoD") == null ? "" : rsQueryComment.getString("commentHoD")%></textarea></td>
                <td><textarea id="hide3"><%=rsQueryComment.getString("commentDGD") == null ? "" : rsQueryComment.getString("commentDGD")%></textarea></td>
                <td><textarea id="hide4"><%=rsQueryComment.getString("commentGD") == null ? "" : rsQueryComment.getString("commentGD")%></textarea></td>
                </tr>
                <tr>

                <td>Date:<%=rsQueryComment.getString("dateTeamLeader") == null ? "" : rsQueryComment.getString("dateTeamLeader")%></td>
                <td>Date:<%=rsQueryComment.getString("dateHoD") == null ? "" : rsQueryComment.getString("dateHoD")%></td>
                <td>Date:<%=rsQueryComment.getString("dateDGD") == null ? "" : rsQueryComment.getString("dateDGD")%></td>
                <td>Date:<%=rsQueryComment.getString("dateGD") == null ? "" : rsQueryComment.getString("dateGD")%></td>

                </tr>
                <%
                    }
                    if (s == 0) {
                %>
                <tr>
                <td><textarea id="hide0" ></textarea></td>
                <td><textarea id="hide1" ></textarea></td>
                <td><textarea id="hide2"></textarea></td>
                <td><textarea id="hide3"></textarea></td>
                </tr>
                <tr>
                <td>Date:</td>
                <td>Date:</td>
                <td>Date:</td>
                <td>Date:</td>
                </tr>
                <%
                    }
                } else if ((kt1 == 1) && (teamName.equals("Sales"))) {
                %>
                <table class="comment" border="1">
                    <tr>
                    <th>H.O.D</th>
                    <th>D.G.Director</th>
                    <th>G.Director</th>
                    </tr>
                    <%String queryComment = "select *from tbl_comment_kpi_individual where codeCommentIndividual ='" + ma + "'";
                        int s = 0;
                        ResultSet rsQueryComment = mydb.executeQuery(queryComment);

                        while (rsQueryComment.next()) {
                            s++;
                    %>
                    <tr>

                    <td><textarea id="hide1" ><%=rsQueryComment.getString("commentHoD") == null ? "" : rsQueryComment.getString("commentHoD")%></textarea></td>
                    <td><textarea id="hide3"><%=rsQueryComment.getString("commentDGD") == null ? "" : rsQueryComment.getString("commentDGD")%></textarea></td>
                    <td><textarea id="hide4"><%=rsQueryComment.getString("commentGD") == null ? "" : rsQueryComment.getString("commentGD")%></textarea></td>
                    </tr>
                    <tr>

                    <td>Date:<%=rsQueryComment.getString("dateHoD") == null ? "" : rsQueryComment.getString("dateHoD")%></td>
                    <td>Date:<%=rsQueryComment.getString("dateDGD") == null ? "" : rsQueryComment.getString("dateDGD")%></td>
                    <td>Date:<%=rsQueryComment.getString("dateGD") == null ? "" : rsQueryComment.getString("dateGD")%></td>

                    </tr>
                    <%
                        }
                        if (s == 0) {
                    %>
                    <tr>
                    <td><textarea id="hide2"></textarea></td>
                    <td><textarea id="hide3"></textarea></td>
                    <td><textarea id="hide4"></textarea></td>
                    </tr>
                    <tr>
                    <td>Date:</td>
                    <td>Date:</td>
                    <td>Date:</td>
                    <td>Date:</td>
                    </tr>
                </table>
                <%
                    }
                } else if ((kt1 == 0) && (teamName != "Sales")) {
                %>
                <table class="comment" border="1">
                    <tr>
                    <th>Team Leader</th>
                    <th>H.O.D</th>

                    </tr>
                    <%String queryComment = "select *from tbl_comment_kpi_individual where codeCommentIndividual ='" + ma + "'";
                        int s = 0;
                        ResultSet rsQueryComment = mydb.executeQuery(queryComment);

                        while (rsQueryComment.next()) {
                            s++;
                    %>
                    <tr>

                    <td><textarea id="hide1" ><%=rsQueryComment.getString("commentTeamLeader") == null ? "" : rsQueryComment.getString("commentTeamLeader")%></textarea></td>
                    <td><textarea id="hide1" ><%=rsQueryComment.getString("commentHoD") == null ? "" : rsQueryComment.getString("commentHoD")%></textarea></td>
                    </tr>
                    <tr>

                    <td>Date:<%=rsQueryComment.getString("dateTeamLeader") == null ? "" : rsQueryComment.getString("dateTeamLeader")%></td>
                    <td>Date:<%=rsQueryComment.getString("dateHoD") == null ? "" : rsQueryComment.getString("dateHoD")%></td>
                    </tr>
                    <%
                        }
                        if (s == 0) {
                    %>
                    <tr>
                    <td><textarea id="hide0" ></textarea></td>
                    <td><textarea id="hide1" ></textarea></td>
                    </tr>
                    <tr>
                    <td>Date:</td>
                    <td>Date:</td>
                    </tr>
                </table>
                <%
                    }
                } else if ((kt1 == 1) && (teamName != "Sales")) {
                %>
                <table class="comment" border="1">
                    <tr>
                    <th>H.O.D</th>

                    </tr>
                    <%String queryComment = "select *from tbl_comment_kpi_individual where codeCommentIndividual ='" + ma + "'";
                        int s = 0;
                        ResultSet rsQueryComment = mydb.executeQuery(queryComment);

                        while (rsQueryComment.next()) {
                            s++;
                    %>
                    <tr>

                    <td><textarea id="hide1" ><%=rsQueryComment.getString("commentHoD") == null ? "" : rsQueryComment.getString("commentHoD")%></textarea></td>
                    </tr>
                    <tr>

                    <td>Date:<%=rsQueryComment.getString("dateHoD") == null ? "" : rsQueryComment.getString("dateHoD")%></td>
                    </tr>
                    <%
                        }
                        if (s == 0) {
                    %>
                    <tr>
                    <td><textarea id="hide1" ></textarea></td>
                    </tr>
                    <tr>
                    <td>Date:</td>
                    </tr>
                </table>
                <%
                        }
                    }
                %>

                <%                String sSql3 = "select *from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + ma + "'";
                    ResultSet rsQueryConfirmed = mydb.executeQuery(sSql3);
                    int confirmed = 0;
                    while (rsQueryConfirmed.next()) {
                        confirmed = rsQueryConfirmed.getInt("confirmedTeamLeader");
                    }
                    if (confirmed == 0) {
                %>
                <center>
                    <input class="btn btn-default" type="submit" value="Save" name="btAction" onclick="test()" >
                    <input class="btn btn-default" type="submit" value="SendMail" name="btAction" onclick="test()" >
                </center>
                <%
                    }

                %>
        </center>
        <script>
            document.getElementById("hide0").readOnly = true;
            document.getElementById("hide1").readOnly = true;
            document.getElementById("hide2").readOnly = true;
            document.getElementById("hide3").readOnly = true;
            document.getElementById("hide4").readOnly = true;
        </script>
    </form>
</div>
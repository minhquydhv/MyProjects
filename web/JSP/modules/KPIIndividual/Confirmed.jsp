<%-- 
    Document   : Confirmed
    Created on : Aug 8, 2015, 5:08:29 PM
    Author     : Admin
--%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="models.DataServices"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath}/CSS/bootstrap.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/CSS/commonStyle.css" rel="stylesheet" type="text/css"/>
<script src="${pageContext.request.contextPath}/JS/addTable.js" type="text/javascript"></script>

<%
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("utf-8");
    response.setCharacterEncoding("utf-8");
    DataServices mydb = new DataServices();
    //begin
    Date currentDate = new Date();
    SimpleDateFormat dateFormatCurrent = new SimpleDateFormat("dd-MM-yyyy");
    String displayTimeCurrent = dateFormatCurrent.format(currentDate);
    //end
    Date date = new Date();
    SimpleDateFormat dateFormat = new SimpleDateFormat("YY");
    String displayTime = dateFormat.format(date);
    String s1 = displayTime;

    ArrayList arrayList1 = new ArrayList();
    int kt1 = 0;
    String username1 = (String) session.getAttribute("username");
    String queryRoles = "select roleID from tbl_decentralization where staffID='" + username1 + "'";
    ResultSet rsS = mydb.executeQuery(queryRoles);
    while (rsS.next()) {
        arrayList1.add(rsS.getString("roleID"));
    }
    for (int i = 0; i < arrayList1.size(); i++) {
        if (arrayList1.get(i).equals("02")) {// quyen truong phong
            kt1 = 0;
            break;
        } else if (arrayList1.get(i).equals("03")) {//teamleader
            kt1 = 3;
            break;
        } else if (arrayList1.get(i).equals("06")) {
            kt1 = 4;
        } else if (arrayList1.get(i).equals("08")) {
            kt1 = 5;
        }
    }
    if (kt1 == 3) {//bat dau teamleader
%>
<form action="../kpi/confirmedKPITeamLeader" method="post">
    <center>
        <%
            String queryTeam = "select * from tbl_staff a, tbl_team b  where a.teamID=b.teamID and staffID='" + username1 + "'";
            ResultSet rsQueryTeam = mydb.executeQuery(queryTeam);
            String teamName = "";
            while (rsQueryTeam.next()) {
                teamName = rsQueryTeam.getString("teamName");
            }
        %>      
        <table class="staff-wrapper">
            <tr>
            <td>
                <div class="teamName"> Team Name: <% out.print(teamName); %></div>
            </td>
            <td>
                <select name="seStaff">
                    <%
                        ArrayList arrayList = new ArrayList();
                        ArrayList arrayList3 = new ArrayList();
                        String queryStaff = "select * from tbl_staff a, tbl_team b  where a.teamID=b.teamID and teamName='" + teamName + "'";
                        ResultSet rsQueryStaff = mydb.executeQuery(queryStaff);
                        while (rsQueryStaff.next()) {
                            String code = s1 + rsQueryStaff.getString("staffID");
                            String queryConfirmed = "select * from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + code + "'  ";
                            ResultSet rsQueryConfirmed = mydb.executeQuery(queryConfirmed);
                            while (rsQueryConfirmed.next()) {
                                if ((rsQueryConfirmed.getInt("confirmedIndividual") == 1)) {
                                    arrayList.add(rsQueryStaff.getString("StaffID"));
                                    arrayList3.add(rsQueryStaff.getString("staffName"));
                                }
                            }
                        }
                        for (int i = 0; i < arrayList.size(); i++) {
                    %>
                    <option value="<%=arrayList.get(i)%>"><%=arrayList3.get(i)%></option>
                    <%
                        }
                    %>

                </select> 
                <input class="btn btn-default" type="submit" value="Select Staff" name="btAction" >
            </td>
            </td>
        </table>
        <div class="mess">${requestScope.mess1}</div>            

        <br/>
        <table id="dataTable" class="setting" border="1">
            <tr>
            <th>No.</th>
            <th>Job Field</th>
            <th>Current Status</th>
            <th>KPI target</th>
            <th>Ratio(%)</th>
            <th>Remark</th>
            </tr>
            <%
                String staffID = (String) request.getAttribute("staffID");
                String codeKPIstaffID = s1 + staffID;
                // out.print(codeKPIstaffID);
                String queryKPIStaff = "select *from tbl_setting_kpi_individual where codeKPIIndividual like'" + codeKPIstaffID + "%'";
                ResultSet rsQueryKPIStaff = mydb.executeQuery(queryKPIStaff);
                int i2 = 1;
                while (rsQueryKPIStaff.next()) {
            %>
            <tr>
            <td><%=i2%></td>
            <td><%=rsQueryKPIStaff.getString("jobField")%></td>
            <td><%=rsQueryKPIStaff.getString("currentStatus")%></td>
            <td><%=rsQueryKPIStaff.getString("kpiTarget")%></td>
            <td><%=rsQueryKPIStaff.getString("ratio")%></td>
            <td><input type="text" name ="remark<%=i2%>" checked value=""/></td>
            </tr>
            <%
                    i2++;
                }


            %>
        </table>
    </center> 
    <%            String commentTeamLeader = "";
        String commentHoD = "";
        String dateHoD = "";
        String commentDGD = "";
        String dateDGD = "";
        String commentGD = "";
        String dateGD = "";
        String queryCommentTL = "select *from tbl_comment_kpi_individual where codeCommentIndividual='" + displayTime + staffID + "'";
        ResultSet rsQueryCommentTL = mydb.executeQuery(queryCommentTL);
        while (rsQueryCommentTL.next()) {
            commentHoD = rsQueryCommentTL.getString("commentHoD");
            dateHoD = rsQueryCommentTL.getString("dateHoD");
            commentDGD = rsQueryCommentTL.getString("commentDGD");
            dateDGD = rsQueryCommentTL.getString("dateDGD");
            commentGD = rsQueryCommentTL.getString("commentGD");
            dateGD = rsQueryCommentTL.getString("dateGD");
        }
    %>
    <table class="comment" border="1">
        <tr>
        <th>Team Leader</th>
        <th>H.O.D</th>
        <th>D.G.Director</th>
        <th>G.Director</th>
        </tr>
        <tr>
        <td><textarea name="confirmedTeamLeader"></textarea></td>
        <td><textarea id="hide3" name="confirmedHoD"><%=commentHoD%></textarea></td>
        <td><textarea id="hide1" name="confirmedDGD"><%=commentDGD%></textarea></td>
        <td><textarea id="hide2" name="confirmedGD"><%=commentGD%></textarea></td>
        </tr>
        <tr>
        <td>Date:<%=displayTimeCurrent%></td>
        <td>Date:<%=dateHoD%></td>
        <td>Date:<%=dateDGD%></td>
        <td>Date:<%=dateGD%></td>
        </tr>
    </table>

    <div style="text-align: center;">
        <% String queryConfirmedHoD = "Select * from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + codeKPIstaffID + "'";
            ResultSet rsQueryConfirmedHoD = mydb.executeQuery(queryConfirmedHoD);
            while (rsQueryConfirmedHoD.next()) {
                if (rsQueryConfirmedHoD.getInt("confirmedTeamLeader") == 0) {
        %>
        <input type="submit" value="Accept" name="btAction" onclick="getCode()">
        <input type="submit" value="Reject" name="btAction">
        <%
                }
            }
        %>
    </div>

    <input type="hidden" name="getCode" value="${requestScope.staffID}"/>  
    <input type="hidden" name="username1" value="<%=username1%>"/> 
    <script>
        document.getElementById("hide").readOnly = true;
        document.getElementById("hide1").readOnly = true;
        document.getElementById("hide2").readOnly = true;
        document.getElementById("hide3").readOnly = true;
    </script>
</form>
<%
}//ket thuc teamleader
//bat dau cho truong phong
else if (kt1 == 0) {%>
<form action="../kpi/confirmedKPIHoD" method="post">
    <center>
        <%
            ArrayList arrayListTeamName = new ArrayList();
            ArrayList arrayListTeamID = new ArrayList();
            ArrayList arrayListTL = new ArrayList();
            int countStaff = 0;

            String queryDept = "select a.deptID from tbl_department a,tbl_team b, tbl_staff c where a.deptID=b.deptID and b.teamID=c.teamID and c.staffID='" + username1 + "'";
            ResultSet rsQueryDept = mydb.executeQuery(queryDept);
            String deptID = "";
            while (rsQueryDept.next()) {
                deptID = rsQueryDept.getString("deptID");
            }


        %>
        <table class="staff-wrapper">
            <tr>
            <td>
                Select Team:  <select name="seTeam"> 
                    <%                        //out.print(deptID);
                        //out.print(deptID);
                        String queryTeam = "select b.teamID,teamName from tbl_department a,tbl_team b where a.deptID=b.deptID and a.deptID='" + deptID + "'";
                        ResultSet rsQueryTeam = mydb.executeQuery(queryTeam);

                        while (rsQueryTeam.next()) {
                            arrayListTeamName.add(rsQueryTeam.getString("teamName"));
                            arrayListTeamID.add(rsQueryTeam.getString("teamID"));
                        }
                        for (int i = 0; i < arrayListTeamID.size(); i++) {
                            String countStaff1 = "select count(*) as 'count' from tbl_staff where teamID ='" + arrayListTeamID.get(i) + "'";
                            ResultSet rsCountStaff1 = mydb.executeQuery(countStaff1);
                            while (rsCountStaff1.next()) {
                                countStaff = rsCountStaff1.getInt("count");
                            }
                            String queryStaff1 = "select * from tbl_staff a, tbl_team b where a.teamID=b.teamID and b.teamID ='" + arrayListTeamID.get(i) + "'";
                            ResultSet rsQueryStaff1 = mydb.executeQuery(queryStaff1);
                            while (rsQueryStaff1.next()) {
                                String codeKPI1 = s1 + rsQueryStaff1.getString("staffID");
                                String queryConfirmed = "select *from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + codeKPI1 + "'";
                                ResultSet rsQueryConfirmed = mydb.executeQuery(queryConfirmed);
                                while (rsQueryConfirmed.next()) {
                                    if (rsQueryConfirmed.getInt("confirmedTeamLeader") == 1) {
                                        arrayListTL.add("1");
                                    }

                                }
                            }
                            if (countStaff == arrayListTL.size()) {
                    %>
                    <option value="<%=arrayListTeamID.get(i)%>"><%=arrayListTeamName.get(i)%></option>
                    <%
                            }
                            arrayListTL.clear();//xoa tat ca phan tu cua 1 mang da duoc thiet lap
                        }
                    %>
                </select>

                <!-- select staff-->
                <input class="btn btn-default" type="submit" value="Select Team" name="btAction" >
            </td>
            <td>
                <select name="seStaff">
                    <%
                        String teamID = (String) request.getAttribute("teamID");
                        String queryStaff = "select staffID,staffName from tbl_staff where teamID='" + teamID + "' and staffID not in (select staffID from tbl_staff where staffID= '" + username1 + "')";
                        ResultSet rsQueryStaff = mydb.executeQuery(queryStaff);
                        while (rsQueryStaff.next()) {
                            String codeKPI = s1 + rsQueryStaff.getString("staffID");
                            String queryConfirmed = "select *from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + codeKPI + "'";
                            ResultSet rsQueryConfirmed = mydb.executeQuery(queryConfirmed);
                            while (rsQueryConfirmed.next()) {

                    %>
                    <option value="<%=rsQueryStaff.getString("staffID")%>"><%=rsQueryStaff.getString("staffName")%></option>
                    <%

                            }
                        }
                    %>
                </select>

                <input class="btn btn-default" type="submit" value="Select Staff" name="btAction" >

            </td>
            </tr>
        </table>
        <div class="mess">
            <%
                String mess1 = (String) request.getAttribute("mess1");
                if (mess1 != null) {
                    out.print(request.getAttribute("mess1"));
                }
            %>
        </div>
        <br>
        <table id="dataTable" class="setting" border="1">
            <tr>
            <th>No.</th>
            <th>Job Field</th>
            <th>Current Status</th>
            <th>KPI target</th>
            <th>Ratio(%)</th>
            <th>Remark</th>
            </tr>
            <%
                // String staffID = (String) request.getAttribute("staffID");
                String staffID = (String) request.getAttribute("staffID");
                //  out.print(staffID);
                Date date1 = new Date();
                SimpleDateFormat dateFormat1 = new SimpleDateFormat("YY");
                String displayTime1 = dateFormat1.format(date1);
                String s12 = displayTime1;
                String KpiCode = s12 + staffID;
                String queryKPI = "select *  from tbl_setting_kpi_individual  where codeKPIIndividual like '" + KpiCode + "%'";
                ResultSet rsQueryKPI = mydb.executeQuery(queryKPI);
                int ii = 1;
                int kt2 = 0;
                String queryConfirmedIndividual = "select confirmedIndividual from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + KpiCode + "'";
                ResultSet rsQueryConfirmedIndividual = mydb.executeQuery(queryConfirmedIndividual);
                while (rsQueryConfirmedIndividual.next()) {
                    if (rsQueryConfirmedIndividual.getInt("confirmedIndividual") == 1) {
                        kt2 = 1;
                        break;
                    }
                }
                if (kt2 == 1) {
                    while (rsQueryKPI.next()) {
            %>
            <tr>
            <td><%=ii%></td>
            <td><%=rsQueryKPI.getString("jobField")%></td>
            <td><%=rsQueryKPI.getString("currentStatus")%></td>
            <td><%=rsQueryKPI.getString("kpiTarget")%></td>
            <td><%=rsQueryKPI.getString("ratio")%></td>
            <td><input type="text"  name="remark<%=ii%>" value=""/></td>
            </tr>


            <%
                        ii++;
                    }
                }
            %>
        </table>
    </center>
    <div class="confirmed">confirmed:</div>
    <%
        String commentTeamLeader = "";
        String dateTeamLeader = "";
        String queryCommentTL = "select *from tbl_comment_kpi_individual where codeCommentIndividual='" + displayTime + staffID + "'";
        ResultSet rsQueryCommentTL = mydb.executeQuery(queryCommentTL);
        while (rsQueryCommentTL.next()) {
            commentTeamLeader = rsQueryCommentTL.getString("commentTeamLeader");
            dateTeamLeader = rsQueryCommentTL.getString("dateTeamLeader");
        }
    %>
    <table class="comment" border="1">
        <tr>
        <th>Team Leader</th>
        <th>H.O.D</th>
        <th>D.G.Director</th>
        <th>G.Director</th>
        </tr>
        <tr>
        <td><textarea id="hide0"><%=commentTeamLeader%></textarea></td>
        <td><textarea name="confirmedHoD"></textarea></td>
        <td><textarea id="hide"></textarea></td>
        <td><textarea id="hide1"></textarea></td>
        <td><textarea id="hide2"></textarea></td>
        </tr>
        <tr>
        <td>Date:<%=dateTeamLeader%></td>
        <td>Date:<%=displayTimeCurrent%></td>
        <td>Date:</td>
        <td>Date:</td>
        </tr>
    </table>
    <% String queryConfirmedHoD = "Select * from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + KpiCode + "'";
        ResultSet rsQueryConfirmedHoD = mydb.executeQuery(queryConfirmedHoD);
        while (rsQueryConfirmedHoD.next()) {
            if (rsQueryConfirmedHoD.getInt("confirmedHoD") == 0) {
    %>
    <div style="text-align: center;">
        <input type="submit" value="Accept" name="btAction" onclick="getCode()">
        <input type="submit" value="Reject" name="btAction">

    </div>
    <%
            }
        }
    %>

    <input type="hidden" name="getCode" value="${requestScope.staffID}"/>   
    <input type="hidden" name="username1" value="<%=username1%>"/>
    <script>
        document.getElementById("hide0").readOnly = true;
        document.getElementById("hide").readOnly = true;
        document.getElementById("hide1").readOnly = true;
        document.getElementById("hide2").readOnly = true;
    </script>

</form>

<%
    //ket thuc phan quyen cho HoDs
} else if (kt1 == 4) {//bat dau cho pho giam doc
%>
<form action="../kpi/confirmedKPIDGD" method="post">
    <center>
        <select name="seSaleMan">
            <%
                ArrayList arrayListStaffID = new ArrayList();
                String queryStaff = "select staffID from tbl_staff a, tbl_team b  where a.teamID=b.teamID and teamName='Sales'";
                ResultSet rsQueryStaff = mydb.executeQuery(queryStaff);
                while (rsQueryStaff.next()) {
                    String staffID = s1 + rsQueryStaff.getString("StaffID");
                    arrayListStaffID.add(staffID);
                }
                int kt2 = 0;
                for (int i = 0; i < arrayListStaffID.size(); i++) {
                    String queryConfirmedHoD = "select *from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + arrayListStaffID.get(i) + "'";
                    ResultSet rsQueryConfirmedHoD = mydb.executeQuery(queryConfirmedHoD);
                    while (rsQueryConfirmedHoD.next()) {
                        if (rsQueryConfirmedHoD.getInt("confirmedHoD") == 0) {//kiem tra kpi da duoc planning phe duyet chua
                            kt2 = 1;
                            break;
                        }
                    }
                }
                if ((kt2 == 0)) {
                    String queryStaff1 = "select staffID,StaffName from tbl_staff a, tbl_team b where a.teamID=b.teamID and teamName='Sales'";
                    ResultSet rsqueryStaff1 = mydb.executeQuery(queryStaff1);
                    while (rsqueryStaff1.next()) {
            %>
            <option value="<%=rsqueryStaff1.getString("StaffID")%>"><%=rsqueryStaff1.getString("staffName")%></option>
            <%
                    }
                }
            %>

        </select> 
        <input class="btn btn-default" type="submit" value="Select SaleMan" name="btAction" >
        <br/>
        <div Class="mess"> ${requestScope.mess1}</div>
        <table id="dataTable" class="setting" border="1">
            <tr>
            <th>No.</th>
            <th>Job Field</th>
            <th>Current Status</th>
            <th>KPI target</th>
            <th>Ratio(%)</th>
            <th>Remark</th>
            </tr>
            <%                                    String saleManID = (String) request.getAttribute("seSaleMan");
                String codeKPISaleMan = s1 + saleManID;
                String queryKPISaleMans = "select *from tbl_setting_kpi_individual where codeKPIIndividual like'" + codeKPISaleMan + "%'";
                ResultSet rsQueryKPISaleMans = mydb.executeQuery(queryKPISaleMans);
                int i2 = 1;
                while (rsQueryKPISaleMans.next()) {
            %>
            <tr>
            <td><%=i2%></td>
            <td><%=rsQueryKPISaleMans.getString("jobField")%></td>
            <td><%=rsQueryKPISaleMans.getString("currentStatus")%></td>
            <td><%=rsQueryKPISaleMans.getString("kpiTarget")%></td>
            <td><%=rsQueryKPISaleMans.getString("ratio")%></td>
            <td><input type="text" value=" " name="remark<%=i2%>" /></td>
            </tr>
            <%
                    i2++;
                }
            %>
        </table>
    </center>
    <div class="confirmed">confirmed:</div>
    <center>

        <%
            String commentTeamLeader = "";
            String dateTeamLeader = "";
            String commentHoD = "";
            String dateHoD = "";
            String queryCommentTL = "select *from tbl_comment_kpi_individual where codeCommentIndividual='" + displayTime + saleManID + "'";
            ResultSet rsQueryCommentTL = mydb.executeQuery(queryCommentTL);
            while (rsQueryCommentTL.next()) {
                commentTeamLeader = rsQueryCommentTL.getString("commentTeamLeader");
                dateTeamLeader = rsQueryCommentTL.getString("dateTeamLeader");
                commentHoD = rsQueryCommentTL.getString("commentHoD");
                dateHoD = rsQueryCommentTL.getString("dateHoD");
            }

        %>
        <table class="comment" border="1">
            <tr>
            <th>Team Leader</th>
            <th>H.O.D</th>
            <th>D.G.Director</th>
            <th>G.Director</th>
            </tr>
            <tr>
            <td><textarea id="hide" name="confirmedTeamLeader"><%=commentTeamLeader%></textarea></td>
            <td><textarea id="hide3" name="confirmedHoD"><%=commentHoD%></textarea></td>
            <td><textarea  name="confirmedDGD"></textarea></td>
            <td><textarea id="hide2"></textarea></td>
            </tr>
            <tr>
            <td>Date:<%=dateTeamLeader%></td>
            <td>Date:<%=dateHoD%></td>
            <td>Date:</td>
            <td>Date:<%=displayTimeCurrent%></td>
            </tr>
        </table>
        <div style="text-align: center;">
            <% String queryConfirmedHoD = "Select * from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + codeKPISaleMan + "'";
                ResultSet rsQueryConfirmedHoD = mydb.executeQuery(queryConfirmedHoD);
                while (rsQueryConfirmedHoD.next()) {
                    if (rsQueryConfirmedHoD.getInt("confirmedDGD") == 0) {
            %>
            <input type="submit" value="Accept" name="btAction" onclick="getCode()">
            <input type="submit" value="Reject" name="btAction">
            <%}
                }%>

        </div>
        <script>
            document.getElementById("hide").readOnly = true;
            document.getElementById("hide1").readOnly = true;
            document.getElementById("hide2").readOnly = true;
            document.getElementById("hide3").readOnly = true;
        </script>
        <input type="hidden" name="getCode" value="${requestScope.seSaleMan}"/>
        <input type="hidden" name="username1" value="<%=username1%>"/> 
    </center>
</form>
<%
} else if (kt1 == 5) {
%>
<form action="../kpi/confirmedKPIGD" method="post">
    <center>
        <select name="seSaleMan">
            <%
                ArrayList arrayListStaffID = new ArrayList();
                String queryStaff = "select staffID from tbl_staff a, tbl_team b  where a.teamID=b.teamID and teamName='Sales'";
                ResultSet rsQueryStaff = mydb.executeQuery(queryStaff);
                while (rsQueryStaff.next()) {
                    String staffID = s1 + rsQueryStaff.getString("StaffID");
                    arrayListStaffID.add(staffID);
                }
                int kt2 = 0;
                for (int i = 0; i < arrayListStaffID.size(); i++) {
                    String queryConfirmedHoD = "select *from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + arrayListStaffID.get(i) + "'";
                    ResultSet rsQueryConfirmedHoD = mydb.executeQuery(queryConfirmedHoD);
                    while (rsQueryConfirmedHoD.next()) {
                        if (rsQueryConfirmedHoD.getInt("confirmedDGD") == 0) {//kiem tra kpi da duoc DGD phe duyet chua
                            kt2 = 1;
                            break;
                        }
                    }
                }
                if ((kt2 == 0)) {
                    String queryStaff1 = "select staffID,StaffName from tbl_staff a, tbl_team b where a.teamID=b.teamID and teamName='Sales'";
                    ResultSet rsqueryStaff1 = mydb.executeQuery(queryStaff1);
                    while (rsqueryStaff1.next()) {
            %>
            <option value="<%=rsqueryStaff1.getString("StaffID")%>"><%=rsqueryStaff1.getString("staffName")%></option>
            <%

                    }

                }
            %>

        </select> 
        <input class="btn btn-default" type="submit" value="Select SaleMan" name="btAction" >
        <br/>

        <table id="dataTable" class="setting" border="1">
            <tr>
            <th>No.</th>
            <th>Job Field</th>
            <th>Current Status</th>
            <th>KPI target</th>
            <th>Ratio(%)</th>
            <th>Remark</th>
            </tr>
            <%                String saleManID = (String) request.getAttribute("seSaleMan");
                String codeKPISaleMan = s1 + saleManID;
                String queryKPISaleMans = "select *from tbl_setting_kpi_individual where codeKPIIndividual like'" + codeKPISaleMan + "%'";
                ResultSet rsQueryKPISaleMans = mydb.executeQuery(queryKPISaleMans);
                int i2 = 1;
                while (rsQueryKPISaleMans.next()) {
            %>
            <tr>
            <td><%=i2%></td>
            <td><%=rsQueryKPISaleMans.getString("jobField")%></td>
            <td><%=rsQueryKPISaleMans.getString("currentStatus")%></td>
            <td><%=rsQueryKPISaleMans.getString("kpiTarget")%></td>
            <td><%=rsQueryKPISaleMans.getString("ratio")%></td>
            <td><input type="text" value="" name="remark<%=i2%>" /></td>
            </tr>
            <%
                    i2++;
                }
            %>
        </table>
    </center>
    <div class="mess">${requestScope.mess1}</div>
    <div class="confirmed">confirmed:</div>
    <center>
        <%
            String commentTeamLeader = "";
            String dateTeamLeader = "";
            String commentHoD = "";
            String dateHoD = "";
            String commentDGD = "";
            String dateDGD = "";
            String queryCommentTL = "select *from tbl_comment_kpi_individual where codeCommentIndividual='" + displayTime + saleManID + "'";
            ResultSet rsQueryCommentTL = mydb.executeQuery(queryCommentTL);
            while (rsQueryCommentTL.next()) {
                commentTeamLeader = rsQueryCommentTL.getString("commentTeamLeader");
                dateTeamLeader = rsQueryCommentTL.getString("dateTeamLeader");
                commentHoD = rsQueryCommentTL.getString("commentHoD");
                dateHoD = rsQueryCommentTL.getString("dateHoD");
                commentDGD = rsQueryCommentTL.getString("commentDGD");
                dateDGD = rsQueryCommentTL.getString("dateDGD");
            }

        %>
        <table class="comment" border="1">
            <tr>
            <th>Team Leader</th>
            <th>H.O.D</th>
            <th>D.G.Director</th>
            <th>G.Director</th>
            </tr>
            <tr>
            <td><textarea id="hide" name="confirmedTeamLeader"><%=commentTeamLeader%></textarea></td>
            <td><textarea id="hide3" name="confirmedHoD"><%=commentHoD%></textarea></td>
            <td><textarea id="hide2" ><%=commentDGD%></textarea></td>
            <td><textarea name="confirmedGD"></textarea></td>
            </tr>
            <tr>
            <td>Date:<%=dateTeamLeader%></td>
            <td>Date:<%=dateHoD%></td>
            <td>Date:<%=dateDGD%></td>
            <td>Date:<%=displayTimeCurrent%></td>
            </tr>
        </table>
        <div style="text-align: center;">
            <% String queryConfirmedHoD = "Select * from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + codeKPISaleMan + "'";
                ResultSet rsQueryConfirmedHoD = mydb.executeQuery(queryConfirmedHoD);
                while (rsQueryConfirmedHoD.next()) {
                    if (rsQueryConfirmedHoD.getInt("confirmedGD") == 0) {
            %>
            <input type="submit" value="Accept" name="btAction" onclick="getCode()">
            <input type="submit" value="Reject" name="btAction">
            <%
                    }
                }
            %>
        </div>
        <script>
            document.getElementById("hide").readOnly = true;
            document.getElementById("hide1").readOnly = true;
            document.getElementById("hide2").readOnly = true;
            document.getElementById("hide3").readOnly = true;
        </script>
        <input type="hidden" name="getCode" value="${requestScope.seSaleMan}"/>  
        <input type="hidden" name="username1" value="<%=username1%>"/> 
    </center>
</form>
<%
    }

%>       
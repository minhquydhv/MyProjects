<%-- 
    Document   : Staff,Engineer Performance Evaluate 
    Created on : Aug 3, 2015, 3:53:10 PM
    Author     : Admin
--%>

<%@page import="objects.EvaluateKPIStaff"%>
<%@page import="models.DataServices"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<div>
    ${sessionScope.username}
    <%
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        DataServices mydb = new DataServices();

        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("YY");
        String displayTime = dateFormat.format(date);
        String s1 = displayTime;

        //lay ma nhan vien 
        String staffID = (String) request.getAttribute("staffID");
        ///    
        int countSettingKPI1 = 0;
        String queryCountSettingKPI1 = "select count(*) as 'nums' from tbl_setting_kpi_individual where codeKPIIndividual like '" + displayTime + staffID + "%'";
        ResultSet rsQueryCountSettingKPI1 = mydb.executeQuery(queryCountSettingKPI1);
        while (rsQueryCountSettingKPI1.next()) {
            countSettingKPI1 = rsQueryCountSettingKPI1.getInt("nums");
        }

        //begin
        Date currentDate = new Date();
        SimpleDateFormat dateFormatCurrent = new SimpleDateFormat("dd-MM-yyyy");
        String displayTimeCurrent = dateFormatCurrent.format(currentDate);
        //end

        ArrayList arrayList1 = new ArrayList();
        int kt1 = 0;
        String username1 = (String) session.getAttribute("username");
        int countSettingKPI = 0;
        String queryCountSettingKPI = "select count(*) as 'nums' from tbl_setting_kpi_individual where codeKPIIndividual like '" + displayTime + username1 + "%'";
        ResultSet rsQueryCountSettingKPI = mydb.executeQuery(queryCountSettingKPI);
        while (rsQueryCountSettingKPI.next()) {
            countSettingKPI = rsQueryCountSettingKPI.getInt("nums");
        }

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
            } else if (arrayList1.get(i).equals("06")) {//dgdg
                kt1 = 4;
            } else if (arrayList1.get(i).equals("08")) {//gd
                kt1 = 5;
                break;
            } else if (arrayList1.get(i).equals("04")) {//staff
                kt1 = 1;
                break;
            } else if (arrayList1.get(i).equals("01")) {//cxo
                kt1 = 2;
                break;
            }
        }
        if (kt1 == 1) {
    %>
    <form action="../kpi/evaluateStaff" method="post">
        <script>
            $(document).ready(function() {
                $(".kpi").attr('readonly', 'readonly');
                $(".weightage").attr('readonly', 'readonly');
                $(".points_staff").attr('readonly', 'readonly');
                $(".score_staff").attr('readonly', 'readonly');
            });
        </script>
        <%
            //dem so bang ghi trong bang danh gia performace cua nhan vien
            String countEvaluate = "select count(*) as 'count' from tbl_evaluate_kpi_staff where code_evaluate_kpi like '" + displayTime + username1 + "%'";
            int count = 0;
            ResultSet rsCountEvaluate = mydb.executeQuery(countEvaluate);
            while (rsCountEvaluate.next()) {
                count = rsCountEvaluate.getInt("count");
            }
                    //ket thuc dem so ban ghi

            //begin lay mang
            ArrayList<EvaluateKPIStaff> arrKPIEvaluateStaff = (ArrayList< EvaluateKPIStaff>) request.getAttribute("arrKPIEvaluateStaff");
            String sumPoint = (String) request.getAttribute("sumPoints");

            //end lay mang
            String queryTeamName = "select *from tbl_staff a,tbl_team b where a.teamID =b.teamID and a.staffID='" + username1 + "'";
            String teamName = "";
            ResultSet rsQueryTeamName = mydb.executeQuery(queryTeamName);
            while (rsQueryTeamName.next()) {
                teamName = rsQueryTeamName.getString("teamName");
            }
            String queryConfirmed = "select *from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + displayTime + username1 + "'";
            int confirmedHoD = 0;
            int confirmedGD = 0;
            ResultSet rsQueryConfirmed = mydb.executeQuery(queryConfirmed);
            while (rsQueryConfirmed.next()) {
                confirmedHoD = rsQueryConfirmed.getInt("confirmedHoD");
                confirmedGD = rsQueryConfirmed.getInt("confirmedGD");
            }
            if (((teamName.equals("Sales") && (confirmedGD == 0)) || ((teamName != "Sales") && (confirmedHoD == 0)))) {
        %>
        <%@include file="../../KPINotYetConfimed.jsp" %>
        <%
        } else {

            if (teamName.equals("Sales") || teamName.equals("RD") || teamName.equals("IA")) {

        %>
        <table class="setting guideline"   border="1">
            <tr>
            <th>Excellent</th>
            <th>Exceeds<br />
                Requirements</th>
            <th>Meet<br />
                Requirements</th>
            <th>Need<br />
                Improvement</th>
            <th>Unsatisfactory</th>
            </tr>
            <tr>
            <td>4.5~5.0</td>
            <td>4.0~4.4</td>
            <td>3.0~3.9</td>
            <td>2.0~2.9</td>
            <td>1.0~1.9</td>
            </tr>
        </table>
        <div class="mess">${requestScope.mess}</div>
        <br/>
        <table class="setting evaluateWorker"  border="1">
            <tr>
            <th colspan="7"></th>
            <th colspan="2">1st Appraiser</th>
            <th colspan="2">2st Appraiser</th>
            <th colspan="2">3st Appraiser</th>
            <th colspan="2">4st Appraiser</th>
            </tr>
            <tr>
            <th rowspan="2">No</th>
            <th rowspan="2">KPI</th>
            <th rowspan="2">Actual Result vs the Target Set</th>
            <th>Weightage%</th>
            <th>Rating</th>
            <th>Point</th>
            <th rowspan="2">Main reason of not achieving target</th>
            <th>Rating</th>
            <th>Point</th>
            <th>Rating</th>
            <th>Point</th>
            <th>Rating</th>
            <th >Point</th>
            <th>Rating</th>
            <th >Point</th>
            </tr>
            <tr>
            <th>W</th>
            <th>R</th>
            <th>W x R</th>
            <th>R</th>
            <th>= W x R</th>
            <th>R</th>
            <th>= W x R</th>
            <th>R</th>
            <th >= W x R</th>
            <th>R</th>
            <th >= W x R</th>
            </tr>
            <%                //kiem tra mang
                if (arrKPIEvaluateStaff == null) {

                    if (count == 0) {
                        String querySettingKPI = "select *from tbl_setting_kpi_individual where codeKPIIndividual like '" + displayTime + username1 + "%'";
                        ResultSet rsQuerySettingKPI = mydb.executeQuery(querySettingKPI);
                        int i = 1;
                        while (rsQuerySettingKPI.next()) {

            %>
            <tr>
            <td><%=i%></td>
            <td><input class="kpi" name="kpi<%=i%>" style="width:140px;" type="text" value="<%=rsQuerySettingKPI.getString("jobField")%>"/></td>
            <td><input name="arvstts<%=i%>" style="width:140px;" type="text"></td>
            <td><input class="weightage" name="weightage<%=i%>" style="width:60%;" type="text" value="<%=rsQuerySettingKPI.getString("ratio")%>"></td>
            <td><input name="rating_staff<%=i%>" style="width:60%;" type="text"></td>
            <td><input class="points_staff" name="points_staff<%=i%>" style="width:60%;" type="text"></td>
            <td><input name="mronat<%=i%>" style="width:145px;" type="text"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>

            </tr>
            <%                        i++;
                }
            } else {
                int i = 1;
                String queryEvaluateKPI = "select *from  tbl_evaluate_kpi_staff where code_evaluate_kpi like '" + displayTime + username1 + "%'";
                ResultSet rsQueryEvaluateKPI = mydb.executeQuery(queryEvaluateKPI);
                while (rsQueryEvaluateKPI.next()) {
            %>
            <!--            <script>
                            $(document).ready(function() {
                                $(".kpi").attr('readonly', 'readonly');
                                $(".weightage").attr('readonly', 'readonly');
                                $(".points_staff").attr('readonly', 'readonly');
                            });
                        </script>-->
            <tr>
            <td><%=i%></td>
            <td><input class="kpi" name="kpi<%=i%>"  style="width:140px;" type="text" value="<%=rsQueryEvaluateKPI.getString("kpi")%>"/></td>
            <td><input name="arvstts<%=i%>" style="width:140px;" type="text" value="<%=rsQueryEvaluateKPI.getString("arvstts")%>"></td>
            <td><input class="weightage" style="width:60%;" name="weightage<%=i%>" type="text" value="<%=rsQueryEvaluateKPI.getString("weightage")%>"></td>
            <td><input name="rating_staff<%=i%>"  style="width:60%;" type="text" value="<%=rsQueryEvaluateKPI.getString("rating_staff")%>"></td>
            <td><input class="points_staff" name="points_staff<%=i%>" style="width:60%;" type="text" value="<%=rsQueryEvaluateKPI.getString("points_staff")%>"></td>
            <td><input  name="mronat<%=i%>" style="width:145px;" type="text" value="<%=rsQueryEvaluateKPI.getString("mronat")%>"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            </tr>
            <%
                        i++;
                    }
                }

                String queryAverageScore = "select *from tbl_average_score_staff where code_average_score='" + displayTime + username1 + "'";
                ResultSet rsQueryAverageScore = mydb.executeQuery(queryAverageScore);
                int s = 0;

                while (rsQueryAverageScore.next()) {
                    s++;
            %>
            <tr>
            <td>1</td>    
            <td colspan="2">Total</td>
            <td>100%</td>
            <td>1</td>
            <td><%=rsQueryAverageScore.getString("score_staff")%></td>
            <td>1</td>
            <td>1</td>
            <td><%=rsQueryAverageScore.getString("score_teamleader")%></td>
            <td>1</td>
            <td><%=rsQueryAverageScore.getString("score_hod")%></td>
            <td>1</td>
            <td><%=rsQueryAverageScore.getString("score_cxo")%></td>
            <td>1</td>   
            <td>1</td>  
            </tr>
            <%
                }
                if (s == 0) {
            %>
            <tr>
            <td>1</td>
            <td colspan="2">Total</td>
            <td>100%</td>
            <td>1</td>
            <td><input class="score_staff" name="score_staff" style="width:60%;" type="text" /></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>

            </tr>
            <%
                }
            } else {

                for (int i = 0; i < arrKPIEvaluateStaff.size(); i++) {
                    int j = i + 1;
            %>

            <tr>
            <td><%=j%></td>
            <td><input class="kpi" style="width:140px;"  name="kpi<%=j%>" type="text" value="<%=arrKPIEvaluateStaff.get(i).getKpi()%>"></td>
            <td><input style="width:60%;" name="arvstts<%=j%>"   type="text" value="<%=arrKPIEvaluateStaff.get(i).getArvstts()%>"></td>
            <td><input class="weightage" style="width:60%;" name="weightage<%=j%>" type="text" value="<%=arrKPIEvaluateStaff.get(i).getWeightage()%>"></td>
            <td><input style="width:145px;" name="rating_staff<%=j%>" type="text" value="<%=arrKPIEvaluateStaff.get(i).getRating_staff()%>"></td>
            <td><input class="points_staff" style="width:60%;" name="points_staff<%=j%>" type="text" value="<%=arrKPIEvaluateStaff.get(i).getPoints_staff()%>"></td>
            <td><input style="width:60%;" name="mronat<%=j%>" type="text" value="<%=arrKPIEvaluateStaff.get(i).getMronat()%>"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            </tr>
            <%
                }

            %>
            <tr>
            <td>1</td>
            <td colspan="2">Total</td>
            <td>100%</td>
            <td>1</td>
            <td><input class="score_staff" name="score_staff" style="width:60%;" type="text" value="<%=sumPoint%>" /></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            </tr>

            <%                    }

            %>


        </table>
        <br/>
        <table class="performanceStaff comment" >
            <tr>
            <td rowspan="2">Appraisee Comment</td>
            <td rowspan="2"><textarea name="taTeamLeader"></textarea></td>
            <td>Signature</td>
            </tr>
            <tr>
            <td><input name="txtTeamLeader" type="text" style="width: 80%;" /></td>
            </tr>
            <tr>
            <td rowspan="2">1Appraisee s Comment</td>
            <td rowspan="2"><textarea name="taHoD"></textarea></td>
            <td>Signature</td>
            </tr>
            <tr>
            <td><input name="txtHoD" type="text" style="width: 80%;" /></td>
            </tr>
            <tr>
            <td rowspan="2">2Appraisees Comment</td>
            <td rowspan="2"><textarea name="taCxO"></textarea></td>

            <td>Signature</td>
            </tr>
            <tr>
            <td><input name="txtCxO" type="text" style="width: 80%" /></td>
            </tr>
            <tr>
            <td rowspan="2">3Appraisees Comment</td>
            <td rowspan="2"><textarea name="taBoD"></textarea></td>

            <td>Signature</td>
            </tr>
            <tr>
            <td><input name="BoD" type="text" style="width: 80%" /></td>
            </tr>
        </table>
        <%        } else {
            ///nhan vien binh thuong bat dau tu day
        %>
        <table class="setting guideline"   border="1">
            <tr>
            <th>Excellent</th>
            <th>Exceeds<br />
                Requirements</th>
            <th>Meet<br />
                Requirements</th>
            <th>Need<br />
                Improvement</th>
            <th>Unsatisfactory</th>
            </tr>
            <tr>
            <td>4.5~5.0</td>
            <td>4.0~4.4</td>
            <td>3.0~3.9</td>
            <td>2.0~2.9</td>
            <td>1.0~1.9</td>
            </tr>
        </table>
        <div class="mess">${requestScope.mess}</div>
        <br/>
        <table class="setting evaluateWorker"  border="1">
            <tr>
            <th colspan="7"></th>
            <th colspan="2">1st Appraiser</th>
            <th colspan="2">2st Appraiser</th>
            <th colspan="2">3st Appraiser</th>
            </tr>
            <tr>
            <th rowspan="2">No</th>
            <th rowspan="2">KPI</th>
            <th rowspan="2">Actual Result vs the Target Set</th>
            <th>Weightage%</th>
            <th>Rating</th>
            <th>Point</th>
            <th rowspan="2">Main reason of not achieving target</th>
            <th>Rating</th>
            <th>Point</th>
            <th>Rating</th>
            <th>Point</th>
            <th>Rating</th>
            <th >Point</th>
            </tr>
            <tr>
            <th>W</th>
            <th>R</th>
            <th>W x R</th>
            <th>R</th>
            <th>= W x R</th>
            <th>R</th>
            <th>= W x R</th>
            <th>R</th>
            <th >= W x R</th>
            </tr>
            <%
                if (arrKPIEvaluateStaff == null) {
                    if (count == 0) {
                        String querySettingKPI = "select *from tbl_setting_kpi_individual where codeKPIIndividual like '" + displayTime + username1 + "%'";
                        ResultSet rsQuerySettingKPI = mydb.executeQuery(querySettingKPI);
                        int i = 1;
                        while (rsQuerySettingKPI.next()) {

            %>
            <tr>
            <td><%=i%></td>

            <td><input class="kpi" name="kpi<%=i%>" style="width:140px;" type="text" value="<%=rsQuerySettingKPI.getString("jobField")%>"/></td>
            <td><input name="arvstts<%=i%>" style="width:140px;" type="text"></td>
            <td><input class="weightage" name="weightage<%=i%>" style="width:60%;" type="text" value="<%=rsQuerySettingKPI.getString("ratio")%>"></td>
            <td><input name="rating_staff<%=i%>" style="width:60%;" type="text"></td>
            <td><input class="points_staff" name="points_staff<%=i%>" style="width:60%;" type="text"></td>
            <td><input name="mronat<%=i%>" style="width:145px;" type="text"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            </tr>
            <%                        i++;
                }
            } else {
                int i = 1;
                String queryEvaluateKPI = "select *from  tbl_evaluate_kpi_staff where code_evaluate_kpi like '" + displayTime + username1 + "%'";
                ResultSet rsQueryEvaluateKPI = mydb.executeQuery(queryEvaluateKPI);
                while (rsQueryEvaluateKPI.next()) {
            %>
            <tr>
            <td><%=i%></td>
            <td><input class="kpi" name="kpi<%=i%>"  style="width:140px;" type="text" value="<%=rsQueryEvaluateKPI.getString("kpi")%>"/></td>
            <td><input name="arvstts<%=i%>" style="width:140px;" type="text" value="<%=rsQueryEvaluateKPI.getString("arvstts")%>"></td>
            <td><input class="weightage" name="weightage<%=i%>" style="width:60%;" type="text" value="<%=rsQueryEvaluateKPI.getString("weightage")%>"></td>
            <td><input name="rating_staff<%=i%>" style="width:60%;" type="text" value="<%=rsQueryEvaluateKPI.getString("rating_staff")%>"></td>
            <td><input class="points_staff" name="points_staff<%=i%>" style="width:60%;" type="text" value="<%=rsQueryEvaluateKPI.getString("points_staff")%>"></td>
            <td><input  name="mronat<%=i%>" style="width:145px;" type="text" value="<%=rsQueryEvaluateKPI.getString("mronat")%>"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            </tr>
            <%
                        i++;
                    }
                }

                String queryAverageScore = "select *from tbl_average_score_staff where code_average_score='" + displayTime + username1 + "'";
                ResultSet rsQueryAverageScore = mydb.executeQuery(queryAverageScore);
                int s = 0;
                while (rsQueryAverageScore.next()) {
                    s++;
            %>
            <tr>
            <td></td>
            <td colspan="2">Total</td>
            <td>100%</td>
            <td>1</td>
            <td><%=rsQueryAverageScore.getString("score_staff")%></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            </tr>
            <%
                }
                if (s == 0) {
            %>
            <tr>
            <td>1</td>
            <td colspan="2">Total</td>
            <td>100%</td>
            <td></td>
            <td><input class="score_staff" name="score_staff" style="width:60%;" type="text"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            </tr>
            <%
                }
            } else {

                for (int i = 0; i < arrKPIEvaluateStaff.size(); i++) {
                    int j = i + 1;
            %>
            <tr>
            <td><%=j%></td>
            <td><input class="kpi" style="width:140px;"  name="kpi<%=j%>" type="text" value="<%=arrKPIEvaluateStaff.get(i).getKpi()%>"></td>
            <td><input  style="width:60%;" name="arvstts<%=j%>"   type="text" value="<%=arrKPIEvaluateStaff.get(i).getArvstts()%>"></td>
            <td><input class="weightage" style="width:60%;" name="weightage<%=j%>" type="text" value="<%=arrKPIEvaluateStaff.get(i).getWeightage()%>"></td>
            <td><input style="width:145px;" name="rating_staff<%=j%>" type="text" value="<%=arrKPIEvaluateStaff.get(i).getRating_staff()%>"></td>
            <td><input class="points_staff" style="width:60%;" name="points_staff<%=j%>" type="text" value="<%=arrKPIEvaluateStaff.get(i).getPoints_staff()%>"></td>
            <td><input style="width:60%;" name="mronat<%=j%>" type="text" value="<%=arrKPIEvaluateStaff.get(i).getMronat()%>"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>

            </tr>
            <%
                }
            %>
            <tr>
            <td>1</td>
            <td colspan="2">Total</td>
            <td>100%</td>
            <td>Total</td>
            <td><input class="score_staff" name="score_staff" style="width:60%;" type="text" value="<%=sumPoint%>"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            </tr>

            <%
                }

            %>


        </table>
        <br/>
        <table class="performanceStaff comment" >
            <tr>
            <td rowspan="2">Appraisee Comment</td>
            <td rowspan="2"><textarea name="taTeamleader"></textarea></td>
            <td>Signature</td>
            </tr>
            <tr>
            <td><input name="txtTeamLeader" type="text" style="width: 80%;" /></td>
            </tr>
            <tr>
            <td rowspan="2">1Appraisee s Comment</td>
            <td rowspan="2"><textarea name="taHoD"></textarea></td>
            <td>Signature</td>
            </tr>
            <tr>
            <td><input name="txtHoD" type="text" style="width: 80%;" /></td>
            </tr>
            <tr>
            <td rowspan="2">2Appraisees Comment</td>
            <td rowspan="2"><textarea name="taCxO"></textarea></td>

            <td>Signature</td>
            </tr>
            <tr>
            <td><input name="txtCxO" type="text" style="width: 80%" /></td>
            </tr>
        </table>


        <%                                   //ket thuc cua nhan vien binh thuong
                }
            }

        %>

        <center><input type="submit" value="Grading" name="btAction"  />
            <input type="submit" value="Save" name="btAction" />
            <input type="submit" value="Send Mail" name="btAction"  />
            <input type="hidden" value="<%=countSettingKPI%>" name="numRows" />
            <input type="hidden" value="<%=username1%>" name="uname" />
        </center>
    </form>
    <%
    }//ket thuc phan danh gia cua nhan vien
    else if (kt1 == 3)//bat dau phan danh gia teamleader
    {
    %>
    <form action="../kpi/evaluateTeamLeader" method="post">
        <script>
            $(document).ready(function() {
                $(".kpi").attr('readonly', 'readonly');
                $(".weightage").attr('readonly', 'readonly');
                $(".points_staff").attr('readonly', 'readonly');
                $(".score_staff").attr('readonly', 'readonly');
            });

        </script>

        <%
            ArrayList<EvaluateKPIStaff> arrEvaluateKPIStaff = (ArrayList<EvaluateKPIStaff>) request.getAttribute("arrEvaluateKPIStaff");
            String sumPoints = (String) request.getAttribute("sumPoints");
        %>
        <center>
            <table class="staff-wrapper">
                <tr>

                <td>
                    <%
                        ArrayList arrStaffID = new ArrayList();
                        ArrayList arrStaffName = new ArrayList();
                        String teamID = "";
                        String teamName = "";

                        String queryTeamID = "select *from tbl_staff a,tbl_team b where a.teamID=b.teamID and  a.staffID='" + username1 + "'";
                        ResultSet rsQueryTeamID = mydb.executeQuery(queryTeamID);
                        while (rsQueryTeamID.next()) {
                            teamID = rsQueryTeamID.getString("teamID");
                            teamName = rsQueryTeamID.getString("teamName");
                        }
                        String queryStaff = "select* from tbl_staff a ,tbl_team b where a.teamID = b.teamID and b.teamID='" + teamID + "'";
                        ResultSet rsQueryStaff = mydb.executeQuery(queryStaff);
                        while (rsQueryStaff.next()) {
                            String code = displayTime + rsQueryStaff.getString("staffID");
                            String queryEvaluate = "select *from tbl_evaluate_individual where code_evaluate_individual='" + code + "'";
                            ResultSet rsQueryEvaluate = mydb.executeQuery(queryEvaluate);
                            while (rsQueryEvaluate.next()) {
                                if (rsQueryEvaluate.getInt("evaluate_individual") == 1) {
                                    arrStaffID.add(rsQueryStaff.getString("staffID"));
                                    arrStaffName.add(rsQueryStaff.getString("staffName"));
                                }
                            }
                        }

                    %>
                    <select name="seStaff" >
                        <%                            for (int i = 0; i < arrStaffName.size(); i++) {
                        %>
                        <option value="<%=arrStaffID.get(i)%>"><%=arrStaffName.get(i)%></option>  
                        <%}%>
                    </select></td>
                <td><input type="submit" value="Select Staff" name="btAction"/></td>
                </tr>  
            </table>
            <%
                if (teamName.equals("Sales") || teamName.equals("RD") || teamName.equals("IA")) {
                    if (arrEvaluateKPIStaff == null) {//kiem tra mang
            %>
            <table class="setting guideline"   border="1">
                <tr>
                <th>Excellent</th>
                <th>Exceeds<br />
                    Requirements</th>
                <th>Meet<br />
                    Requirements</th>
                <th>Need<br />
                    Improvement</th>
                <th>Unsatisfactory</th>
                </tr>
                <tr>
                <td>4.5~5.0</td>
                <td>4.0~4.4</td>
                <td>3.0~3.9</td>
                <td>2.0~2.9</td>
                <td>1.0~1.9</td>
                </tr>
            </table>
            <div class="mess">${requestScope.mess}</div>
            <br/>
            <table class="setting evaluateWorker"  border="1">
                <tr>
                <th colspan="7"></th>
                <th colspan="2">1st Appraiser</th>
                <th colspan="2">2st Appraiser</th>
                <th colspan="2">3st Appraiser</th>
                <th colspan="2">4st Appraiser</th>
                </tr>
                <tr>
                <th rowspan="2">No</th>
                <th rowspan="2">KPI</th>
                <th rowspan="2">Actual Result vs the Target Set</th>
                <th>Weightage%</th>
                <th>Rating</th>
                <th>Point</th>
                <th rowspan="2">Main reason of not achieving target</th>
                <th>Rating</th>
                <th>Point</th>
                <th>Rating</th>
                <th>Point</th>
                <th>Rating</th>
                <th >Point</th>
                <th>Rating</th>
                <th >Point</th>
                </tr>
                <tr>
                <th>W</th>
                <th>R</th>
                <th>W x R</th>
                <th>R</th>
                <th>= W x R</th>
                <th>R</th>
                <th>= W x R</th>
                <th>R</th>
                <th >= W x R</th>
                <th>R</th>
                <th >= W x R</th>
                </tr>        
                <%
                    int i = 1;
                    String queryEvaluateKPI = "select *from  tbl_evaluate_kpi_staff where code_evaluate_kpi like '" + displayTime + staffID + "%'";
                    ResultSet rsQueryEvaluateKPI = mydb.executeQuery(queryEvaluateKPI);
                    while (rsQueryEvaluateKPI.next()) {
                %>
                <tr>
                <td><%=i%></td>
                <td><%=rsQueryEvaluateKPI.getString("kpi")%></td>
                <td><%=rsQueryEvaluateKPI.getString("arvstts")%></td>
                <td><%=rsQueryEvaluateKPI.getString("weightage")%></td>
                <td><%=rsQueryEvaluateKPI.getString("rating_staff")%></td>
                <td><%=rsQueryEvaluateKPI.getString("points_staff")%></td>
                <td><%=rsQueryEvaluateKPI.getString("mronat")%></td>
                <td><input type="text" style="width:60px;" name="rating_teamleader<%=i%>" value="<%=rsQueryEvaluateKPI.getString("rating_teamleader")%>"/></td>
                <td><input class="score_staff" type="text" style="width:60px;" name="points_teamleader<%=i%>" value="<%=rsQueryEvaluateKPI.getString("points_teamleader")%>"/></td>
                <td><%=rsQueryEvaluateKPI.getString("rating_hod")%></td>
                <td><%=rsQueryEvaluateKPI.getString("points_hod")%></td>
                <td><%=rsQueryEvaluateKPI.getString("rating_cxo")%></td>
                <td><%=rsQueryEvaluateKPI.getString("points_cxo")%></td>
                <td><%=rsQueryEvaluateKPI.getString("rating_dgd")%></td>
                <td><%=rsQueryEvaluateKPI.getString("points_dgd")%></td>
                <td><%=rsQueryEvaluateKPI.getString("rating_gd")%></td>
                <td><%=rsQueryEvaluateKPI.getString("points_gd")%></td>
                </tr>
                <%
                        i++;

                    }
                    String queryScore = "select *from tbl_average_score_staff where code_average_score ='" + displayTime + staffID + "'";
                    ResultSet rsQueryScore = mydb.executeQuery(queryScore);
                    while (rsQueryScore.next()) {
                %>

                <tr>
                <td>1</td>
                <td colspan="2">Total</td>
                <td>100%</td>
                <td>1</td>
                <td><%=rsQueryScore.getString("score_staff")%></td>
                <td></td>
                <td></td>
                <td><input class="score_staff" class="score_staff" name="score_teamleader" style="width:60px;" type="text" value="<%=rsQueryScore.getString("score_teamleader")%>" /></td>
                <td></td>
                <td><%=rsQueryScore.getString("score_hod")%></td>
                <td></td>
                <td><%=rsQueryScore.getString("score_dgd")%></td>
                <td></td>
                <td><%=rsQueryScore.getString("score_gd")%></td>
                </tr>
                <%
                    }
                } else {

                %>
                <table class="setting guideline"   border="1">
                    <tr>
                    <th>Excellent</th>
                    <th>Exceeds<br />
                        Requirements</th>
                    <th>Meet<br />
                        Requirements</th>
                    <th>Need<br />
                        Improvement</th>
                    <th>Unsatisfactory</th>
                    </tr>
                    <tr>
                    <td>4.5~5.0</td>
                    <td>4.0~4.4</td>
                    <td>3.0~3.9</td>
                    <td>2.0~2.9</td>
                    <td>1.0~1.9</td>
                    </tr>
                </table>
                <div class="mess">${requestScope.mess}</div>
                <br/>
                <table class="setting evaluateWorker"  border="1">
                    <tr>
                    <th colspan="7"></th>
                    <th colspan="2">1st Appraiser</th>
                    <th colspan="2">2st Appraiser</th>
                    <th colspan="2">3st Appraiser</th>
                    <th colspan="2">4st Appraiser</th>
                    </tr>
                    <tr>
                    <th rowspan="2">No</th>
                    <th rowspan="2">KPI</th>
                    <th rowspan="2">Actual Result vs the Target Set</th>
                    <th>Weightage%</th>
                    <th>Rating</th>
                    <th>Point</th>
                    <th rowspan="2">Main reason of not achieving target</th>
                    <th>Rating</th>
                    <th>Point</th>
                    <th>Rating</th>
                    <th>Point</th>
                    <th>Rating</th>
                    <th >Point</th>
                    <th>Rating</th>
                    <th >Point</th>
                    </tr>
                    <tr>
                    <th>W</th>
                    <th>R</th>
                    <th>W x R</th>
                    <th>R</th>
                    <th>= W x R</th>
                    <th>R</th>
                    <th>= W x R</th>
                    <th>R</th>
                    <th >= W x R</th>
                    <th>R</th>
                    <th >= W x R</th>
                    </tr>        
                    <%                    int i = 1;
                        for (int j = 0; j < arrEvaluateKPIStaff.size(); j++) {
                    %>
                    <tr>
                    <td><%=i%></td>
                    <td><%=arrEvaluateKPIStaff.get(j).getKpi()%></td>
                    <td><%=arrEvaluateKPIStaff.get(j).getArvstts()%></td>
                    <td><%=arrEvaluateKPIStaff.get(j).getWeightage()%></td>
                    <td><%=arrEvaluateKPIStaff.get(j).getRating_staff()%></td>
                    <td><%=arrEvaluateKPIStaff.get(j).getPoints_staff()%></td>
                    <td><%=arrEvaluateKPIStaff.get(j).getMronat()%></td>
                    <td><input type="text" style="width:60px;" name="rating_teamleader<%=i%>" value="<%=arrEvaluateKPIStaff.get(j).getRating_teamleader()%>"/></td>
                    <td><input class="score_staff" type="text" style="width:60px;" name="points_teamleader<%=i%>" value="<%=arrEvaluateKPIStaff.get(j).getPoints_teamleader()%>"/></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    </tr>
                    <%
                            i++;

                        }
                        String queryScore = "select *from tbl_average_score_staff where code_average_score ='" + displayTime + staffID + "'";
                        ResultSet rsQueryScore = mydb.executeQuery(queryScore);
                        while (rsQueryScore.next()) {
                    %>

                    <tr>
                    <td>1</td>
                    <td colspan="2">Total</td>
                    <td>100%</td>
                    <td>1</td>
                    <td><%=rsQueryScore.getString("score_staff")%></td>
                    <td></td>
                    <td></td>
                    <td><input class="score_staff" class="score_staff" name="score_teamleader" style="width:60px;" type="text" value="<%=sumPoints%>" /></td>
                    <td></td>
                    <td><%=rsQueryScore.getString("score_hod")%></td>
                    <td></td>
                    <td><%=rsQueryScore.getString("score_dgd")%></td>
                    <td></td>
                    <td><%=rsQueryScore.getString("score_gd")%></td>
                    </tr>



                    <%    }
                        }

                    %>
                </table>
                <%                int s = 0;
                    String queryCommentEvaluate = "select *from tbl_comment_evaluate_staff where code_comment_evaluate_staff='" + displayTime + staffID + "'";
                    ResultSet rsQueryCommentEvaluate = mydb.executeQuery(queryCommentEvaluate);
                    while (rsQueryCommentEvaluate.next()) {
                        s++;
                %>
                <table class="performanceStaff comment" >
                    <tr>
                    <td rowspan="2">Appraisee Comment</td>
                    <td rowspan="2"><textarea name="taTeamLeader"><%=rsQueryCommentEvaluate.getString("comment_teamleader")%></textarea></td>
                    <td>Signature</td>
                    </tr>
                    <tr>
                    <td><input name="txtTeamLeader" type="text" style="width: 80%;" /></td>
                    </tr>
                    <tr>
                    <td rowspan="2">1Appraisee s Comment</td>
                    <td rowspan="2"><textarea name="taHoD"><%=rsQueryCommentEvaluate.getString("comment_hod")%></textarea></td>
                    <td>Signature</td>
                    </tr>
                    <tr>
                    <td><input name="txtHoD" type="text" style="width: 80%;" /></td>
                    </tr>
                    <tr>
                    <td rowspan="2">2Appraisees Comment</td>
                    <td rowspan="2"><textarea name="taCxO"><%=rsQueryCommentEvaluate.getString("comment_dgd")%></textarea></td>

                    <td>Signature</td>
                    </tr>
                    <tr>
                    <td><input name="txtCxO" type="text" style="width: 80%" /></td>
                    </tr>
                    <tr>
                    <td rowspan="2">3Appraisees Comment</td>
                    <td rowspan="2"><textarea name="taBoD"><%=rsQueryCommentEvaluate.getString("comment_gd")%></textarea></td>

                    <td>Signature</td>
                    </tr>
                    <tr>
                    <td><input name="BoD" type="text" style="width: 80%" /></td>
                    </tr>
                </table>
                <%
                    }
                    if (s == 0) {
                %>
                <table class="performanceStaff comment" >
                    <tr>
                    <td rowspan="2">Appraisee Comment</td>
                    <td rowspan="2"><textarea name="taTeamLeader"></textarea></td>
                    <td>Signature</td>
                    </tr>
                    <tr>
                    <td><input name="txtTeamLeader" type="text" style="width: 80%;" /></td>
                    </tr>
                    <tr>
                    <td rowspan="2">1Appraisee s Comment</td>
                    <td rowspan="2"><textarea name="taHoD"></textarea></td>
                    <td>Signature</td>
                    </tr>
                    <tr>
                    <td><input name="txtHoD" type="text" style="width: 80%;" /></td>
                    </tr>
                    <tr>
                    <td rowspan="2">2Appraisees Comment</td>
                    <td rowspan="2"><textarea name="taCxO"></textarea></td>

                    <td>Signature</td>
                    </tr>
                    <tr>
                    <td><input name="txtCxO" type="text" style="width: 80%" /></td>
                    </tr>
                    <tr>
                    <td rowspan="2">3Appraisees Comment</td>
                    <td rowspan="2"><textarea name="taBoD"></textarea></td>

                    <td>Signature</td>
                    </tr>
                    <tr>
                    <td><input name="BoD" type="text" style="width: 80%" /></td>
                    </tr>
                </table>
                <%
                    }
                } else {
                    ///nhan vien binh thuong bat dau tu day
                    if (arrEvaluateKPIStaff == null) {
                %>
                <table class="setting guideline"   border="1">
                    <tr>
                    <th>Excellent</th>
                    <th>Exceeds<br />
                        Requirements</th>
                    <th>Meet<br />
                        Requirements</th>
                    <th>Need<br />
                        Improvement</th>
                    <th>Unsatisfactory</th>
                    </tr>
                    <tr>
                    <td>4.5~5.0</td>
                    <td>4.0~4.4</td>
                    <td>3.0~3.9</td>
                    <td>2.0~2.9</td>
                    <td>1.0~1.9</td>
                    </tr>
                </table>
                <div class="mess">${requestScope.mess}</div>
                <br/>
                <table class="setting evaluateWorker"  border="1">
                    <tr>
                    <th colspan="7"></th>
                    <th colspan="2">1st Appraiser</th>
                    <th colspan="2">2st Appraiser</th>
                    <th colspan="2">3st Appraiser</th>
                    </tr>
                    <tr>
                    <th rowspan="2">No</th>
                    <th rowspan="2">KPI</th>
                    <th rowspan="2">Actual Result vs the Target Set</th>
                    <th>Weightage%</th>
                    <th>Rating</th>
                    <th>Point</th>
                    <th rowspan="2">Main reason of not achieving target</th>
                    <th>Rating</th>
                    <th>Point</th>
                    <th>Rating</th>
                    <th>Point</th>
                    <th>Rating</th>
                    <th >Point</th>
                    </tr>
                    <tr>
                    <th>W</th>
                    <th>R</th>
                    <th>W x R</th>
                    <th>R</th>
                    <th>= W x R</th>
                    <th>R</th>
                    <th>= W x R</th>
                    <th>R</th>
                    <th >= W x R</th>
                    </tr>
                    <%
                        int i = 1;
                        String queryEvaluateKPI = "select *from  tbl_evaluate_kpi_staff where code_evaluate_kpi like '" + displayTime + staffID + "%'";
                        ResultSet rsQueryEvaluateKPI = mydb.executeQuery(queryEvaluateKPI);
                        while (rsQueryEvaluateKPI.next()) {
                    %>
                    <tr>
                    <td><%=i%></td>
                    <td><%=rsQueryEvaluateKPI.getString("kpi")%></td>
                    <td><%=rsQueryEvaluateKPI.getString("arvstts")%></td>
                    <td><%=rsQueryEvaluateKPI.getString("weightage")%></td>
                    <td><%=rsQueryEvaluateKPI.getString("rating_staff")%></td>
                    <td><%=rsQueryEvaluateKPI.getString("points_staff")%></td>
                    <td><%=rsQueryEvaluateKPI.getString("mronat")%></td>
                    <td><input type="text" style="width:60px;" name="rating_teamleader<%=i%>" value="<%=rsQueryEvaluateKPI.getString("rating_teamleader")%>"/></td>
                    <td><input class="score_staff" type="text" style="width:60px;" name="points_teamleader<%=i%>" value="<%=rsQueryEvaluateKPI.getString("points_teamleader")%>"/></td>
                    <td><%=rsQueryEvaluateKPI.getString("rating_hod")%></td>
                    <td><%=rsQueryEvaluateKPI.getString("points_hod")%></td>
                    <td><%=rsQueryEvaluateKPI.getString("rating_cxo")%></td>
                    <td><%=rsQueryEvaluateKPI.getString("points_cxo")%></td>

                    </tr>
                    <%
                            i++;

                        }
                        String queryScore = "select *from tbl_average_score_staff where code_average_score ='" + displayTime + staffID + "'";
                        ResultSet rsQueryScore = mydb.executeQuery(queryScore);
                        while (rsQueryScore.next()) {
                    %>

                    <tr>
                    <td>1</td>
                    <td colspan="2">Total</td>
                    <td>100%</td>
                    <td>1</td>
                    <td><%=rsQueryScore.getString("score_staff")%></td>
                    <td></td>
                    <td></td>
                    <td><input class="score_staff" class="score_staff" name="score_teamleader" style="width:60px;" type="text" value="<%=rsQueryScore.getString("score_teamleader")%>" /></td>
                    <td></td>
                    <td><%=rsQueryScore.getString("score_hod")%></td>
                    <td></td>
                    <td><%=rsQueryScore.getString("score_cxo")%></td>
                    <td></td>

                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <table class="setting guideline"   border="1">
                        <tr>
                        <th>Excellent</th>
                        <th>Exceeds<br />
                            Requirements</th>
                        <th>Meet<br />
                            Requirements</th>
                        <th>Need<br />
                            Improvement</th>
                        <th>Unsatisfactory</th>
                        </tr>
                        <tr>
                        <td>4.5~5.0</td>
                        <td>4.0~4.4</td>
                        <td>3.0~3.9</td>
                        <td>2.0~2.9</td>
                        <td>1.0~1.9</td>
                        </tr>
                    </table>
                    <div class="mess">${requestScope.mess}</div>
                    <br/>
                    <table class="setting evaluateWorker"  border="1">
                        <tr>
                        <th colspan="7"></th>
                        <th colspan="2">1st Appraiser</th>
                        <th colspan="2">2st Appraiser</th>
                        <th colspan="2">3st Appraiser</th>
                        </tr>
                        <tr>
                        <th rowspan="2">No</th>
                        <th rowspan="2">KPI</th>
                        <th rowspan="2">Actual Result vs the Target Set</th>
                        <th>Weightage%</th>
                        <th>Rating</th>
                        <th>Point</th>
                        <th rowspan="2">Main reason of not achieving target</th>
                        <th>Rating</th>
                        <th>Point</th>
                        <th>Rating</th>
                        <th>Point</th>
                        <th>Rating</th>
                        <th >Point</th>
                        </tr>
                        <tr>
                        <th>W</th>
                        <th>R</th>
                        <th>W x R</th>
                        <th>R</th>
                        <th>= W x R</th>
                        <th>R</th>
                        <th>= W x R</th>
                        <th>R</th>
                        <th >= W x R</th>
                        </tr>
                        <%
                            int i = 1;
                            for (int j = 0; j < arrEvaluateKPIStaff.size(); j++) {
                        %>
                        <tr>
                        <td><%=i%></td>
                        <td><%=arrEvaluateKPIStaff.get(j).getKpi()%></td>
                        <td><%=arrEvaluateKPIStaff.get(j).getArvstts()%></td>
                        <td><%=arrEvaluateKPIStaff.get(j).getWeightage()%></td>
                        <td><%=arrEvaluateKPIStaff.get(j).getRating_staff()%></td>
                        <td><%=arrEvaluateKPIStaff.get(j).getPoints_staff()%></td>
                        <td><%=arrEvaluateKPIStaff.get(j).getMronat()%></td>
                        <td><input type="text" style="width:60px;" name="rating_teamleader<%=i%>" value="<%=arrEvaluateKPIStaff.get(j).getPoints_teamleader()%>"/></td>
                        <td><input class="score_staff" type="text" style="width:60px;" name="points_teamleader<%=i%>" value="<%=arrEvaluateKPIStaff.get(j).getPoints_teamleader()%>"/></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>

                        </tr>
                        <%
                                i++;

                            }
                            String queryScore = "select *from tbl_average_score_staff where code_average_score ='" + displayTime + staffID + "'";
                            ResultSet rsQueryScore = mydb.executeQuery(queryScore);
                            while (rsQueryScore.next()) {
                        %>

                        <tr>
                        <td>1</td>
                        <td colspan="2">Total</td>
                        <td>100%</td>
                        <td>1</td>
                        <td><%=rsQueryScore.getString("score_staff")%></td>
                        <td></td>
                        <td></td>
                        <td><input class="score_staff" class="score_staff" name="score_teamleader" style="width:60px;" type="text" value="<%=sumPoints%>" /></td>
                        <td></td>
                        <td><%=rsQueryScore.getString("score_hod")%></td>
                        <td></td>
                        <td><%=rsQueryScore.getString("score_cxo")%></td>
                        <td></td>

                        </tr>
                        <%
                                }
                            }
                        %>
                    </table>
                    <%                int s11 = 0;
                        String queryCommentEvaluate1 = "select *from tbl_comment_evaluate_staff where code_comment_evaluate_staff='" + displayTime + staffID + "'";
                        ResultSet rsQueryCommentEvaluate1 = mydb.executeQuery(queryCommentEvaluate1);
                        while (rsQueryCommentEvaluate1.next()) {
                            s11++;
                    %>
                    <table class="performanceStaff comment" >
                        <tr>
                        <td rowspan="2">Appraisee Comment</td>
                        <td rowspan="2"><textarea name="taTeamLeader"><%=rsQueryCommentEvaluate1.getString("comment_teamleader")%></textarea></td>
                        <td>Signature</td>
                        </tr>
                        <tr>
                        <td><input name="txtTeamLeader" type="text" style="width: 80%;" /></td>
                        </tr>
                        <tr>
                        <td rowspan="2">1Appraisee s Comment</td>
                        <td rowspan="2"><textarea name="taHoD"><%=rsQueryCommentEvaluate1.getString("comment_hod")%></textarea></td>
                        <td>Signature</td>
                        </tr>
                        <tr>
                        <td><input name="txtHoD" type="text" style="width: 80%;" /></td>
                        </tr>
                        <tr>
                        <td rowspan="2">2Appraisees Comment</td>
                        <td rowspan="2"><textarea name="taCxO"><%=rsQueryCommentEvaluate1.getString("comment_cxo")%></textarea></td>

                        <td>Signature</td>
                        </tr>
                        <tr>
                        <td><input name="txtCxO" type="text" style="width: 80%" /></td>
                        </tr>

                    </table>
                    <%
                        }
                        if (s11 == 0) {
                    %>
                    <table class="performanceStaff comment" >
                        <tr>
                        <td rowspan="2">Appraisee Comment</td>
                        <td rowspan="2"><textarea name="taTeamLeader"></textarea></td>
                        <td>Signature</td>
                        </tr>
                        <tr>
                        <td><input name="txtTeamLeader" type="text" style="width: 80%;" /></td>
                        </tr>
                        <tr>
                        <td rowspan="2">1Appraisee s Comment</td>
                        <td rowspan="2"><textarea name="taHoD"></textarea></td>
                        <td>Signature</td>
                        </tr>
                        <tr>
                        <td><input name="txtHoD" type="text" style="width: 80%;" /></td>
                        </tr>
                        <tr>
                        <td rowspan="2">2Appraisees Comment</td>
                        <td rowspan="2"><textarea name="taCxO"></textarea></td>

                        <td>Signature</td>
                        </tr>
                        <tr>
                        <td><input name="txtCxO" type="text" style="width: 80%" /></td>
                        </tr>
                    </table>
                    <%
                            }
                        }

                    %>
                    </center>
                    <center><input type="submit" value="Grading" name="btAction"  />
                        <input type="submit" value="Save" name="btAction" />
                        <input type="submit" value="Send Mail" name="btAction"  />
                        <input type="text" value="<%=countSettingKPI1%>" name="numRows" />
                        <input type="text" value="<%=staffID%>" name="staffID" />
                    </center>
                    </form>
                    <%            } else if (kt1 == 0) {//bat dau cho HoD


                    %>
                    <form action="../kpi/evaluateHoD" method="post">
                        <%                            ArrayList<EvaluateKPIStaff> arrEvaluateKPIStaff = (ArrayList<EvaluateKPIStaff>) request.getAttribute("arrEvaluateKPIStaff");
                            String sumPoints = (String) request.getAttribute("sumPoints");
                            String queryDept = "select *from tbl_staff a ,tbl_team b,tbl_department c where a.teamID = b.teamID and b.deptID=c.deptID and a.staffID='" + username1 + "'";
                            String deptID = "";
                            ResultSet rsQueryDept = mydb.executeQuery(queryDept);
                            while (rsQueryDept.next()) {
                                deptID = rsQueryDept.getString("deptID");
                            }

                        %>
                        <table class="staff-wrapper">
                            <tr>
                            <td>

                                Select Team:     <select name="seTeam">
                                    <%                                    out.print(request.getAttribute("teamID"));
                                        ArrayList arrayListTL = new ArrayList();
                                        ArrayList arrayListTeamName = new ArrayList();
                                        ArrayList arrayListTeamID = new ArrayList();
                                        String queryTeam = "select b.teamID,teamName from tbl_department a,tbl_team b where a.deptID=b.deptID and a.deptID='" + deptID + "'";
                                        ResultSet rsQueryTeam = mydb.executeQuery(queryTeam);

                                        while (rsQueryTeam.next()) {
                                            arrayListTeamName.add(rsQueryTeam.getString("teamName"));
                                            arrayListTeamID.add(rsQueryTeam.getString("teamID"));
                                        }
                                        int countStaff = 0;
                                        for (int i = 0; i < arrayListTeamID.size(); i++) {
                                            String countStaff1 = "select count(*) as 'count' from tbl_staff where teamID ='" + arrayListTeamID.get(i) + "'";
                                            ResultSet rsCountStaff1 = mydb.executeQuery(countStaff1);
                                            while (rsCountStaff1.next()) {
                                                countStaff = rsCountStaff1.getInt("count");
                                            }
                                            String queryStaff1 = "select * from tbl_staff a, tbl_team b where a.teamID=b.teamID and b.teamID ='" + arrayListTeamID.get(i) + "' and a.staffID <> '" + username1 + "'";
                                            ResultSet rsQueryStaff1 = mydb.executeQuery(queryStaff1);
                                            while (rsQueryStaff1.next()) {
                                                String codeKPI1 = displayTime + rsQueryStaff1.getString("staffID");
                                                String queryEvaluate = "select *from tbl_evaluate_individual where code_evaluate_individual='" + codeKPI1 + "'";
                                                ResultSet rsQueryEvaluate = mydb.executeQuery(queryEvaluate);
                                                while (rsQueryEvaluate.next()) {
                                                    if (rsQueryEvaluate.getInt("evaluate_teamleader") == 1) {
                                                        arrayListTL.add("1");
                                                    }

                                                }
                                            }
                                            if (countStaff - 1 == arrayListTL.size()) {
                                    %>
                                    <option value="<%=arrayListTeamID.get(i)%>"><%=arrayListTeamName.get(i)%></option>
                                    <%
                                            }
                                            arrayListTL.clear();
                                        }
                                    %>
                                </select>

                                <input class="btn btn-default" type="submit" value="Select Team" name="btAction" >
                            </td>
                            <td>
                                Select Staff:     <select name="seStaff">
                                    <%
                                        String teamID = (String) request.getAttribute("teamID");
                                        String queryStaff = "select *from tbl_staff a, tbl_decentralization b where a.staffID=b.staffID and b.roleID ='04' and teamID='" + teamID + "'";
                                        ResultSet rsQueryStaff = mydb.executeQuery(queryStaff);
                                        while (rsQueryStaff.next()) {
                                    %>
                                    <option value="<%=rsQueryStaff.getString("staffID")%>"><%=rsQueryStaff.getString("staffName")%></option>
                                    <%
                                        }
                                    %>
                                </select>
                                <input class="btn btn-default" type="submit" value="Select Staff" name="btAction" >
                            </td>
                            </tr>
                        </table>
                        <%
                            if (arrEvaluateKPIStaff == null) {
                        %>
                        <table class="setting guideline"   border="1">
                            <tr>
                            <th>Excellent</th>
                            <th>Exceeds<br />
                                Requirements</th>
                            <th>Meet<br />
                                Requirements</th>
                            <th>Need<br />
                                Improvement</th>
                            <th>Unsatisfactory</th>
                            </tr>
                            <tr>
                            <td>4.5~5.0</td>
                            <td>4.0~4.4</td>
                            <td>3.0~3.9</td>
                            <td>2.0~2.9</td>
                            <td>1.0~1.9</td>
                            </tr>
                        </table>
                        <div class="mess">${requestScope.mess}</div>
                        <br/>
                        <table class="setting evaluateWorker"  border="1">
                            <tr>
                            <th colspan="7"></th>
                            <th colspan="2">1st Appraiser</th>
                            <th colspan="2">2st Appraiser</th>
                            <th colspan="2">3st Appraiser</th>
                            </tr>
                            <tr>
                            <th rowspan="2">No</th>
                            <th rowspan="2">KPI</th>
                            <th rowspan="2">Actual Result vs the Target Set</th>
                            <th>Weightage%</th>
                            <th>Rating</th>
                            <th>Point</th>
                            <th rowspan="2">Main reason of not achieving target</th>
                            <th>Rating</th>
                            <th>Point</th>
                            <th>Rating</th>
                            <th>Point</th>
                            <th>Rating</th>
                            <th >Point</th>
                            </tr>
                            <tr>
                            <th>W</th>
                            <th>R</th>
                            <th>W x R</th>
                            <th>R</th>
                            <th>= W x R</th>
                            <th>R</th>
                            <th>= W x R</th>
                            <th>R</th>
                            <th >= W x R</th>
                            </tr>
                            <%
                                int i = 1;
                                String queryEvaluateKPI = "select *from  tbl_evaluate_kpi_staff where code_evaluate_kpi like '" + displayTime + staffID + "%'";
                                ResultSet rsQueryEvaluateKPI = mydb.executeQuery(queryEvaluateKPI);
                                while (rsQueryEvaluateKPI.next()) {
                            %>
                            <tr>
                            <td><%=i%></td>
                            <td><%=rsQueryEvaluateKPI.getString("kpi")%></td>
                            <td><%=rsQueryEvaluateKPI.getString("arvstts")%></td>
                            <td><%=rsQueryEvaluateKPI.getString("weightage")%></td>
                            <td><%=rsQueryEvaluateKPI.getString("rating_staff")%></td>
                            <td><%=rsQueryEvaluateKPI.getString("points_staff")%></td>
                            <td><%=rsQueryEvaluateKPI.getString("mronat")%></td>
                            <td><input type="text" style="width:60px;" name="rating_teamleader<%=i%>" value="<%=rsQueryEvaluateKPI.getString("rating_teamleader")%>"/></td>
                            <td><input class="score_staff" type="text" style="width:60px;" name="points_teamleader<%=i%>" value="<%=rsQueryEvaluateKPI.getString("points_teamleader")%>"/></td>
                            <td><%=rsQueryEvaluateKPI.getString("rating_hod")%></td>
                            <td><%=rsQueryEvaluateKPI.getString("points_hod")%></td>
                            <td><%=rsQueryEvaluateKPI.getString("rating_cxo")%></td>
                            <td><%=rsQueryEvaluateKPI.getString("points_cxo")%></td>

                            </tr>
                            <%
                                    i++;

                                }
                                String queryScore = "select *from tbl_average_score_staff where code_average_score ='" + displayTime + staffID + "'";
                                ResultSet rsQueryScore = mydb.executeQuery(queryScore);
                                while (rsQueryScore.next()) {
                            %>

                            <tr>
                            <td>1</td>
                            <td colspan="2">Total</td>
                            <td>100%</td>
                            <td>1</td>
                            <td><%=rsQueryScore.getString("score_staff")%></td>
                            <td></td>
                            <td></td>
                            <td><input class="score_staff" class="score_staff" name="score_teamleader" style="width:60px;" type="text" value="<%=rsQueryScore.getString("score_teamleader")%>" /></td>
                            <td></td>
                            <td><%=rsQueryScore.getString("score_hod")%></td>
                            <td></td>
                            <td><%=rsQueryScore.getString("score_cxo")%></td>
                            <td></td>

                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <table class="setting guideline"   border="1">
                                <tr>
                                <th>Excellent</th>
                                <th>Exceeds<br />
                                    Requirements</th>
                                <th>Meet<br />
                                    Requirements</th>
                                <th>Need<br />
                                    Improvement</th>
                                <th>Unsatisfactory</th>
                                </tr>
                                <tr>
                                <td>4.5~5.0</td>
                                <td>4.0~4.4</td>
                                <td>3.0~3.9</td>
                                <td>2.0~2.9</td>
                                <td>1.0~1.9</td>
                                </tr>
                            </table>
                            <div class="mess">${requestScope.mess}</div>
                            <br/>
                            <table class="setting evaluateWorker"  border="1">
                                <tr>
                                <th colspan="7"></th>
                                <th colspan="2">1st Appraiser</th>
                                <th colspan="2">2st Appraiser</th>
                                <th colspan="2">3st Appraiser</th>
                                </tr>
                                <tr>
                                <th rowspan="2">No</th>
                                <th rowspan="2">KPI</th>
                                <th rowspan="2">Actual Result vs the Target Set</th>
                                <th>Weightage%</th>
                                <th>Rating</th>
                                <th>Point</th>
                                <th rowspan="2">Main reason of not achieving target</th>
                                <th>Rating</th>
                                <th>Point</th>
                                <th>Rating</th>
                                <th>Point</th>
                                <th>Rating</th>
                                <th >Point</th>
                                </tr>
                                <tr>
                                <th>W</th>
                                <th>R</th>
                                <th>W x R</th>
                                <th>R</th>
                                <th>= W x R</th>
                                <th>R</th>
                                <th>= W x R</th>
                                <th>R</th>
                                <th >= W x R</th>
                                </tr>
                                <%
                                    int i = 1;
                                    for (int j = 0; j < arrEvaluateKPIStaff.size(); j++) {
                                %>
                                <tr>
                                <td><%=i%></td>
                                <td><%=arrEvaluateKPIStaff.get(j).getKpi()%></td>
                                <td><%=arrEvaluateKPIStaff.get(j).getArvstts()%></td>
                                <td><%=arrEvaluateKPIStaff.get(j).getWeightage()%></td>
                                <td><%=arrEvaluateKPIStaff.get(j).getRating_staff()%></td>
                                <td><%=arrEvaluateKPIStaff.get(j).getPoints_staff()%></td>
                                <td><%=arrEvaluateKPIStaff.get(j).getMronat()%></td>
                                <td><input type="text" style="width:60px;" name="rating_teamleader<%=i%>" value="<%=arrEvaluateKPIStaff.get(j).getPoints_teamleader()%>"/></td>
                                <td><input class="score_staff" type="text" style="width:60px;" name="points_teamleader<%=i%>" value="<%=arrEvaluateKPIStaff.get(j).getPoints_teamleader()%>"/></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>

                                </tr>
                                <%
                                        i++;

                                    }
                                    String queryScore = "select *from tbl_average_score_staff where code_average_score ='" + displayTime + staffID + "'";
                                    ResultSet rsQueryScore = mydb.executeQuery(queryScore);
                                    while (rsQueryScore.next()) {
                                %>

                                <tr>
                                <td>1</td>
                                <td colspan="2">Total</td>
                                <td>100%</td>
                                <td>1</td>
                                <td><%=rsQueryScore.getString("score_staff")%></td>
                                <td></td>
                                <td></td>
                                <td><input class="score_staff" class="score_staff" name="score_teamleader" style="width:60px;" type="text" value="<%=sumPoints%>" /></td>
                                <td></td>
                                <td><%=rsQueryScore.getString("score_hod")%></td>
                                <td></td>
                                <td><%=rsQueryScore.getString("score_cxo")%></td>
                                <td></td>

                                </tr>
                                <%
                                        }
                                    }
                                %>
                            </table>
                            <%                int s11 = 0;
                                String queryCommentEvaluate1 = "select *from tbl_comment_evaluate_staff where code_comment_evaluate_staff='" + displayTime + staffID + "'";
                                ResultSet rsQueryCommentEvaluate1 = mydb.executeQuery(queryCommentEvaluate1);
                                while (rsQueryCommentEvaluate1.next()) {
                                    s11++;
                            %>
                            <table class="performanceStaff comment" >
                                <tr>
                                <td rowspan="2">Appraisee Comment</td>
                                <td rowspan="2"><textarea name="taTeamLeader"><%=rsQueryCommentEvaluate1.getString("comment_teamleader")%></textarea></td>
                                <td>Signature</td>
                                </tr>
                                <tr>
                                <td><input name="txtTeamLeader" type="text" style="width: 80%;" /></td>
                                </tr>
                                <tr>
                                <td rowspan="2">1Appraisee s Comment</td>
                                <td rowspan="2"><textarea name="taHoD"><%=rsQueryCommentEvaluate1.getString("comment_hod")%></textarea></td>
                                <td>Signature</td>
                                </tr>
                                <tr>
                                <td><input name="txtHoD" type="text" style="width: 80%;" /></td>
                                </tr>
                                <tr>
                                <td rowspan="2">2Appraisees Comment</td>
                                <td rowspan="2"><textarea name="taCxO"><%=rsQueryCommentEvaluate1.getString("comment_cxo")%></textarea></td>

                                <td>Signature</td>
                                </tr>
                                <tr>
                                <td><input name="txtCxO" type="text" style="width: 80%" /></td>
                                </tr>
                            </table>
                            <%
                                }
                                if (s11 == 0) {
                            %>
                            <table class="performanceStaff comment" >
                                <tr>
                                <td rowspan="2">Appraisee Comment</td>
                                <td rowspan="2"><textarea name="taTeamLeader"></textarea></td>
                                <td>Signature</td>
                                </tr>
                                <tr>
                                <td><input name="txtTeamLeader" type="text" style="width: 80%;" /></td>
                                </tr>
                                <tr>
                                <td rowspan="2">1Appraisee s Comment</td>
                                <td rowspan="2"><textarea name="taHoD"></textarea></td>
                                <td>Signature</td>
                                </tr>
                                <tr>
                                <td><input name="txtHoD" type="text" style="width: 80%;" /></td>
                                </tr>
                                <tr>
                                <td rowspan="2">2Appraisees Comment</td>
                                <td rowspan="2"><textarea name="taCxO"></textarea></td>

                                <td>Signature</td>
                                </tr>
                                <tr>
                                <td><input name="txtCxO" type="text" style="width: 80%" /></td>
                                </tr>
                            </table>
                            <%
                                    }
                            %>
                            </center>
                            <center><input type="submit" value="Grading" name="btAction"  />
                                <input type="submit" value="Save" name="btAction" />
                                <input type="submit" value="Send Mail" name="btAction"  />
                                <input type="text" value="<%=countSettingKPI1%>" name="numRows" />
                                <input type="text" value="<%=staffID%>" name="staffID" />
                            </center>
                    </form>

                    <%                            }//ket thuc cho HoD

                    %>
                    </div>
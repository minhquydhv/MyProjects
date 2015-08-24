<%-- 
    Document   :  Worker,Driver,Cleaner Evaluate
    Created on : Aug 3, 2015, 3:25:12 PM
    Author     : nguyen quang quy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath}/CSS/commonStyle.css" rel="stylesheet" type="text/css"/>
<div>
    <form id="form1" action="#" method="post">
        <table class="evaluateWorker setting" border="1">
            <tr>
            <th rowspan="3">No.1</th>
            <th rowspan="3">Full name</th>
            <th rowspan="3">Employee Code</th>
            <th colspan="8">Evaluated by Team leader</th>
            <th colspan="2">Trưởng phòng</th>
            <th colspan="2">CxO</th>
            </tr>
            <tr>
            <th colspan="6">Regular Employee Evaluation Result</th>
            <th rowspan="2">Average score</th>
            <th rowspan="2">Rank</th>
            <th rowspan="2">Average score</th>
            <th rowspan="2">Rank</th>
            <th rowspan="2">Average score</th>
            <th rowspan="2">Rank</th>
            </tr>
            <tr>
            <th>Safety &amp; hygiene</th>
            <th>Job performanc</th>
            <th>Cost saving mind</th>
            <th>Dilligence</th>
            <th>Teamwork</th>
            <th>Follow rules</th>
            </tr>
            <tr>
            <td>1</td>
            <td>Nguyen quang quy</td>
            <td></td>
            <td><input type="text" style="width:60px;"></td>
            <td><input type="text" style="width:60px;"></td>
            <td><input type="text" style="width:60px;"></td>
            <td><input type="text" style="width:60px;"></td>
            <td><input type="text" style="width:60px;"></td>
            <td><input type="text" style="width:60px;"></td>
            <td><input type="text" style="width:60px;"></td>
            <td><input type="text" style="width:60px;"></td>
            <td><input type="text" style="width:60px;"></td>
            <td><input type="text" style="width:60px;"></td>
            <td><input type="text" style="width:60px;"></td>
            <td><input type="text" style="width:60px;"></td>
            </tr>
        </table>
        <br/>
        <div class="confirmed">confirmed: </div>
        <table class="comment commentEvaluateWorker" border="1">
            <tr>
            <th>Head of Department</th>
            <th>Related CxO</th>
            </tr>
            <tr>
            <td><textarea name="confirmedTeamLeader"></textarea></td>
            <td><textarea id="hide3" name="confirmedHoD"></textarea></td>
            </tr>
            <tr>
            <td>Date:</td>
            <td>Date:</td>
            </tr>
        </table>
    </form>
</div>
<%-- 
    Document   : content
    Created on : Aug 2, 2015, 4:03:49 PM
    Author     : quang quy
--%>
<%@page import="java.util.ArrayList"%>
<div class="content">
    <%        String trang = request.getParameter("page");
        String subTrang = request.getParameter("subPage");
        String ac = request.getParameter("ac");
        //bat dau lay quyen
        ArrayList arr = new ArrayList();
        arr = (ArrayList) session.getAttribute("quyen");
        boolean kt = false;
        if ((trang != null) && (trang.equals("company"))) {
            if (ac.equals("setting")) {///bat dau thiet lap cong ty
                for (int i = 0; i < arr.size(); i++) {
                    if ((arr.get(i).equals("07")) || (arr.get(i).equals("06")) || (arr.get(i).equals("02")) || (arr.get(i).equals("01"))|| (arr.get(i).equals("08"))) {
                        kt = true;
                    }//ket thuc if
                }//ket thuc vong for
                if (kt) {
    %>
    <%@include file="KPICompany/Setting.jsp" %>                 
    <%
    } else {
    %>
    <%@include file="mess.jsp" %>
    <%
        }
    }//ket thuc thiet lap cong ty       
    else if (ac.equals("evaluate")) {//bat dau danh gia cong ty

        for (int i = 0; i < arr.size(); i++) {
            if ((arr.get(i).equals("07")) || arr.get(i).equals("06")|| (arr.get(i).equals("08"))) {
                kt = true;
            }

        }
        if (kt) {
    %>
    <%@include file="KPICompany/Evaluate.jsp" %>
    <%
    } else {
    %>
    <%@include file="mess.jsp" %>
    <%
            }
        }

// ket thuc danh gia cong ty
    } else if ((trang != null) && (trang.equals("department"))) {//bat dau thiet lap phong

        if (ac.equals("setting")) {

            for (int i = 0; i < arr.size(); i++) {
                if ((arr.get(i).equals("02")) || (arr.get(i).equals("01")) || (arr.get(i).equals("06"))|| (arr.get(i).equals("08"))) {
                    kt = true;
                }//ket thuc if

            }//ket thuc vong for  
            if (kt) {
    %>
    <%@include file="KPIDepartment/Setting.jsp"%>
    <%
    } else {
    %>
    <%@include file="mess.jsp" %>
    <%
        }

    }//ket thuc thiet lap phong
    else if (ac.equals("evaluate")) {//bat dau danh gia phong
        for (int i = 0; i < arr.size(); i++) {
            if ((arr.get(i).equals("02")) || (arr.get(i).equals("01")) || (arr.get(i).equals("06"))|| (arr.get(i).equals("08"))) {
                kt = true;
            }
        }
        if (kt) {


    %>
    <%@include file="KPIDepartment/Evaluate.jsp" %>
    <%    } else {
    %>
    <%@include file="mess.jsp" %>
    <%
            }
        }//ket thuc danh gia phong

    } else if ((trang != null) && (trang.equals("individual"))) {
        if (subTrang.equals("kpiIndividual")) {//bat dau thiet lap ca nhan
            if (ac.equals("setting")) {//bat dau setting
                for (int i = 0; i < arr.size(); i++) {
                    if ((arr.get(i).equals("04")) || (arr.get(i).equals("03"))) {
                        kt = true;
                    }
                }
                if (kt) {

    %>
    <%@include file="KPIIndividual/Setting.jsp" %>
    <%    } else {

    %>
    <%@include file="mess.jsp" %>
    <%        }
    }//ket thuc setting
    else if (ac.equals("confirmed")) {//bat dau confirmed
        for (int i = 0; i < arr.size(); i++) {
            if ((arr.get(i).equals("02")) || (arr.get(i).equals("03")) || (arr.get(i).equals("06")) || (arr.get(i).equals("07"))|| (arr.get(i).equals("08"))) {
                kt = true;
            }
        }
        if (kt) {
    %>
    <%@include file="KPIIndividual/Confirmed.jsp" %>
    <%
    } else {

    %>
    <%@include file="mess.jsp" %>
    <%            }
        }//ket thuc confirmed
    }//ket thuc thiet lap ca nhan
    else if (subTrang.equals("worker")) {
        if (ac.equals("evaluate")) {//bat dau danh gia worker,driver,cleaner

            for (int i = 0; i < arr.size(); i++) {
                if ((arr.get(i).equals("03")) || (arr.get(i).equals("02")) || (arr.get(i).equals("01"))) {
                    kt = true;
                }
            }
            if (kt) {
    %>

    <%@include file="KPIIndividual/KPIWorker_Driver_Cleaner/Evaluate.jsp" %>
    <%
    } else {
    %>
    <%@include file="mess.jsp" %>
    <%
            }
        }
        //ket thuc danh gia worker,driver,cleaner
    } else if (subTrang.equals("staff")) {//bat dau danh nang luc staff
        if (ac.equals("competency")) {
            for (int i = 0; i < arr.size(); i++) {
                if ((arr.get(i).equals("03")) || (arr.get(i).equals("02")) || (arr.get(i).equals("01")) || (arr.get(i).equals("04")) || (arr.get(i).equals("06"))|| (arr.get(i).equals("08"))) {
                    kt = true;
                }
            }
            if (kt) {

    %>
    <%@include file="KPIIndividual/KPIStaff_Engineer/Competency.jsp" %>
    <%    } else {
    %>
    <%@include file="mess.jsp" %>
    <%
        }
    } //ket thuc danh nang luc staff
    else {
        for (int i = 0; i < arr.size(); i++) {
            if ((arr.get(i).equals("03")) || (arr.get(i).equals("02")) || (arr.get(i).equals("01")) || (arr.get(i).equals("04")) || (arr.get(i).equals("06"))|| (arr.get(i).equals("08"))) {
                kt = true;
            }
        }
        if (kt) {

    %>
    <%@include file="KPIIndividual/KPIStaff_Engineer/Performace.jsp" %>
    <%    } else {
    %>
    <%@include file="mess.jsp" %>
    <%
            }
        }
    } else if (subTrang.equals("teamleader")) {//bat dau danh gia teamleader 
        if (ac.equals("competency")) {
            for (int i = 0; i < arr.size(); i++) {
                if ((arr.get(i).equals("03")) || (arr.get(i).equals("02")) || (arr.get(i).equals("01")) || (arr.get(i).equals("06"))|| (arr.get(i).equals("08"))) {
                    kt = true;
                }
            }
            if (kt) {
    %>
    <%@include file="KPIIndividual/KPITeam_Leader/Competency.jsp" %>
    <%
    } else {
    %>
    <%@include file="mess.jsp" %>
    <%
        }
    } //ket thuc danh gia nang luc teamleader
    else {
        for (int i = 0; i < arr.size(); i++) {
            if ((arr.get(i).equals("03")) || (arr.get(i).equals("02")) || (arr.get(i).equals("01")) || (arr.get(i).equals("06"))|| (arr.get(i).equals("08"))) {
                kt = true;
            }
        }
        if (kt) {
    %>
    <%@include file="KPIIndividual/KPITeam_Leader/Performace.jsp" %>
    <%
    } else {
    %>
    <%@include file="mess.jsp" %>
    <%
            }
        }
    } else if (subTrang.equals("hod")) {
        if (ac.equals("competency")) {//bat dau danh gia nang luc truong phong
            for (int i = 0; i < arr.size(); i++) {
                if ((arr.get(i).equals("06")) || (arr.get(i).equals("02")) || (arr.get(i).equals("01"))|| (arr.get(i).equals("08"))) {
                    kt = true;
                }
            }
            if (kt) {
    %>
    <%@include file="KPIIndividual/KPIHead_Of_Department/Competency.jsp" %>
    <%
    } else {
    %>
    <%@include file="mess.jsp" %>
    <%
        }
    } //ket thuc danh gia nang luc truong phong
    else {
        for (int i = 0; i < arr.size(); i++) {
            if ((arr.get(i).equals("06")) || (arr.get(i).equals("02")) || (arr.get(i).equals("01"))|| (arr.get(i).equals("08"))) {
                kt = true;
            }
        }
        if (kt) {
    %>
    <%@include file="KPIIndividual/KPIHead_Of_Department/Performace.jsp" %>
    <%
    } else {
    %>
    <%@include file="mess.jsp" %>
    <%
                }
            }
        }

    } else if ((trang != null) && (trang.equals("sendmail"))) {
    %>
    <%@include file="sendmail.jsp" %>
    <%
    } else {
    %>
    <%@include file="main.jsp" %>
    <%
        }
    %>
</div>

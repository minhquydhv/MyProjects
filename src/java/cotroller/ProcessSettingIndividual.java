/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cotroller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.DataServices;
import objects.SettingKPIIndividual;

/**
 *
 * @author Admin
 */
public class ProcessSettingIndividual extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws java.lang.ClassNotFoundException
     * @throws java.lang.CloneNotSupportedException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException, CloneNotSupportedException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProcessSettingIndividual</title>");
            out.println("</head>");
            out.println("<body>");

            DataServices mydb = new DataServices();
            String action = request.getParameter("btAction");
            //su kien cua nut  save button

            if (action.equals("Save")) {
                String usename = request.getParameter("uname");
                String num = request.getParameter("numRows");
                Date date = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("YY");
                String displayTime = dateFormat.format(date);
                String codeKPI = displayTime + usename;
                int numRows = Integer.parseInt(num);
                ArrayList<SettingKPIIndividual> arrayList = new ArrayList();
                /*
                 lay so ban ghi trong co so du lieu
                 */
                ResultSet rs = mydb.executeQuery("select count(*) as 'num' from tbl_setting_kpi_individual where codeKPIIndividual like '" + codeKPI + "%'");
                int count = 0;
                while (rs.next()) {
                    count = rs.getInt("num");
                }
                for (int i = 1; i < numRows; i++) {

                    String s1 = "jobField" + String.valueOf(i);
                    String s2 = "currentStatus" + String.valueOf(i);
                    String s3 = "kpiTarget" + String.valueOf(i);
                    String s4 = "ratio" + String.valueOf(i);
//                    String s5 = "remark" + String.valueOf(i);
                    String codeKPIIndividual = codeKPI + String.valueOf(i);
                    String jobField = request.getParameter(s1);
                    String currentStatus = request.getParameter(s2);
                    String kpiTarget = request.getParameter(s3);
                    String ratio = request.getParameter(s4);
                    //                    String remark = request.getParameter(s5);
                    //kiem tra neu mot truong nao do bi b
                    if ((jobField != "") && (currentStatus != "") && (kpiTarget != "")) {
                        SettingKPIIndividual st = new SettingKPIIndividual(codeKPIIndividual, jobField, currentStatus, kpiTarget, ratio, "");
                        arrayList.add(st);
                    }

                }
                try {

                    double sum = 0;
                    for (int i = 0; i < arrayList.size(); i++) {
                        sum += Double.parseDouble(arrayList.get(i).getRatio());
                    }
                    if (sum == 100) {

                        ///kiem tra cap nhat hoac la them noi dung
                        if (arrayList.size() >= count) {
                            if ((arrayList.size() == 0) && (count == 0)) {
                                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=setting");
                                dispatcher.forward(request, response);
                            } else {
                                for (int i = 0; i < count; i++) {
                                    int f = i + 1;
                                    SettingKPIIndividual st = arrayList.get(i);
                                    String sSql = "update tbl_setting_kpi_individual set jobField='" + st.getJobField() + "',currentStatus='" + st.getCurrentStatus() + "',kpiTarget='" + st.getKpiTarget() + "',ratio='" + st.getRatio() + "',remark=' ' where codeKPIIndividual='" + codeKPI + String.valueOf(f) + "'";
                                    mydb.executeNonQuery(sSql);
                                    out.print("ok");
                                }
                                for (int j = count; j < arrayList.size(); j++) {
                                    SettingKPIIndividual st = arrayList.get(j);
                                    String sSql = "insert into tbl_setting_kpi_individual values ('"
                                            + st.getCodeKPIIndividual() + "','" + st.getJobField()
                                            + "','" + st.getCurrentStatus() + "','" + st.getKpiTarget() + "','" + st.getRatio() + "',' ')";
                                    mydb.executeNonQuery(sSql);
                                }
                            }
                        } //neu so dong trong bang < so ban ghi trong co so du lieu 
                        else {
                            if ((arrayList.size() == 0) && (count > 0)) {
//                        String deleteConfirmed = "delete from tbl_confirmed_kpi_individual where codeConfirmedKPI ='" + codeKPI + "'";
//                        mydb.executeNonQuery(deleteConfirmed);
                                String sSql = "delete  from tbl_setting_kpi_individual  where codeKPIIndividual='" + codeKPI + "%'";
                                mydb.executeNonQuery(sSql);
                            }
                            for (int i = 0; i < arrayList.size(); i++) {
                                int f = i + 1;
                                SettingKPIIndividual st = arrayList.get(i);
                                String sSql = "update tbl_setting_kpi_individual set jobField='" + st.getJobField() + "',currentStatus='" + st.getCurrentStatus() + "',kpiTarget='" + st.getKpiTarget() + "',ratio='" + st.getRatio() + "',remark=' '   where codeKPIIndividual='" + codeKPI + String.valueOf(f) + "'";
                                mydb.executeNonQuery(sSql);
                            }
                            for (int j = arrayList.size(); j < count; j++) {
                                int f = j + 1;
                                String sSql = "delete  from tbl_setting_kpi_individual  where codeKPIIndividual='" + codeKPI + String.valueOf(f) + "'";
                                mydb.executeNonQuery(sSql);
                            }
                        }
                        if ((count == 0) && (arrayList.size() > 0)) {
                            String sSql = "insert into tbl_confirmed_kpi_individual  values('" + codeKPI + "',0,0,0,0,0)";
                            mydb.executeNonQuery(sSql);
                            String sSql1 = "insert into tbl_comment_kpi_individual(codeCommentIndividual) values('" + codeKPI + "')";
                            mydb.executeNonQuery(sSql1);
                        } else if ((count > 0) && (arrayList.size() == 0)) {
                            String deleteConfirmed = "delete from tbl_confirmed_kpi_individual where codeConfirmedKPI ='" + codeKPI + "'";
                            mydb.executeNonQuery(deleteConfirmed);

                            String deleteComment = "delete from tbl_comment_kpi_individual where codeCommentIndividual ='" + codeKPI + "'";
                            mydb.executeNonQuery(deleteComment);
                        }
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=setting");
                        dispatcher.forward(request, response);
                    } else {
                        request.setAttribute("arr1", arrayList);
                        request.setAttribute("mess1", "Sum of ratios must equal 100% !");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=setting");
                        dispatcher.forward(request, response);
                    }

                } catch (Exception e) {
                    request.setAttribute("arr1", arrayList);
                    request.setAttribute("mess1", "ratio must is a number !");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=setting");
                    dispatcher.forward(request, response);
                }

            }//ket thuc su kien nut save
            else if (action.equals("SendMail")) {//bat dau sendmail
                String usename = request.getParameter("uname");
                String num = request.getParameter("numRows");
                Date date = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("YY");
                String displayTime = dateFormat.format(date);
                String codeKPI = displayTime + usename;
                int numRows = Integer.parseInt(num);
                String mess = "You dont't send mail !";
                ArrayList<SettingKPIIndividual> arrayList = new ArrayList();

                //lay thong tin cua nguoi nhan
                String teamID = "";
                String staffName = "";
                String queryTeamID = "select *from tbl_staff a , tbl_team b where a.teamID=b.teamID and a.staffID ='" + usename + "'";
                ResultSet rsQueryTeamID = mydb.executeQuery(queryTeamID);
                while (rsQueryTeamID.next()) {
                    teamID = rsQueryTeamID.getString("a.teamID");
                    staffName = rsQueryTeamID.getString("staffName");
                }
                String queryYourMail = "select *from tbl_staff a, tbl_team b, tbl_decentralization c  where a.teamID=b.teamID and a.staffID = c.staffID and b.teamID = '" + teamID + "' and c.roleID='03'";
                ResultSet rsQueryYourMail = mydb.executeQuery(queryYourMail);
                String yourMail = "";
                while (rsQueryYourMail.next()) {
                    yourMail = rsQueryYourMail.getString("email");
                }
                String object = staffName + " setting KPI";
                String content = "i has complete setting KPI !";

                /*
                 lay so ban ghi trong co so du lieu
                 */
                ResultSet rs = mydb.executeQuery("select count(*) as 'num' from tbl_setting_kpi_individual where codeKPIIndividual like '" + codeKPI + "%'");
                int count = 0;
                while (rs.next()) {
                    count = rs.getInt("num");
                }

                for (int i = 1; i < numRows; i++) {
                    String s1 = "jobField" + String.valueOf(i);
                    String s2 = "currentStatus" + String.valueOf(i);
                    String s3 = "kpiTarget" + String.valueOf(i);
                    String s4 = "ratio" + String.valueOf(i);
//                    String s5 = "remark" + String.valueOf(i);
                    String codeKPIIndividual = codeKPI + String.valueOf(i);
                    String jobField = request.getParameter(s1);
                    String currentStatus = request.getParameter(s2);
                    String kpiTarget = request.getParameter(s3);
                    String ratio = request.getParameter(s4);
//                    String remark = request.getParameter(s5);
                    //kiem tra neu mot truong nao do bi b
                    if ((jobField != "") && (currentStatus != "") && (kpiTarget != "")) {
                        SettingKPIIndividual st = new SettingKPIIndividual(codeKPIIndividual, jobField, currentStatus, kpiTarget, ratio, "");
                        arrayList.add(st);
                    }
                }
                //
                try {

                    double sum = 0;
                    for (int i = 0; i < arrayList.size(); i++) {
                        sum += Double.parseDouble(arrayList.get(i).getRatio());
                    }
                    if (sum == 100) {

                        ///kiem tra cap nhat hoac la them noi dung
                        if (arrayList.size() >= count) {
                            if ((arrayList.size() == 0) && (count == 0)) {
                                request.setAttribute("mess", mess);
                                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=setting");
                                dispatcher.forward(request, response);
                            } else {
                                for (int i = 0; i < count; i++) {
                                    int f = i + 1;
                                    SettingKPIIndividual st = arrayList.get(i);
                                    String sSql = "update tbl_setting_kpi_individual set jobField='" + st.getJobField() + "',currentStatus='" + st.getCurrentStatus() + "',kpiTarget='" + st.getKpiTarget() + "',ratio='" + st.getRatio() + "',remark=' ' where codeKPIIndividual='" + codeKPI + String.valueOf(f) + "'";
                                    mydb.executeNonQuery(sSql);
                                }
                                for (int j = count; j < arrayList.size(); j++) {
                                    SettingKPIIndividual st = arrayList.get(j);
                                    String sSql = "insert into tbl_setting_kpi_individual values ('"
                                            + st.getCodeKPIIndividual() + "','" + st.getJobField()
                                            + "','" + st.getCurrentStatus() + "','" + st.getKpiTarget() + "','" + st.getRatio() + "',' ')";
                                    mydb.executeNonQuery(sSql);
                                }
                            }
                        } //neu so dong trong bang < so ban ghi trong co so du lieu 
                        else {
                            for (int i = 0; i < arrayList.size(); i++) {
                                int f = i + 1;
                                SettingKPIIndividual st = arrayList.get(i);
                                String sSql = "update tbl_setting_kpi_individual set jobField='" + st.getJobField() + "',currentStatus='" + st.getCurrentStatus() + "',kpiTarget='" + st.getKpiTarget() + "',ratio='" + st.getRatio() + "',remark=' '   where codeKPIIndividual='" + codeKPI + String.valueOf(f) + "'";
                                mydb.executeNonQuery(sSql);
                            }
                            for (int j = arrayList.size(); j < count; j++) {
                                int f = j + 1;
                                String sSql = "delete  from tbl_setting_kpi_individual  where codeKPIIndividual='" + codeKPI + String.valueOf(f) + "'";
                                mydb.executeNonQuery(sSql);
                            }
                        }
                        if ((count == 0) && (arrayList.size() > 0)) {

                            String sSql = "insert into tbl_confirmed_kpi_individual  values('" + codeKPI + "',1,0,0,0,0)";
                            mydb.executeNonQuery(sSql);

                            String sSql1 = "insert into tbl_comment_kpi_individual(codeCommentIndividual) values('" + codeKPI + "')";
                            mydb.executeNonQuery(sSql1);
                            request.setAttribute("yourMail", yourMail);
                            request.setAttribute("object", object);
                            request.setAttribute("content", content);
                            //begin lay thong tin cua nhan vien va username de bat loi khi gui mail khọng thanh cong !
                            request.setAttribute("username", usename);
                            request.setAttribute("codeKPI", codeKPI);
                            //end 
                            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=sendmail");
                            dispatcher.forward(request, response);
//                    String sSql1 = "insert into tbl_comment_kpi_individual(codeCommentIndividual) values('" + codeKPI + "')";
//                    mydb.executeNonQuery(sSql1);
                        } else {
                            if ((count > 0) && (arrayList.size() > 0)) {
//                        String sSql1 = "update tbl_comment_kpi_individual codeCommentIndividual) values('" + codeKPI + "')";
//                        mydb.executeNonQuery(sSql1);

                                String sSql = "update tbl_confirmed_kpi_individual set confirmedIndividual=1,confirmedTeamleader=0, confirmedHoD=0,confirmedDGD=0,confirmedGD=0 where codeConfirmedKPI ='" + codeKPI + "'";
                                mydb.executeNonQuery(sSql);
                                request.setAttribute("yourMail", yourMail);
                                request.setAttribute("object", object);
                                request.setAttribute("content", content);
                                //begin lay thong tin cua nhan vien va username de bat loi khi gui mail khọng thanh cong !
                                request.setAttribute("username", usename);
                                request.setAttribute("codeKPI", codeKPI);
                                //end 
                                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=sendmail");
                                dispatcher.forward(request, response);

                            } else if ((count > 0) && (arrayList.size() == 0)) {
                                String deleteConfirmed = "delete from tbl_confirmed_kpi_individual where codeConfirmedKPI ='" + codeKPI + "'";
                                mydb.executeNonQuery(deleteConfirmed);

                                String deleteComment = "delete from tbl_comment_kpi_individual where codeConfirmedKPI ='" + codeKPI + "'";
                                mydb.executeNonQuery(deleteComment);

                                request.setAttribute("mess", mess);
                                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=setting");
                                dispatcher.forward(request, response);
                            }
                        }
                    } else {
                        request.setAttribute("arr1", arrayList);
                        request.setAttribute("mess1", "Sum of ratios must equal 100% !");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=setting");
                        dispatcher.forward(request, response);
                    }

                } catch (Exception e) {
                    request.setAttribute("arr1", arrayList);
                    request.setAttribute("mess1", "ratio must is a number !");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=setting");
                    dispatcher.forward(request, response);
                }
            }

            out.println("</body>");
            out.println("</html>");

            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html; charset=UTF-8");
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException | ClassNotFoundException | CloneNotSupportedException ex) {
            Logger.getLogger(ProcessSettingIndividual.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException | ClassNotFoundException | CloneNotSupportedException ex) {
            Logger.getLogger(ProcessSettingIndividual.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}

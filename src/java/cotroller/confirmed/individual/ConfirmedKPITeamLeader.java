/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cotroller.confirmed.individual;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.DataServices;

/**
 *
 * @author Admin
 */
public class ConfirmedKPITeamLeader extends HttpServlet {

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
            out.println("<title>Servlet ConfirmedKPITeamLeader</title>");
            out.println("</head>");
            out.println("<body>");
            DataServices mydb = new DataServices();
            Date date = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("YY");
            String displayTime = dateFormat.format(date);
            String s = displayTime;
            String action = request.getParameter("btAction");
            String seStaff = request.getParameter("seStaff");
            String getCode = request.getParameter("getCode");
            String username = request.getParameter("username1");
            String codeKPI = s + getCode;
            if (action.equals("Select Staff")) {
                //session.setAttribute("staffID", seStaff);
                request.setAttribute("staffID", seStaff);
                // out.print("ok");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed");
                dispatcher.forward(request, response);
            } else if (action.equals("Accept")) {
                ///begin
                String confirmedTeamLeader = request.getParameter("confirmedTeamLeader");
                String newStr = confirmedTeamLeader.replaceAll(" ", "");
                if (newStr.equals("")) {
                    String mess = "you must enter comment in Confirmed Team Leader box bellow !";
                    request.setAttribute("mess1", mess);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed");
                    dispatcher.forward(request, response);
                } else {
                    Date date1 = new Date();
                    SimpleDateFormat dateFormat1 = new SimpleDateFormat("dd-MM-yyyy");
                    String displayTime1 = dateFormat1.format(date1);
                    String s11 = displayTime1;
                    String comment = request.getParameter("confirmedTeamLeader");

                    String updateComment = "update  tbl_comment_kpi_individual set commentTeamLeader='" + comment + "',dateTeamLeader='" + s11 + "' where codeCommentIndividual='" + codeKPI + "'";
                    mydb.executeNonQuery(updateComment);
                    //end
                    String sSqlUpdateConfirmed = "update tbl_confirmed_kpi_individual set confirmedTeamleader =1 where codeConfirmedKPI='" + codeKPI + "'";
                    mydb.executeNonQuery(sSqlUpdateConfirmed);
                    String queryTeamID = "select *from tbl_staff a ,tbl_team b where a.teamID=b.teamID and a.staffID= '" + seStaff + "'";
                    ResultSet rsQueryTeamID = mydb.executeQuery(queryTeamID);
                    String teamID = "";
                    while (rsQueryTeamID.next()) {
                        teamID = rsQueryTeamID.getString("teamID");
                    }
                    String queryStaff = "select *from tbl_staff where teamID='" + teamID + "'";
                    ResultSet rsQueryStaff = mydb.executeQuery(queryStaff);
                    int kt = 0;
                    while (rsQueryStaff.next()) {
                        String s1 = s + rsQueryStaff.getString("staffID");
                        String countKPI = "select count(*) as 'count' from tbl_setting_kpi_individual where codeKPIIndividual like '" + s1 + "%'";
                        ResultSet rsCountKPI = mydb.executeQuery(countKPI);
                        while (rsCountKPI.next()) {
                            if (rsCountKPI.getInt("count") == 0) {
                                kt = 1;
                                break;
                            }
                        }
                        String queryConfirmedTL = "select *from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + s1 + "'";
                        ResultSet rsQueryConfirmedTL = mydb.executeQuery(queryConfirmedTL);
                        while (rsQueryConfirmedTL.next()) {
                            if (rsQueryConfirmedTL.getInt("confirmedTeamleader") == 0) {
                                kt = 1;
                                break;
                            }
                        }
                    }
                    if (kt == 1) {
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed");
                        dispatcher.forward(request, response);
                    } else if (kt == 0) {
                        String deptID = "";
                        String teamName = "";
                        String queryDeptID = "select *from tbl_staff a, tbl_team b, tbl_department c where a.teamID = b.teamID and b.deptID =c.deptID and a.staffID='" + seStaff + "'";
                        ResultSet rsQueryDeptID = mydb.executeQuery(queryDeptID);
                        while (rsQueryDeptID.next()) {
                            deptID = rsQueryDeptID.getString("c.deptID");
                            teamName = rsQueryDeptID.getString("teamName");
                        }
                        String yourMail = "";
                        String queryYourMail = "select *from tbl_staff a , tbl_team b, tbl_department c ,tbl_decentralization d where a.teamID=b.teamID and b.deptID =c.deptID and a.staffID =d.staffID and c.deptID='" + deptID + "' and d.roleID='02'";
                        ResultSet rsQueryYourMail = mydb.executeQuery(queryYourMail);
                        while (rsQueryYourMail.next()) {
                            yourMail = rsQueryYourMail.getString("email");
                        }
                        String object = teamName + " setting KPI ";
                        String content = teamName + "has complete setting KPI ! !";
                        request.setAttribute("yourMail", yourMail);
                        request.setAttribute("object", object);
                        request.setAttribute("content", content);
                        //begin lay username va codeKPI de bat loi send mail khong thanh cong ! 
                        request.setAttribute("username", username);
                        request.setAttribute("codeKPI", codeKPI);
                        //end
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=sendmail");
                        dispatcher.forward(request, response);
                    }
                }
            } else if (action.equals("Reject")) {

                String countKPIStaff = "select count(*) as 'count1' from tbl_setting_kpi_individual where codeKPIIndividual like '" + codeKPI + "%'";
                ResultSet rsCountKPIStaff = mydb.executeQuery(countKPIStaff);
                String mess = "";
                int count = 0;
                while (rsCountKPIStaff.next()) {
                    count = rsCountKPIStaff.getInt("count1");

                }
                int kt = 0;
                String s2 = "";
                for (int i = 1; i <= count; i++) {
                    String f = "remark" + String.valueOf(i);
                    s2 = request.getParameter(f);
                    String newStr = s2.replaceAll(" ", "");
                    if (!newStr.equals("")) {//chu y day la xoa het tat ca cac dau cach
                        kt = 1;
                        break;
                    }
                }

                if (kt == 0) {
                    mess = "you must enter comment in remark box bellow !";
                    request.setAttribute("mess1", mess);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed");
                    dispatcher.forward(request, response);
                } else if (kt == 1) {
                    String confirmedTeamLeader = request.getParameter("confirmedTeamLeader");
                    String newStr = confirmedTeamLeader.replaceAll(" ", "");
                    if (newStr.equals("")) {
                        mess = "you must enter comment in Confirmed Team Leader box bellow !";
                        request.setAttribute("mess1", mess);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed");
                        dispatcher.forward(request, response);
                    } else {
                        for (int i = 1; i <= count; i++) {
                            String f = "remark" + String.valueOf(i);
                            s2 = request.getParameter(f);
                            // out.print(s2);
                            String a = codeKPI + String.valueOf(i);//chu y ghep xau moi
                            // out.print(a);
                            String updateKPI = "update tbl_setting_kpi_individual set remark ='" + s2 + "' where codeKPIIndividual='" + a + "'";
                            mydb.executeNonQuery(updateKPI);
                        }
                        String updateConfirmed = "update tbl_confirmed_kpi_individual set confirmedIndividual= 0 where codeConfirmedKPI ='" + codeKPI + "'";
                        mydb.executeNonQuery(updateConfirmed);
                        Date date1 = new Date();
                        SimpleDateFormat dateFormat1 = new SimpleDateFormat("dd-MM-yyyy");
                        String displayTime1 = dateFormat1.format(date1);
                        String s11 = displayTime1;
                        String comment = request.getParameter("confirmedTeamLeader");

                        String updateComment = "update  tbl_comment_kpi_individual set commentTeamLeader='" + comment + "',dateTeamLeader='" + s11 + "' where codeCommentIndividual='" + codeKPI + "'";
                        mydb.executeNonQuery(updateComment);
                        //lay thong tin cua nguoi nhan
                        String yourMail = "";
                        String queryYourMail = "select *from tbl_staff where staffID ='" + seStaff + "'";
                        ResultSet rsQueryYourMail = mydb.executeQuery(queryYourMail);
                        while (rsQueryYourMail.next()) {
                            yourMail = rsQueryYourMail.getString("email");
                        }
                        String object = "confirmed KPI ";
                        String content = "KPI has not TeamLeader confirmed !";
                        request.setAttribute("yourMail", yourMail);
                        request.setAttribute("object", object);
                        request.setAttribute("content", content);
                        //begin lay username va codeKPI de bat loi send mail khong thanh cong ! 
                        request.setAttribute("username", username);
                        request.setAttribute("codeKPI", codeKPI);
                        //end
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=sendmail");
                        dispatcher.forward(request, response);
                    }
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
            Logger.getLogger(ConfirmedKPITeamLeader.class
                    .getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ConfirmedKPITeamLeader.class
                    .getName()).log(Level.SEVERE, null, ex);
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

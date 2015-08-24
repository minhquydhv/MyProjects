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
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.DataServices;

/**
 *
 * @author Admin
 */
public class ConfirmedKPIHoD extends HttpServlet {

    private Object seSaleMan;

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
            out.println("<title>Servlet ConfirmedKPIIndividual</title>");
            out.println("</head>");
            out.println("<body>");
            DataServices mydb = new DataServices();
            Date date = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("YY");
            String displayTime = dateFormat.format(date);
            String s1 = displayTime;
            String seTeam = request.getParameter("seTeam");
            String seStaff = request.getParameter("seStaff");
            String getCodeStaffID = request.getParameter("getCode");
            String action = request.getParameter("btAction");
            String username = request.getParameter("username1");
            HttpSession session = request.getSession();

            if (action.equals("Select Team")) {
                request.setAttribute("teamID", seTeam);

                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed");
                dispatcher.forward(request, response);
            } else if (action.equals("Select Staff")) {
                request.setAttribute("staffID", seStaff);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed");
                dispatcher.forward(request, response);

            } else if (action.equals("Accept")) {
                String confirmedHoD = request.getParameter("confirmedHoD");
                String newStr = confirmedHoD.replaceAll(" ", "");
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
                    String a = s1 + getCodeStaffID;

                    String sSql = "update  tbl_comment_kpi_individual set commentHoD=N'" + confirmedHoD + "',dateHoD='" + s11 + "'  where codeCommentIndividual='" + a + "'";
                    mydb.executeNonQuery(sSql);
                    String updateConfirmedHoD = "update  tbl_confirmed_kpi_individual set confirmedHoD=1 where codeConfirmedKPI='" + s1 + getCodeStaffID + "'";
                    mydb.executeNonQuery(updateConfirmedHoD);
                    String queryTeamName = "select teamName from tbl_team where teamID='" + seTeam + "'";

                    ResultSet rsQueryTeamName = mydb.executeQuery(queryTeamName);
                    String teamName = "";
                    while (rsQueryTeamName.next()) {
                        teamName = rsQueryTeamName.getString("teamName");
                    }
                    if (teamName.equals("Sales")) {

                        int kt5 = 0;
                        ArrayList arrStaffID = new ArrayList();
                        String queryStaffID = "select * from tbl_staff a, tbl_team b  where a.teamID = b.teamID  and teamName='Sales'";
                        ResultSet rsQueryStaffID = mydb.executeQuery(queryStaffID);
                        while (rsQueryStaffID.next()) {
                            String s2 = s1 + rsQueryStaffID.getString("staffID");
                            arrStaffID.add(s2);
                        }

                        for (int i = 0; i < arrStaffID.size(); i++) {
                            String queryConfirmedHoD = "select * from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + arrStaffID.get(i) + "'";
                            ResultSet rsQueryConfirmedHoD = mydb.executeQuery(queryConfirmedHoD);
                            while (rsQueryConfirmedHoD.next()) {
                                if (rsQueryConfirmedHoD.getInt("confirmedHoD") == 0) {
                                    kt5 = 1;
                                    break;
                                }
                            }
                        }
                        if (kt5 == 0) {
                            String yourMail = "";
                            String queryYourMail = "select *from tbl_staff a ,tbl_decentralization b where a.staffID = b.staffID and b.roleID='06'";
                            ResultSet rsQueryYourMail = mydb.executeQuery(queryYourMail);
                            while (rsQueryYourMail.next()) {
                                yourMail = rsQueryYourMail.getString("email");
                            }
                            String object = "Sales setting KPI";
                            String content = "Sale Team has setting KPI";
                            request.setAttribute("yourMail", yourMail);
                            request.setAttribute("object", object);
                            request.setAttribute("content", content);
                            //
                            //begin lay username va codeKPI de bat loi send mail khong thanh cong ! 
                            request.setAttribute("username", username);
                            request.setAttribute("codeKPI", s1 + getCodeStaffID);
                            //end
                            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=sendmail");
                            dispatcher.forward(request, response);
                        } else {
                            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed");
                            dispatcher.forward(request, response);
                        }

                    }//ket thuc if cua sale
                    else {
                        String teamID = "";
                        //  out.print(getCodeStaffID);
                        String queryTeamID = "select *from tbl_staff a, tbl_team b where a.teamID = b.teamID and a.staffID='" + getCodeStaffID + "'";
                        ResultSet rsQueryTeamID = mydb.executeQuery(queryTeamID);
                        while (rsQueryTeamID.next()) {
                            teamID = rsQueryTeamID.getString("a.teamID");
                        }

                        int kt = 0;
                        ArrayList arrStaffID = new ArrayList();
                        // out.print(teamID);
                        String queryStaffID = "select * from tbl_staff a, tbl_team b  where a.teamID = b.teamID  and b.teamID='" + teamID + "'";
                        ResultSet rsQueryStaffID = mydb.executeQuery(queryStaffID);
                        while (rsQueryStaffID.next()) {
                            String s2 = s1 + rsQueryStaffID.getString("staffID");
                            arrStaffID.add(s2);
                        }

                        for (int i = 0; i < arrStaffID.size(); i++) {
                            String queryConfirmedHoD = "select * from tbl_confirmed_kpi_individual where codeConfirmedKPI='" + arrStaffID.get(i) + "'";
                            ResultSet rsQueryConfirmedHoD = mydb.executeQuery(queryConfirmedHoD);
                            while (rsQueryConfirmedHoD.next()) {
                                if (rsQueryConfirmedHoD.getInt("confirmedHoD") == 0) {
                                    kt = 1;
                                    break;
                                }
                            }
                        }
                        if (kt == 0) {
                            String yourMail = "";
                            String queryYourMail = "select *from tbl_staff where teamID ='" + teamID + "'";
                            ResultSet rsQueryYourMail = mydb.executeQuery(queryYourMail);
                            while (rsQueryYourMail.next()) {
                                yourMail += rsQueryYourMail.getString("email") + ",";
                            }
                            yourMail = yourMail.substring(0, (yourMail.length() - 1));
                            String object = "confirmed KPI of " + teamName;
                            String content = "KPI of team: " + teamName + " has HoD confirmed !";
                            request.setAttribute("yourMail", yourMail);
                            request.setAttribute("object", object);
                            request.setAttribute("content", content);
                            //begin lay username va codeKPI de bat loi send mail khong thanh cong ! 
                            request.setAttribute("username", username);
                            request.setAttribute("codeKPI", s1 + getCodeStaffID);
                            //end
                            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=sendmail");
                            dispatcher.forward(request, response);
                        } else {
                            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed");
                            dispatcher.forward(request, response);
                        }

                    }
                }
            }//ket thuc accept
            else if (action.equals("Reject")) {

                String codeKPI1 = s1 + getCodeStaffID;
                //out.print(codeKPI1);
                String countKPIStaff1 = "select count(*) as 'count1' from tbl_setting_kpi_individual where codeKPIIndividual like '" + codeKPI1 + "%'";
                ResultSet rsCountKPIStaff1 = mydb.executeQuery(countKPIStaff1);
                String mess = "";
                int count1 = 0;
                while (rsCountKPIStaff1.next()) {
                    count1 = rsCountKPIStaff1.getInt("count1");

                }
                //out.print(count1);
                int kt = 0;
                String sb = "";
                for (int i = 1; i <= count1; i++) {
                    String f1 = "remark" + String.valueOf(i);
                    sb = request.getParameter(f1);
                    String newStr = sb.replaceAll(" ", "");
                    // out.print(f1);
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
                    String confirmedHoD = request.getParameter("confirmedHoD");
                    if (confirmedHoD == "") {
                        mess = "you must enter comment in confirmed HoD box bellow !";
                        request.setAttribute("mess1", mess);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed");
                        dispatcher.forward(request, response);
                    } else {
                        for (int i = 1; i <= count1; i++) {
                            String f1 = "remark" + String.valueOf(i);
                            String sa = request.getParameter(f1);
                            String a = codeKPI1 + String.valueOf(i);//chu y ghep xau 
                            String updateKPI = "update tbl_setting_kpi_individual set remark ='" + sa + "' where codeKPIIndividual='" + a + "'";
                            mydb.executeNonQuery(updateKPI);
                        }
                        String updateConfirmed = "update tbl_confirmed_kpi_individual set confirmedIndividual= 0,confirmedTeamleader=0 where codeConfirmedKPI ='" + codeKPI1 + "'";
                        mydb.executeNonQuery(updateConfirmed);
                        Date date1 = new Date();
                        SimpleDateFormat dateFormat1 = new SimpleDateFormat("dd-MM-yyyy");
                        String displayTime1 = dateFormat1.format(date1);
                        String s11 = displayTime1;
                        String a = s1 + getCodeStaffID;

                        String sSql = "update  tbl_comment_kpi_individual set commentHoD=N'" + confirmedHoD + "',dateHoD='" + s11 + "'  where codeCommentIndividual='" + a + "'";
                        mydb.executeNonQuery(sSql);
                        //lay thong tin cua nguoi nhan
                        String teamID = "";
                        String yourMail = "";
                        String staffName = "";
                        String queryMailStaff = "select *from tbl_staff where staffId ='" + getCodeStaffID + "'";
                        ResultSet rsQueryMailStaff = mydb.executeQuery(queryMailStaff);
                        while (rsQueryMailStaff.next()) {
                            teamID = rsQueryMailStaff.getString("teamID");
                            yourMail = rsQueryMailStaff.getString("email");
                            staffName = rsQueryMailStaff.getString("staffName");
                        }
                        String queryEmailTL = "select *from tbl_staff a, tbl_team b , tbl_decentralization c where a.teamID = b.teamID and a.staffID = c.staffID and b.teamID ='" + teamID + "' and c.roleID='03'";
                        ResultSet rsQueryEmailTL = mydb.executeQuery(queryEmailTL);
                        while (rsQueryEmailTL.next()) {
                            yourMail += "," + rsQueryEmailTL.getString("email");
                        }
                        String object = "confirmed KPI " + staffName;
                        String content = "KPI of" + staffName + " has not HoD confirmed !";
                        request.setAttribute("yourMail", yourMail);
                        request.setAttribute("object", object);
                        request.setAttribute("content", content);
                        //begin lay username va codeKPI de bat loi send mail khong thanh cong ! 
                        request.setAttribute("username", username);
                        request.setAttribute("codeKPI", s1 + getCodeStaffID);
                        //end
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=sendmail");
                        dispatcher.forward(request, response);
                    }
                }
            }

            out.println("</body>");
            out.println("</html>");
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
            Logger.getLogger(ConfirmedKPIHoD.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ConfirmedKPIHoD.class.getName()).log(Level.SEVERE, null, ex);
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

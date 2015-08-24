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
public class ConfirmedKPIGD extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     * @throws java.lang.CloneNotSupportedException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException, CloneNotSupportedException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ConfirmedKPIGD</title>");
            out.println("</head>");
            out.println("<body>");
            DataServices mydb = new DataServices();
            Date date = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("YY");
            String displayTime = dateFormat.format(date);
            String s = displayTime;
            String action = request.getParameter("btAction");
            String seSaleMan = request.getParameter("seSaleMan");
            String getCode = request.getParameter("getCode");
            String codeKPI = s + getCode;
            String username = request.getParameter("username1");
            if (action.equals("Select SaleMan")) {
                request.setAttribute("seSaleMan", seSaleMan);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed");
                dispatcher.forward(request, response);
            } else if (action.equals("Accept")) {
                String confirmedTeamLeader = request.getParameter("confirmedGD");
                String newStr = confirmedTeamLeader.replaceAll(" ", "");
                if (newStr.equals("")) {
                    String mess = "you must enter comment in confirmed GD  box bellow !";
                    request.setAttribute("mess1", mess);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed");
                    dispatcher.forward(request, response);
                } else {
                    Date date1 = new Date();
                    SimpleDateFormat dateFormat1 = new SimpleDateFormat("dd-MM-yyyy");
                    String displayTime1 = dateFormat1.format(date1);
                    String s11 = displayTime1;
                    String comment = request.getParameter("confirmedGD");
                    String updateComment = "update  tbl_comment_kpi_individual set commentGD=N'" + comment + "',dateGD='" + s11 + "' where codeCommentIndividual='" + codeKPI + "'";
                    mydb.executeNonQuery(updateComment);
                    String sSqlUpdateConfirmed = "update tbl_confirmed_kpi_individual set confirmedGD =1 where codeConfirmedKPI='" + codeKPI + "'";
                    mydb.executeNonQuery(sSqlUpdateConfirmed);
                    String queryTeamID = "select *from tbl_staff a ,tbl_team b where a.teamID=b.teamID and a.staffID= '" + seSaleMan + "'";
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
                            if (rsQueryConfirmedTL.getInt("confirmedGD") == 0) {
                                kt = 1;
                                break;
                            }
                        }
                    }
                    if (kt == 1) {
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed");
                        dispatcher.forward(request, response);
                    } else if (kt == 0) {
                        //lay yourMail cho giam doc
                        String yourMail = "";
                        String queryYourMailDGD = "select *from tbl_staff a,tbl_decentralization b where a.staffID = b.staffID and b.roleID ='06'";
                        ResultSet rsQueryYourMailDGD = mydb.executeQuery(queryYourMailDGD);
                        while (rsQueryYourMailDGD.next()) {
                            yourMail = rsQueryYourMailDGD.getString("email");
                        }
                       
                        String depID = "";
                        String queryDeptID = "select * from tbl_team a,tbl_department b where a.deptID=b.deptID and a.teamName='Sales'";
                        ResultSet rsQueryDeptID = mydb.executeQuery(queryDeptID);
                        while (rsQueryDeptID.next()) {
                            depID = rsQueryDeptID.getString("a.deptID");
                        }
                        String queryYourMailHoD = "select *from tbl_staff a , tbl_team b, tbl_department c,tbl_decentralization d where a.teamID =b.teamID and b.deptID=c.deptID and a.staffID=d.staffID and c.deptID='" + depID + "' and d.roleID ='02'";
                        ResultSet rsQueryYourMailHoD = mydb.executeQuery(queryYourMailHoD);
                        while (rsQueryYourMailHoD.next()) {
                            yourMail += "," + rsQueryYourMailHoD.getString("email");
                        }
                        String queryYourMailSales = "select *from tbl_staff a, tbl_team b where a.teamID=b.teamID and b.teamName='Sales'";
                        ResultSet rsQueryYourMailSales = mydb.executeQuery(queryYourMailSales);
                        while (rsQueryYourMailSales.next()) {
                            yourMail += "," + rsQueryYourMailSales.getString("email");
                        }
                        String object = "confirmed KPI ";
                        String content = "KPI has GD confirmed !";
                        request.setAttribute("yourMail", yourMail);
                        request.setAttribute("object", object);
                        request.setAttribute("content", content);

                        //begin lay username va codeKPI de bat loi send mail khong thanh cong ! 
                        request.setAttribute("username", username);
                        request.setAttribute("codeKPI", codeKPI);
                        //end            

                        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=sendmail");
                        dispatcher.forward(request, response);
                        //ket lay yourMail
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
                    String confirmedTeamLeader = request.getParameter("confirmedGD");
                    String newStr = confirmedTeamLeader.replaceAll(" ", "");
                    if (newStr.equals("")) {
                        mess = "you must enter comment in confirmed GD  box bellow !";
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
                        String updateConfirmed = "update tbl_confirmed_kpi_individual set confirmedIndividual=0,confirmedTeamLeader=0,confirmedHoD=0,confirmedDGD=0 where codeConfirmedKPI ='" + codeKPI + "'";
                        mydb.executeNonQuery(updateConfirmed);
                        Date date1 = new Date();
                        SimpleDateFormat dateFormat1 = new SimpleDateFormat("dd-MM-yyyy");
                        String displayTime1 = dateFormat1.format(date1);
                        String s11 = displayTime1;
                        String comment = request.getParameter("confirmedGD");
                        String updateComment = "update  tbl_comment_kpi_individual set commentGD=N'" + comment + "',dateGD='" + s11 + "' where codeCommentIndividual='" + codeKPI + "'";
                        mydb.executeNonQuery(updateComment);

                        //lay thong tin nguoi nhan
                        String yourMail = "";
                        String TeamID = "";
                        String staffName = "";
                        String queryMailStaff = "select *from tbl_staff where staffID='" + getCode + "'";
                        ResultSet rsQueryMailStaff = mydb.executeQuery(queryMailStaff);
                        while (rsQueryMailStaff.next()) {
                            TeamID = rsQueryMailStaff.getString("teamID");
                            yourMail = rsQueryMailStaff.getString("email");
                            staffName = rsQueryMailStaff.getString("staffName");
                        }
                        String deptID = "";
                        String queryMailTeamLeader = "select *from tbl_staff a,tbl_decentralization b,tbl_team c where a.teamID=c.teamID and a.staffID=b.staffID and a.teamID='" + TeamID + "' and b.roleID='03'";
                        ResultSet rsQueryMailTeamLeader = mydb.executeQuery(queryMailTeamLeader);
                        while (rsQueryMailTeamLeader.next()) {
                            yourMail += "," + rsQueryMailTeamLeader.getString("email");
                            deptID = rsQueryMailTeamLeader.getString("deptID");
                        }
                        String queryMailHoD = "select *from tbl_staff a, tbl_team b, tbl_department c,tbl_decentralization d where a.teamID=b.teamID and b.deptID=c.deptID and a.staffID=d.staffID and c.deptID='" + deptID + "' and d.roleID='02'";
                        ResultSet rsQueryMailHoD = mydb.executeQuery(queryMailHoD);
                        while (rsQueryMailHoD.next()) {
                            yourMail += "," + rsQueryMailHoD.getString("email");
                        }

                       
                        String queryYourMailDGD = "select *from tbl_staff a,tbl_decentralization b where a.staffID = b.staffID and b.roleID ='06'";
                        ResultSet rsQueryYourMailDGD = mydb.executeQuery(queryYourMailDGD);
                        while (rsQueryYourMailDGD.next()) {
                            yourMail += "," + rsQueryYourMailDGD.getString("email");
                        }
                        String object = "confirmed KPI of " + staffName;
                        String content = "KPI of staffName: " + staffName + " has not DGD confirmed !";
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
        } catch (ClassNotFoundException | SQLException | CloneNotSupportedException ex) {
            Logger.getLogger(ConfirmedKPIGD.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException | SQLException | CloneNotSupportedException ex) {
            Logger.getLogger(ConfirmedKPIGD.class.getName()).log(Level.SEVERE, null, ex);
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cotroller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.DataServices;
import objects.SendMail;

/**
 *
 * @author Admin
 */
public class ProcessSendMail extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {

        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProcessSendMail</title>");
            out.println("</head>");
            out.println("<body>");
            DataServices mydb = new DataServices();
            boolean kt = false;
            String myEmail = request.getParameter("myEmail");
            String myPass = request.getParameter("myPass");
            String yourEmail = request.getParameter("yourEmail");
            String object = request.getParameter("object");
            String content = request.getParameter("content");
            String action = request.getParameter("btAction");
            char arrYourMails[] = yourEmail.toCharArray();
            ArrayList arrayListYourMails = new ArrayList();
            String str = "";
            for (int i = 0; i < arrYourMails.length; i++) {
                if (arrYourMails[i] == ',') {
                    arrayListYourMails.add(str);
                    str = "";
                } else {
                    str += arrYourMails[i];
                }
            }

            arrayListYourMails.add(str);
            for (int i = 0; i < arrayListYourMails.size(); i++) {
                if (action.equals("Send")) {
                    SendMail obj = new SendMail();
                    kt = obj.send((String) arrayListYourMails.get(i), myEmail, myPass, object, content);
                    if (kt) {
                        out.print("<script>alert('Your message is successfully sent !')</script>" + "<div style='width:200px;margin:100px auto;'><a href='../JSP/index.jsp'><img src='../Images/MB__back.png' title='Click here to come back home !'/></a></div>");
                        break;
                    } else {
                        String username = request.getParameter("username");
                        String codeKPI = request.getParameter("codeKPI");
                        String queryRole = "select *from tbl_decentralization where staffID='" + username + "'";
                        ResultSet rsQueryRole = mydb.executeQuery(queryRole);
                        String role = "";
                        while (rsQueryRole.next()) {
                            role = rsQueryRole.getString("roleID");
                        }
                        if (role.equals("04")) {
                            String updateConfirmedIndividual = "update tbl_confirmed_kpi_individual set confirmedIndividual=0 where codeConfirmedKPI='" + codeKPI + "'";
                            mydb.executeNonQuery(updateConfirmedIndividual);
                            out.print("<div style='width:400px;margin:100px auto;'><p style='color:#ff0000;font-size:20px;'>Your message isn't successfully sent !</p><br/><a href='../JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=setting'><img src='../Images/MB__back.png' title='Click here to come back your setting !'/></a></div>");
                            break;
                        } else if (role.equals("03")) {
                            String updateConfirmedIndividual = "update tbl_confirmed_kpi_individual set confirmedIndividual=1,confirmedTeamLeader=0 where codeConfirmedKPI='" + codeKPI + "'";
                            mydb.executeNonQuery(updateConfirmedIndividual);
                            String updateCommentIndividual = "update tbl_comment_kpi_individual set commentTeamLeader='' ,dateTeamLeader='' where codeCommentIndividual='" + codeKPI + "'";
                            mydb.executeNonQuery(updateCommentIndividual);
                            out.print("<div style='width:400px;margin:100px auto;'><p style='color:#ff0000;font-size:20px;'>Your message isn't successfully sent !</p><br/><a href='../JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed'><img src='../Images/MB__back.png' title='Click here to come back your setting !'/></a></div>");
                            break;
                        } else if (role.equals("02")) {
                            String updateConfirmedIndividual = "update tbl_confirmed_kpi_individual set confirmedIndividual=1,confirmedTeamLeader=1,confirmedHoD=0 where codeConfirmedKPI='" + codeKPI + "'";
                            mydb.executeNonQuery(updateConfirmedIndividual);
                            String updateCommentIndividual = "update tbl_comment_kpi_individual set commentHoD='' ,dateHoD='' where codeCommentIndividual='" + codeKPI + "'";
                            mydb.executeNonQuery(updateCommentIndividual);
                            out.print("<div style='width:400px;margin:100px auto;'><p style='color:#ff0000;font-size:20px;'>Your message isn't successfully sent !</p><br/><a href='../JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed'><img src='../Images/MB__back.png' title='Click here to come back your setting !'/></a></div>");
                            break;
                        } else if (role.equals("06")) {
                            String updateConfirmedIndividual = "update tbl_confirmed_kpi_individual set confirmedIndividual=1,confirmedTeamLeader=1,confirmedHoD=1,confirmedDGD=0 where codeConfirmedKPI='" + codeKPI + "'";
                            mydb.executeNonQuery(updateConfirmedIndividual);
                            String updateCommentIndividual = "update tbl_comment_kpi_individual set commentDGD='' ,dateDGD='' where codeCommentIndividual='" + codeKPI + "'";
                            mydb.executeNonQuery(updateCommentIndividual);
                            out.print("<div style='width:400px;margin:100px auto;'><p style='color:#ff0000;font-size:20px;'>Your message isn't successfully sent !</p><br/><a href='../JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed'><img src='../Images/MB__back.png' title='Click here to come back your setting !'/></a></div>");
                            break;
                        } else if (role.equals("08")) {
                            String updateConfirmedIndividual = "update tbl_confirmed_kpi_individual set confirmedIndividual=1,confirmedTeamLeader=1,confirmedHoD=1,confirmedDGD=1,confirmedGD=0 where codeConfirmedKPI='" + codeKPI + "'";
                            mydb.executeNonQuery(updateConfirmedIndividual);
                            String updateCommentIndividual = "update tbl_comment_kpi_individual set commentGD='' ,dateGD='' where codeCommentIndividual='" + codeKPI + "'";
                            mydb.executeNonQuery(updateCommentIndividual);
                            out.print("<div style='width:400px;margin:100px auto;'><p style='color:#ff0000;font-size:20px;'>Your message isn't successfully sent !</p><br/><a href='../JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed'><img src='../Images/MB__back.png' title='Click here to come back your setting !'/></a></div>");
                            break;
                        }
                    }
                }
            }
            out.println("</body>");
            out.println("</html>");
        }
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
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
        } catch (Exception ex) {
            Logger.getLogger(ProcessSendMail.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (Exception ex) {
            Logger.getLogger(ProcessSendMail.class.getName()).log(Level.SEVERE, null, ex);
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

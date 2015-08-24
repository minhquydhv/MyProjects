/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cotroller.evaluate.individual;

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
import objects.EvaluateKPIStaff;

/**
 *
 * @author Admin
 */
public class EvaluateStaff extends HttpServlet {

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
            out.println("<title>Servlet EvaluateStaff</title>");
            out.println("</head>");
            out.println("<body>");
            Date date = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("YY");
            String displayTime = dateFormat.format(date);
            DataServices mydb = new DataServices();
            String action = request.getParameter("btAction");
            ArrayList<EvaluateKPIStaff> arrKPIEvaluateStaff = new ArrayList<EvaluateKPIStaff>();
            if (action.equals("Grading")) {
                String uname = request.getParameter("uname");
                String numRows = request.getParameter("numRows");
                int count = Integer.parseInt(numRows);
                for (int i = 1; i <= count; i++) {
                    String codeEvaluateStaff = displayTime + uname + String.valueOf(i);
                    String kpi = request.getParameter("kpi" + String.valueOf(i));
                    String arvstts = request.getParameter("arvstts" + String.valueOf(i));
                    String weightage = request.getParameter("weightage" + String.valueOf(i));
                    String rating_staff = request.getParameter("rating_staff" + String.valueOf(i));
                    String points_staff = request.getParameter("points_staff" + String.valueOf(i));
                    String mronat = request.getParameter("mronat" + String.valueOf(i));
                    EvaluateKPIStaff ev = new EvaluateKPIStaff(codeEvaluateStaff, kpi, arvstts, weightage, rating_staff, "", mronat, "", "", "", "", "", "", "", "", "", "");
                    arrKPIEvaluateStaff.add(ev);
                }
                double sumPoints = 0;
                for (int i = 0; i < arrKPIEvaluateStaff.size(); i++) {
                    if (arrKPIEvaluateStaff.get(i).getRating_staff() != null) {
                        try {
                            double rating = Double.parseDouble(arrKPIEvaluateStaff.get(i).getRating_staff());
                            double weightage = Double.parseDouble(arrKPIEvaluateStaff.get(i).getWeightage());
                            double points = (rating * weightage) / 100;
                            sumPoints += points;
                            arrKPIEvaluateStaff.get(i).setPoints_staff(String.valueOf(points));
                        } catch (Exception e) {
                            request.setAttribute("mess", "rating must is a number !");
                            request.setAttribute("arrKPIEvaluateStaff", arrKPIEvaluateStaff);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                            dispatcher.forward(request, response);
                        }
                    }
                }
                request.setAttribute("sumPoints", String.valueOf(sumPoints));
                request.setAttribute("arrKPIEvaluateStaff", arrKPIEvaluateStaff);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                dispatcher.forward(request, response);
            }
            if (action.equals("Save")) {
                String uname = request.getParameter("uname");
                String numRows = request.getParameter("numRows");
                int count = Integer.parseInt(numRows);
                for (int i = 1; i <= count; i++) {
                    String codeEvaluateStaff = displayTime + uname + String.valueOf(i);
                    String kpi = request.getParameter("kpi" + String.valueOf(i));
                    String arvstts = request.getParameter("arvstts" + String.valueOf(i));
                    String weightage = request.getParameter("weightage" + String.valueOf(i));
                    String rating_staff = request.getParameter("rating_staff" + String.valueOf(i));
                    String points_staff = request.getParameter("points_staff" + String.valueOf(i));
                    String mronat = request.getParameter("mronat" + String.valueOf(i));
                    EvaluateKPIStaff ev = new EvaluateKPIStaff(codeEvaluateStaff, kpi, arvstts, weightage, rating_staff, "", mronat, "", "", "", "", "", "", "", "", "", "");
                    arrKPIEvaluateStaff.add(ev);
                }
                double sumPoints = 0;
                for (int i = 0; i < arrKPIEvaluateStaff.size(); i++) {
                    if (arrKPIEvaluateStaff.get(i).getRating_staff() != null) {
                        try {
                            double rating = Double.parseDouble(arrKPIEvaluateStaff.get(i).getRating_staff());
                            double weightage = Double.parseDouble(arrKPIEvaluateStaff.get(i).getWeightage());
                            double points = (rating * weightage) / 100;
                            sumPoints += points;
                            arrKPIEvaluateStaff.get(i).setPoints_staff(String.valueOf(points));
                        } catch (Exception e) {
                            request.setAttribute("mess", "rating must is a number !");
                            request.setAttribute("arrKPIEvaluateStaff", arrKPIEvaluateStaff);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                            dispatcher.forward(request, response);
                        }
                    }
                }
                int countEvaluate = 0;
                String queryCountEvaluate = "select count(*) as 'count' from tbl_evaluate_kpi_staff where code_evaluate_kpi like '" + displayTime + uname + "%'";
                ResultSet rsQueryCountEvaluate = mydb.executeQuery(queryCountEvaluate);
                while (rsQueryCountEvaluate.next()) {
                    countEvaluate = rsQueryCountEvaluate.getInt("count");
                }
                out.print(countEvaluate);
                if (countEvaluate == 0) {
                    for (int i = 0; i < arrKPIEvaluateStaff.size(); i++) {
                        String insertEvaluate = "insert into tbl_evaluate_kpi_staff values('" + arrKPIEvaluateStaff.get(i).getCode_evaluate_kpi()
                                + "','" + arrKPIEvaluateStaff.get(i).getKpi() + "','" + arrKPIEvaluateStaff.get(i).getArvstts() + "','"
                                + arrKPIEvaluateStaff.get(i).getWeightage() + "','" + arrKPIEvaluateStaff.get(i).getRating_staff() + "','"
                                + arrKPIEvaluateStaff.get(i).getPoints_staff() + "','" + arrKPIEvaluateStaff.get(i).getMronat() + "','','','','','','','','','','')";
                        mydb.executeNonQuery(insertEvaluate);
                    }
                    String insertScore = "insert into tbl_average_score_staff values('" + displayTime + uname + "','" + sumPoints + "','','','','','','','')";
                    mydb.executeNonQuery(insertScore);
                    String insertEvaluate = "insert into tbl_evaluate_individual values('" + displayTime + uname + "',0,0,0,0,0,0)";
                    mydb.executeNonQuery(insertEvaluate);
                    String insertComment = "insert into tbl_comment_evaluate_staff values('" + displayTime + uname + "','','','','','','','','','','','','','','','') ";
                    mydb.executeNonQuery(insertComment);

                } else {
                    for (int i = 0; i < arrKPIEvaluateStaff.size(); i++) {
                        String updateEvaluate = "update tbl_evaluate_kpi_staff set arvstts='" + arrKPIEvaluateStaff.get(i).getArvstts()
                                + "',rating_staff='" + arrKPIEvaluateStaff.get(i).getRating_staff() + "',points_staff='" + arrKPIEvaluateStaff.get(i).getPoints_staff() + "',mronat='" + arrKPIEvaluateStaff.get(i).getMronat() + "' where code_evaluate_kpi='" + arrKPIEvaluateStaff.get(i).getCode_evaluate_kpi() + "'";
                        mydb.executeNonQuery(updateEvaluate);
                    }
                    String updateScore = "update tbl_average_score_staff set score_staff='" + sumPoints + "' where code_average_score='" + displayTime + uname + "'";
                    mydb.executeNonQuery(updateScore);
                }
                request.setAttribute("sumPoints", String.valueOf(sumPoints));
                request.setAttribute("arrKPIEvaluateStaff", arrKPIEvaluateStaff);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                dispatcher.forward(request, response);
            }//ket thuc nut save
            //bat dau send mail
            else if (action.equals("Send Mail")) {
                String uname = request.getParameter("uname");
                String numRows = request.getParameter("numRows");
                int count = Integer.parseInt(numRows);
                for (int i = 1; i <= count; i++) {
                    String codeEvaluateStaff = displayTime + uname + String.valueOf(i);
                    String kpi = request.getParameter("kpi" + String.valueOf(i));
                    String arvstts = request.getParameter("arvstts" + String.valueOf(i));
                    String weightage = request.getParameter("weightage" + String.valueOf(i));
                    String rating_staff = request.getParameter("rating_staff" + String.valueOf(i));
                    String points_staff = request.getParameter("points_staff" + String.valueOf(i));
                    String mronat = request.getParameter("mronat" + String.valueOf(i));
                    EvaluateKPIStaff ev = new EvaluateKPIStaff(codeEvaluateStaff, kpi, arvstts, weightage, rating_staff, "", mronat, "", "", "", "", "", "", "", "", "", "");
                    arrKPIEvaluateStaff.add(ev);
                }
                double sumPoints = 0;
                for (int i = 0; i < arrKPIEvaluateStaff.size(); i++) {
                    if ((arrKPIEvaluateStaff.get(i).getRating_staff() != "") && (arrKPIEvaluateStaff.get(i).getArvstts() != "") && (arrKPIEvaluateStaff.get(i).getMronat() != "")) {
                        try {
                            double rating = Double.parseDouble(arrKPIEvaluateStaff.get(i).getRating_staff());
                            double weightage = Double.parseDouble(arrKPIEvaluateStaff.get(i).getWeightage());
                            double points = (rating * weightage) / 100;
                            sumPoints += points;
                            arrKPIEvaluateStaff.get(i).setPoints_staff(String.valueOf(points));
                        } catch (Exception e) {
                            request.setAttribute("mess", "rating must is a number !");
                            request.setAttribute("arrKPIEvaluateStaff", arrKPIEvaluateStaff);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                            dispatcher.forward(request, response);
                        }
                    } else {
                        request.setAttribute("mess", "input data not null !");
                        request.setAttribute("arrKPIEvaluateStaff", arrKPIEvaluateStaff);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                        dispatcher.forward(request, response);
                    }
                }
                int countEvaluate = 0;
                String queryCountEvaluate = "select count(*) as 'count' from tbl_evaluate_kpi_staff where code_evaluate_kpi like '" + displayTime + uname + "%'";
                ResultSet rsQueryCountEvaluate = mydb.executeQuery(queryCountEvaluate);
                while (rsQueryCountEvaluate.next()) {
                    countEvaluate = rsQueryCountEvaluate.getInt("count");
                }
                out.print(countEvaluate);
                if (countEvaluate == 0) {
                    for (int i = 0; i < arrKPIEvaluateStaff.size(); i++) {
                        String insertEvaluate = "insert into tbl_evaluate_kpi_staff values('" + arrKPIEvaluateStaff.get(i).getCode_evaluate_kpi()
                                + "','" + arrKPIEvaluateStaff.get(i).getKpi() + "','" + arrKPIEvaluateStaff.get(i).getArvstts() + "','"
                                + arrKPIEvaluateStaff.get(i).getWeightage() + "','" + arrKPIEvaluateStaff.get(i).getRating_staff() + "','"
                                + arrKPIEvaluateStaff.get(i).getPoints_staff() + "','" + arrKPIEvaluateStaff.get(i).getMronat() + "','','','','','','','','','','')";
                        mydb.executeNonQuery(insertEvaluate);
                    }
                    String insertScore = "insert into tbl_average_score_staff values('" + displayTime + uname + "','" + sumPoints + "','','','','','','','')";
                    mydb.executeNonQuery(insertScore);

                    String insertEvaluate = "insert into tbl_evaluate_individual values('" + displayTime + uname + "',1,0,0,0,0,0)";
                    mydb.executeNonQuery(insertEvaluate);
                } else {
                    for (int i = 0; i < arrKPIEvaluateStaff.size(); i++) {
                        String updateEvaluate = "update tbl_evaluate_kpi_staff set arvstts='" + arrKPIEvaluateStaff.get(i).getArvstts()
                                + "',rating_staff='" + arrKPIEvaluateStaff.get(i).getRating_staff() + "',points_staff='" + arrKPIEvaluateStaff.get(i).getPoints_staff() + "',mronat='" + arrKPIEvaluateStaff.get(i).getMronat() + "' where code_evaluate_kpi='" + arrKPIEvaluateStaff.get(i).getCode_evaluate_kpi() + "'";
                        mydb.executeNonQuery(updateEvaluate);
                    }
                    String updateScore = "update tbl_average_score_staff set score_staff='" + sumPoints + "' where code_average_score='" + displayTime + uname + "'";
                    mydb.executeNonQuery(updateScore);

                    String updateEvaluate = "update tbl_evaluate_individual set evaluate_staff=1 where code_evalate_individual ='" + displayTime + uname + "'";
                    mydb.executeNonQuery(updateEvaluate);
                }
//                request.setAttribute("sumPoints", String.valueOf(sumPoints));
//                request.setAttribute("arrKPIEvaluateStaff", arrKPIEvaluateStaff);

                String queryTeamID = "select *from tbl_staff a , tbl_team b where a.teamID = b.teamID and a.staffID='" + uname + "'";
                String teamID = "";
                String staffName = "";

                ResultSet rsQueryTeamID = mydb.executeQuery(queryTeamID);
                while (rsQueryTeamID.next()) {
                    teamID = rsQueryTeamID.getString("teamID");
                    staffName = rsQueryTeamID.getString("staffName");
                }
                String queryStaff = "select *from tbl_staff a,tbl_team b,tbl_decentralization c where a.teamID = b.teamID and a.staffID =c.staffID and b.teamID='" + teamID + "' and c.roleID='03'";
                ResultSet rsQueryStaff = mydb.executeQuery(queryStaff);
                String yourMail = "";
                while (rsQueryStaff.next()) {
                    yourMail = rsQueryStaff.getString("email");
                }
                String object = staffName + " Evaluate KPI";
                String content = staffName + "Evaluated KPI ";
                request.setAttribute("yourMail", yourMail);
                request.setAttribute("object", object);
                request.setAttribute("content", content);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=sendmail");
                dispatcher.forward(request, response);

            }//ket thuc send mail
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
            Logger.getLogger(EvaluateStaff.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(EvaluateStaff.class.getName()).log(Level.SEVERE, null, ex);
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

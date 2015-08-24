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
public class EvaluateTeamLeader extends HttpServlet {

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
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException, CloneNotSupportedException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EvaluateTeamLeader</title>");
            out.println("</head>");
            out.println("<body>");
            Date date1 = new Date();
            SimpleDateFormat dateFormat1 = new SimpleDateFormat("dd-MM-YYYY");
            String displayTime1 = dateFormat1.format(date1);

            Date date = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("YY");
            String displayTime = dateFormat.format(date);
            DataServices mydb = new DataServices();
            String action = request.getParameter("btAction");
            String seStaff = request.getParameter("seStaff");
            if (action.equals("Select Staff")) {
                request.setAttribute("staffID", seStaff);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                dispatcher.forward(request, response);
            } else if (action.equals("Grading")) {
                String numRows = request.getParameter("numRows");
                int rows = Integer.parseInt(numRows);
                String staffID = request.getParameter("staffID");
                // out.print(numRows);
                //out.print(staffID);
                String queryEvaluate = "select *from tbl_evaluate_kpi_staff where code_evaluate_kpi like'" + displayTime + staffID + "%'";
                ArrayList<EvaluateKPIStaff> arrEvaluateKPIStaff = new ArrayList<EvaluateKPIStaff>();
                ResultSet rsQueryEvaluate = mydb.executeQuery(queryEvaluate);
                while (rsQueryEvaluate.next()) {
                    EvaluateKPIStaff ev = new EvaluateKPIStaff(rsQueryEvaluate.getString("code_evaluate_kpi"), rsQueryEvaluate.getString("kpi"), rsQueryEvaluate.getString("arvstts"), rsQueryEvaluate.getString("weightage"), "", "", rsQueryEvaluate.getString("mronat"), "", "", "", "", "", "", "", "", "", "");
                    arrEvaluateKPIStaff.add(ev);
                }

                int j = 0;
                for (int i = 1; i <= rows; i++) {
                    String ratingTL = request.getParameter("rating_teamleader" + String.valueOf(i));
                    arrEvaluateKPIStaff.get(j).setRating_teamleader(ratingTL);
                    j++;
                }
                // out.print(arrEvaluateKPIStaff.get(0).getRating_teamleader());
                double sumPoints = 0;
                for (int i = 0; i < arrEvaluateKPIStaff.size(); i++) {
                    if (arrEvaluateKPIStaff.get(i).getRating_teamleader() != "") {
                        try {
                            double weightage = Double.parseDouble(arrEvaluateKPIStaff.get(i).getWeightage());
                            double rating = Double.parseDouble(arrEvaluateKPIStaff.get(i).getRating_teamleader());
                            double points = (weightage * rating) / 100;
                            arrEvaluateKPIStaff.get(i).setPoints_teamleader(String.valueOf(points));
                            sumPoints += points;
                        } catch (Exception e) {
                            request.setAttribute("mess", "rating must is a number !");
                            request.setAttribute("arrEvaluateKPIStaff", arrEvaluateKPIStaff);
                            request.setAttribute("staffID", staffID);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                            dispatcher.forward(request, response);
                        }
                    }
                }
                request.setAttribute("arrEvaluateKPIStaff", arrEvaluateKPIStaff);
                request.setAttribute("sumPoints", String.valueOf(sumPoints));
                request.setAttribute("staffID", staffID);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                dispatcher.forward(request, response);
            } else if (action.equals("Save")) {
                String numRows = request.getParameter("numRows");
                int rows = Integer.parseInt(numRows);
                String staffID = request.getParameter("staffID");
                // out.print(numRows);
                //out.print(staffID);
                String queryEvaluate = "select *from tbl_evaluate_kpi_staff where code_evaluate_kpi like'" + displayTime + staffID + "%'";
                ArrayList<EvaluateKPIStaff> arrEvaluateKPIStaff = new ArrayList<EvaluateKPIStaff>();
                ResultSet rsQueryEvaluate = mydb.executeQuery(queryEvaluate);
                while (rsQueryEvaluate.next()) {
                    EvaluateKPIStaff ev = new EvaluateKPIStaff(rsQueryEvaluate.getString("code_evaluate_kpi"), rsQueryEvaluate.getString("kpi"), rsQueryEvaluate.getString("arvstts"), rsQueryEvaluate.getString("weightage"), "", "", rsQueryEvaluate.getString("mronat"), "", "", "", "", "", "", "", "", "", "");
                    arrEvaluateKPIStaff.add(ev);
                }

                int j = 0;
                for (int i = 1; i <= rows; i++) {
                    String ratingTL = request.getParameter("rating_teamleader" + String.valueOf(i));
                    arrEvaluateKPIStaff.get(j).setRating_teamleader(ratingTL);
                    j++;
                }
                // out.print(arrEvaluateKPIStaff.get(0).getRating_teamleader());
                double sumPoints = 0;
                for (int i = 0; i < arrEvaluateKPIStaff.size(); i++) {
                    if (arrEvaluateKPIStaff.get(i).getRating_teamleader() != "") {
                        try {
                            double weightage = Double.parseDouble(arrEvaluateKPIStaff.get(i).getWeightage());
                            double rating = Double.parseDouble(arrEvaluateKPIStaff.get(i).getRating_teamleader());
                            double points = (weightage * rating) / 100;
                            arrEvaluateKPIStaff.get(i).setPoints_teamleader(String.valueOf(points));
                            sumPoints += points;
                        } catch (Exception e) {
                            request.setAttribute("mess", "rating must is a number !");
                            request.setAttribute("arrEvaluateKPIStaff", arrEvaluateKPIStaff);
                            request.setAttribute("staffID", staffID);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                            dispatcher.forward(request, response);
                        }
                    }
                }
                for (int i = 0; i < arrEvaluateKPIStaff.size(); i++) {
                    String updateEvaluateKPI = "update tbl_evaluate_kpi_staff set rating_teamleader='" + arrEvaluateKPIStaff.get(i).getRating_teamleader() + "',points_teamleader='" + arrEvaluateKPIStaff.get(i).getPoints_teamleader() + "' where code_evaluate_kpi='" + arrEvaluateKPIStaff.get(i).getCode_evaluate_kpi() + "'";
                    mydb.executeNonQuery(updateEvaluateKPI);
                }
                String updateScore = "update tbl_average_score_staff set score_teamleader='" + sumPoints + "' where 	code_average_score='" + displayTime + staffID + "'";
                mydb.executeNonQuery(updateScore);
//                String updateEvaluate = "update tbl_evaluate_individual set evaluate_teamleader=1 where code_evaluate_individual ='" + displayTime + staffID + "'";
//                mydb.executeNonQuery(updateEvaluate);
                String updateComment = "update tbl_comment_evaluate_staff set comment_teamleader='" + request.getParameter("taTeamLeader") + "',date_teamleader='" + displayTime1 + "', signature_teamleader='" + request.getParameter("txtTeamLeader") + "' where code_comment_evaluate_staff='" + displayTime + staffID + "'";
                mydb.executeNonQuery(updateComment);
                request.setAttribute("arrEvaluateKPIStaff", arrEvaluateKPIStaff);
                request.setAttribute("sumPoints", String.valueOf(sumPoints));
                request.setAttribute("staffID", staffID);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                dispatcher.forward(request, response);
            } else if (action.equals("Send Mail")) {
                String numRows = request.getParameter("numRows");
                int rows = Integer.parseInt(numRows);
                String staffID = request.getParameter("staffID");
                // out.print(numRows);
                //out.print(staffID);
                String queryEvaluate = "select *from tbl_evaluate_kpi_staff where code_evaluate_kpi like'" + displayTime + staffID + "%'";
                ArrayList<EvaluateKPIStaff> arrEvaluateKPIStaff = new ArrayList<EvaluateKPIStaff>();
                ResultSet rsQueryEvaluate = mydb.executeQuery(queryEvaluate);
                while (rsQueryEvaluate.next()) {
                    EvaluateKPIStaff ev = new EvaluateKPIStaff(rsQueryEvaluate.getString("code_evaluate_kpi"), rsQueryEvaluate.getString("kpi"), rsQueryEvaluate.getString("arvstts"), rsQueryEvaluate.getString("weightage"), "", "", rsQueryEvaluate.getString("mronat"), "", "", "", "", "", "", "", "", "", "");
                    arrEvaluateKPIStaff.add(ev);
                }

                int j = 0;
                for (int i = 1; i <= rows; i++) {
                    String ratingTL = request.getParameter("rating_teamleader" + String.valueOf(i));
                    arrEvaluateKPIStaff.get(j).setRating_teamleader(ratingTL);
                    j++;
                }
                // out.print(arrEvaluateKPIStaff.get(0).getRating_teamleader());
                double sumPoints = 0;
                for (int i = 0; i < arrEvaluateKPIStaff.size(); i++) {
                    if (arrEvaluateKPIStaff.get(i).getRating_teamleader() != "") {
                        try {
                            double weightage = Double.parseDouble(arrEvaluateKPIStaff.get(i).getWeightage());
                            double rating = Double.parseDouble(arrEvaluateKPIStaff.get(i).getRating_teamleader());
                            double points = (weightage * rating) / 100;
                            arrEvaluateKPIStaff.get(i).setPoints_teamleader(String.valueOf(points));
                            sumPoints += points;
                        } catch (Exception e) {
                            request.setAttribute("mess", "rating must is a number !");
                            request.setAttribute("arrEvaluateKPIStaff", arrEvaluateKPIStaff);
                            request.setAttribute("staffID", staffID);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                            dispatcher.forward(request, response);
                        }
                    } else {
                        request.setAttribute("mess", "rating not null !");
                        request.setAttribute("arrEvaluateKPIStaff", arrEvaluateKPIStaff);
                        request.setAttribute("staffID", staffID);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                        dispatcher.forward(request, response);
                    }
                }
                String signatureTeamleader = request.getParameter("txtTeamLeader");
                signatureTeamleader = signatureTeamleader.replace(" ", "");
                if (signatureTeamleader.equals("")) {
                    request.setAttribute("mess", " signature not null!");
                    request.setAttribute("arrEvaluateKPIStaff", arrEvaluateKPIStaff);
                    request.setAttribute("staffID", staffID);
                    request.setAttribute("sumPoints", String.valueOf(sumPoints));
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance");
                    dispatcher.forward(request, response);
                }
                for (int i = 0; i < arrEvaluateKPIStaff.size(); i++) {
                    String updateEvaluateKPI = "update tbl_evaluate_kpi_staff set rating_teamleader='" + arrEvaluateKPIStaff.get(i).getRating_teamleader() + "',points_teamleader='" + arrEvaluateKPIStaff.get(i).getPoints_teamleader() + "' where code_evaluate_kpi='" + arrEvaluateKPIStaff.get(i).getCode_evaluate_kpi() + "'";
                    mydb.executeNonQuery(updateEvaluateKPI);
                }
                String updateScore = "update tbl_average_score_staff set score_teamleader='" + sumPoints + "' where 	code_average_score='" + displayTime + staffID + "'";
                mydb.executeNonQuery(updateScore);
                String updateEvaluate = "update tbl_evaluate_individual set evaluate_teamleader=1 where code_evaluate_individual ='" + displayTime + staffID + "'";
                mydb.executeNonQuery(updateEvaluate);
                String updateComment = "update tbl_comment_evaluate_staff set comment_teamleader='" + request.getParameter("taTeamLeader") + "',date_teamleader='" + displayTime1 + "', signature_teamleader='" + request.getParameter("txtTeamLeader") + "' where code_comment_evaluate_staff='" + displayTime + staffID + "'";
                mydb.executeNonQuery(updateComment);
                request.setAttribute("arrEvaluateKPIStaff", arrEvaluateKPIStaff);
                request.setAttribute("sumPoints", String.valueOf(sumPoints));
                request.setAttribute("staffID", staffID);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/index.jsp?page=sendmail");
                dispatcher.forward(request, response);
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
            Logger.getLogger(EvaluateTeamLeader.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(EvaluateTeamLeader.class.getName()).log(Level.SEVERE, null, ex);
        } catch (CloneNotSupportedException ex) {
            Logger.getLogger(EvaluateTeamLeader.class.getName()).log(Level.SEVERE, null, ex);
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

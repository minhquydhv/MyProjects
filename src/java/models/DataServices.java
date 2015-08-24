/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class DataServices {

    /*
     private final String jdbc = "com.mysql.jdbc.Driver";
     private final String urlDB = "jdbc:mysql://s155.eatj.com:3307/kpidb?autoReconnect=true";
     private final String userID = "kpidb";
     private final String password = "kpidb123@abc";
     */
    private final String jdbc = "com.mysql.jdbc.Driver";
    private final String urlDB = "jdbc:mysql://localhost/mykpidb";
    private final String userID = "root";
    private final String password = "";

    private Connection conn;

//    Hàm mở kết nối
    public void openDB() throws ClassNotFoundException, SQLException {
        try {
            if (conn == null || conn.isClosed()) {
                Class.forName(jdbc);
                this.conn = DriverManager.getConnection(urlDB, userID, password);
                System.out.print("ket noi thanh cong !");
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.print(e);
        }
    }

    public boolean checkUser(String username, String password) throws ClassNotFoundException, SQLException {
        openDB();
        boolean status = false;
        try {
            PreparedStatement ps = this.conn.prepareStatement("select * from tbl_staff where username=? and password=?");
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            status = rs.next();
        } catch (SQLException e) {
            System.out.print(e.toString());
            status = false;
        }
        return status;
    }

    public ArrayList quyen(String username) throws SQLException, ClassNotFoundException {
        openDB();
        ArrayList arr = new ArrayList();
        PreparedStatement ps = this.conn.prepareStatement("select roleID  from tbl_decentralization where staffID=?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            arr.add(rs.getString("roleID"));
        }
        return arr;
    }
//hàm thực thi câu lệnh truy vấn

    public ResultSet executeQuery(String sSql) throws ClassNotFoundException, SQLException {
        ResultSet rs = null;
        openDB();
        Statement smt = this.conn.createStatement();
        rs = smt.executeQuery(sSql);
        return rs;
    }
//hàm thực thêm sửa, xóa ,cập nhật

    public void executeNonQuery(String sSql) throws SQLException, ClassNotFoundException, CloneNotSupportedException {
        openDB();
        Statement smt = this.conn.createStatement();
        smt.executeUpdate(sSql);
        // closeDB();
    }
//hàm đóng kết nối

    public void closeDB() throws SQLException {
        if (conn != null && !conn.isClosed()) {
            conn.close();
        }
    }

}

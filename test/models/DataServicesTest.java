/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Admin
 */
public class DataServicesTest {
    
    public DataServicesTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of openDB method, of class DataServices.
     *
     * @throws java.lang.Exception
     */
    public void testOpenDB() throws Exception {
        System.out.println("openDB");
        DataServices instance = new DataServices();
        instance.openDB();
    }

    /**
     * Test of checkUser method, of class DataServices.
     *
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     */
    public void testCheckUser() throws ClassNotFoundException, SQLException {
        System.out.println("checkUser");
        String username = "";
        String password = "";
        DataServices instance = new DataServices();
        boolean expResult = false;
        boolean result = instance.checkUser(username, password);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of executeQuery method, of class DataServices.
     *
     * @throws java.lang.Exception
     */
    @Test
    public void testExecuteQuery() throws Exception {
        System.out.println("executeQuery");
        DataServices instance = new DataServices();
        String sSql = "select staffName from tbl_staff where staffID='VKX072092'";
        ResultSet result = instance.executeQuery(sSql);
        while (result.next()) {
            System.out.print(result.getString("staffName"));
        }
        
    }

    /**
     * Test of executeNonQuery method, of class DataServices.
     *
     * @throws java.lang.Exception
     */
    public void testExecuteNonQuery() throws Exception {
        System.out.println("executeNonQuery");
        String sSql = "select staffName from tbl_staff where staffID='VKX072092'";
        DataServices instance = new DataServices();
        instance.executeNonQuery(sSql);
    }

    /**
     * Test of closeDB method, of class DataServices.
     *
     * @throws java.lang.Exception
     */
    public void testCloseDB() throws Exception {
        System.out.println("closeDB");
        DataServices instance = new DataServices();
        instance.closeDB();
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of quyen method, of class DataServices.
     *
     * @throws java.lang.Exception
     */
    public void testQuyen() throws Exception {
        System.out.println("quyen");
        String username = "VKX072092";
        DataServices instance = new DataServices();
        ArrayList result = instance.quyen(username);
        for (int i = 0; i < result.size(); i++) {
            if (result.get(i).equals("05")) {
                System.out.print("đây là 05 \n");
            } else if (result.get(i).equals("04")) {
                System.out.print("đây là 04");
            }
        }
    }
    
}

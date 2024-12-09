/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dbmanager;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author ASUS
 */
public class ConnectionManager {

    private Connection conn = null;

    public Connection getDBConnection() {
        try {

            Class.forName("com.mysql.jdbc.Driver");

            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/schedulerDB", "root", "admin@123");

        } catch (ClassNotFoundException ex) {
            System.out.println("Driver class Not found Exceptions");
            System.exit(1);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return this.conn;
    }
}

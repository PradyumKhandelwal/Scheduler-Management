/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.schedulerOperations;

import com.dbmanager.ConnectionManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author pradyumkhandelwal
 */
public class schedulerOperations {

    public void test() {
        try {
            ConnectionManager db = new ConnectionManager();
            Connection conn = db.getDBConnection();
            PreparedStatement ps = conn.prepareStatement("select * from schedulermaster");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                System.out.println("Name:" + rs.getString("name"));
                System.out.println("Description:" + rs.getString("description"));
                System.out.println("Time:" + rs.getString("timeframe"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertSchInfo(String schname, String sType, String hr, String min, String sMonth, String sDay) {
        try {
            ConnectionManager db = new ConnectionManager();
            Connection conn = db.getDBConnection();
            PreparedStatement ps = conn.prepareStatement("INSERT into schedulermaster VALUES(0,?,?,?,'','1',now(),now())");
            ps.setString(1, schname);
            ps.setString(2, sType);
            ps.setString(3, hr + ":" + min);
            System.out.println("ps--:" + ps);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public JSONArray fetchData() {
        JSONArray resArr = new JSONArray();
        try {
            ConnectionManager db = new ConnectionManager();
            Connection conn = db.getDBConnection();
            PreparedStatement ps = conn.prepareStatement("select * from schedulermaster");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                JSONObject record = new JSONObject();
                record.put("ID", rs.getInt("id"));
                record.put("name", rs.getString("name"));
                record.put("description", rs.getString("description"));
                record.put("timeFrame", rs.getString("timeFrame"));
                record.put("action", rs.getString("schedulerRegex"));
                record.put("status", rs.getString("status"));
                record.put("rcre_time", rs.getString("rcre_time"));
                record.put("lchg_time", rs.getString("lchg_time"));
                resArr.add(record);

            }
            return resArr;

        } catch (SQLException e) {
            e.printStackTrace();
            return resArr;

        }
    }

    public String update(String id,String status) {
        String result = "Fail";
        
        try {
            ConnectionManager db = new ConnectionManager();
            Connection conn = db.getDBConnection();
            PreparedStatement ps = conn.prepareStatement("UPDATE  schedulermaster set status =?, lchg_time =now() where id =?");
            ps.setString(1, status);
            ps.setString(2, id);
            System.out.println("ps--:" + ps);
            int exc =ps.executeUpdate();
            if(exc>0)
            {
                result = "Success";
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;

    }
;

}

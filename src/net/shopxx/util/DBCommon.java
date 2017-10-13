/*
 * DBCommon.java
 *
 * Created on 2008��9��2��, ����1:23
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package net.shopxx.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
/**
 *
 * @author Administrator
 */
public class DBCommon {
    private Connection conn = null;
    private Statement stmt = null;
    private ResultSet rs = null;
    private static String driver = null;
    private static String url = null;
    private static String username = null;
    private static String password = null;

    static {
        driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        url = "jdbc:sqlserver://101.200.125.58;DatabaseName=truckdata2016a";
        username = "web";
        password = "fangliguo";
    }
  
    public Connection getConnection(){
        try{
            Class.forName(driver);
            conn = DriverManager.getConnection(url,username,password);
            return conn;
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
            return null;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }         
    }
    public String[][] select(String sql){
        String[][] data = null;
        conn = this.getConnection();
        try {
        
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
            rs = stmt.executeQuery(sql);
            rs.last();
            int x = rs.getRow();
            int y = rs.getMetaData().getColumnCount();
            data = new String[x][y];         
            rs.beforeFirst();
            int i = 0;
            while(rs.next()){
                for(int j=0;j<y;j++){             
                    data[i][j] = rs.getString(j+1);
                }
                i++;
            }
            return data;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        } finally{
            this.rsClose();
            this.stmtClose();
            this.connClose();
        }
    }
    public boolean doDml(String[] sqldata){
        try {
            conn = this.getConnection();
            conn.setAutoCommit(false);
            stmt = conn.createStatement();
            if(sqldata!=null){
                int sqllength = sqldata.length;
                for(int i=0;i<sqllength;i++){
                    stmt.executeUpdate(sqldata[i]);
                }
            }
            conn.commit();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            try {
                conn.rollback();
            } catch (SQLException ex1) {
                ex.printStackTrace();
            }
            return false;
        }finally{
           this.stmtClose();
           this.connClose();
        }
    }
    public boolean insert(String sql){
        try {
            conn = this.getConnection();
            stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }finally{
           this.stmtClose();
           this.connClose();     
        }
    }
    public boolean update(String sql){
        return this.insert(sql);      
    }
    public boolean delete(String sql){
        return this.insert(sql);    
    }  
    public void stmtClose(){
        try {
            if(stmt!=null){
                 stmt.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    public void connClose(){
        try {
            if(conn!=null){
                 conn.close();
            }       
        } catch (SQLException ex) {
            ex.printStackTrace();
        }       
    }
    public void rsClose(){
        try {
            if(rs!=null){
                 rs.close();
            }       
        } catch (SQLException ex) {
            ex.printStackTrace();
        }          
    }
}

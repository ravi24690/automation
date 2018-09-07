package com.partner;

import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBRetrieval {
	public static void main(String[] args) {
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn= DriverManager.getConnection("jdbc:oracle:thin:@10.151.14.55:1521:orcl","passport","passport");
			Statement st=conn.createStatement();
			ResultSet rs=st.executeQuery("select * from migration");
			PrintWriter psout = new PrintWriter(new FileWriter("./input/in.csv"));

			while(rs.next())
			{
				String s0 = rs.getString(1);
				String s1 = rs.getString(2);
				String s2 = rs.getString(3);
				String s3 = rs.getString(4);
				String s4 = rs.getString(5);
				String s5 = rs.getString(6);
				String s6 = rs.getString(7);
				String s7 = rs.getString(8);
				String s8 = rs.getString(9);
                                String s9 = rs.getString(10);
                                String s10 = rs.getString(11);
                                String s11 = rs.getString(12);
                                String s12 = rs.getString(13);
                                String s13 = rs.getString(14);
                                String s14 = rs.getString(15);
				psout.println(s0 + "," + s1 + "," + s2 + "," + s3 + "," + s4 + "," + s5 + "," + s6 + "," + s7 + "," + s8 + "," + s9 + "," + s10 + "," + s11 + "," + s12 + "," + s13 + "," + s14 + ",");
			}
			conn.close();
			psout.close();
		}
		catch(SQLException se)
		{
			se.printStackTrace();
		}
		catch(Exception e)
		{
			System.out.println("Unable to connect to database" +e);
		}
	}
}

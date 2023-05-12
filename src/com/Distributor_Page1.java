package com;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Distributor_Page1")
public class Distributor_Page1 extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


		try {

			Class.forName("oracle.jdbc.driver.OracleDriver");

		} catch (ClassNotFoundException e) {

			System.out.println("Where is your Oracle JDBC Driver?");
			e.printStackTrace();
			return;

		}

		Connection conn = null;

		try {

			int dist_id = 0;
			String dist_name = "";
			
			 conn = DriverManager.getConnection("jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu", "axb1312", "Ashmisrav1502");
			System.out.println("connection successful");
			
			PreparedStatement st = conn.prepareStatement("SELECT DIST_ID\r\n"
					+ "FROM FALL22_S001_12_DISTRIBUTOR_PROD_DETAILS \r\n"
					+ "WHERE PROD_ID = ? AND BRAND_NAME = ?");

			st.setString(1, request.getParameter("prod_type"));
			st.setString(2, request.getParameter("brand_name"));

			ResultSet rs = st.executeQuery();

			while (rs.next()) {

				dist_id = rs.getInt(1);
			

			}

			rs.close();
			st.close();
			conn.close();

			response.sendRedirect("Result.jsp?dist_id=" + dist_id);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}

package com.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/expense";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "Saurabh@19091";

    static {
        try {
            // Load MySQL JDBC driver class
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new IllegalStateException("Failed to load MySQL JDBC driver: " + e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uname = request.getParameter("username");
        String uemail = request.getParameter("email");
        String upass = request.getParameter("password");

        // Database connection
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
        	String sql = "INSERT INTO users (uname, uemail, upass, Creation_date) VALUES (?, ?, ?, ?)";
        	PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        	statement.setString(1, uname);
        	statement.setString(2, uemail);
        	statement.setString(3, upass);
        	statement.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
        	int rowsInserted = statement.executeUpdate();


            if (rowsInserted > 0) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body>");
                out.println("<h2>Registration Successful</h2>");
                out.println("<p>Username: " + uname + "</p>");
                out.println("<p>Email: " + uemail + "</p>");
                out.println("</body></html>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error storing user registration data");
        }
    }
}

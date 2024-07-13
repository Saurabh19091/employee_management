package com.Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/add")
public class AddTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/expense";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Saurabh@19091";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeName = request.getParameter("employee_name");
        String project = request.getParameter("project");
        String date = request.getParameter("date_1");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        String taskCategory = request.getParameter("task_category");
        String description = request.getParameter("description");

        HttpSession session = request.getSession();
        Integer uid = (Integer) session.getAttribute("uid");
        if (uid == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Calculate duration in hours
            double durationHours = calculateDurationHours(startTime, endTime);
            if (durationHours < 0) {
                request.setAttribute("errorMessage", "End time cannot be earlier than start time.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            // Insert query with duration in hours
            String sql = "INSERT INTO task_add (uid, employee_name, project, date_1, task_category, description, duration) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, uid);
            stmt.setString(2, employeeName);
            stmt.setString(3, project);
            stmt.setString(4, date);
            stmt.setString(5, taskCategory);
            stmt.setString(6, description);
            stmt.setDouble(7, durationHours); // Duration in hours

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect(request.getContextPath() + "/success.jsp");
            } else {
                request.setAttribute("errorMessage", "Failed to add task. Please try again.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "JDBC Driver not found");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private double calculateDurationHours(String startTime, String endTime) {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
            LocalTime start = LocalTime.parse(startTime, formatter);
            LocalTime end = LocalTime.parse(endTime, formatter);

            long durationMinutes = Duration.between(start, end).toMinutes();
            double durationHours = durationMinutes / 60.0;
            return durationHours >= 0 ? durationHours : -1; // Check for negative duration
        } catch (Exception e) {
            e.printStackTrace();
            return -1; // Handle the exception properly in your application
        }
    }
}

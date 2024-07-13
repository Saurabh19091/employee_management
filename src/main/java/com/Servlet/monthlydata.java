package com.Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/fetchok")
public class monthlydata extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("userId");
        if (userIdStr == null || userIdStr.isEmpty()) {
            response.sendRedirect("Users.jsp"); // Redirect if userId is not provided
            return;
        }

        int userId = Integer.parseInt(userIdStr);
        Map<String, Double> taskDurations = new HashMap<>();

        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/expense";
        String username = "root";
        String password = "Saurabh@19091";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            // Fetch task durations for the selected user
            String sql = "SELECT task_category, SUM(duration) AS total_duration " +
                         "FROM task_add " +
                         "WHERE uid = ? " +
                         "GROUP BY task_category";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                String taskCategory = rs.getString("task_category");
                long totalDuration = rs.getLong("total_duration");
                double totalDurationHours = totalDuration / 60.0; // Convert minutes to hours
                taskDurations.put(taskCategory, totalDurationHours);
            }

            // Close resources
            rs.close();
            stmt.close();
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Error in fetching task durations", e);
        } finally {
            // Close database connection
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Convert taskDurations map to JSON string
        String taskDurationsJson = new Gson().toJson(taskDurations);

        // Forward the data to chart.jsp
        request.setAttribute("userId", userId);
        request.setAttribute("taskDurationsJson", taskDurationsJson);
        request.getRequestDispatcher("monthly.jsp").forward(request, response);
    }
}

package com.Servlet;

import com.google.gson.Gson;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/fetchChartData")
public class FetchChartDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/expense";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Saurabh@19091";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer uid = Integer.parseInt(request.getParameter("uid"));

        List<Long> dailyDurations = fetchDailyDurations(uid);
        Map<String, Long> weeklyDurations = fetchWeeklyDurations(uid);
        Map<Integer, Long> monthlyDurations = fetchMonthlyDurations(uid);

        // Convert data to JSON strings
        String dailyTaskDurationsJson = new Gson().toJson(dailyDurations);
        String weeklyTaskDurationsJson = new Gson().toJson(weeklyDurations);
        String monthlyTaskDurationsJson = new Gson().toJson(monthlyDurations);

        // Set attributes to be accessed in JSP
        request.setAttribute("userId", uid);
        request.setAttribute("dailyTaskDurationsJson", dailyTaskDurationsJson);
        request.setAttribute("weeklyTaskDurationsJson", weeklyTaskDurationsJson);
        request.setAttribute("monthlyTaskDurationsJson", monthlyTaskDurationsJson);

        request.getRequestDispatcher("/chart.jsp").forward(request, response);
    }

    private List<Long> fetchDailyDurations(int uid) {
        List<Long> dailyDurations = new ArrayList<>();
        String sql = "SELECT duration FROM task_add WHERE uid = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, uid);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    long duration = rs.getLong("duration");
                    dailyDurations.add(duration);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dailyDurations;
    }

    private Map<String, Long> fetchWeeklyDurations(int uid) {
        Map<String, Long> weeklyDurations = new HashMap<>();
        String sql = "SELECT YEARWEEK(date_1) AS week, SUM(duration) AS total_duration " +
                     "FROM task_add " +
                     "WHERE uid = ? " +
                     "GROUP BY YEARWEEK(date_1)";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, uid);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String week = rs.getString("week");
                    long totalDuration = rs.getLong("total_duration");
                    weeklyDurations.put(week, totalDuration);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return weeklyDurations;
    }


    private Map<Integer, Long> fetchMonthlyDurations(int uid) {
        Map<Integer, Long> monthlyDurations = new HashMap<>();
        String sql = "SELECT MONTH(date_1) AS month, SUM(duration) AS total_duration " +
                     "FROM task_add " +
                     "WHERE uid = ? " +
                     "GROUP BY MONTH(date_1)";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, uid);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int month = rs.getInt("month");
                    long totalDuration = rs.getLong("total_duration");
                    monthlyDurations.put(month, totalDuration);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return monthlyDurations;
    }
}

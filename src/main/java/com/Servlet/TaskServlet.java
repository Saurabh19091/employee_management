package com.Servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/TaskServlet")
public class TaskServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // Get the logged-in user from session or request parameter
        String loggedInUser = request.getParameter("username");
        
        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/mydatabase";
        String user = "username";
        String password = "password";
        
        // Fetch tasks from database for the logged-in user
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, password);
            PreparedStatement ps = con.prepareStatement("SELECT task_id, task_name, task_description, CONCAT(task_date, ' ', task_time) AS task_date_time FROM tasks WHERE username=?");
            ps.setString(1, loggedInUser);
            ResultSet rs = ps.executeQuery();
            
            out.println("<html><body>");
            out.println("<h2>Tasks for " + loggedInUser + "</h2>");
            out.println("<table border='1'>");
            out.println("<tr><th>Task ID</th><th>Task Name</th><th>Description</th><th>Date & Time</th><th>Edit</th><th>Delete</th></tr>");
            while (rs.next()) {
                int taskId = rs.getInt("task_id");
                String taskName = rs.getString("task_name");
                String taskDescription = rs.getString("task_description");
                String taskDateTime = rs.getString("task_date_time");
                
                out.println("<tr>");
                out.println("<td>" + taskId + "</td>");
                out.println("<td>" + taskName + "</td>");
                out.println("<td>" + taskDescription + "</td>");
                out.println("<td>" + taskDateTime + "</td>");
                out.println("<td><form action='EditTask' method='get'><input type='hidden' name='id' value='" + taskId + "'><input type='submit' value='Edit'></form></td>");
                out.println("<td><form action='DeleteTask' method='post'><input type='hidden' name='id' value='" + taskId + "'><input type='submit' value='Delete'></form></td>");
                out.println("</tr>");
            }
            out.println("</table>");
            out.println("</body></html>");
            
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}

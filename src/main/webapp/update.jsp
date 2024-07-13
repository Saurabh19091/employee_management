<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
// Get task ID from request parameter
String taskId = request.getParameter("task_id");

// Database connection parameters
String url = "jdbc:mysql://localhost:3306/expense";
String username = "root";
String password = "Saurabh@19091";

Connection conn = null;
PreparedStatement stmt = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url, username, password);

    // Retrieve task details based on task ID
    String sql = "SELECT * FROM add_task WHERE task_id=?";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, taskId);
    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
        // Task details
        String employeeName = rs.getString("employee_name");
        String project = rs.getString("project");
        String date = rs.getString("date_1");
        String startTime = rs.getString("start_time");
        String endTime = rs.getString("end_time");
        String taskCategory = rs.getString("task_category");
        String description = rs.getString("description");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Task</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="text-center">Update Task</h2>
        <form action="" method="post">
            <div class="form-group">
                <label for="employeeName">Employee Name:</label>
                <input type="text" class="form-control" id="employeeName" name="employee_name" value="<%= employeeName %>">
            </div>
            <div class="form-group">
                <label for="project">Project:</label>
                <input type="text" class="form-control" id="project" name="project" value="<%= project %>">
            </div>
            <div class="form-group">
                <label for="date">Date:</label>
                <input type="text" class="form-control" id="date" name="date_1" value="<%= date %>">
            </div>
            <!-- Include other fields here -->
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
    </div>
</body>
</html>

<%
    } else {
        out.println("Task not found!");
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

// Process the form submission
if (request.getMethod().equals("POST")) {
    String employeeName = request.getParameter("employee_name");
    String project = request.getParameter("project");
    String date = request.getParameter("date_1");
    // Retrieve other form parameters

    try {
        conn = DriverManager.getConnection(url, username, password);

        // Update SQL query
        String updateSql = "UPDATE add_task SET employee_name=?, project=?, date_1=? WHERE task_id=?";
        PreparedStatement updateStmt = conn.prepareStatement(updateSql);
        updateStmt.setString(1, employeeName);
        updateStmt.setString(2, project);
        updateStmt.setString(3, date);
        // Set other parameters
        updateStmt.setString(4, taskId);

        // Execute the update query
        int rowsAffected = updateStmt.executeUpdate();

        // Redirect to a confirmation page or display a message
        if (rowsAffected > 0) {
            out.println("<p>Task updated successfully!</p>");
        } else {
            out.println("<p>Failed to update task.</p>");
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
%>

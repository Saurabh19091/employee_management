<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.Servlet.User" %> <!-- Import User class from appropriate package -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="text-center">Users</h2>
        <table class="table table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>User ID</th>
                    <th>Username</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<User> users = new ArrayList<>(); // Ensure User class is correctly imported
                    String url = "jdbc:mysql://localhost:3306/expense";
                    String username = "root";
                    String password = "Saurabh@19091";
                    
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection(url, username, password);
                        String sql = "SELECT uid, uname FROM users";
                        PreparedStatement statement = connection.prepareStatement(sql);
                        ResultSet resultSet = statement.executeQuery();

                        while (resultSet.next()) {
                            User user = new User();
                            user.setId(resultSet.getInt("uid"));
                            user.setName(resultSet.getString("uname"));
                            users.add(user);
                        }
                        resultSet.close();
                        statement.close();
                        connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    if (users != null && !users.isEmpty()) {
                        for (User user : users) {
                %>
                <tr>
                    <td><%= user.getId() %></td>
                    <td><%= user.getName() %></td>
                    <td>
                        <form action="fetchUserTaskDurations" method="get" style="display:inline;">
                            <input type="hidden" name="userId" value="<%= user.getId() %>">
                            <button type="submit" class="btn btn-primary">Daily</button>
                        </form>
                        <form action="fetchUserTaskDurations" method="get" style="display:inline;">
                            <input type="hidden" name="userId" value="<%= user.getId() %>">
                            <button type="submit" class="btn btn-success">Weekly</button>
                        </form>
                        <form action="fetchok" method="get" style="display:inline;">
                            <input type="hidden" name="userId" value="<%= user.getId() %>">
                            <button type="submit" class="btn btn-info">Monthly</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="3">No users found</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>

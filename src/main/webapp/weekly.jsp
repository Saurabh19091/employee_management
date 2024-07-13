<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Monthly Task Durations</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="container">
        <h2 class="text-center">Monthly Task Durations</h2>
        <div class="row">
            <div class="col-md-6">
                <h4 class="text-center">(Monthly Data) Bar Chart</h4>
                <canvas id="monthlyBarChart" width="400" height="400"></canvas>
            </div>
        </div>
    </div>

    <script>
        // Retrieve data from request attributes set by servlet
        var userId = <%= request.getAttribute("userId") %>;
        var monthlyTaskDurationsJson = '<%= request.getAttribute("monthlyTaskDurationsJson") %>';

        // Parse JSON data
        var monthlyTaskDurations = JSON.parse(monthlyTaskDurationsJson);

        // Prepare data for monthly bar chart
        var monthlyLabels = Object.keys(monthlyTaskDurations);
        var monthlyData = Object.values(monthlyTaskDurations);

        // Draw Monthly Bar Chart
        var monthlyBarCtx = document.getElementById('monthlyBarChart').getContext('2d');
        var monthlyBarChart = new Chart(monthlyBarCtx, {
            type: 'bar',
            data: {
                labels: monthlyLabels,
                datasets: [{
                    label: 'Monthly Task Durations (Hours)',
                    data: monthlyData,
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: 'Monthly Task Durations for User ' + userId + ' (Hours)'
                    }
                }
            }
        });
    </script>
</body>
</html>

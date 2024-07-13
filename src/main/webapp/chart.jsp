<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Durations Chart</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="container">
        <h2 class="text-center">Task Durations Chart</h2>
        <div class="row">
        
        <div class="col-md-6">
                <h4 class="text-center">(Daily Data)Pie Chart</h4>
                <canvas id="pieChart" width="400" height="400"></canvas>
            </div>
                         <div class="col-md-6">
                <h4 class="text-center">(Weekly Data) Bar Chart</h4>
                <canvas id="barChart" width="400" height="400"></canvas>
            </div>
            
           
        </div>
    </div>

    <script>
        // Retrieve data from request attributes set by servlet
        var userId = <%= request.getAttribute("userId") %>;
        var taskDurationsJson = '<%= request.getAttribute("taskDurationsJson") %>';
        var taskDurations = JSON.parse(taskDurationsJson);

        // Prepare data for charts
        var labels = Object.keys(taskDurations);
        var data = Object.values(taskDurations);
        
        var barCtx = document.getElementById('barChart').getContext('2d');
        var barChart = new Chart(barCtx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Task Durations (Hours)',
                    data: data,
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
                        text: 'Task Durations for User ' + userId + ' (Hours)'
                    }
                }
            }
        });
       


        // Draw Pie Chart
        var pieCtx = document.getElementById('pieChart').getContext('2d');
        var pieChart = new Chart(pieCtx, {
            type: 'pie',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Task Durations (Hours)',
                    data: data,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                    ],
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
                        text: 'Task Durations for User ' + userId + ' (Hours)'
                    }
                }
            }
        });
     // Draw Weekly Bar Chart
       

        // Draw Bar Chart
    </script>
    <script>
    // Retrieve data from request attributes set by servlet
    var userId = <%= request.getAttribute("userId") %>;
    var weeklyTaskDurationsJson = '<%= request.getAttribute("weeklyTaskDurationsJson") %>';

    // Parse JSON data
    var weeklyTaskDurations = JSON.parse(weeklyTaskDurationsJson);

    // Prepare data for weekly bar chart
    var weeklyLabels = Object.keys(weeklyTaskDurations);
    var weeklyData = Object.values(weeklyTaskDurations);

    // Draw Weekly Bar Chart
    var weeklyBarCtx = document.getElementById('barChart').getContext('2d');
    var weeklyBarChart = new Chart(weeklyBarCtx, {
        type: 'bar',
        data: {
            labels: weeklyLabels,
            datasets: [{
                label: 'Weekly Task Durations (Hours)',
                data: weeklyData,
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
                    text: 'Weekly Task Durations for User ' + userId + ' (Hours)'
                }
            }
        }
    });
</script>
</body>
</html>

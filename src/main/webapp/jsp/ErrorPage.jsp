<%--
  Created by IntelliJ IDEA.
  User: Alond
  Date: 4/12/2024
  Time: 7:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error Page</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .error-container {
            margin-top: 50px;
            text-align: center;
        }
        .error-heading {
            font-size: 4rem;
            font-weight: bold;
            color: #dc3545;
        }
        .error-message {
            font-size: 1.5rem;
            margin-top: 20px;
            color: #6c757d;
        }
        .back-button {
            margin-top: 30px;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row error-container">
            <div class="col">
                <h1 class="error-heading">Error</h1>
                <p class="error-message">An unexpected error occurred.</p>
                <a href="/list" class="btn btn-primary back-button">Back to Home</a>
            </div>
        </div>
    </div>

</body>
</html>

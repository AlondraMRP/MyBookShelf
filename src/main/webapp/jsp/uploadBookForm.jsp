<%--
  Created by IntelliJ IDEA.
  User: Alond
  Date: 4/15/2024
  Time: 12:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upload Excel File</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<header>
    <nav class="navbar navbar-expand-md navbar-dark" style="background-color: rebeccapurple">
        <div>
            <a href="/list" class="navbar-brand"> My Bookshelf Management </a>
        </div>
        <ul class="navbar-nav">
            <li><a href="<%=request.getContextPath()%>/list" class="nav-link"> List of Books</a></li>
        </ul>
        <div class="dropdown">
            <button class="dropbtn btn" type="button" data-toggle="dropdown" style="color: #f8f9fa">
                Records
                <i class="fa fa-caret-down"></i>
            </button>
            <div class="dropdown-menu dropdown-content">
                <a class="dropdown-item" href="${pageContext.request.contextPath}/record">Overall</a>
                <a class="dropdown-item" href="${pageContext.request.contextPath}/yearly">Yearly</a>
                <a class="dropdown-item" href="${pageContext.request.contextPath}/monthly">Monthly</a>
            </div>
        </div>
    </nav>
</header>
<br>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h2 class="card-title text-center mb-4">Upload Excel File</h2>
                    <form id="upload-form" action="upload" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="file">Select Excel File:</label>
                            <input type="file" class="form-control-file" name="file" id="file">
                        </div>
                        <button type="submit" class="btn btn-success" value="upload" >Upload</button>
                    </form>
                    <div class="progress mt-3" style="display: none;">
                        <div id="progressBar" class="progress-bar" role="progressbar" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">0%</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

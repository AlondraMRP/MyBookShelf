<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>My Bookshelf</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style>

    .dataTables_wrapper #myTable_filter {
        text-align: right;
    }

    .dataTables_wrapper #myTable_filter label {
        margin-right: 10px;
        font-size: 18px;
        font-weight: bold;
    }

    .dataTables_wrapper #myTable_filter input[type="search"] {
        padding: 5px;
        border-radius: 4px;
        border: 1px solid #ced4da;
    }

    .dataTables_wrapper #myTable_length {
        text-align: left;
        display: flex;
        align-items: center;
    }

    .dataTables_wrapper #myTable_length label {
        margin-right: 10px;

    }

    .dataTables_wrapper #myTable_length select {
        padding: 5px;
        border-radius: 4px;
        border: 1px solid #ced4da;
    }

    .dataTables_wrapper .sorting::after,
    .dataTables_wrapper .sorting_asc::after,
    .dataTables_wrapper .sorting_desc::after {
        content: "";
        display: inline-block;
        vertical-align: middle;
        margin-left: 5px;
        color: #888;
    }

    .dataTables_wrapper .sorting::after {
        content: " \25B4";
    }

    .dataTables_wrapper .sorting_asc::after {
        content: " \25B2";
        color: green;
    }

    .dataTables_wrapper .sorting_desc::after {
        content: " \25BE";
        color: red;
    }

    #myTable_paginate {
        text-align: right;
    }

    .dataTables_paginate a.paginate_button {
        padding: 6px 12px;
        margin: 0 3px;
        color: darkgreen;
        border: 1px solid darkgreen;
        border-radius: 4px;
        text-decoration: none;
    }

    .dataTables_paginate a.paginate_button.current {
        background-color: #28a745;
        color: #fff;
    }

    .dataTables_paginate a.paginate_button.disabled {
        pointer-events: none;
        color: #6c757d;
        border-color: #6c757d;
    }

    .dataTables_paginate a.paginate_button:hover {
        background-color: darkgreen;
        border-color: darkgreen;
        color: #fff;
    }
    .dropbtn {
        color: white;
    }

</style>


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
            <button class="dropbtn btn" type="button" data-toggle="dropdown">
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

<div class="row">
    <div class="container">
        <h2 class="card-title text-center mb-4">My books</h2>
        <hr>
       <div class="container text-left">
           <a href="<%=request.getContextPath()%>/new" class="btn btn-success">Add
               New Book</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <a href="<%=request.getContextPath()%>/upload" class="btn btn-success">Upload New Book</a>
       </div>
        <br>
        <table id="myTable" class="table table-bordered">
            <thead>
            <tr>
                <th>No.</th>
                <th>Title</th>
                <th>Publication Year</th>
                <th>Rating</th>
                <th>Author</th>
                <th>Author Nationality</th>
                <th>Genre</th>
                <th>Date Finished</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:set var="count" value="0" scope="page"/>
            <c:forEach var="book" items="${requestScope.listBook}">
                <c:set var="count" value="${count + 1}" scope="page"/>
                <tr>
                    <td>
                        <c:out value="${count}"/>
                    </td>
                    <td>
                        <c:out value="${book.title}"/>
                    </td>
                    <td>
                      <c:out value="${book.publication_year}"/>
                    </td>
                    <td>
                        <c:out value="${book.rating}"/>
                    </td>
                    <td>
                        <c:out value="${book.getAuthor().getAuthor_name()}" />
                    </td>
                    <td>
                        <c:out value="${book.getAuthor().getAuthor_nationality()}" />
                    </td>
                    <td>
                        <c:out value="${book.getGenre().getGenre_name ()}" />
                    </td>
                    <td>
                        <c:set var="formattedDate" value="${fn:substring(book.dateFinished, 8, 10)}-${fn:substring(book.dateFinished, 5, 7)}-${fn:substring(book.dateFinished, 0, 4)}" />
                        <c:out value="${formattedDate}" />

                    </td>
                    <td>
                       $ <c:out value="${book.price}" />
                    </td>
                    <td><a href="${pageContext.request.contextPath}/edit?id=${book.book_id}">Edit</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="${pageContext.request.contextPath}/delete?id=${book.book_id}">Delete</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
<script>
    $(document).ready(function(){
        $('#myTable').dataTable();
    });
</script>
</html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://jakarta.apache.org/taglibs/standard/permittedTaglibs" %>
<%--
  Created by IntelliJ IDEA.
  User: Alond
  Date: 4/20/2024
  Time: 5:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Bookshelf Records</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.anychart.com/releases/8.0.0/js/anychart-base.min.js"></script>
    <script src="https://cdn.anychart.com/themes/2.0.0/light_provence.min.js"></script>
    <script src="https://cdn.anychart.com/themes/2.0.0/sea.min.js"></script>
    <script src="https://cdn.anychart.com/releases/8.0.0/js/anychart-bundle.min.js"></script>
    <script src="https://cdn.anychart.com/releases/8.0.0/js/anychart-core.min.js"></script>
    <style>
        .dropbtn {
            color: white;
        }
        :root {
            --red: hsl(0, 78%, 62%);
            --cyan: hsl(180, 62%, 55%);
            --orange: hsl(34, 97%, 64%);
            --blue: hsl(212, 86%, 64%);
            --varyDarkBlue: hsl(234, 12%, 34%);
            --grayishBlue: hsl(229, 6%, 66%);
            --veryLightGray: hsl(0, 0%, 98%);
            --weight1: 200;
            --weight2: 400;
            --weight3: 600;
        }
        .box p {
            color: var(--varyDarkBlue);
            font-size: 35px;
        }
        .box {
            border-radius: 5px;
            box-shadow: 0px 30px 40px -20px var(--grayishBlue);
            padding: 30px;
            margin: 20px;
        }



        @media (max-width: 950px) and (min-width: 450px) {
            .box {
                text-align: center;
                height: 180px;
            }
        }

        .cyan {
            border-top: 3px solid var(--cyan);
        }

        .orange {
            border-top: 3px solid var(--orange);
        }
        .red {
            border-top: 3px solid var(--red);
        }
        .blue {
            border-top: 3px solid var(--blue);
        }
        @media (min-width: 950px) {
            .row1-container {
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .box {
                width: 20%;
                font-size: 1rem;

            }
            .header p {
                width: 30%;
            }

            .row1-container .box {
                display: flex;
                flex-direction: column;
                height: 250px;
            }

            .box ol li {
                font-size: 0.9em;
                margin: 0 -20px;
            }
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
<div class="container">
    <div class="row">
        <div class="col-sm-12">
            <br>
            <div class="container text-left">
                <button class="btn btn-success" onclick="window.print()">Print Record</button>
            </div>
            <br>
            <h2 class="card-title text-center mb-4">My Bookshelf Overall</h2>
            <hr>
        </div>
    </div>
    <div class="row1-container">

            <div class="box box-down cyan">
                <h4>Total of Books Read</h4>
                <p><c:out value="${requestScope.booksReadOverall}"/></p>
            </div>
            <div class="box orange">
                <h4>Average of Books Rating</h4>
                <p><c:out value="${requestScope.avgRatingOverall}"/></p>
            </div>
        <div class="box box-down blue">
            <h4>Best Rated Books</h4>
            <ol>
                <c:forEach var="book" items="${requestScope.topRatingBooks}">
                    <li>
                        <c:out value="${book.key}" />: <c:out value="${book.value}" /> stars
                    </li>
                </c:forEach>
            </ol>
        </div>
        <div class="box red">
            <h4>Most Read Authors</h4>
                <ol>
                <c:forEach var="author" items="${requestScope.mostReadAuthors}">
                        <li>
                        <c:out value="${author.key}" />: <c:out value="${author.value}" /> books
                        </li>
                </c:forEach>
                </ol>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
                <h4>Most Read Genres</h4>
                <div id="container" style="height: 450px;" ></div>
                <script>


                    function createChart(data) {
                        anychart.theme('lightProvence');
                        let chart = anychart.column();
                        chart.data(data);
                        let xAxis = chart.xAxis();
                        xAxis.title("Genre");
                        let yAxis = chart.yAxis();
                        yAxis.title("# of Books");
                        chart.labels(true);
                        chart.container('container');
                        chart.draw();
                    }
                    let chartData = {
                        header: ["Genre", "# of books"],
                        rows:[]
                    };
                    <c:forEach var="genre" items="${requestScope.mostReadGenre}">
                    chartData.rows.push(["${genre.key}", ${genre.value}]);
                    </c:forEach>
                    createChart(chartData);
                </script>
        </div>
    </div>
        <div class="row" >
            <div class="col-sm-12">
                    <h4>Books Read Per Year</h4>
                    <div id="containerYear" style="height: 500px;" ></div>
                    <script>

                        function createChartYear(data) {
                            anychart.theme('sea');
                            let chart = anychart.column();
                            chart.data(data);
                            let xAxis = chart.xAxis();
                            xAxis.title("Year");
                            let yAxis = chart.yAxis();
                            yAxis.title("# of Books");
                            chart.labels(true);
                            chart.container('containerYear');
                            chart.draw();
                        }
                        let chartDataYear = {
                            header: ["Year", "# of books"],
                            rows:[]
                        };
                        <c:forEach var="year" items="${requestScope.booksReadPerYear}">
                        chartDataYear.rows.push(["${year.key}", ${year.value}]);
                        </c:forEach>
                        createChartYear(chartDataYear);
                    </script>
            </div>
        </div>
    </div>

</body>
</html>


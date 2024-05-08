<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../css/styles.css">
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

                margin: 0 -29px;
                word-wrap: break-word;
                font-size: 0.9em;
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
            <h2 class="card-title text-center mb-4">My Bookshelf Monthly</h2>
            <hr>
            <div class="well">
                <form method="post" action="${pageContext.request.contextPath}/monthly">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="selectedMonth">Select Month: </label>
                            <select class="form-control" name="selectedMonth" id="selectedMonth">
                                <option value=" ">Month</option>
                                <option value="1">January</option>
                                <option value="2">February</option>
                                <option value="3">March</option>
                                <option value="4">April</option>
                                <option value="5">May</option>
                                <option value="6">June</option>
                                <option value="7">July</option>
                                <option value="8">August</option>
                                <option value="9">September</option>
                                <option value="10">October</option>
                                <option value="11">November</option>
                                <option value="12">December</option>
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="selectedYear">Select Year: </label>
                            <select class="form-control" name="selectedYear" id="selectedYear">
                                <option value=" ">Year</option>
                                <option value="2015">2015</option>
                                <option value="2016">2016</option>
                                <option value="2017">2017</option>
                                <option value="2018">2018</option>
                                <option value="2019">2019</option>
                                <option value="2020">2020</option>
                                <option value="2021">2021</option>
                                <option value="2022">2022</option>
                                <option value="2023">2023</option>
                                <option value="2024">2024</option>
                            </select>
                        </div>
                    </div>
                    <input type="submit" class="btn btn-success" value="Submit">
                </form>
            </div>
            <c:if test="${requestScope.booksReadMonthly != null}">

                <div class="row1-container">

                        <div class="box box-down cyan">
                            <h4>Total of Books Read in ${requestScope.monthName} ${requestScope.selectedYear}</h4>
                            <p><c:out value="${requestScope.booksReadMonthly}"/></p>
                        </div>


                        <div class="box orange">
                            <h4>Average of Books Rating in ${requestScope.monthName} ${requestScope.selectedYear}</h4>
                            <p><c:out value="${requestScope.avgRatingMonthly}"/></p>
                        </div>

                    <div class="box box-down blue">
                        <h5>Best Rated Books in ${requestScope.monthName} ${requestScope.selectedYear}</h5>
                        <ol>
                            <c:forEach var="book" items="${requestScope.topRatingMonthly}">
                                <li style="font-size: 13px">
                                    <c:out value="${book.key}" />: <c:out value="${book.value}" /> stars
                                </li>
                            </c:forEach>
                        </ol>
                    </div>
                    <div class="box red">
                        <h5>Most Read Authors in ${requestScope.monthName} ${requestScope.selectedYear} </h5>
                        <ol>
                            <c:forEach var="author" items="${requestScope.topAuthorsMonthly}">
                                <li>
                                    <c:out value="${author.key}" />: <c:out value="${author.value}" /> books
                                </li>
                            </c:forEach>
                        </ol>
                    </div>
                </div>
            <div class="row">
                <div class="col-sm-12">
                    <h4>Most Read Genres in ${requestScope.monthName} ${requestScope.selectedYear}</h4>
                    <div id="containerGenre" style="height: 450px;" ></div>
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
                            chart.container('containerGenre');
                            chart.draw();
                        }
                        let chartData = {
                            header: ["Genre", "# of books"],
                            rows:[]
                        };
                        <c:forEach var="genre" items="${requestScope.mostReadGenreMonthly}">
                        chartData.rows.push(["${genre.key}", ${genre.value}]);
                        </c:forEach>
                        createChart(chartData);
                    </script>
                </div>
            </div>
            <div class="row" >
                <div class="col-sm-12">
                    <h4>Books Read Per Day in ${requestScope.monthName} ${requestScope.selectedYear} </h4>
                    <div id="containerPerDay" style="height: 500px;" ></div>
                    <script>

                        function createChartYear(data) {
                            anychart.theme('sea');
                            let chart = anychart.line();
                            chart.data(data);
                            let xAxis = chart.xAxis();
                            xAxis.title("Day");
                            let yAxis = chart.yAxis();
                            yAxis.title("# of Books");
                            chart.container('containerPerDay');
                            chart.draw();
                        }
                        let chartDataYear = {
                            header: ["Day", "# of books"],
                            rows:[]
                        };
                        <c:forEach var="day" items="${requestScope.booksPerDay}">
                        chartDataYear.rows.push(["${day.key}", ${day.value}]);
                        </c:forEach>
                        createChartYear(chartDataYear);
                    </script>
                </div>
            </div>
        </div>
            </c:if>
        </div>
    </div>

</body>
</html>

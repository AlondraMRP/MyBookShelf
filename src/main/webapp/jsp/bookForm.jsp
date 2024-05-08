<%--
  Created by IntelliJ IDEA.
  User: Alond
  Date: 4/12/2024
  Time: 6:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>My Bookshelf</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
<div class="container col-md-5">
    <div class="card">
        <div class="card-body">
            <c:if test="${requestScope.book != null}">
                <form action="<%=request.getContextPath()%>update" method="post">
            </c:if>
            <c:if test="${requestScope.book == null}">
                <form action="<%=request.getContextPath()%>insert" method="post">
                </c:if>

            <caption>
              <h2>
                  <c:if test="${book != null}">
                      Edit Book
                  </c:if>
                  <c:if test="${book == null}">
                      Add New Book
                  </c:if>
              </h2>
            </caption>

            <c:if test="${book != null}">
               <input type="hidden" name="book_id" value="<c:out value='${book.book_id}' />" />
            </c:if>

            <fieldset class="form-group">
                 <label>Title</label> <span style="color: red !important; display: inline; float: none;">*</span> <input type="text" value="<c:out value='${book.title}' />"
                                             class="form-control" name="title" required="required" maxlength="150" minlength="2">
            </fieldset>

            <fieldset class="form-group">
                <label for="date-dropdown">Publication Year</label> <span style="color: red !important; display: inline; float: none;">*</span>
                <select class="form-control" id="date-dropdown" name="publication_year">
                    <option value="">Year</option>
                    <c:forEach var="year" begin="970" end="2024">
                        <option value="${year}"
                                <c:if test="${year == book.publication_year}">  selected
                                </c:if>>
                                ${year}
                        </option>
                    </c:forEach>
                </select>
                <script>
                    let dropdown = document.getElementById('date-dropdown');
                    let options = Array.from(dropdown.options);
                    options.reverse();
                    for (let option of options) {
                        dropdown.appendChild(option);
                    }
                </script>

            </fieldset>

            <fieldset class="form-group">
                        <label>Rating</label> <span style="color: red !important; display: inline; float: none;">*</span> <input type="number" name="rating" min="1" max="5" step="0.01"
                                                     placeholder="Enter rating (1.00-5)" value="<c:out value='${book.rating}'/>"
                                                     class="form-control" required="required">
            </fieldset>
            <fieldset class="form-group">
                        <label>Author</label> <span style="color: red !important; display: inline; float: none;">*</span> <input type="text" value="<c:out value='${book.author.author_name}' />" class="form-control"
                                                     name="author_name" required="required" maxlength="70" minlength="2" onkeydown="return /[a-zA-Z\s\-]/.test(event.key)">
            </fieldset>

            <fieldset class="form-group">
                        <label for="country">Author Nationality</label> <span style="color: red !important; display: inline; float: none;">*</span>
                        <select id="country" name="author_nationality" class="form-control" value="<c:out value='${book.author.author_nationality}' />">

                            <option value="">Select Nationality</option>
                            <option value="Afghanistan" ${book.author.author_nationality == 'Afghanistan' ? 'selected' : ''}>Afghanistan</option>
                            <option value="Åland Islands" ${book.author.author_nationality == 'Åland Islands' ? 'selected' : ''}>Åland Islands</option>
                            <option value="Albania" ${book.author.author_nationality == 'Albania' ? 'selected' : ''}>Albania</option>
                            <option value="Algeria" ${book.author.author_nationality == 'Algeria' ? 'selected' : ''}>Algeria</option>
                            <option value="American Samoa" ${book.author.author_nationality == 'American Samoa' ? 'selected' : ''}>American Samoa</option>
                            <option value="Andorra" ${book.author.author_nationality == 'Andorra' ? 'selected' : ''}>Andorra</option>
                            <option value="Angola" ${book.author.author_nationality == 'Angola' ? 'selected' : ''}>Angola</option>
                            <option value="Anguilla" ${book.author.author_nationality == 'Anguilla' ? 'selected' : ''}>Anguilla</option>
                            <option value="Antarctica" ${book.author.author_nationality == 'Antarctica' ? 'selected' : ''}>Antarctica</option>
                            <option value="Antigua and Barbuda" ${book.author.author_nationality == 'Antigua and Barbuda' ? 'selected' : ''}>Antigua and Barbuda</option>
                            <option value="Argentina" ${book.author.author_nationality == 'Argentina' ? 'selected' : ''}>Argentina</option>
                            <option value="Armenia" ${book.author.author_nationality == 'Armenia' ? 'selected' : ''}>Armenia</option>
                            <option value="Aruba" ${book.author.author_nationality == 'Aruba' ? 'selected' : ''}>Aruba</option>
                            <option value="Australia" ${book.author.author_nationality == 'Australia' ? 'selected' : ''}>Australia</option>
                            <option value="Austria" ${book.author.author_nationality == 'Austria' ? 'selected' : ''}>Austria</option>
                            <option value="Azerbaijan" ${book.author.author_nationality == 'Azerbaijan' ? 'selected' : ''}>Azerbaijan</option>
                            <option value="Bahamas" ${book.author.author_nationality == 'Bahamas' ? 'selected' : ''}>Bahamas</option>
                            <option value="Bahrain" ${book.author.author_nationality == 'Bahrain' ? 'selected' : ''}>Bahrain</option>
                            <option value="Bangladesh" ${book.author.author_nationality == 'Bangladesh' ? 'selected' : ''}>Bangladesh</option>
                            <option value="Barbados" ${book.author.author_nationality == 'Barbados' ? 'selected' : ''}>Barbados</option>
                            <option value="Belarus" ${book.author.author_nationality == 'Belarus' ? 'selected' : ''}>Belarus</option>
                            <option value="Belgium" ${book.author.author_nationality == 'Belgium' ? 'selected' : ''}>Belgium</option>
                            <option value="Belize" ${book.author.author_nationality == 'Belize' ? 'selected' : ''}>Belize</option>
                            <option value="Benin" ${book.author.author_nationality == 'Benin' ? 'selected' : ''}>Benin</option>
                            <option value="Bermuda" ${book.author.author_nationality == 'Bermuda' ? 'selected' : ''}>Bermuda</option>
                            <option value="Bhutan" ${book.author.author_nationality == 'Bhutan' ? 'selected' : ''}>Bhutan</option>
                            <option value="Bolivia" ${book.author.author_nationality == 'Bolivia' ? 'selected' : ''}>Bolivia</option>
                            <option value="Bosnia and Herzegovina" ${book.author.author_nationality == 'Bosnia and Herzegovina' ? 'selected' : ''}>Bosnia and Herzegovina</option>
                            <option value="Botswana" ${book.author.author_nationality == 'Botswana' ? 'selected' : ''}>Botswana</option>
                            <option value="Bouvet Island" ${book.author.author_nationality == 'Bouvet Island' ? 'selected' : ''}>Bouvet Island</option>
                            <option value="Brazil" ${book.author.author_nationality == 'Brazil' ? 'selected' : ''}>Brazil</option>
                            <option value="British Indian Ocean Territory" ${book.author.author_nationality == 'British Indian Ocean Territory' ? 'selected' : ''}>British Indian Ocean Territory</option>
                            <option value="Brunei Darussalam" ${book.author.author_nationality == 'Brunei Darussalam' ? 'selected' : ''}>Brunei Darussalam</option>
                            <option value="Bulgaria" ${book.author.author_nationality == 'Bulgaria' ? 'selected' : ''}>Bulgaria</option>
                            <option value="Burkina Faso" ${book.author.author_nationality == 'Burkina Faso' ? 'selected' : ''}>Burkina Faso</option>
                            <option value="Burundi" ${book.author.author_nationality == 'Burundi' ? 'selected' : ''}>Burundi</option>
                            <option value="Cambodia" ${book.author.author_nationality == 'Cambodia' ? 'selected' : ''}>Cambodia</option>
                            <option value="Cameroon" ${book.author.author_nationality == 'Cameroon' ? 'selected' : ''}>Cameroon</option>
                            <option value="Canada" ${book.author.author_nationality == 'Canada' ? 'selected' : ''}>Canada</option>
                            <option value="Cape Verde" ${book.author.author_nationality == 'Cape Verde' ? 'selected' : ''}>Cape Verde</option>
                            <option value="Cayman Islands" ${book.author.author_nationality == 'Cayman Islands' ? 'selected' : ''}>Cayman Islands</option>
                            <option value="Central African Republic" ${book.author.author_nationality == 'Central African Republic' ? 'selected' : ''}>Central African Republic</option>
                            <option value="Chad" ${book.author.author_nationality == 'Chad' ? 'selected' : ''}>Chad</option>
                            <option value="Chile" ${book.author.author_nationality == 'Chile' ? 'selected' : ''}>Chile</option>
                            <option value="China" ${book.author.author_nationality == 'China' ? 'selected' : ''}>China</option>
                            <option value="Christmas Island" ${book.author.author_nationality == 'Christmas Island' ? 'selected' : ''}>Christmas Island</option>
                            <option value="Cocos (Keeling) Islands" ${book.author.author_nationality == 'Cocos (Keeling) Islands' ? 'selected' : ''}>Cocos (Keeling) Islands</option>
                            <option value="Colombia" ${book.author.author_nationality == 'Colombia' ? 'selected' : ''}>Colombia</option>
                            <option value="Comoros" ${book.author.author_nationality == 'Comoros' ? 'selected' : ''}>Comoros</option>
                            <option value="Congo" ${book.author.author_nationality == 'Congo' ? 'selected' : ''}>Congo</option>
                            <option value="Congo, The Democratic Republic of The" ${book.author.author_nationality == 'Congo, The Democratic Republic of The' ? 'selected' : ''}>Congo, The Democratic Republic of The</option>
                            <option value="Cook Islands" ${book.author.author_nationality == 'Cook Islands' ? 'selected' : ''}>Cook Islands</option>
                            <option value="Costa Rica" ${book.author.author_nationality == 'Costa Rica' ? 'selected' : ''}>Costa Rica</option>
                            <option value="Croatia" ${book.author.author_nationality == 'Croatia' ? 'selected' : ''}>Croatia</option>
                            <option value="Cuba" ${book.author.author_nationality == 'Cuba' ? 'selected' : ''}>Cuba</option>
                            <option value="Cyprus" ${book.author.author_nationality == 'Cyprus' ? 'selected' : ''}>Cyprus</option>
                            <option value="Czech Republic" ${book.author.author_nationality == 'Czech Republic' ? 'selected' : ''}>Czech Republic</option>
                            <option value="Denmark" ${book.author.author_nationality == 'Denmark' ? 'selected' : ''}>Denmark</option>
                            <option value="Djibouti" ${book.author.author_nationality == 'Djibouti' ? 'selected' : ''}>Djibouti</option>
                            <option value="Dominica" ${book.author.author_nationality == 'Dominica' ? 'selected' : ''}>Dominica</option>
                            <option value="Dominican Republic" ${book.author.author_nationality == 'Dominican Republic' ? 'selected' : ''}>Dominican Republic</option>
                            <option value="Ecuador" ${book.author.author_nationality == 'Ecuador' ? 'selected' : ''}>Ecuador</option>
                            <option value="Egypt" ${book.author.author_nationality == 'Egypt' ? 'selected' : ''}>Egypt</option>
                            <option value="El Salvador" ${book.author.author_nationality == 'El Salvador' ? 'selected' : ''}>El Salvador</option>
                            <option value="Equatorial Guinea" ${book.author.author_nationality == 'Equatorial Guinea' ? 'selected' : ''}>Equatorial Guinea</option>
                            <option value="Eritrea" ${book.author.author_nationality == 'Eritrea' ? 'selected' : ''}>Eritrea</option>
                            <option value="Estonia" ${book.author.author_nationality == 'Estonia' ? 'selected' : ''}>Estonia</option>
                            <option value="Ethiopia" ${book.author.author_nationality == 'Ethiopia' ? 'selected' : ''}>Ethiopia</option>
                            <option value="Falkland Islands (Malvinas)" ${book.author.author_nationality == 'Falkland Islands (Malvinas)' ? 'selected' : ''}>Falkland Islands (Malvinas)</option>
                            <option value="Faroe Islands" ${book.author.author_nationality == 'Faroe Islands' ? 'selected' : ''}>Faroe Islands</option>
                            <option value="Fiji" ${book.author.author_nationality == 'Fiji' ? 'selected' : ''}>Fiji</option>
                            <option value="Finland" ${book.author.author_nationality == 'Finland' ? 'selected' : ''}>Finland</option>
                            <option value="France" ${book.author.author_nationality == 'France' ? 'selected' : ''}>France</option>
                            <option value="French Guiana" ${book.author.author_nationality == 'French Guiana' ? 'selected' : ''}>French Guiana</option>
                            <option value="French Polynesia" ${book.author.author_nationality == 'French Polynesia' ? 'selected' : ''}>French Polynesia</option>
                            <option value="French Southern Territories" ${book.author.author_nationality == 'French Southern Territories' ? 'selected' : ''}>French Southern Territories</option>
                            <option value="Gabon" ${book.author.author_nationality == 'Gabon' ? 'selected' : ''}>Gabon</option>
                            <option value="Gambia" ${book.author.author_nationality == 'Gambia' ? 'selected' : ''}>Gambia</option>
                            <option value="Georgia" ${book.author.author_nationality == 'Georgia' ? 'selected' : ''}>Georgia</option>
                            <option value="Germany" ${book.author.author_nationality == 'Germany' ? 'selected' : ''}>Germany</option>
                            <option value="Ghana" ${book.author.author_nationality == 'Ghana' ? 'selected' : ''}>Ghana</option>
                            <option value="Gibraltar" ${book.author.author_nationality == 'Gibraltar' ? 'selected' : ''}>Gibraltar</option>
                            <option value="Greece" ${book.author.author_nationality == 'Greece' ? 'selected' : ''}>Greece</option>
                            <option value="Greenland" ${book.author.author_nationality == 'Greenland' ? 'selected' : ''}>Greenland</option>
                            <option value="Grenada" ${book.author.author_nationality == 'Grenada' ? 'selected' : ''}>Grenada</option>
                            <option value="Guadeloupe" ${book.author.author_nationality == 'Guadeloupe' ? 'selected' : ''}>Guadeloupe</option>
                            <option value="Guam" ${book.author.author_nationality == 'Guam' ? 'selected' : ''}>Guam</option>
                            <option value="Guatemala" ${book.author.author_nationality == 'Guatemala' ? 'selected' : ''}>Guatemala</option>
                            <option value="Guernsey" ${book.author.author_nationality == 'Guernsey' ? 'selected' : ''}>Guernsey</option>
                            <option value="Guinea" ${book.author.author_nationality == 'Guinea' ? 'selected' : ''}>Guinea</option>
                            <option value="Guinea-bissau" ${book.author.author_nationality == 'Guinea-bissau' ? 'selected' : ''}>Guinea-bissau</option>
                            <option value="Guyana" ${book.author.author_nationality == 'Guyana' ? 'selected' : ''}>Guyana</option>
                            <option value="Haiti" ${book.author.author_nationality == 'Haiti' ? 'selected' : ''}>Haiti</option>
                            <option value="Heard Island and Mcdonald Islands" ${book.author.author_nationality == 'Heard Island and Mcdonald Islands' ? 'selected' : ''}>Heard Island and Mcdonald Islands</option>
                            <option value="Holy See (Vatican City State)" ${book.author.author_nationality == 'Holy See (Vatican City State)' ? 'selected' : ''}>Holy See (Vatican City State)</option>
                            <option value="Honduras" ${book.author.author_nationality == 'Honduras' ? 'selected' : ''}>Honduras</option>
                            <option value="Hong Kong" ${book.author.author_nationality == 'Hong Kong' ? 'selected' : ''}>Hong Kong</option>
                            <option value="Hungary" ${book.author.author_nationality == 'Hungary' ? 'selected' : ''}>Hungary</option>
                            <option value="Iceland" ${book.author.author_nationality == 'Iceland' ? 'selected' : ''}>Iceland</option>
                            <option value="India" ${book.author.author_nationality == 'India' ? 'selected' : ''}>India</option>
                            <option value="Indonesia" ${book.author.author_nationality == 'Indonesia' ? 'selected' : ''}>Indonesia</option>
                            <option value="Iran, Islamic Republic of" ${book.author.author_nationality == 'Iran, Islamic Republic of' ? 'selected' : ''}>Iran, Islamic Republic of</option>
                            <option value="Iraq" ${book.author.author_nationality == 'Iraq' ? 'selected' : ''}>Iraq</option>
                            <option value="Ireland" ${book.author.author_nationality == 'Ireland' ? 'selected' : ''}>Ireland</option>
                            <option value="Isle of Man" ${book.author.author_nationality == 'Isle of Man' ? 'selected' : ''}>Isle of Man</option>
                            <option value="Israel" ${book.author.author_nationality == 'Israel' ? 'selected' : ''}>Israel</option>
                            <option value="Italy" ${book.author.author_nationality == 'Italy' ? 'selected' : ''}>Italy</option>
                            <option value="Jamaica" ${book.author.author_nationality == 'Jamaica' ? 'selected' : ''}>Jamaica</option>
                            <option value="Japan" ${book.author.author_nationality == 'Japan' ? 'selected' : ''}>Japan</option>
                            <option value="Jersey" ${book.author.author_nationality == 'Jersey' ? 'selected' : ''}>Jersey</option>
                            <option value="Jordan" ${book.author.author_nationality == 'Jordan' ? 'selected' : ''}>Jordan</option>
                            <option value="Kazakhstan" ${book.author.author_nationality == 'Kazakhstan' ? 'selected' : ''}>Kazakhstan</option>
                            <option value="Kenya" ${book.author.author_nationality == 'Kenya' ? 'selected' : ''}>Kenya</option>
                            <option value="Kiribati" ${book.author.author_nationality == 'Kiribati' ? 'selected' : ''}>Kiribati</option>
                            <option value="Korea, Democratic People's Republic of" ${book.author.author_nationality == 'Korea, Democratic Peoples Republic of' ? 'selected' : ''}>Korea, Democratic People's Republic of</option>
                            <option value="Korea, Republic of" ${book.author.author_nationality == 'Korea, Republic of' ? 'selected' : ''}>Korea, Republic of</option>
                            <option value="Kuwait" ${book.author.author_nationality == 'Kuwait' ? 'selected' : ''}>Kuwait</option>
                            <option value="Kyrgyzstan" ${book.author.author_nationality == 'Kyrgyzstan' ? 'selected' : ''}>Kyrgyzstan</option>
                            <option value="Lao People's Democratic Republic" ${book.author.author_nationality == 'Lao Peoples Democratic Republic' ? 'selected' : ''}>Lao People's Democratic Republic</option>
                            <option value="Latvia" ${book.author.author_nationality == 'Latvia' ? 'selected' : ''}>Latvia</option>
                            <option value="Lebanon" ${book.author.author_nationality == 'Lebanon' ? 'selected' : ''}>Lebanon</option>
                            <option value="Lesotho" ${book.author.author_nationality == 'Lesotho' ? 'selected' : ''}>Lesotho</option>
                            <option value="Liberia" ${book.author.author_nationality == 'Liberia' ? 'selected' : ''}>Liberia</option>
                            <option value="Libyan Arab Jamahiriya" ${book.author.author_nationality == 'Libyan Arab Jamahiriya' ? 'selected' : ''}>Libyan Arab Jamahiriya</option>
                            <option value="Liechtenstein" ${book.author.author_nationality == 'Liechtenstein' ? 'selected' : ''}>Liechtenstein</option>
                            <option value="Lithuania" ${book.author.author_nationality == 'Lithuania' ? 'selected' : ''}>Lithuania</option>
                            <option value="Luxembourg" ${book.author.author_nationality == 'Luxembourg' ? 'selected' : ''}>Luxembourg</option>
                            <option value="Macao" ${book.author.author_nationality == 'Macao' ? 'selected' : ''}>Macao</option>
                            <option value="Macedonia, The Former Yugoslav Republic of" ${book.author.author_nationality == 'Macedonia, The Former Yugoslav Republic of' ? 'selected' : ''}>Macedonia, The Former Yugoslav Republic of</option>
                            <option value="Madagascar" ${book.author.author_nationality == 'Madagascar' ? 'selected' : ''}>Madagascar</option>
                            <option value="Malawi" ${book.author.author_nationality == 'Malawi' ? 'selected' : ''}>Malawi</option>
                            <option value="Malaysia" ${book.author.author_nationality == 'Malaysia' ? 'selected' : ''}>Malaysia</option>
                            <option value="Maldives" ${book.author.author_nationality == 'Maldives' ? 'selected' : ''}>Maldives</option>
                            <option value="Mali" ${book.author.author_nationality == 'Mali' ? 'selected' : ''}>Mali</option>
                            <option value="Malta" ${book.author.author_nationality == 'Malta' ? 'selected' : ''}>Malta</option>
                            <option value="Marshall Islands" ${book.author.author_nationality == 'Marshall Islands' ? 'selected' : ''}>Marshall Islands</option>
                            <option value="Martinique" ${book.author.author_nationality == 'Martinique' ? 'selected' : ''}>Martinique</option>
                            <option value="Mauritania" ${book.author.author_nationality == 'Mauritania' ? 'selected' : ''}>Mauritania</option>
                            <option value="Mauritius" ${book.author.author_nationality == 'Mauritius' ? 'selected' : ''}>Mauritius</option>
                            <option value="Mayotte" ${book.author.author_nationality == 'Mayotte' ? 'selected' : ''}>Mayotte</option>
                            <option value="Mexico" ${book.author.author_nationality == 'Mexico' ? 'selected' : ''}>Mexico</option>
                            <option value="Micronesia, Federated States of" ${book.author.author_nationality == 'Micronesia, Federated States of' ? 'selected' : ''}>Micronesia, Federated States of</option>
                            <option value="Moldova, Republic of" ${book.author.author_nationality == 'Moldova, Republic of' ? 'selected' : ''}>Moldova, Republic of</option>
                            <option value="Monaco" ${book.author.author_nationality == 'Monaco' ? 'selected' : ''}>Monaco</option>
                            <option value="Mongolia" ${book.author.author_nationality == 'Mongolia' ? 'selected' : ''}>Mongolia</option>
                            <option value="Montenegro" ${book.author.author_nationality == 'Montenegro' ? 'selected' : ''}>Montenegro</option>
                            <option value="Montserrat" ${book.author.author_nationality == 'Montserrat' ? 'selected' : ''}>Montserrat</option>
                            <option value="Morocco" ${book.author.author_nationality == 'Morocco' ? 'selected' : ''}>Morocco</option>
                            <option value="Mozambique" ${book.author.author_nationality == 'Mozambique' ? 'selected' : ''}>Mozambique</option>
                            <option value="Myanmar" ${book.author.author_nationality == 'Myanmar' ? 'selected' : ''}>Myanmar</option>
                            <option value="Namibia" ${book.author.author_nationality == 'Namibia' ? 'selected' : ''}>Namibia</option>
                            <option value="Nauru" ${book.author.author_nationality == 'Nauru' ? 'selected' : ''}>Nauru</option>
                            <option value="Nepal" ${book.author.author_nationality == 'Nepal' ? 'selected' : ''}>Nepal</option>
                            <option value="Netherlands" ${book.author.author_nationality == 'Netherlands' ? 'selected' : ''}>Netherlands</option>
                            <option value="Netherlands Antilles" ${book.author.author_nationality == 'Netherlands Antilles' ? 'selected' : ''}>Netherlands Antilles</option>
                            <option value="New Caledonia" ${book.author.author_nationality == 'New Caledonia' ? 'selected' : ''}>New Caledonia</option>
                            <option value="New Zealand" ${book.author.author_nationality == 'New Zealand' ? 'selected' : ''}>New Zealand</option>
                            <option value="Nicaragua" ${book.author.author_nationality == 'Nicaragua' ? 'selected' : ''}>Nicaragua</option>
                            <option value="Niger" ${book.author.author_nationality == 'Niger' ? 'selected' : ''}>Niger</option>
                            <option value="Nigeria" ${book.author.author_nationality == 'Nigeria' ? 'selected' : ''}>Nigeria</option>
                            <option value="Niue" ${book.author.author_nationality == 'Niue' ? 'selected' : ''}>Niue</option>
                            <option value="Norfolk Island" ${book.author.author_nationality == 'Norfolk Island' ? 'selected' : ''}>Norfolk Island</option>
                            <option value="Northern Mariana Islands" ${book.author.author_nationality == 'Northern Mariana Islands' ? 'selected' : ''}>Northern Mariana Islands</option>
                            <option value="Norway" ${book.author.author_nationality == 'Norway' ? 'selected' : ''}>Norway</option>
                            <option value="Oman" ${book.author.author_nationality == 'Oman' ? 'selected' : ''}>Oman</option>
                            <option value="Pakistan" ${book.author.author_nationality == 'Pakistan' ? 'selected' : ''}>Pakistan</option>
                            <option value="Palau" ${book.author.author_nationality == 'Palau' ? 'selected' : ''}>Palau</option>
                            <option value="Palestinian Territory, Occupied" ${book.author.author_nationality == 'Palestinian Territory, Occupied' ? 'selected' : ''}>Palestinian Territory, Occupied</option>
                            <option value="Panama" ${book.author.author_nationality == 'Panama' ? 'selected' : ''}>Panama</option>
                            <option value="Papua New Guinea" ${book.author.author_nationality == 'Papua New Guinea' ? 'selected' : ''}>Papua New Guinea</option>
                            <option value="Paraguay" ${book.author.author_nationality == 'Paraguay' ? 'selected' : ''}>Paraguay</option>
                            <option value="Peru" ${book.author.author_nationality == 'Peru' ? 'selected' : ''}>Peru</option>
                            <option value="Philippines" ${book.author.author_nationality == 'Philippines' ? 'selected' : ''}>Philippines</option>
                            <option value="Pitcairn" ${book.author.author_nationality == 'Pitcairn' ? 'selected' : ''}>Pitcairn</option>
                            <option value="Poland" ${book.author.author_nationality == 'Poland' ? 'selected' : ''}>Poland</option>
                            <option value="Portugal" ${book.author.author_nationality == 'Portugal' ? 'selected' : ''}>Portugal</option>
                            <option value="Puerto Rico" ${book.author.author_nationality == 'Puerto Rico' ? 'selected' : ''}>Puerto Rico</option>
                            <option value="Qatar" ${book.author.author_nationality == 'Qatar' ? 'selected' : ''}>Qatar</option>
                            <option value="Reunion" ${book.author.author_nationality == 'Reunion' ? 'selected' : ''}>Reunion</option>
                            <option value="Romania" ${book.author.author_nationality == 'Romania' ? 'selected' : ''}>Romania</option>
                            <option value="Russian Federation" ${book.author.author_nationality == 'Russian Federation' ? 'selected' : ''}>Russian Federation</option>
                            <option value="Rwanda" ${book.author.author_nationality == 'Rwanda' ? 'selected' : ''}>Rwanda</option>
                            <option value="Saint Helena" ${book.author.author_nationality == 'Saint Helena' ? 'selected' : ''}>Saint Helena</option>
                            <option value="Saint Kitts and Nevis" ${book.author.author_nationality == 'Saint Kitts and Nevis' ? 'selected' : ''}>Saint Kitts and Nevis</option>
                            <option value="Saint Lucia" ${book.author.author_nationality == 'Saint Lucia' ? 'selected' : ''}>Saint Lucia</option>
                            <option value="Saint Pierre and Miquelon" ${book.author.author_nationality == 'Saint Pierre and Miquelon' ? 'selected' : ''}>Saint Pierre and Miquelon</option>
                            <option value="Saint Vincent and The Grenadines" ${book.author.author_nationality == 'Saint Vincent and The Grenadines' ? 'selected' : ''}>Saint Vincent and The Grenadines</option>
                            <option value="Samoa" ${book.author.author_nationality == 'Samoa' ? 'selected' : ''}>Samoa</option>
                            <option value="San Marino" ${book.author.author_nationality == 'San Marino' ? 'selected' : ''}>San Marino</option>
                            <option value="Sao Tome and Principe" ${book.author.author_nationality == 'Sao Tome and Principe' ? 'selected' : ''}>Sao Tome and Principe</option>
                            <option value="Saudi Arabia" ${book.author.author_nationality == 'Saudi Arabia' ? 'selected' : ''}>Saudi Arabia</option>
                            <option value="Senegal" ${book.author.author_nationality == 'Senegal' ? 'selected' : ''}>Senegal</option>
                            <option value="Serbia" ${book.author.author_nationality == 'Serbia' ? 'selected' : ''}>Serbia</option>
                            <option value="Seychelles" ${book.author.author_nationality == 'Seychelles' ? 'selected' : ''}>Seychelles</option>
                            <option value="Sierra Leone" ${book.author.author_nationality == 'Sierra Leone' ? 'selected' : ''}>Sierra Leone</option>
                            <option value="Singapore" ${book.author.author_nationality == 'Singapore' ? 'selected' : ''}>Singapore</option>
                            <option value="Slovakia" ${book.author.author_nationality == 'Slovakia' ? 'selected' : ''}>Slovakia</option>
                            <option value="Slovenia" ${book.author.author_nationality == 'Slovenia' ? 'selected' : ''}>Slovenia</option>
                            <option value="Solomon Islands" ${book.author.author_nationality == 'Solomon Islands' ? 'selected' : ''}>Solomon Islands</option>
                            <option value="Somalia" ${book.author.author_nationality == 'Somalia' ? 'selected' : ''}>Somalia</option>
                            <option value="South Africa" ${book.author.author_nationality == 'South Africa' ? 'selected' : ''}>South Africa</option>
                            <option value="South Georgia and The South Sandwich Islands" ${book.author.author_nationality == 'South Georgia and The South Sandwich Islands' ? 'selected' : ''}>South Georgia and The South Sandwich Islands</option>
                            <option value="Spain" ${book.author.author_nationality == 'Spain' ? 'selected' : ''}>Spain</option>
                            <option value="Sri Lanka" ${book.author.author_nationality == 'Sri Lanka' ? 'selected' : ''}>Sri Lanka</option>
                            <option value="Sudan" ${book.author.author_nationality == 'Sudan' ? 'selected' : ''}>Sudan</option>
                            <option value="Suriname" ${book.author.author_nationality == 'Suriname' ? 'selected' : ''}>Suriname</option>
                            <option value="Svalbard and Jan Mayen" ${book.author.author_nationality == 'Svalbard and Jan Mayen' ? 'selected' : ''}>Svalbard and Jan Mayen</option>
                            <option value="Swaziland" ${book.author.author_nationality == 'Swaziland' ? 'selected' : ''}>Swaziland</option>
                            <option value="Sweden" ${book.author.author_nationality == 'Sweden' ? 'selected' : ''}>Sweden</option>
                            <option value="Switzerland" ${book.author.author_nationality == 'Switzerland' ? 'selected' : ''}>Switzerland</option>
                            <option value="Syrian Arab Republic" ${book.author.author_nationality == 'Syrian Arab Republic' ? 'selected' : ''}>Syrian Arab Republic</option>
                            <option value="Taiwan" ${book.author.author_nationality == 'Taiwan' ? 'selected' : ''}>Taiwan</option>
                            <option value="Tajikistan" ${book.author.author_nationality == 'Tajikistan' ? 'selected' : ''}>Tajikistan</option>
                            <option value="Tanzania, United Republic of" ${book.author.author_nationality == 'Tanzania, United Republic of' ? 'selected' : ''}>Tanzania, United Republic of</option>
                            <option value="Thailand" ${book.author.author_nationality == 'Thailand' ? 'selected' : ''}>Thailand</option>
                            <option value="Timor-leste" ${book.author.author_nationality == 'Timor-leste' ? 'selected' : ''}>Timor-leste</option>
                            <option value="Togo" ${book.author.author_nationality == 'Togo' ? 'selected' : ''}>Togo</option>
                            <option value="Tokelau" ${book.author.author_nationality == 'Tokelau' ? 'selected' : ''}>Tokelau</option>
                            <option value="Tonga" ${book.author.author_nationality == 'Tonga' ? 'selected' : ''}>Tonga</option>
                            <option value="Trinidad and Tobago" ${book.author.author_nationality == 'Trinidad and Tobago' ? 'selected' : ''}>Trinidad and Tobago</option>
                            <option value="Tunisia" ${book.author.author_nationality == 'Tunisia' ? 'selected' : ''}>Tunisia</option>
                            <option value="Turkey" ${book.author.author_nationality == 'Turkey' ? 'selected' : ''}>Turkey</option>
                            <option value="Turkmenistan" ${book.author.author_nationality == 'Turkmenistan' ? 'selected' : ''}>Turkmenistan</option>
                            <option value="Turks and Caicos Islands" ${book.author.author_nationality == 'Turks and Caicos Islands' ? 'selected' : ''}>Turks and Caicos Islands</option>
                            <option value="Tuvalu" ${book.author.author_nationality == 'Tuvalu' ? 'selected' : ''}>Tuvalu</option>
                            <option value="Uganda" ${book.author.author_nationality == 'Uganda' ? 'selected' : ''}>Uganda</option>
                            <option value="Ukraine" ${book.author.author_nationality == 'Ukraine' ? 'selected' : ''}>Ukraine</option>
                            <option value="United Arab Emirates" ${book.author.author_nationality == 'United Arab Emirates' ? 'selected' : ''}>United Arab Emirates</option>
                            <option value="United Kingdom" ${book.author.author_nationality == 'United Kingdom' ? 'selected' : ''}>United Kingdom</option>
                            <option value="United States" ${book.author.author_nationality == 'United States' ? 'selected' : ''}>United States</option>
                            <option value="United States Minor Outlying Islands" ${book.author.author_nationality == 'United States Minor Outlying Islands' ? 'selected' : ''}>United States Minor Outlying Islands</option>
                            <option value="Uruguay" ${book.author.author_nationality == 'Uruguay' ? 'selected' : ''}>Uruguay</option>
                            <option value="Uzbekistan" ${book.author.author_nationality == 'Uzbekistan' ? 'selected' : ''}>Uzbekistan</option>
                            <option value="Vanuatu" ${book.author.author_nationality == 'Vanuatu' ? 'selected' : ''}>Vanuatu</option>
                            <option value="Venezuela" ${book.author.author_nationality == 'Venezuela' ? 'selected' : ''}>Venezuela</option>
                            <option value="Viet Nam" ${book.author.author_nationality == 'Viet Nam' ? 'selected' : ''}>Viet Nam</option>
                            <option value="Virgin Islands, British" ${book.author.author_nationality == 'Virgin Islands, British' ? 'selected' : ''}>Virgin Islands, British</option>
                            <option value="Virgin Islands, U.S." ${book.author.author_nationality == 'Virgin Islands, U.S.' ? 'selected' : ''}>Virgin Islands, U.S.</option>
                            <option value="Wallis and Futuna" ${book.author.author_nationality == 'Wallis and Futuna' ? 'selected' : ''}>Wallis and Futuna</option>
                            <option value="Western Sahara" ${book.author.author_nationality == 'Western Sahara' ? 'selected' : ''}>Western Sahara</option>
                            <option value="Yemen" ${book.author.author_nationality == 'Yemen' ? 'selected' : ''}>Yemen</option>
                            <option value="Zambia" ${book.author.author_nationality == 'Zambia' ? 'selected' : ''}>Zambia</option>
                            <option value="Zimbabwe" ${book.author.author_nationality == 'Zimbabwe' ? 'selected' : ''}>Zimbabwe</option>
                        </select>
            </fieldset>

            <fieldset class="form-group">
              <label for="genre">Genre</label> <span style="color: red !important; display: inline; float: none;">*</span>
                <select value="<c:out value='${book.genre.genre_name}' />" class="form-control"
                                                                    name="genre_name" required="required" id="genre">
                    <option value="">Select Genre</option>
                    <option value="Action" ${book.genre.genre_name == 'Action' ? 'selected' : ''}>Action</option>
                    <option value="Adventure" ${book.genre.genre_name == 'Adventure' ? 'selected' : ''}>Adventure</option>
                    <option value="Animation" ${book.genre.genre_name == 'Animation' ? 'selected' : ''}>Animation</option>
                    <option value="Biography" ${book.genre.genre_name == 'Biography' ? 'selected' : ''}>Biography</option>
                    <option value="Comedy" ${book.genre.genre_name == 'Comedy' ? 'selected' : ''}>Comedy</option>
                    <option value="Drama" ${book.genre.genre_name == 'Drama' ? 'selected' : ''}>Drama</option>
                    <option value="Documentary" ${book.genre.genre_name == 'Documentary' ? 'selected' : ''}>Documentary</option>
                    <option value="Classics" ${book.genre.genre_name == 'Classics' ? 'selected' : ''}>Classics</option>
                    <option value="Fantasy" ${book.genre.genre_name == 'Fantasy' ? 'selected' : ''}>Fantasy</option>
                    <option value="Historical" ${book.genre.genre_name == 'Historical' ? 'selected' : ''}>Historical</option>
                    <option value="Horror" ${book.genre.genre_name == 'Horror' ? 'selected' : ''}>Horror</option>
                    <option value="Romance" ${book.genre.genre_name == 'Romance' ? 'selected' : ''}>Romance</option>
                    <option value="Non-fiction" ${book.genre.genre_name == 'Non-fiction' ? 'selected' : ''}>Non-fiction</option>
                    <option value="Essay" ${book.genre.genre_name == 'Essay' ? 'selected' : ''}>Essay</option>
                    <option value="Poetry" ${book.genre.genre_name == 'Poetry' ? 'selected' : ''}>Poetry</option>
                    <option value="Science Fiction" ${book.genre.genre_name == 'Science Fiction' ? 'selected' : ''}>Science Fiction</option>
                </select>
            </fieldset>

            <fieldset class="form-group">
                        <label>Date Finished: </label> <span style="color: red !important; display: inline; float: none;">*</span> <input type="date" value="<c:out value='${book.dateFinished}' />" class="form-control"
                                                                                                                                 name="dateFinished" required="required">
            </fieldset>
                    <fieldset class="form-group">
                        <label>Price: </label> <span style="color: red !important; display: inline; float: none;">*</span> <input type="number" value="<c:out value='${book.price}' />" class="form-control"
                                                                                                                                          name="price"  placeholder="$$$" required="required" min="1" step="any">
                    </fieldset>

                <button type="submit" class="btn btn-success">Save</button>
          </form>
        </div>
    </div>
</div>

</body>
</html>

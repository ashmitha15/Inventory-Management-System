<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey">

<sql:setDataSource
        var="myDS"
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu"
        user="axb1312" password="Ashmisrav1502"
    />
     
    <sql:query var="listEmployees"   dataSource="${myDS}">
        SELECT *FROM Fall22_S001_12_Employee
    </sql:query>
   <div class="w3-bar w3-black w3-hide-small" style="line-height:400%;">
     <a href="Employee.jsp" class="w3-bar-item w3-button" style="font-size:25px">Employees</a>
  <a href="NewEmployee.jsp" class="w3-bar-item w3-button" style="font-size:25px">New Employee</a>
  <a href="CurrentEmployees.jsp" class="w3-bar-item w3-button" style="font-size:25px">Current Employees</a>
</div>
   
     
    <div align="center">
        <table border="1" cellpadding="7">
            <caption><h2>List of Employees</h2></caption>
            <tr>
                <th>EMP_ID</th>
                <th>EMP_NAME</th>
                <th>EMP_PHONE_NO</th>
                <th>SALARY_PER_MONTH</th>
                <th>START_DATE</th>
                <th>END_DATE</th>
                <th>ADMIN_ID</th>
            </tr>
            <c:forEach var="user" items="${listEmployees.rows}">
                <tr>
                    <td><c:out value="${user.EMP_ID}" /></td>
                    <td><c:out value="${user.EMP_NAME}" /></td>
                    <td><c:out value="${user.EMP_PHONE_NO}" /></td>
                    <td><c:out value="${user.SALARY_PER_MONTH}" /></td>
                    <td><c:out value="${user.START_DATE}" /></td>
                    <td><c:out value="${user.END_DATE}" /></td>
                    <td><c:out value="${user.ADMIN_ID}" /></td>
                </tr>
            </c:forEach>
        </table>
    </div>


<input type="button" value="Return to Home"
        onclick="window.location.href='Home.jsp'" />
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Optimal Transport Agency</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-light-grey">

<sql:setDataSource
        var="myDS"
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@acaddbprod.uta.edu:1523/pcse1p.data.uta.edu"
        user="axb1312" password="Ashmisrav1502"
    />
     
    <sql:query var="listAgencies"   dataSource="${myDS}">
        SELECT T.TRANS_AGENCY_NAME, COUNT(T.TRANS_AGENCY_NAME) AS NUM_OF_TIMES_SENT_THROUGH, SUM(CHARGES)AS TOTAL_CHARGE_PER_TRANSPORTER, AVG(CHARGES) AS AVG_OF_CHARGES FROM FALL22_S001_12_TRANSPORTER T, FALL22_S001_12_SENDS_THROUGH ST WHERE T.VEHICLE_NO = ST.VEHICLE_NO GROUP BY T.TRANS_AGENCY_NAME ORDER BY AVG_OF_CHARGES ASC
    </sql:query>
 
     
    <div align="center">
        <table border="1" cellpadding="7">
            <caption><h2>Choose Optimal Transport Agency</h2></caption>
            <tr>
                <th>TRANS_AGENCY_NAME</th>
                <th>NUM_OF_TIMES_SENT_THROUGH</th>
                <th>TOTAL_CHARGE_PER_TRANSPORTER</th>
                <th>AVG_OF_CHARGES</th>
                
            </tr>
            <c:forEach var="user" items="${listAgencies.rows}">
                <tr>
                    <td><c:out value="${user.TRANS_AGENCY_NAME}" /></td>
                    <td><c:out value="${user.NUM_OF_TIMES_SENT_THROUGH}" /></td>
                    <td><c:out value="${user.TOTAL_CHARGE_PER_TRANSPORTER}" /></td>
                    <td><c:out value="${user.AVG_OF_CHARGES}" /></td>
                    
                </tr>
            </c:forEach>
        </table>
    </div>


<input type="button" value="Return to Home"
        onclick="window.location.href='Home.jsp'" />
</body>
</html>